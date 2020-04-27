
ESX = nil
price = 100

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

TriggerEvent('es:addCommand', 'ad', function(source, args, user)
    local xPlayer = ESX.GetPlayerFromId(source)
    local xPlayers = ESX.GetPlayers()
    local name = getName(source)
    if args[1] then  
        xPlayer.removeAccountMoney('bank', 100)
        TriggerClientEvent('esx:showAdvancedNotification', xPlayer.source, 'Banque', 'Frais de votre annonce' , '~r~-100 DH~s~', 'CHAR_BANK_MAZE', 9)
        for i = 1, #xPlayers do
            local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
            TriggerClientEvent('alttab_ad:showAd', xPlayer.source, nil , source, name ,'Annonce', table.concat(args, " "))
        end
    else
        TriggerClientEvent('chat:addMessage', xPlayer.source, { args = { '^1Usage:', ' /ad [blabla bla]' } })
    end

end)

function getName(v)
	local result = MySQL.Sync.fetchAll('SELECT firstname, lastname FROM users WHERE identifier = @identifier', {
		['@identifier'] = GetPlayerIdentifiers(v)[1]
	})

	if result[1] and result[1].firstname and result[1].lastname then
		return ('%s %s'):format(result[1].firstname, result[1].lastname)
	else
		return GetPlayerName(v)
	end
end