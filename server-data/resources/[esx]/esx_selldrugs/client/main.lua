ESX = nil
local selling = false
local secondsRemaining
local sold = false
local playerHasDrugs = false
local pedIsTryingToSellDrugs = false
local PlayerData		= {}

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end

	PlayerData = ESX.GetPlayerData()
end)

--TIME TO SELL
Citizen.CreateThread(function()
	while true do
		if selling then
			if secondsRemaining > 0 then
				secondsRemaining = secondsRemaining - 1
			end
			Citizen.Wait(1000)
		end
		Citizen.Wait(100)
	end
end)

currentped = nil
Citizen.CreateThread(function()
	while true do
		Wait(10)
		local player = GetPlayerPed(-1)
		local pid = PlayerPedId()
  		local playerloc = GetEntityCoords(player, 0)
		local handle, ped = FindFirstPed()
		local success
		repeat
		    success, ped = FindNextPed(handle)
		   	local pos = GetEntityCoords(ped)
	 		local distance = GetDistanceBetweenCoords(pos.x, pos.y, pos.z, playerloc['x'], playerloc['y'], playerloc['z'], true)
			local distanceFromCity = GetDistanceBetweenCoords(Config.CityPoint.x, Config.CityPoint.y, Config.CityPoint.z, playerloc['x'], playerloc['y'], playerloc['z'], true)
			if IsPedInAnyVehicle(GetPlayerPed(-1)) == false then
				if DoesEntityExist(ped)then
					if IsPedDeadOrDying(ped) == false then
						if IsPedInAnyVehicle(ped) == false then
							local pedType = GetPedType(ped)
							if pedType ~= 28 and IsPedAPlayer(ped) == false then
								currentped = pos
								if distance <= 2 and ped  ~= GetPlayerPed(-1) and ped ~= oldped and IsControlJustPressed(1, 38) then
									TriggerServerEvent('check')
									if distanceFromCity < Config.DistanceFromCity then
										if playerHasDrugs and sold == false and selling == false then 
											--PED REJECT OFFER
											local random = math.random(1, Config.PedRejectPercent)
											if random == Config.PedRejectPercent then
												ESX.ShowNotification(_U('reject'))
												oldped = ped
												--PED CALLING COPS
												if Config.CallCops then
													local randomReport = math.random(1, Config.CallCopsPercent)
													if randomReport == Config.CallCopsPercent then
														TriggerServerEvent('drugsNotify')
													end
												end
												TriggerEvent("sold")
											--PED ACCEPT OFFER
											else
												SetEntityAsMissionEntity(ped)
												ClearPedTasks(ped)
												FreezeEntityPosition(ped,true)
												oldped = ped										
												TaskStandStill(ped, 9)
												pos1 = GetEntityCoords(ped)
												TriggerEvent("sellingdrugs")
											end
										end
									else
										-- ESX.ShowNotification(_U('too_far_away_from_city'))
									end
								end
							end
						end
					end
				end
			end
		until not success

		EndFindPed(handle)
	end	
end)

Citizen.CreateThread(function()
	while true do
		Wait(100)
		if selling then
			local player = GetPlayerPed(-1)
			local playerloc = GetEntityCoords(player, 0)
			local distance = GetDistanceBetweenCoords(pos1.x, pos1.y, pos1.z, playerloc['x'], playerloc['y'], playerloc['z'], true)
			local pid = PlayerPedId()
			--TOO FAR
			if distance > 2 then
				ESX.ShowNotification(_U('too_far_away'))
				selling = false
				SetEntityAsMissionEntity(oldped)
				SetPedAsNoLongerNeeded(oldped)
				FreezeEntityPosition(oldped,false)
			end
			--SUCCESS
			if secondsRemaining <= 1 then
				selling = false
				SetEntityAsMissionEntity(oldped)
				SetPedAsNoLongerNeeded(oldped)
				FreezeEntityPosition(oldped,false)
				playerHasDrugs = false
				sold = false
				TriggerServerEvent('sellDrugs')
			end	

			if secondsRemaining == Config.TimeToSell and Config.PlayAnimation then
				exports['progressBars']:startUI(4500, "Vente en cours")
				Citizen.Wait(3100) 
				playAnim('mp_common', 'givetake1_a', 1000)
				Citizen.Wait(1000)
				end
		end	
	end
end)

function playAnim(animDict, animName, duration)
	RequestAnimDict(animDict)
	while not HasAnimDictLoaded(animDict) do Citizen.Wait(0) end
	TaskPlayAnim(PlayerPedId(), animDict, animName, 1.0, -1.0, duration, 49, 1, false, false, false)
	RemoveAnimDict(animDict)
end
		
RegisterNetEvent('sellingdrugs')
AddEventHandler('sellingdrugs', function()
	secondsRemaining = Config.TimeToSell + 1
	selling = true
end)

RegisterNetEvent('sold')
AddEventHandler('sold', function()
	sold = false
	selling = false
	secondsRemaining = 0
end)

--Info that you dont have drugs
RegisterNetEvent('nomoredrugs')
AddEventHandler('nomoredrugs', function()
	-- ESX.ShowNotification(_U('no_more_drugs'))
	playerHasDrugs = false
	sold = false
	selling = false
	secondsRemaining = 0
end)

--Show help notification ("PRESS E...")
RegisterNetEvent('playerhasdrugs')
AddEventHandler('playerhasdrugs', function()
	-- ESX.ShowHelpNotification(_U('input'))
	playerHasDrugs = true
end)

--DISPATCH BEGIN (better do not touch)
--Only if Config.CallCops = true
GetPlayerName()
RegisterNetEvent('outlawNotify')
AddEventHandler('outlawNotify', function(alert)
		if PlayerData.job ~= nil and PlayerData.job.name == 'police' then
			exports['mythic_notify']:SendAlert('error', alert, 7000)
		end
end)


--Config
local showOutlaw = true --Set if show outlaw act on map
--End config


Citizen.CreateThread(function()
    while true do
        Wait(100)
        if NetworkIsSessionStarted() then
            DecorRegister("IsOutlaw",  3)
            DecorSetInt(GetPlayerPed(-1), "IsOutlaw", 1)
            return
        end
    end
end)

Citizen.CreateThread( function()
    while true do
				Wait(100)
				local plyPos = GetEntityCoords(PlayerPedId())
				streetNameCoord = GetStreetNameAtCoord(plyPos.x, plyPos.y, plyPos.z)
				streetName = GetStreetNameFromHashKey(streetNameCoord)

        if pedIsTryingToSellDrugs then
					DecorSetInt(GetPlayerPed(-1), "IsOutlaw", 2)
					if PlayerData.job ~= nil and PlayerData.job.name == 'police' then 
						TriggerServerEvent('drugsInProgress', streetName)
						TriggerServerEvent('drugsInProgressPos', plyPos.x, plyPos.y, plyPos.z)
						Wait(3000)
						pedIsTryingToSellDrugs = false
					end
        end
    end
end)

RegisterNetEvent('drugsPlace')
AddEventHandler('drugsPlace', function(tx, ty, tz)
	if PlayerData.job.name == 'police' then
		local alpha = 250
		local drugBlip = AddBlipForCoord(tx, ty, tz)

		SetBlipSprite(drugBlip, 496)
		SetBlipDisplay(drugBlip, 4)
		SetBlipScale(drugBlip, 1.0)
		SetBlipColour(drugBlip, 1)
		SetBlipAlpha(drugBlip, alpha)
		SetBlipAsShortRange(drugBlip, false)

		BeginTextCommandSetBlipName('STRING')
		AddTextComponentSubstringPlayerName("[DISPATCH] Vente de drogues")
		EndTextCommandSetBlipName(drugBlip)

		while alpha ~= 0 do
			Citizen.Wait(Config.DrugBlipDuration * 4)
			alpha = alpha - 1
			SetBlipAlpha(drugBlip, alpha)

			if alpha == 0 then
				RemoveBlip(drugBlip)
				return
			end
		end
	end
end)


RegisterNetEvent('drugsEnable')
AddEventHandler('drugsEnable', function()
	pedIsTryingToSellDrugs = true
end)
--DISPATCH END
