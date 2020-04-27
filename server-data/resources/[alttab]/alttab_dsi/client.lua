Citizen.CreateThread(function()
	while true do
		SetDiscordAppId(574947153374478347)
		SetDiscordRichPresenceAsset('alttabgaming')
        SetDiscordRichPresenceAssetText('ALTTAB GAMING')

		Citizen.Wait(60000)
		SetRichPresence(GetPlayerName(PlayerId()))

		-- players = {}
		-- for _, player in ipairs(GetActivePlayers()) do
		-- 	table.insert( players, player )
		-- end
		-- SetRichPresence(#players)
	end
end)