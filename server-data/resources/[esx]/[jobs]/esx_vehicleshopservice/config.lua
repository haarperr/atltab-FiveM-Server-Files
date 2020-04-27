Config                            = {}
Config.DrawDistance               = 15.5
Config.MarkerColor                = { r = 120, g = 120, b = 240 }
Config.EnablePlayerManagement     = false -- enables the actual car dealer job. You'll need esx_addonaccount, esx_billing and esx_society
Config.EnableOwnedVehicles        = true
Config.EnableSocietyOwnedVehicles = false -- use with EnablePlayerManagement disabled, or else it wont have any effects
Config.ResellPercentage           = 50

Config.Locale                     = 'fr'

Config.LicenseEnable = false -- require people to own drivers license when buying vehicles? Only applies if EnablePlayerManagement is disabled. Requires esx_license

-- The maximum plate length is 8 chars (including spaces & symbols), don't go past it!
Config.PlateLetters  = 3
Config.PlateNumbersStart  = 2
Config.PlateNumbersEnd  = 3

Config.Zones = {

	-- ShopEntering = {
	-- 	Pos   = { x = -31.45, y = -1106.70, z = 25.422 },
	-- 	Size  = { x = 1.3, y = 1.3, z = 1.0 },
	-- 	Type  = -1
	-- },

	-- ShopInside = {
	-- 	Pos     = { x = -47.570, y = -1097.221, z = 25.422 },
	-- 	Size    = { x = 1.5, y = 1.5, z = 1.0 },
	-- 	Heading = -20.0,
	-- 	Type    = -1
	-- },

	-- ShopOutside = {
	-- 	Pos     = { x = -28.637, y = -1085.691, z = 25.565 },
	-- 	Size    = { x = 1.5, y = 1.5, z = 1.0 },
	-- 	Heading = 330.0,
	-- 	Type    = -1
	-- },

	ShopEntering = {
		Pos   = { x = -268.91, y = -956.21, z = 31.00 },
		Size  = { x = 1.0, y = 1.0, z = 1.0 },
		Type  = 36
	},

	ShopInside = {
		Pos     = { x = -276.29, y = -999.1, z = 26.88 },
		Size    = { x = 1.5, y = 1.5, z = 1.0 },
		Heading = 246.5,
		Type    = -1
	},

	ShopOutside = {
		Pos     = { x = -276.29, y = -999.1, z = 26.88 },
		Size    = { x = 1.5, y = 1.5, z = 1.0 },
		Heading = 246.5,
		Type    = -1
	},

	BossActions = {
		Pos   = { x = -32.065, y = -1114.277, z = 25.422 },
		Size  = { x = 1.5, y = 1.5, z = 1.0 },
		Type  = -1
	},

	GiveBackVehicle = {
		Pos   = { x = -18.227, y = -1078.558, z = 50.675 },
		Size  = { x = 3.0, y = 3.0, z = 1.0 },
		Type  = -1
	},

	ResellVehicle = {
		Pos   = { x = -275.96, y = -995.55, z = 26.00 },
		Size  = { x = 2.0, y = 2.0, z = 2.0 },
		Type  = 36
	}

}