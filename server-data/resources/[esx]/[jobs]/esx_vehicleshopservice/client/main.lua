local Keys = {
  ["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
  ["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
  ["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
  ["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
  ["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
  ["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
  ["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
  ["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
  ["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}

local HasAlreadyEnteredMarker = false
local LastZone                = nil
local CurrentAction           = nil
local CurrentActionMsg        = ''
local CurrentActionData       = {}
local IsInShopMenu            = false
local Categories              = {}
local Vehicles                = {}
local LastVehicles            = {}
local CurrentVehicleData      = nil

ESX                           = nil

Citizen.CreateThread(function ()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

	Citizen.Wait(10000)

	ESX.TriggerServerCallback('esx_vehicleshopservice:getCategories', function (categories)
		Categories = categories
	end)

	ESX.TriggerServerCallback('esx_vehicleshopservice:getVehicles', function (vehicles)
		Vehicles = vehicles
	end)
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	ESX.PlayerData = xPlayer
end)

RegisterNetEvent('esx_vehicleshopservice:sendCategories')
AddEventHandler('esx_vehicleshopservice:sendCategories', function (categories)
	Categories = categories
end)

RegisterNetEvent('esx_vehicleshopservice:sendVehicles')
AddEventHandler('esx_vehicleshopservice:sendVehicles', function (vehicles)
	Vehicles = vehicles
end)

function DeleteShopInsideVehicles()
	while #LastVehicles > 0 do
		local vehicle = LastVehicles[1]

		ESX.Game.DeleteVehicle(vehicle)
		table.remove(LastVehicles, 1)
	end
end


function StartShopRestriction()
	Citizen.CreateThread(function()
		while IsInShopMenu do
			Citizen.Wait(1)

			DisableControlAction(0, 75,  true) -- Disable exit vehicle
			DisableControlAction(27, 75, true) -- Disable exit vehicle
		end
	end)
end

function OpenShopMenu()
	IsInShopMenu = true

	StartShopRestriction()
	ESX.UI.Menu.CloseAll()

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
		if IsModelInCdimage(GetHashKey(Vehicles[i].model)) then
			table.insert(vehiclesByCategory[Vehicles[i].category], Vehicles[i])
		else
			print(('esx_vehicleshopservice: vehicle "%s" does not exist'):format(Vehicles[i].model))
		end
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

			table.insert(options, ('%s <span style="color:green;">%s</span>'):format(vehicle.name, _U('generic_shopitem', ESX.Math.GroupDigits(vehicle.price))))
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
		title    = _U('car_dealer'),
		align    = 'top-left',
		elements = elements
	}, function (data, menu)
		local vehicleData = vehiclesByCategory[data.current.name][data.current.value + 1]

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'shop_confirm', {
			title = _U('buy_vehicle_shop', vehicleData.name, ESX.Math.GroupDigits(vehicleData.price)),
			align = 'top-left',
			elements = {
				{label = _U('yes'), value = 'yes'},
				{label = _U('no'),  value = 'no'}
			}
		}, function(data2, menu2)
			if data2.current.value == 'yes' then
				if Config.EnablePlayerManagement then
					ESX.TriggerServerCallback('esx_vehicleshopservice:buyVehicleSociety', function(hasEnoughMoney)

						if hasEnoughMoney then
							IsInShopMenu = false

							DeleteShopInsideVehicles()

							local playerPed = PlayerPedId()

							CurrentAction     = 'shop_menu'
							CurrentActionMsg  = _U('shop_menu')
							CurrentActionData = {}

							FreezeEntityPosition(playerPed, false)
							SetEntityVisible(playerPed, true)
							SetEntityCoords(playerPed, Config.Zones.ShopEntering.Pos.x, Config.Zones.ShopEntering.Pos.y, Config.Zones.ShopEntering.Pos.z)

							menu2.close()
							menu.close()

							ESX.ShowNotification(_U('vehicle_purchased'))
						else
							ESX.ShowNotification(_U('broke_company'))
						end

					end, 'cardealer', vehicleData.model)
				else
					local playerData = ESX.GetPlayerData()

					if Config.EnableSocietyOwnedVehicles and playerData.job.grade_name == 'boss' then

						ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'shop_confirm_buy_type', {
							title = _U('purchase_type'),
							align = 'top-left',
							elements = {
								{label = _U('staff_type'),   value = 'personnal'},
								{label = _U('society_type'), value = 'society'}
							}
						}, function (data3, menu3)

							if data3.current.value == 'personnal' then

								ESX.TriggerServerCallback('esx_vehicleshopservice:buyVehicle', function(hasEnoughMoney)

									if hasEnoughMoney then
										IsInShopMenu = false

										menu3.close()
										menu2.close()
										menu.close()

										DeleteShopInsideVehicles()

										ESX.Game.SpawnVehicle(vehicleData.model, Config.Zones.ShopOutside.Pos, Config.Zones.ShopOutside.Heading, function (vehicle)
											TaskWarpPedIntoVehicle(playerPed, vehicle, -1)

											local newPlate     = GeneratePlate()
											local vehicleProps = ESX.Game.GetVehicleProperties(vehicle)
											vehicleProps.plate = newPlate
											SetVehicleNumberPlateText(vehicle, newPlate)

											if Config.EnableOwnedVehicles then
												TriggerServerEvent('esx_vehicleshopservice:setVehicleOwned', vehicleProps)
											end

											ESX.ShowNotification(_U('vehicle_purchased'))
										end)

										FreezeEntityPosition(playerPed, false)
										SetEntityVisible(playerPed, true)
									else
										ESX.ShowNotification(_U('not_enough_money'))
									end

								end, vehicleData.model)

							elseif data3.current.value == 'society' then

								ESX.TriggerServerCallback('esx_vehicleshopservice:buyVehicleSociety', function (hasEnoughMoney)

									if hasEnoughMoney then
										IsInShopMenu = false

										menu3.close()
										menu2.close()
										menu.close()

										DeleteShopInsideVehicles()

										ESX.Game.SpawnVehicle(vehicleData.model, Config.Zones.ShopOutside.Pos, Config.Zones.ShopOutside.Heading, function (vehicle)
											TaskWarpPedIntoVehicle(playerPed, vehicle, -1)

											local newPlate     = GeneratePlate()
											local vehicleProps = ESX.Game.GetVehicleProperties(vehicle)
											vehicleProps.plate = newPlate
											SetVehicleNumberPlateText(vehicle, newPlate)

											TriggerServerEvent('esx_vehicleshopservice:setVehicleOwnedSociety', playerData.job.name, vehicleProps)

											ESX.ShowNotification(_U('vehicle_purchased'))
										end)

										FreezeEntityPosition(playerPed, false)
										SetEntityVisible(playerPed, true)
									else
										ESX.ShowNotification(_U('broke_company'))
									end

								end, playerData.job.name, vehicleData.model)

							end
						end, function (data3, menu3)
							menu3.close()
						end)
					else
						ESX.TriggerServerCallback('esx_vehicleshopservice:buyVehicle', function (hasEnoughMoney)

							if hasEnoughMoney then
								IsInShopMenu = false

								menu2.close()
								menu.close()

								DeleteShopInsideVehicles()

								ESX.Game.SpawnVehicle(vehicleData.model, Config.Zones.ShopOutside.Pos, Config.Zones.ShopOutside.Heading, function (vehicle)
									TaskWarpPedIntoVehicle(playerPed, vehicle, -1)

									local newPlate     = GeneratePlate()
									local vehicleProps = ESX.Game.GetVehicleProperties(vehicle)
									vehicleProps.plate = newPlate
									SetVehicleNumberPlateText(vehicle, newPlate)

									if Config.EnableOwnedVehicles then
										TriggerServerEvent('esx_vehicleshopservice:setVehicleOwned', vehicleProps)
									end

									ESX.ShowNotification(_U('vehicle_purchased'))
								end)

								FreezeEntityPosition(playerPed, false)
								SetEntityVisible(playerPed, true)
							else
								ESX.ShowNotification(_U('not_enough_money'))
							end

						end, vehicleData.model)
					end
				end
			elseif data2.current.value == 'no' then

			end

		end, function (data2, menu2)
			menu2.close()
		end)

	end, function (data, menu)

		menu.close()

		DeleteShopInsideVehicles()

		local playerPed = PlayerPedId()

		CurrentAction     = 'shop_menu'
		CurrentActionMsg  = _U('shop_menu')
		CurrentActionData = {}

		FreezeEntityPosition(playerPed, false)
		SetEntityVisible(playerPed, true)
		SetEntityCoords(playerPed, Config.Zones.ShopEntering.Pos.x, Config.Zones.ShopEntering.Pos.y, Config.Zones.ShopEntering.Pos.z)

		IsInShopMenu = false

	end, function (data, menu)
		local vehicleData = vehiclesByCategory[data.current.name][data.current.value + 1]
		local playerPed   = PlayerPedId()

		DeleteShopInsideVehicles()
		WaitForVehicleToLoad(vehicleData.model)

		ESX.Game.SpawnLocalVehicle(vehicleData.model, Config.Zones.ShopInside.Pos, Config.Zones.ShopInside.Heading, function (vehicle)
			table.insert(LastVehicles, vehicle)
			TaskWarpPedIntoVehicle(playerPed, vehicle, -1)
			FreezeEntityPosition(vehicle, true)
		end)
	end)

	DeleteShopInsideVehicles()
	WaitForVehicleToLoad(firstVehicleData.model)

	ESX.Game.SpawnLocalVehicle(firstVehicleData.model, Config.Zones.ShopInside.Pos, Config.Zones.ShopInside.Heading, function (vehicle)
		table.insert(LastVehicles, vehicle)
		TaskWarpPedIntoVehicle(playerPed, vehicle, -1)
		FreezeEntityPosition(vehicle, true)
		SetModelAsNoLongerNeeded(firstVehicleData.model)
	end)
end

function WaitForVehicleToLoad(modelHash)
	modelHash = (type(modelHash) == 'number' and modelHash or GetHashKey(modelHash))

	if not HasModelLoaded(modelHash) then
		RequestModel(modelHash)

		BeginTextCommandBusyString('STRING')
		AddTextComponentSubstringPlayerName(_U('shop_awaiting_model'))
		EndTextCommandBusyString(4)

		while not HasModelLoaded(modelHash) do
			Citizen.Wait(1)
			DisableAllControlActions(0)
		end

		RemoveLoadingPrompt()
	end
end

AddEventHandler('esx_vehicleshopservice:hasEnteredMarker', function (zone)
	if zone == 'ShopEntering' then

		CurrentAction     = 'shop_menu'
		CurrentActionMsg  = _U('shop_menu')
		CurrentActionData = {}
	
	elseif zone == 'ResellVehicle' then

		local playerPed = PlayerPedId()

		if IsPedSittingInAnyVehicle(playerPed) then

			local vehicle     = GetVehiclePedIsIn(playerPed, false)
			local vehicleData, model, resellPrice, plate

			if GetPedInVehicleSeat(vehicle, -1) == playerPed then
				for i=1, #Vehicles, 1 do
					if GetHashKey(Vehicles[i].model) == GetEntityModel(vehicle) then
						vehicleData = Vehicles[i]
						break
					end
				end
				
				resellPrice = ESX.Math.Round(vehicleData.price)
				model = GetEntityModel(vehicle)
				plate = ESX.Math.Trim(GetVehicleNumberPlateText(vehicle))

				CurrentAction     = 'resell_vehicle'
				CurrentActionMsg  = _U('sell_menu', vehicleData.name, ESX.Math.GroupDigits(resellPrice))

				CurrentActionData = {
					vehicle = vehicle,
					label = vehicleData.name,
					price = resellPrice,
					model = model,
					plate = plate
				}
			end
		end
	end
end)

AddEventHandler('esx_vehicleshopservice:hasExitedMarker', function (zone)
	if not IsInShopMenu then
		ESX.UI.Menu.CloseAll()
	end

	CurrentAction = nil
end)

AddEventHandler('onResourceStop', function(resource)
	if resource == GetCurrentResourceName() then
		if IsInShopMenu then
			ESX.UI.Menu.CloseAll()

			DeleteShopInsideVehicles()
			local playerPed = PlayerPedId()

			FreezeEntityPosition(playerPed, false)
			SetEntityVisible(playerPed, true)
			SetEntityCoords(playerPed, Config.Zones.ShopEntering.Pos.x, Config.Zones.ShopEntering.Pos.y, Config.Zones.ShopEntering.Pos.z)
		end
	end
end)

-- Create Blips
Citizen.CreateThread(function()
	local blip = AddBlipForCoord(Config.Zones.ShopEntering.Pos.x, Config.Zones.ShopEntering.Pos.y, Config.Zones.ShopEntering.Pos.z)

	SetBlipSprite (blip, 326)
	SetBlipDisplay(blip, 4)
	SetBlipColour(blip, 69)
	SetBlipScale  (blip, 0.6)
	SetBlipAsShortRange(blip, true)

	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString(_U('car_dealer'))
	EndTextCommandSetBlipName(blip)
end)

-- Display markers
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)

		local coords = GetEntityCoords(PlayerPedId())

		for k,v in pairs(Config.Zones) do
			if(v.Type ~= -1 and GetDistanceBetweenCoords(coords, v.Pos.x, v.Pos.y, v.Pos.z, true) < Config.DrawDistance) then
				DrawMarker(v.Type, v.Pos.x, v.Pos.y, v.Pos.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, v.Size.x, v.Size.y, v.Size.z, Config.MarkerColor.r, Config.MarkerColor.g, Config.MarkerColor.b, 100, false, true, 2, false, false, false, false)
			end
		end
	end
end)

-- Enter / Exit marker events
Citizen.CreateThread(function ()
	while true do
		Citizen.Wait(0)

		local coords      = GetEntityCoords(PlayerPedId())
		local isInMarker  = false
		local currentZone = nil

		for k,v in pairs(Config.Zones) do
			if(GetDistanceBetweenCoords(coords, v.Pos.x, v.Pos.y, v.Pos.z, true) < 5) then
				isInMarker  = true
				currentZone = k
			end
		end

		if (isInMarker and not HasAlreadyEnteredMarker) or (isInMarker and LastZone ~= currentZone) then
			HasAlreadyEnteredMarker = true
			LastZone                = currentZone
			TriggerEvent('esx_vehicleshopservice:hasEnteredMarker', currentZone)
		end

		if not isInMarker and HasAlreadyEnteredMarker then
			HasAlreadyEnteredMarker = false
			TriggerEvent('esx_vehicleshopservice:hasExitedMarker', LastZone)
		end
	end
end)

-- Key controls
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(10)

		if CurrentAction == nil then
			Citizen.Wait(500)
		else
			ESX.ShowHelpNotification(CurrentActionMsg)

			if IsControlJustReleased(0, Keys['E']) then
				if CurrentAction == 'shop_menu' then
					if Config.LicenseEnable then
						ESX.TriggerServerCallback('esx_license:checkLicense', function(hasDriversLicense)
							if hasDriversLicense then
								OpenShopMenu()
							else
								ESX.ShowNotification(_U('license_missing'))
							end
						end, GetPlayerServerId(PlayerId()), 'drive')
					else
						OpenShopMenu()
					end
				elseif CurrentAction == 'resell_vehicle' then
					ESX.TriggerServerCallback('esx_vehicleshopservice:resellVehicle', function(vehicleSold)
						if vehicleSold then
							ESX.Game.DeleteVehicle(CurrentActionData.vehicle)
							ESX.ShowNotification(_U('vehicle_sold_for', CurrentActionData.label, ESX.Math.GroupDigits(CurrentActionData.price)))
						else
							ESX.ShowNotification(_U('not_yours'))
						end
					end, CurrentActionData.plate, CurrentActionData.model)
				end
				CurrentAction = nil
			end
		end
	end
end)