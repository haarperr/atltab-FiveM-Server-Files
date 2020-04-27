Config              = {}
Config.DrawDistance = 100.0
Config.MarkerColor  = { r = 255, g = 255, b = 1 }
Config.Locale       = 'fr'
Config.MaxInService = -1

Config.AuthorizedVehicles = {
 --   { name = 'schafter3',  label = 'Schafter V12' },
    { name = 'Mule3',  label = 'Camion de demenagement' },
}


Config.Zones = {
	OfficeEnter = {
		Pos   = { x = -141.226, y = -614.166, z = -167.820 },
		Size  = { x = 1.5, y = 1.5, z = 1.0 },
		Type  = 1
	},

	OfficeExit = {
		Pos   = { x = -141.226, y = -614.166, z = -167.820 },
		Size  = { x = 1.5, y = 1.5, z = 1.0 },
		Type  = 1
	},

	OfficeInside = {
		Pos   = { x = -140.07, y = -623.72, z = 167.820 },
		Size  = { x = 1.5, y = 1.5, z = 1.0 },
		Type  = -1
	},

	OfficeOutside = {
		Pos   = { x = -202.238, y = -578.193, z = 39.500 },
		Size  = { x = 1.5, y = 1.5, z = 1.0 },
		Type  = -1
	},

	OfficeActions = {
		Pos   = { x = -124.786, y = -641.486, z = 168.820 },
		Size  = { x = 1.0, y = 1.0, z = 1.0 },
		Type  = -1
	},

	Vehicles = {
        Pos          = { x = -113.765, y = -614.924, z = 36.00 },
        SpawnPoint   = { x = -105.344, y = -610.903, z = 36.00 },
        Size         = { x = 1.0, y = 1.0, z = 1.0 },
        Type         = 22,
        Heading      = 164.14
    },

     VehicleDeleter = {
        Pos   = { x = -116.32, y = -640.94, z = 35.00 },
        Size  = { x = 3.0, y = 3.0, z = 0.4 },
        Type  = 1,
  
  }


 -- marker = {
 --        Pos   = { x = -117.37, y = -604.45, z = 36.28 },
 --        Size  = { x = 1.0, y = 1.0, z = 1.0 },
 --        Type  = 22
  
 --  },

 -- marker2 = {
 --        Pos   = { x = -140.17, y = -617.76, z = 168.82 },
 --         Size  = { x = 1.0, y = 1.0, z = 1.0 },
 --        Type  = 22
  
 --   }



    
}
