Config                            = {}

Config.DrawDistance               = 100.0
Config.MarkerType                 = 1
Config.MarkerSize                 = { x = 1.5, y = 1.5, z = 0.5 }
Config.MarkerColor                = { r = 50, g = 50, b = 204 }

Config.EnablePlayerManagement     = true
Config.EnableArmoryManagement     = true
Config.EnableESXIdentity          = true -- enable if you're using esx_identity
Config.EnableNonFreemodePeds      = false -- turn this on if you want custom peds
Config.EnableLicenses             = true -- enable if you're using esx_license

Config.EnableHandcuffTimer        = false -- enable handcuff timer? will unrestrain player after the time ends
Config.HandcuffTimer              = 10 * 60000 -- 10 mins

Config.EnableJobBlip              = true -- enable blips for colleagues, requires esx_society

Config.MaxInService               = -1
Config.Locale                     = 'fr'

Config.StateStations = {

	State = {

		Blip = {
			Coords  = vector3(-811.376, 181.169, 76.74),
			Sprite  = 419,
			Display = 4,
			Scale   = 0.8
		},

		Cloakrooms = {
			vector3(-811.79, 175.12, 76.74)
		},

		Armories = {
			vector3(-803.40, 185.38, 72.10)
		},

		Vehicles = {
			{
				Spawner = vector3(-811.13, 187.51, 72.5),
				InsideShop = vector3(-805.67, 162.79, 71.5),
				SpawnPoints = {
					{ coords = vector3(-823.19, 183.61, 71.90), heading = 137.0, radius = 6.0 },
					{ coords = vector3(-828.56, 177.05, 70.97), heading = 152.0, radius = 6.0 }
				}
			}
		},

		Helicopters = {
			{
				Spawner = vector3(-782.041, 156.52, 67.6),
				InsideShop = vector3(-773.78, 144.14, 67.470),
				SpawnPoints = {
					{ coords = vector3(-773.27, 160.082, 67.47), heading = 263.92, radius = 10.0 }
				}
			}
		},

		BossActions = {
			vector3(-811.36462402344, 181.18090820313, 76.740760803223)
		}

	}

}

Config.AuthorizedWeapons = {
	recruit = {
	},

	officer = {
		
	},

	sergeant = {
		
	},

	intendent = {
		
	},

	lieutenant = {
	
	},

	chef = {
	},

	boss = {
		{ weapon = 'WEAPON_COMBATPISTOL', components = { 0, 0, 1000, 4000, nil }, price = 100 },
		{ weapon = 'WEAPON_CARBINERIFLE', components = { 0, 2000, 100000, 4000, 8000, nil }, price = 500 },
		{ weapon = 'WEAPON_NIGHTSTICK', price = 0 },
		{ weapon = 'WEAPON_STUNGUN', price = 500 },
		{ weapon = 'WEAPON_FLASHLIGHT', price = 0 },
		{ weapon = 'WEAPON_FIREEXTINGUISHER', price = 0 },
		{ weapon = 'GADGET_PARACHUTE', price = 0 }
	}
}

Config.AuthorizedVehicles = {
	Shared = {
		{ model = 'fbi2', label = 'Unmarked Emergency', price = 1000 },
		{ model = 'baller6', label = 'Range Rover', price = 1000 },
		{ model = 'schafter6', label = 'Schafter V6', price = 1000 }
	},

	recruit = {

	},

	officer = {
	},

	sergeant = {
	},

	intendent = {

	},

	lieutenant = {

	},

	chef = {

	},

	boss = {
		{ model = 'btype', label = 'BType', price = 1000 },
		{ model = 'xls2', label = 'XLS 2', price = 1000 },
	}
}

Config.AuthorizedHelicopters = {
	recruit = {},

	officer = {},

	sergeant = {},

	intendent = {},

	lieutenant = {
	},

	chef = {
	},

	boss = {
		{ model = 'buzzard2', label = 'Buzzard 2', livery = 0, price = 1000 }
	}
}

-- CHECK SKINCHANGER CLIENT MAIN.LUA for matching elements
Config.Uniforms = {
	recruit_wear = {
		male = {
			['tshirt_1'] = 31,  ['tshirt_2'] = 0,
			['torso_1'] = 142,   ['torso_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 33,
			['pants_1'] = 10,   ['pants_2'] = 0,
			['shoes_1'] = 20,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 12,    ['chain_2'] = 0,
			['ears_1'] = 2,     ['ears_2'] = 0
		},
		female = {
			['tshirt_1'] = 31,  ['tshirt_2'] = 0,
			['torso_1'] = 142,   ['torso_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 33,
			['pants_1'] = 10,   ['pants_2'] = 0,
			['shoes_1'] = 20,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 12,    ['chain_2'] = 0,
			['ears_1'] = 2,     ['ears_2'] = 0
		}
	},
	boss_wear = { -- currently the same as chef_wear
		male = {
			['tshirt_1'] = 31,  ['tshirt_2'] = 0,
			['torso_1'] = 142,   ['torso_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 33,
			['pants_1'] = 10,   ['pants_2'] = 0,
			['shoes_1'] = 20,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 12,    ['chain_2'] = 0,
			['ears_1'] = 2,     ['ears_2'] = 0
		},
		female = {
			['tshirt_1'] = 31,  ['tshirt_2'] = 0,
			['torso_1'] = 142,   ['torso_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 33,
			['pants_1'] = 10,   ['pants_2'] = 0,
			['shoes_1'] = 20,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 12,    ['chain_2'] = 0,
			['ears_1'] = 2,     ['ears_2'] = 0
		}
	},
	bullet_wear = {
		male = {
			['bproof_1'] = 11,  ['bproof_2'] = 1
		},
		female = {
			['bproof_1'] = 13,  ['bproof_2'] = 1
		}
	}
}