ESX              = nil
local Categories = {}
local Vehicles   = {}

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

Citizen.CreateThread(function()
	local char = Config.PlateLetters
	char = char + Config.PlateNumbersStart + Config.PlateNumbersEnd
	if Config.PlateUseSpace then char = char + 1 end

	if char > 8 then
		print(('esx_vehicleshopservice: ^1WARNING^7 plate character count reached, %s/8 characters.'):format(char))
	end
end)

function RemoveOwnedVehicle(plate)
	MySQL.Async.execute('DELETE FROM owned_vehicles WHERE plate = @plate', {
		['@plate'] = plate
	})
end

MySQL.ready(function()
	Categories     = MySQL.Sync.fetchAll('SELECT * FROM vehicle_categories WHERE name = "service"')
	local vehicles = MySQL.Sync.fetchAll('SELECT * FROM vehicles WHERE category = "service"')

	for i=1, #vehicles, 1 do
		local vehicle = vehicles[i]

		for j=1, #Categories, 1 do
			if Categories[j].name == vehicle.category then
				vehicle.categoryLabel = Categories[j].label
				break
			end
		end

		table.insert(Vehicles, vehicle)
	end

	-- send information after db has loaded, making sure everyone gets vehicle information
	TriggerClientEvent('esx_vehicleshopservice:sendCategories', -1, Categories)
	TriggerClientEvent('esx_vehicleshopservice:sendVehicles', -1, Vehicles)
end)


ESX.RegisterServerCallback('esx_vehicleshopservice:buyVehicle', function (source, cb, vehicleModel)
	local xPlayer     = ESX.GetPlayerFromId(source)
	local vehicleData = nil

	for i=1, #Vehicles, 1 do
		if Vehicles[i].model == vehicleModel then
			vehicleData = Vehicles[i]
			break
		end
	end

	if xPlayer.getMoney() >= vehicleData.price then
		xPlayer.removeMoney(vehicleData.price)
		cb(true)
	else
		cb(false)
	end
end)

RegisterServerEvent('esx_vehicleshopservice:setVehicleOwned')
AddEventHandler('esx_vehicleshopservice:setVehicleOwned', function (vehicleProps)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)

	MySQL.Async.execute('INSERT INTO owned_vehicles (owner, plate, vehicle, job) VALUES (@owner, @plate, @vehicle, @job)',
	{
		['@owner']   = xPlayer.identifier,
		['@plate']   = vehicleProps.plate,
		['@vehicle'] = json.encode(vehicleProps),
		['@job'] = "service"
	}, function (rowsChanged)
		TriggerClientEvent('esx:showNotification', _source, _U('vehicle_belongs', vehicleProps.plate))
	end)
end)

RegisterServerEvent('esx_vehicleshopservice:setVehicleOwnedPlayerId')
AddEventHandler('esx_vehicleshopservice:setVehicleOwnedPlayerId', function (playerId, vehicleProps)
	local xPlayer = ESX.GetPlayerFromId(playerId)

	MySQL.Async.execute('INSERT INTO owned_vehicles (owner, plate, vehicle, job) VALUES (@owner, @plate, @vehicle, @job)',
	{
		['@owner']   = xPlayer.identifier,
		['@plate']   = vehicleProps.plate,
		['@vehicle'] = json.encode(vehicleProps),
		['@job'] = "service"
	}, function (rowsChanged)
		TriggerClientEvent('esx:showNotification', playerId, _U('vehicle_belongs', vehicleProps.plate))
	end)
end)


ESX.RegisterServerCallback('esx_vehicleshopservice:getCategories', function (source, cb)
	cb(Categories)
end)

ESX.RegisterServerCallback('esx_vehicleshopservice:getVehicles', function (source, cb)
	cb(Vehicles)
end)


ESX.RegisterServerCallback('esx_vehicleshopservice:resellVehicle', function (source, cb, plate, model)
	local xPlayer = ESX.GetPlayerFromId(source)
	local resellPrice = 0

	-- calculate the resell price
	for i=1, #Vehicles, 1 do
		if GetHashKey(Vehicles[i].model) == model then
			resellPrice = ESX.Math.Round(Vehicles[i].price)
			break
		end
	end

	if resellPrice == 0 then
		TriggerServerEvent("alttab:anticheat", xPlayer.identifier, "esx:resellVehicle (price)")
		cb(false)
	else
		MySQL.Async.fetchAll('SELECT * FROM rented_vehicles WHERE plate = @plate', {
			['@plate'] = plate
		}, function (result)
			if result[1] then -- is it a rented vehicle?
				cb(false) -- it is, don't let the player sell it since he doesn't own it
			else
				local xPlayer = ESX.GetPlayerFromId(source)

				MySQL.Async.fetchAll('SELECT * FROM owned_vehicles WHERE owner = @owner AND @plate = plate AND job = @service', {
					['@owner'] = xPlayer.identifier,
					['@plate'] = plate,
					['@service'] = "service"
				}, function (result)
					if result[1] then -- does the owner match?
						local vehicle = json.decode(result[1].vehicle)

						if vehicle.model == model then
							if vehicle.plate == plate then
								xPlayer.addMoney(resellPrice)
								RemoveOwnedVehicle(plate)
								cb(true)
							else
								TriggerServerEvent("alttab:anticheat", xPlayer.identifier, "esx:resellVehicle (modal)")
								cb(false)
							end
						else
							TriggerServerEvent("alttab:anticheat", xPlayer.identifier, "esx:resellVehicle (plate)")			
								cb(false)
						end
					else
						TriggerClientEvent('esx:showNotification', source, "Vente seulement pour les véhicules de service")
					end
				end)
			end
		end)
	end
end)

ESX.RegisterServerCallback('esx_vehicleshopservice:isPlateTaken', function (source, cb, plate)
	MySQL.Async.fetchAll('SELECT 1 FROM owned_vehicles WHERE plate = @plate', {
		['@plate'] = plate
	}, function (result)
		cb(result[1] ~= nil)
	end)
end)