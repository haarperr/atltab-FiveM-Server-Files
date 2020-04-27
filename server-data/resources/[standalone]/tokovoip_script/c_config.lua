TokoVoipConfig = {
	refreshRate = 100, -- Rate at which the data is sent to the TSPlugin
	networkRefreshRate = 2000, -- Rate at which the network data is updated/reset on the local ped
	playerListRefreshRate = 5000, -- Rate at which the playerList is updated
	minVersion = "1.2.4", -- Version of the TS plugin required to play on the server

	distance = {
		15, -- Normal speech distance in gta distance units
		5, -- Whisper speech distance in gta distance units
		40, -- Shout speech distance in gta distance units
	},
	headingType = 0, -- headingType 0 uses GetGameplayCamRot, basing heading on the camera's heading, to match how other GTA sounds work. headingType 1 uses GetEntityHeading which is based on the character's direction
	radioKey = 246, -- Keybind used to talk on the radio (Y)
	keySwitchChannels = 47, -- Keybind used to switch the radio channels (G)
	keySwitchChannelsSecondary = 21, -- If set, both the keySwitchChannels and keySwitchChannelsSecondary keybinds must be pressed to switch the radio channels (LEFT SHIFT)
	keyProximity = 56, -- Keybind used to switch the proximity mode (F9)

	plugin_data = {
		-- TeamSpeak channel name used by the voip
		-- If the TSChannelWait is enabled, players who are currently in TSChannelWait will be automatically moved
		-- to the TSChannel once everything is running
		TSChannel = "Citoyens",
		TSPassword = "dakchizwin", -- TeamSpeak channel password (can be empty)

		-- Optional: TeamSpeak waiting channel name, players wait in this channel and will be moved to the TSChannel automatically
		-- If the TSChannel is public and people can join directly, you can leave this empty and not use the auto-move
		TSChannelWait = "En attente",

		-- Blocking screen informations
		TSServer = "ts.alttabgaming.com", -- TeamSpeak server address to be displayed on blocking screen
		TSChannelSupport = "🔑 Support (ouvert)", -- TeamSpeak support channel name displayed on blocking screen
		TSDownload = "http://alttabgaming.com", -- Download link displayed on blocking screen
		TSChannelWhitelist = { -- Black screen will not be displayed when users are in those TS channels
			"🔑 Support (ouvert)",
			"🔒 Support (fermé)"
		},

		-- The following is purely TS client settings, to match tastes
		local_click_on = true, -- Is local click on sound active
		local_click_off = true, -- Is local click off sound active
		remote_click_on = true, -- Is remote click on sound active
		remote_click_off = true, -- Is remote click off sound active
		enableStereoAudio = true, -- If set to true, positional audio will be stereo (you can hear people more on the left or the right around you)

		localName = "Citoyen", -- If set, this name will be used as the user's teamspeak display name
		localNamePrefix = "[" .. GetPlayerServerId(PlayerId()) .. "] ", -- If set, this prefix will be added to the user's teamspeak display name
	}
};

AddEventHandler("onClientResourceStart", function(resource)
	if (resource == GetCurrentResourceName()) then	--	Initialize the script when this resource is started
		Citizen.CreateThread(function()
			TokoVoipConfig.plugin_data.localName = "Citoyen"; -- Set the local name
		end);
		TriggerEvent("initializeVoip"); -- Trigger this event whenever you want to start the voip
	end
end)
