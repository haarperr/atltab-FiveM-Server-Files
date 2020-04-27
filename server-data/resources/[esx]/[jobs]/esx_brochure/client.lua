local IsInShopMenu = false
local Categories   = {}
local Vehicles     = {}
local LastVehicles = {}

ESX                = nil

--- Draw marker & action
Citizen.CreateThread(function()

	while true do
		Citizen.Wait(0)

		local playerPos = GetEntityCoords(PlayerPedId(), true)
		if Vdist(playerPos.x, playerPos.y, playerPos.z, Config.Zones.ShopOutside.Pos.x, Config.Zones.ShopOutside.Pos.y, Config.Zones.ShopOutside.Pos.z) < Config.DrawDistance then
			DrawMarker(Config.MarkerType, Config.Zones.ShopOutside.Pos.x, 
			Config.Zones.ShopOutside.Pos.y, Config.Zones.ShopOutside.Pos.z - 1, 0, 0, 0, 0, 0, 0, 1.0, 1.0, 1.0, 100, 10, 10, 165, 0, 1, 0, 0)

			if Vdist(playerPos.x, playerPos.y, playerPos.z, Config.Zones.ShopOutside.Pos.x, Config.Zones.ShopOutside.Pos.y, Config.Zones.ShopOutside.Pos.z) < 1.0 then

				ESX.ShowHelpNotification('Appuyez sur ~INPUT_CONTEXT~ pour jeter un coup d\'œil à nos véhicules')

				if IsControlJustReleased(0, 38) then

					DoScreenFadeOut(800)
					Citizen.Wait(1000)
					DoScreenFadeIn(800)
					OpenShopMenu()

				end
			end

		else
			Citizen.Wait(500)
		end
	end
end)

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

	ESX.TriggerServerCallback('esx_vehicleshop:getCategories', function (categories)
		Categories = categories
	end)

	ESX.TriggerServerCallback('esx_vehicleshop:getVehicles', function (vehicles)
		Vehicles = vehicles
	end)
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)

		if IsInShopMenu then
			DisableControlAction(0, 75, true)  -- Disable exit vehicle
			DisableControlAction(27, 75, true) -- Disable exit vehicle
		else
			Citizen.Wait(500)
		end
	end
end)

RegisterNetEvent('esx_vehicleshop:sendCategories')
AddEventHandler('esx_vehicleshop:sendCategories', function (categories)
	Categories = categories
end)

RegisterNetEvent('esx_vehicleshop:sendVehicles')
AddEventHandler('esx_vehicleshop:sendVehicles', function (vehicles)
	Vehicles = vehicles
end)

function DeleteShopInsideVehicles()
	while #LastVehicles > 0 do
		local vehicle = LastVehicles[1]
		ESX.Game.DeleteVehicle(vehicle)
		table.remove(LastVehicles, 1)
	end
end

function OpenShopMenu()
	IsInShopMenu = true
	SetEntityVisible(playerPed, false)

	local playerPed = PlayerPedId()

	FreezeEntityPosition(playerPed, true)
	SetEntityVisible(playerPed, false)
	SetEntityCoords(playerPed, Config.Zones.ShopInside.Pos.x, Config.Zones.ShopInside.Pos.y, Config.Zones.ShopInside.Pos.z)

	local vehiclesByCategory = {}
	local elements           = {}
	local firstVehicleData   = nil

	for i=1, #Categories, 1 do
		vehiclesByCategory[Categories[i].name] = {}
	end

	for i=1, #Vehicles, 1 do
		table.insert(vehiclesByCategory[Vehicles[i].category], Vehicles[i])
	end

	for i=1, #Categories, 1 do
		local category         = Categories[i]
		local categoryVehicles = vehiclesByCategory[category.name]
		local options          = {}

		for j=1, #categoryVehicles, 1 do
			local vehicle = categoryVehicles[j]

			if i == 1 and j == 1 then
				firstVehicleData = vehicle
			end

			table.insert(options, vehicle.name)
		end

		table.insert(elements, {
			name    = category.name,
			label   = category.label,
			value   = 0,
			type    = 'slider',
			max     = #Categories[i],
			options = options
		})
	end

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'vehicle_shop',
	{
		title    = 'Brochure',
		align    = 'top',
		elements = elements,
	}, function (data, menu)
		local vehicleData  = vehiclesByCategory[data.current.name][data.current.value + 1]
		local vehiclePrice = math.floor(vehicleData.price + (vehicleData.price * 0.25))

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'shop_confirm',
		{
			title = vehicleData.name,
			align = 'top',
			elements = { { label = (string.format('Prix: <span style="color: green;">%s DH</span>', vehiclePrice)) } }
		}, function (data2, menu2)

		end, function (data2, menu2)
			menu2.close()
		end)

	end, function (data, menu)

		menu.close()
		DeleteShopInsideVehicles()

		local playerPed = PlayerPedId()

		FreezeEntityPosition(playerPed, false)
		SetEntityVisible(playerPed, true)

		DoScreenFadeOut(800)
		Citizen.Wait(1000)
		DoScreenFadeIn(800)

		SetEntityCoords(playerPed, Config.Zones.ShopEntering.Pos.x, Config.Zones.ShopEntering.Pos.y, Config.Zones.ShopEntering.Pos.z)

		IsInShopMenu = false

	end, function (data, menu)

		local vehicleData = vehiclesByCategory[data.current.name][data.current.value + 1]
		local playerPed   = PlayerPedId()

		DeleteShopInsideVehicles()

		ESX.Game.SpawnLocalVehicle(vehicleData.model, Config.Zones.ShopInside.Pos, Config.Zones.ShopInside.Heading, function(vehicle)
			table.insert(LastVehicles, vehicle)
			TaskWarpPedIntoVehicle(playerPed, vehicle, -1)
			FreezeEntityPosition(vehicle, true)
		end)

	end)

	DeleteShopInsideVehicles()

	ESX.Game.SpawnLocalVehicle(firstVehicleData.model, Config.Zones.ShopInside.Pos, Config.Zones.ShopInside.Heading, function (vehicle)
		table.insert(LastVehicles, vehicle)
		TaskWarpPedIntoVehicle(playerPed, vehicle, -1)
		FreezeEntityPosition(vehicle, true)
	end)

end