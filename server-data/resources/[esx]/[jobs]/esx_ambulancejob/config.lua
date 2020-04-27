Config                            = {}

Config.DrawDistance               = 100.0

Config.Marker                     = { type = 22, x = 1.0, y = 1.0, z = 1.0, r = 200, g = 0, b = 0, a = 100, rotate = false }

Config.ReviveReward               = 100  -- revive reward, set to 0 if you don't want it enabled
Config.AntiCombatLog              = true -- enable anti-combat logging?
Config.LoadIpl                    = false -- disable if you're using fivem-ipl or other IPL loaders

Config.Locale                     = 'fr'

local second = 1000
local minute = 60 * second

Config.EarlyRespawnTimer          = 1 * minute  -- Time til respawn is available
Config.BleedoutTimer              = 5 * minute -- Time til the player bleeds out

Config.EnablePlayerManagement     = true

Config.AlertPoliceIfHasGun     		= true
Config.RemoveCashAfterRPDeath     = true
Config.RemoveWeaponsAfterRPDeath  = false
Config.RemoveItemsAfterRPDeath    = false

-- Let the player pay for respawning early, only if he can afford it.
Config.EarlyRespawnFine           = false
Config.EarlyRespawnFineAmount     = 5000

Config.RespawnPoint = { coords = vector3(298.89, -572.96, 43.26), heading = 131.31 }

Config.Hospitals = {

	CentralLosSantos = {

		Blip = {
			coords = vector3(297.97, -584.09, 43.26),
			sprite = 61,
			scale  = 0.8,
			color  = 59
		},

		AmbulanceActions = {
			vector3(309.62, -602.81, 43.29)
		},

		Pharmacies = {
			vector3(310.3, -599.59, 43.29)
		},

		Vehicles = {
			{
				Spawner = vector3(293.04, -599.08, 43.3),
				InsideShop = vector3(446.7, -1355.6, 43.5),
				Marker = { type = 36, x = 1.0, y = 1.0, z = 1.0, r = 200, g = 0, b = 0, a = 100, rotate = true },
				SpawnPoints = {
					{ coords = vector3(289.73, -593.14, 43.17), heading = 342.9, radius = 4.0 },
					{ coords = vector3(294.0, -1433.1, 29.8), heading = 227.6, radius = 4.0 },
					{ coords = vector3(309.4, -1442.5, 29.8), heading = 227.6, radius = 6.0 }
				}
			}
		},

		Helicopters = {
			{
				Spawner = vector3(338.52, -587.5, 74.17),
				InsideShop = vector3(305.6, -1419.7, 41.5),
				Marker = { type = 34, x = 1.5, y = 1.5, z = 1.5, r = 100, g = 150, b = 150, a = 100, rotate = true },
				SpawnPoints = {
					{ coords = vector3(351.16, -588.38, 74.17), heading = 318.76, radius = 10.0 },
					{ coords = vector3(299.5, -1453.2, 46.5), heading = 142.7, radius = 10.0 }
				}
			}
		},

		FastTravels = {
			{
				From = vector3(247.3, -1371.5, 23.5),
				To = { coords = vector3(333.1, -1434.9, 45.5), heading = 138.6 },
				Marker = { type = 20, x = 1.0, y = 1.0, z = 1.0, r = 200, g = 0, b = 0, a = 100, rotate = true }
			},

			{
				From = vector3(335.5, -1432.0, 45.50),
				To = { coords = vector3(249.1, -1369.6, 23.5), heading = 0.0 },
				Marker = { type = 20, x = 2.0, y = 2.0, z = 0.5, r = 200, g = 0, b = 0, a = 100, rotate = false }
			},

			{
				From = vector3(325.33, -598.76, 42.40),
				To = { coords = vector3(340.48, -584.64, 74.17), heading = 245.15 },
				Marker = { type = 27, x = 1.5, y = 1.5, z = 1.0, r = 200, g = 0, b = 0, a = 100, rotate = false }
			},

			{
				From = vector3(338.59, -583.81, 73.20),
				To = { coords = vector3(323.55, -598.17, 43.60), heading = 63.15 },
				Marker = { type = 27, x = 1.5, y = 1.5, z = 1.0, r = 200, g = 0, b = 0, a = 100, rotate = false }
			},

			{
				From = vector3(334.23, -569.14, 42.40),
				To = { coords = vector3(274.33, -1360.42, 24.54), heading = 50.02 },
				Marker = { type = 27, x = 1.5, y = 1.5, z = 1.0, r = 200, g = 0, b = 0, a = 100, rotate = false }
			},

			{
				From = vector3(275.84, -1361.43, 23.60),
				To = { coords = vector3(333.68, -571.15, 43.32), heading = 149.75 },
				Marker = { type = 27, x = 1.5, y = 1.5, z = 1.0, r = 200, g = 0, b = 0, a = 100, rotate = false }
			}
		},

		FastTravelsPrompt = {
			{
				From = vector3(237.4, -1373.8, 26.1),
				To = { coords = vector3(251.9, -1363.3, 38.5), heading = 170.0 },
				Marker = { type = 27, x = 1.5, y = 1.5, z = 0.5, r = 200, g = 0, b = 0, a = 100, rotate = false },
				Prompt = _U('fast_travel')
			},

			{
				From = vector3(256.5, -1357.7, 36.1),
				To = { coords = vector3(240.9, -1370.3, 23.5), heading = 325.0 },
				Marker = { type = 27, x = 1.5, y = 1.5, z = 0.5, r = 200, g = 0, b = 0, a = 100, rotate = false },
				Prompt = _U('fast_travel')
			}
		}

	}
}

Config.AuthorizedVehicles = {

	ambulance = {
		{ model = 'ambulance', label = 'Ambulance Van', price = 1000}
	},

	doctor = {
		{ model = 'ambulance', label = 'Ambulance Van', price = 1000}
	},

	chief_doctor = {
		{ model = 'ambulance', label = 'Ambulance Van', price = 1000}
	},

	boss = {
		{ model = 'ambulance', label = 'Ambulance Van', price = 1000}
	}

}

Config.AuthorizedHelicopters = {

	ambulance = {},

	doctor = {
		{ model = 'buzzard2', label = 'Nagasaki Buzzard', price = 10000 }
	},

	chief_doctor = {
		{ model = 'buzzard2', label = 'Nagasaki Buzzard', price = 10000 },
		{ model = 'seasparrow', label = 'Sea Sparrow', price = 10000 }
	},

	boss = {
		{ model = 'buzzard2', label = 'Nagasaki Buzzard', price = 10000 },
		{ model = 'seasparrow', label = 'Sea Sparrow', price = 10000 }
	}

}
