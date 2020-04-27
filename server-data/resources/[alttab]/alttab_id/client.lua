ESX = nil
local open 				= false
local playerData	= {}

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

-- function getPlayerJob(player)
-- 	ESX.TriggerServerCallback('alttab_id:getOtherPlayerData', function(data)
-- 		sourceJobLabel = data.sourceJob.label
-- 		targetJobLabel = data.targetJob.label
-- 		print(data.source)
-- 		print(data.target)

-- 	end, GetPlayerServerId(player))
-- 	jobLabel = targetJobLabel
-- end

RegisterNetEvent("alttab_id:getID")
AddEventHandler("alttab_id:getID", function(cinTarget, _source)
	if cinTarget == _source then
		cin = GetPlayerServerId(PlayerId())
	else
		cin = cinTarget
	end
end)

-- Open ID card
RegisterNetEvent('alttab_id:open')
AddEventHandler('alttab_id:open', function(data, type)
-- print(jobLabel)
	open = true
	SendNUIMessage({
		action = "open",
		array  = data,
		type   = type,
		cin 	 = cin
	})
end)
-- Key events
Citizen.CreateThread(function()
	while true do
		Wait(0)
		if IsControlJustReleased(0, 177) then
			SendNUIMessage({
				action = "close"
			})
			open = false
		end
	end
end)


RegisterNetEvent("alttab_id:getPic")
AddEventHandler("alttab_id:getPic", function(player, _source)
	if player == _source then
		player = GetPlayerPed(-1)
	else
		player = GetPlayerPed(GetPlayerFromServerId(player))
	end

	local handle = RegisterPedheadshot(player)
	while not IsPedheadshotReady(handle) do
		Wait(100)
	end

	local headshot = GetPedheadshotTxdString(handle)
	while not IsControlJustReleased(0, 177) do
		Wait(1)
		DrawSprite(headshot, headshot, 0.192, 0.490, 0.040, 0.078, 0.0, 255, 255, 255, 255)
	end
	UnregisterPedheadshot(handle)
end)

function hasID(cb)
	if (ESX == nil) then return cb(0) end
	ESX.TriggerServerCallback('alttab_id:getItemAmount', function(qtty)
	  cb(qtty > 0)
	end, 'id')
end
RegisterCommand("id", function(source)
	hasID(function (hasID)
		if hasID == true then
			TriggerEvent("alttab_id:getID")
			TriggerEvent("alttab_id:getPic")
			TriggerServerEvent('alttab_id:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(PlayerId()))
		else
			exports['mythic_notify']:SendAlert('error', "Vous n'avez pas de CIN")
		end
	end)
	
end, false)

RegisterCommand("showid", function(source)
	
    hasID(function (hasID)
		if hasID == true then
			local target, distance = ESX.Game.GetClosestPlayer()
			if target ~= -1 and distance <= 3.0 then
				TriggerServerEvent('alttab_id:getTargetID', GetPlayerServerId(target))
				TriggerServerEvent('alttab_id:getTargetPic', GetPlayerServerId(target))
				TriggerServerEvent('alttab_id:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(target))
			else
				exports['mythic_notify']:SendAlert('inform', "personne n'est à proximité")
			end
		else
			exports['mythic_notify']:SendAlert('error', "Vous n'avez pas de CIN")
		end
	end)

end, false)