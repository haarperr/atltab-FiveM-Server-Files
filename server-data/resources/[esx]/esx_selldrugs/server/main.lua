ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('sellDrugs')
AddEventHandler('sellDrugs', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local marijuanaQT = xPlayer.getInventoryItem('marijuana').count
	local x = 0
	local price = 0
	local drugType = nil
	
	if marijuanaQT > 0 then
		drugType = 'marijuana'
		math.randomseed(GetGameTimer())
		x = math.random(1, 10)
		if marijuanaQT < 10 then
			math.randomseed(GetGameTimer())
			x = math.random(1, marijuanaQT)
		end
	else
		TriggerClientEvent('nomoredrugs', _source)
		return
	end
	
	if drugType=='marijuana' then
		price = Config.MarijuanaPrice * x
	end
	
	if drugType ~= nil then
		xPlayer.removeInventoryItem(drugType, x)
	end
	
	xPlayer.addMoney(price)
	TriggerClientEvent('sold', _source)
	TriggerClientEvent('esx:showNotification', _source, _U('you_have_sold') .. '~b~'..x..'x~s~' .. _U(drugType) .. '~r~' .. price .. ' DH')
end)


RegisterServerEvent('check')
AddEventHandler('check', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local xPlayers = ESX.GetPlayers()
	local cannabisQT = xPlayer.getInventoryItem('cannabis').count
	local marijuanaQT = xPlayer.getInventoryItem('marijuana').count
	--check cops count on server
	local cops = 0
	for i=1, #xPlayers, 1 do
 		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
 		if xPlayer.job.name == 'police' then
				cops = cops + 1
		end
	end
	
	if cops >= Config.CopsRequiredToSell then
		if cannabisQT > 0 or marijuanaQT > 0 then
			TriggerClientEvent('playerhasdrugs', _source)
			return
		end
		TriggerClientEvent('nomoredrugs', _source)
	else
		TriggerClientEvent('esx:showNotification', _source, _U('must_be') .. Config.CopsRequiredToSell .. _U('to_sell_drugs'))
	end
end)


RegisterServerEvent('drugsNotify')
AddEventHandler('drugsNotify', function()
	TriggerClientEvent("drugsEnable", source)
end)

--if you need you can translate it to your language
RegisterServerEvent('drugsInProgress')
AddEventHandler('drugsInProgress', function(streetName)
	TriggerClientEvent("outlawNotify", -1, "[DISPATCH] Vente de drogue à <span style=\"color:#f1c40f;font-size: 13px;\">" ..streetName .. "</span>")
end)

RegisterServerEvent('drugsInProgressPos')
AddEventHandler('drugsInProgressPos', function(gx, gy, gz)
	TriggerClientEvent('drugsPlace', -1, gx, gy, gz)
end)
