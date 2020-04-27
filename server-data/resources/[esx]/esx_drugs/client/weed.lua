ESX = nil
local spawnedWeeds = -1
local firstSpawn = true
local weedPlants = {}
local isPickingUp, isProcessing = false, false
local farmWeed, procWeed
Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

	ESX.TriggerServerCallback('esx_drugs:drugsPosition', function(cb)
		farmWeed = cb.WeedField
		procWeed = cb.WeedProcessing
	end)
	
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(10)
		local coords = GetEntityCoords(PlayerPedId())

		if (GetDistanceBetweenCoords(coords, farmWeed, true) < 50) and firstSpawn == true then
			TriggerEvent('esx_drugs:startTheFuckingPlanting')
			Citizen.Wait(2000)
			firstSpawn = false
		end

		if GetDistanceBetweenCoords(coords, farmWeed, true) < 50 and firstSpawn == false then
			SpawnWeedPlants()
			Citizen.Wait(500)
		else
			Citizen.Wait(500)
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		local playerPed = PlayerPedId()
		local coords = GetEntityCoords(playerPed)

		if GetDistanceBetweenCoords(coords, procWeed, true) < 1 then
			if not isProcessing then
				ESX.ShowHelpNotification(_U('weed_processprompt'))
			end

			if IsControlJustReleased(0, 38) and not isProcessing then
				ProcessWeed()
			end
		else
			Citizen.Wait(500)
		end
	end
end)

function ProcessWeed()
	isProcessing = true

	exports['progressBars']:startUI(Config.Delays.WeedProcessing, "Transformation de cannabis")
	TriggerServerEvent('esx_drugs:processCannabis')
	local timeLeft = Config.Delays.WeedProcessing / 1000		
	local playerPed = PlayerPedId()

	while timeLeft > 0 do
		Citizen.Wait(1000)
		timeLeft = timeLeft - 1

		if GetDistanceBetweenCoords(GetEntityCoords(playerPed), procWeed, false) > 4 then
			ESX.ShowNotification(_U('weed_processingtoofar'))
			TriggerServerEvent('esx_drugs:cancelProcessing')
			break
		end
	end

	isProcessing = false
end

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		local playerPed = PlayerPedId()
		local coords = GetEntityCoords(playerPed)
		local nearbyObject, nearbyID

		for i=1, #weedPlants, 1 do
			if GetDistanceBetweenCoords(coords, GetEntityCoords(weedPlants[i]), false) < 1 then
				nearbyObject, nearbyID = weedPlants[i], i
			end
		end

		if nearbyObject and IsPedOnFoot(playerPed) then

			if not isPickingUp then
				ESX.ShowHelpNotification(_U('weed_pickupprompt'))
			end

			if IsControlJustReleased(0, 38) and not isPickingUp then
				isPickingUp = true

				ESX.TriggerServerCallback('esx_drugs:canPickUp', function(canPickUp)

					if canPickUp then
						TaskStartScenarioInPlace(playerPed, 'PROP_HUMAN_BUM_BIN', 0, false)
						exports['progressBars']:startUI(9000, "Collecte de cannabis")
						Citizen.Wait(8000)
						ClearPedTasks(playerPed)
						Citizen.Wait(1000)
		
						ESX.Game.DeleteObject(nearbyObject)
		
						table.remove(weedPlants, nearbyID)
						spawnedWeeds = spawnedWeeds - 1
		
						TriggerServerEvent('esx_drugs:pickedUpCannabis')
					else
						ESX.ShowNotification(_U('weed_inventoryfull'))
					end

					isPickingUp = false

				end, 'cannabis')
			end

		else
			Citizen.Wait(500)
		end

	end

end)

AddEventHandler('onResourceStop', function(resource)
	if resource == GetCurrentResourceName() then
		for k, v in pairs(weedPlants) do
			ESX.Game.DeleteObject(v)
		end
	end
end)

function SpawnWeedPlants()
	Citizen.Wait(1000)
	if spawnedWeeds == 0 then
		exports['progressBars']:startUI(180000, "Culture de cannabis")
		Citizen.Wait(180000)
		TriggerEvent('esx_drugs:startTheFuckingPlanting')
	end
end

function ValidateWeedCoord(plantCoord)
	if spawnedWeeds > 0 then
		local validate = true

		for k, v in pairs(weedPlants) do
			if GetDistanceBetweenCoords(plantCoord, GetEntityCoords(v), true) < 2 then
				validate = false
			end
		end

		if GetDistanceBetweenCoords(plantCoord, farmWeed, false) > 10 then
			validate = false
		end

		return validate
	else
		return true
	end
end

function GenerateWeedCoords()
	while true do
		local weedCoordX, weedCoordY
	
		Citizen.Wait(100)
		
		math.randomseed(GetGameTimer())
		local modX = math.random(0, 1)
		local modY = math.random(0, 5)

		weedCoordX = farmWeed.x + modX
		weedCoordY = farmWeed.y + modY

		local coordZ = GetCoordZ(weedCoordX, weedCoordY)
		local coord = vector3(weedCoordX, weedCoordY, coordZ)

		if ValidateWeedCoord(coord) then
			return coord
		end
	end
end

function GetCoordZ(x, y)
	local groundCheckHeights = { 40.0, 41.0, 42.0, 43.0, 44.0, 45.0, 46.0, 47.0, 48.0, 49.0, 50.0, 21.85, 78.0 }

	for i, height in ipairs(groundCheckHeights) do
		local foundGround, z = GetGroundZFor_3dCoord(x, y, height)

		if foundGround then
			return z
		end
	end

	return 78.0
	-- return 21.85
end

RegisterNetEvent('esx_drugs:startTheFuckingPlanting')
AddEventHandler('esx_drugs:startTheFuckingPlanting', function() 
	Citizen.SetTimeout(3000, function()
		for w = 0, 9 do
			ESX.Game.SpawnLocalObject('prop_weed_01', GenerateWeedCoords(), function(obj)
				PlaceObjectOnGroundProperly(obj)
				FreezeEntityPosition(obj, true)
				table.insert(weedPlants, obj)
			end)
			w = w + 1
		end
		spawnedWeeds = 10
	end)
end)