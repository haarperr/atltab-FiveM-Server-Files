AddEventHandler('es:invalidCommandHandler', function(source, command_args, user)
	CancelEvent()
	TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEM', _U('unknown_command', command_args[1]) } })
end)

AddEventHandler('chatMessage', function(source, name, message)
	if string.sub(message, 1, string.len('/')) ~= '/' then
		CancelEvent()

		if Config.EnableESXIdentity then name = GetCharacterName(source) end
		TriggerClientEvent('chat:addMessage', -1, { args = { name, message }, color = { 26, 188, 156 } })
	end
end)

RegisterServerEvent('esx_rpchat:notifNewTweet')
AddEventHandler('esx_rpchat:notifNewTweet', function(name)
	if name == nil then	
		return 
	end
	local msg = "Nouveau tweet de ^*^5" .. name .. "^0^r, ouvrez ^*^5Twitter^0^r sur votre téléphone 🐌"
	TriggerClientEvent('chat:addMessage', -1, { args = { "^5NOTIFICATION", msg } })
end)

function GetCharacterName(source)
	local result = MySQL.Sync.fetchAll('SELECT firstname, lastname FROM users WHERE identifier = @identifier', {
		['@identifier'] = GetPlayerIdentifiers(source)[1]
	})

	if result[1] and result[1].firstname and result[1].lastname then
		if Config.OnlyFirstname then
			return result[1].firstname
		else
			return ('%s %s'):format(result[1].firstname, result[1].lastname)
		end
	else
		return GetPlayerName(source)
	end
end
