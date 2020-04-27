Config = {}
Config.Locale = 'fr'
Config.Marker = {
	r = 250, g = 0, b = 0, a = 100,  -- red color
	x = 1.0, y = 1.0, z = 1.0,       -- tiny, cylinder formed circle
	DrawDistance = 15.0, Type = 29    -- default circle type, low draw distance due to indoors area
}

Config.PoliceNumberRequired = 4
Config.TimerBeforeNewRob    = 1800 -- The cooldown timer on a store after robbery was completed / canceled, in seconds

Config.MaxDistance    = 20   -- max distance from the robbary, going any longer away from it will to cancel the robbary
Config.GiveBlackMoney = false -- give black money? If disabled it will give cash instead

Stores = {
	["paleto_twentyfourseven"] = {
		position = { x = 1734.80, y = 6420.90, z = 34.60 },
		reward = math.random(1000, 10000),
		nameOfStore = "24/7. (Paleto Bay)",
		secondsRemaining = 300, -- seconds
		lastRobbed = 0
	},
	["sandyshores_twentyfoursever"] = {
		position = { x = 1959.33, y = 3748.91, z = 32.00 },
		reward = math.random(1000, 20000),
		nameOfStore = "24/7. (Sandy Shores)",
		secondsRemaining = 300, -- seconds
		lastRobbed = 0
	},
	["bar_one"] = {
		position = { x = 1982.45, y = 3053.40, z = 47.21 },
		reward = math.random(1000, 5000),
		nameOfStore = "Yellow Jack. (Sandy Shores)",
		secondsRemaining = 300, -- seconds
		lastRobbed = 0
	},
	["ocean_liquor"] = {
		position = { x = -2959.62, y = 387.10, z = 14.00 },
		reward = math.random(1000, 20000),
		nameOfStore = "Robs Liquor. (Great Ocean Highway)",
		secondsRemaining = 300, -- seconds
		lastRobbed = 0
	},
	["rancho_liquor"] = {
		position = { x = 1126.80, y = -980.40, z = 45.41 },
		reward = math.random(1000, 20000),
		nameOfStore = "Robs Liquor. (El Rancho Blvd)",
		secondsRemaining = 300, -- seconds
		lastRobbed = 0
	},
	["sanandreas_liquor"] = {
		position = { x = -1220.78, y = -916.00, z = 11.32 },
		reward = math.random(1000, 30000),
		nameOfStore = "Robs Liquor. (San Andreas Avenue)",
		secondsRemaining = 300, -- seconds
		lastRobbed = 0
	},
	["grove_ltd"] = {
		position = { x = -43.39, y = -1748.30, z = 29.00 },
		reward = math.random(1000, 10000),
		nameOfStore = "LTD Gasoline. (Grove Street)",
		secondsRemaining = 300, -- seconds
		lastRobbed = 0
	},
	["bouchta_ltd"] = {
		position = { x = -709.69, y = -904.14, z = 18.75 },
		reward = math.random(1000, 10000),
		nameOfStore = "LTD Gasoline. (Bouchta)",
		secondsRemaining = 300, -- seconds
		lastRobbed = 0
	}
}
