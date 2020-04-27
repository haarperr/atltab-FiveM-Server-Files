local ESX = nil
-- ESX
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

-- Open ID card
RegisterServerEvent('alttab_id:open')
AddEventHandler('alttab_id:open', function(ID, targetID, type)
	local identifier = ESX.GetPlayerFromId(ID).identifier
	local _source 	 = ESX.GetPlayerFromId(targetID).source
	local show       = false

	MySQL.Async.fetchAll('SELECT firstname, lastname, dateofbirth, sex, height, job FROM users WHERE identifier = @identifier', {['@identifier'] = identifier},
	function (user)
		if (user[1] ~= nil) then
			MySQL.Async.fetchAll('SELECT type FROM user_licenses WHERE owner = @identifier', {['@identifier'] = identifier},
			function (licenses)
				if type ~= nil then
					for i=1, #licenses, 1 do
						if type == 'driver' then
							if licenses[i].type == 'drive' or licenses[i].type == 'drive_bike' or licenses[i].type == 'drive_truck' then
								show = true
							end
						elseif type =='weapon' then
							if licenses[i].type == 'weapon' then
								show = true
							end
						end
					end
				else
					show = true
				end

				if show then
					local array = {
						user = user,
						licenses = licenses
					}
					TriggerClientEvent('alttab_id:open', _source, array, type)
				else
					TriggerClientEvent('esx:showNotification', _source, "Vous n'avez pas ce type de license..")
				end
			end)
		end
	end)
end)


RegisterServerEvent('alttab_id:getTargetPic')
AddEventHandler('alttab_id:getTargetPic', function(target)
	local _source = source
	local player = tonumber(target)
	TriggerClientEvent('alttab_id:getPic', player, _source)
end)

RegisterServerEvent('alttab_id:getTargetID')
AddEventHandler('alttab_id:getTargetID', function(target)
	local _source = source
	local cinTarget = tonumber(target)
	TriggerClientEvent('alttab_id:getID', cinTarget, _source)
end)

-- ESX.RegisterServerCallback('alttab_id:getOtherPlayerData', function(source, cb, target)
-- 	local sourcexPlayer = ESX.GetPlayerFromId(source)
-- 	local targetxPlayer = ESX.GetPlayerFromId(target)

-- 	local data = {
-- 		source = tonumber(source),
-- 		sourceJob       = sourcexPlayer.job,
-- 		target = tonumber(target),
-- 		targetJob       = targetxPlayer.job
-- 	}
-- 	cb(data)
-- end)


ESX.RegisterServerCallback('alttab_id:getItemAmount', function(source, cb, item)
	local xPlayer = ESX.GetPlayerFromId(source)
	local items = xPlayer.getInventoryItem(item)
	
	if items == nil then
		cb(0)
	else
	  cb(items.count)
	end
  end)