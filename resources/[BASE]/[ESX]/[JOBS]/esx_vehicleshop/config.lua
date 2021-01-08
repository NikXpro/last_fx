Config                            = {}
Config.DrawDistance               = 100
Config.MarkerColor                = {r = 120, g = 120, b = 240}
Config.EnablePlayerManagement     = true -- enables the actual car dealer job. You'll need esx_addonaccount, esx_billing and esx_society
Config.ResellPercentage           = 50

Config.Locale                     = 'fr'

Config.LicenseEnable = false -- require people to own drivers license when buying vehicles? Only applies if EnablePlayerManagement is disabled. Requires esx_license

-- looks like this: 'LLL NNN'
-- The maximum plate length is 8 chars (including spaces & symbols), don't go past it!
Config.PlateLetters  = 3
Config.PlateNumbers  = 3
Config.PlateUseSpace = false

Config.Zones = {

	ShopEntering = {
		Pos   = vector3(-234.52, 6217.09, 30.94),
		Size  = {x = 1.5, y = 1.5, z = 1.0},
		Type  = 1
	},

	ShopInside = {
		Pos     = vector3(-228.56, 6221.36, 30.51),
		Size    = {x = 1.5, y = 1.5, z = 1.0},
		Heading = 44.29,
		Type    = -1
	},

	ShopOutside = {
		Pos     = vector3(-228.56, 6221.36, 30.51),
		Size    = {x = 1.5, y = 1.5, z = 1.0},
		Heading = 44.29,
		Type    = -1
	},

	BossActions = {
		Pos   = vector3(-238.27, 6219.19, 30.94),
		Size  = {x = 1.5, y = 1.5, z = 1.0},
		Type  = -1
	},

	GiveBackVehicle = {
		Pos   = vector3(-239.93, 6251.11, 30.49),
		Size  = {x = 3.0, y = 3.0, z = 1.0},
		Type  = (Config.EnablePlayerManagement and 1 or -1)
	},

	ResellVehicle = {
		Pos   = vector3(-245.51, 6257.56, 30.49),
		Size  = {x = 3.0, y = 3.0, z = 1.0},
		Type  = 1
	}

}
