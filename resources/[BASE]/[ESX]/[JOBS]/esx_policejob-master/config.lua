Config                            = {}

Config.DrawDistance               = 10.0 -- How close do you need to be for the markers to be drawn (in GTA units).
Config.MarkerType                 = {Cloakrooms = 20, Armories = 21, BossActions = 22, Vehicles = 36, Helicopters = 34}
Config.MarkerSize                 = {x = 1.5, y = 1.5, z = 0.5}
Config.MarkerColor                = {r = 50, g = 50, b = 204}

Config.EnablePlayerManagement     = true -- Enable if you want society managing.
Config.EnableArmoryManagement     = true
Config.EnableESXIdentity          = true -- Enable if you're using esx_identity.
Config.EnableLicenses             = true -- Enable if you're using esx_license.

Config.EnableHandcuffTimer        = false -- Enable handcuff timer? will unrestrain player after the time ends.
Config.HandcuffTimer              = 10 * 60000 -- 10 minutes.

Config.EnableJobBlip              = false -- Enable blips for cops on duty, requires esx_society.
Config.ItemForJobBlip             = "traqueur_lspd" -- Nom de l'item qui permet d'avoir un blip sur c'est collégue
Config.EnableCustomPeds           = false -- Enable custom peds in cloak room? See Config.CustomPeds below to customize peds.
Config.EnableTenuGrader			  = true

Config.EnableESXService           = false -- Enable esx service?
Config.MaxInService               = -1 -- How much people can be in service at once?

Config.Locale                     = 'fr'

Config.PoliceStations = {

	LSPD = {

		Blip = {
			Coords  = vector3(-440.25, 6002.26, 40.8),
			Sprite  = 60,
			Display = 4,
			Scale   = 0.8,
			Colour  = 29
		},

		Cloakrooms = {
			vector3(-453.32, 6013.97, 31.71)
		},

		Armories = {
			vector3(-439.18, 6010.45, 27.98)
		},

		Vehicles = {
			{
				Spawner = vector3(-442.89, 5995.77, 31.49),
				InsideShop = vector3(-472.17, 6025.24, 31.34),
				SpawnPoints = {
					{coords = vector3(-447.67, 5994.41, 31.34), heading = 83.03, radius = 6.0},
					{coords = vector3(-450.39, 5998.03, 31.34), heading = 86.96, radius = 3.0},
					{coords = vector3(-453.69, 6001.78, 31.34), heading = 89.44, radius = 4.5},
					{coords = vector3(-457.66, 6005.45, 31.34), heading = 89.56, radius = 3.5},
				}
			},

			{
				Spawner = vector3(473.3, -1018.8, 28.0),
				InsideShop = vector3(228.5, -993.5, -99.0),
				SpawnPoints = {
					{coords = vector3(475.9, -1021.6, 28.0), heading = 276.1, radius = 6.0},
					{coords = vector3(484.1, -1023.1, 27.5), heading = 302.5, radius = 6.0}
				}
			}
		},

		Helicopters = {
			{
				Spawner = vector3(-444.39, 5997.11, 31.49),
				InsideShop = vector3(-475.16, 5988.62, 31.33),
				SpawnPoints = {
					{coords = vector3(-475.16, 5988.62, 31.33), heading = 39.60, radius = 10.0}
				}
			}
		},

		BossActions = {
			vector3(-447.02, 6014.22, 36.50)
		}

	}

}

Config.OnlyPolicemen = true

Config.ReceiveAmmo = 1000   

Config.Armory = { ["x"] = -437.38, ["y"] = 6001.12, ["z"] = 31.71, ["h"] = 223.98 }
Config.ArmoryPed = { ["x"] = -435.96, ["y"] = 5999.78, ["z"] = 31.71, ["h"] = 45.62, ["hash"] = "s_m_y_sheriff_01" }

Config.ArmoryAccesory = {
    { name = 'gasmask',      label = "Masque a gaz",   price = 75 },
    { name = 'traqueur_lspd',      label = "Traqueur LSPD",   price = 100 },
	{ name = 'poignet',      label = "Poignet",   price = 3 },
	{ name = 'silencieux',      label = "Silencieux",   price = 3 },
	{ name = 'flashlight',      label = "Lampe",   price = 3 },
	{ name = 'scope_macro',      label = "Petite lunette",   price = 4 }
}

Config.ArmoryWeapons = {
    { ["hash"] = "weapon_sniperrifle", ["type"] = "rifle" },
    { ["hash"] = "weapon_heavysniper_mk2", ["type"] = "rifle" },
	{ ["hash"] = "weapon_specialcarbine", ["type"] = "rifle" },
	{ ["hash"] = "weapon_carbinerifle", ["type"] = "rifle" },
	{ ["hash"] = "weapon_carbinerifle_mk2", ["type"] = "rifle" },
	{ ["hash"] = "weapon_pumpshotgun", ["type"] = "rifle" },
	{ ["hash"] = "weapon_pumpshotgun_mk2", ["type"] = "rifle" },
	{ ["hash"] = "weapon_combatpistol", ["type"] = "pistol" },
	{ ["hash"] = "weapon_pistol_mk2", ["type"] = "pistol" },
	{ ["hash"] = "weapon_nightstick", ["type"] = "pistol" },
	{ ["hash"] = "weapon_stungun", ["type"] = "pistol" },
	{ ["hash"] = "weapon_flashlight", ["type"] = "pistol" },
	{ ["hash"] = "weapon_fireextinguisher", ["type"] = "pistol" }
	
}

Config.AuthorizedVehicles = {
	car = {
		recruit = {
            {model = 'sheriff', price = 1},
            {model = 'sheriff2', price = 1},
            {model = 'policeb', price = 1},
        },

		officer = {
            {model = 'sheriff', price = 1},
            {model = 'sheriff2', price = 1},
            {model = 'policeb', price = 1},

		},

		sergeant = {
            {model = 'sheriff', price = 1},
            {model = 'sheriff2', price = 1},
            {model = 'policeb', price = 1},
		},

		chef = {
            {model = 'sheriff', price = 1},
            {model = 'sheriff2', price = 1},
            {model = 'policeb', price = 1},
		},

		boss = {
            {model = 'sheriff', price = 1},
            {model = 'sheriff2', price = 1},
            {model = 'policeb', price = 1},
        }
	},

	helicopter = {
		recruit = {
			{model = 'polmav', props = {modLivery = 0}, price = 10}
		},

		officer = {
			{model = 'polmav', props = {modLivery = 0}, price = 10}
		},

		sergeant = {
			{model = 'polmav', props = {modLivery = 0}, price = 10}
		},

		lieutenant = {
			{model = 'polmav', props = {modLivery = 0}, price = 10}
		},

		boss = {
			{model = 'polmav', props = {modLivery = 0}, price = 100000}
		}
	}
}

Config.CustomPeds = {
	shared = {
		{label = 'Sheriff Ped', maleModel = 's_m_y_sheriff_01', femaleModel = 's_f_y_sheriff_01'},
		{label = 'Police Ped', maleModel = 's_m_y_cop_01', femaleModel = 's_f_y_cop_01'}
	},

	recruit = {},

	officer = {},

	sergeant = {},

	lieutenant = {},

	boss = {
		{label = 'SWAT Ped', maleModel = 's_m_y_swat_01', femaleModel = 's_m_y_swat_01'}
	}
}

-- CHECK SKINCHANGER CLIENT MAIN.LUA for matching elements
Config.Uniforms = {
	cadet = {
        male = {
            ['tshirt_1'] = 54,  ['tshirt_2'] = 0,
            ['torso_1'] = 190,   ['torso_2'] = 0,
            ['decals_1'] = 0,   ['decals_2'] = 0,
            ['arms'] = 0,
            ['pants_1'] = 52,   ['pants_2'] = 1,
            ['shoes_1'] = 24,   ['shoes_2'] = 0,
            ['helmet_1'] = 46,  ['helmet_2'] = 0,
            ['chain_1'] = 0,    ['chain_2'] = 0,
            ['mask_1'] = -1,  ['mask_2'] = 0,
            ['bproof_1'] = 10,  ['bproof_2'] = 0,
            ['ears_1'] = 2,     ['ears_2'] = 0,
            ['bags_1'] = 0,    ['bags_2'] = 0,
        },
        female = {
            ['tshirt_1'] = 19,  ['tshirt_2'] = 0,
            ['torso_1'] =192,   ['torso_2'] = 0,
            ['decals_1'] = 0,   ['decals_2'] = 0,
            ['arms'] = 14,
            ['pants_1'] = 54,   ['pants_2'] = 1,
            ['shoes_1'] = 24,   ['shoes_2'] = 0,
            ['helmet_1'] = 45,  ['helmet_2'] = 0,
            ['chain_1'] = 0,    ['chain_2'] = 0,
            ['mask_1'] = -1,  ['mask_2'] = 0,
            ['bproof_1'] = 19,  ['bproof_2'] = 0,
            ['ears_1'] = 2,     ['ears_2'] = 0,
            ['bags_1'] = 0,    ['bags_2'] = 0,
        }
	},

	sheriff1 = {
        male = {
            ['tshirt_1'] = 55,  ['tshirt_2'] = 0,
            ['torso_1'] = 100,   ['torso_2'] = 0,
            ['decals_1'] = 0,   ['decals_2'] = 0,
            ['arms'] = 0,
            ['pants_1'] = 48,   ['pants_2'] = 0,
            ['shoes_1'] = 51,   ['shoes_2'] = 0,
            ['helmet_1'] = -1,  ['helmet_2'] = 0,
            ['chain_1'] = -1,    ['chain_2'] = 0,
            ['mask_1'] = -1,  ['mask_2'] = 0,
            ['bproof_1'] = 13,  ['bproof_2'] = 0,
            ['ears_1'] = 5,     ['ears_2'] = 4,
            ['bags_1'] = 0,    ['bags_2'] = 0
        },
        female = {
            ['tshirt_1'] = 27,  ['tshirt_2'] = 0,
            ['torso_1'] = 192,   ['torso_2'] = 0,
            ['decals_1'] = 0,   ['decals_2'] = 0,
            ['arms'] = 14,
            ['pants_1'] = 54,   ['pants_2'] = 1,
            ['shoes_1'] = 24,   ['shoes_2'] = 0,
            ['helmet_1'] = -1,  ['helmet_2'] = 0,
            ['chain_1'] = 8,    ['chain_2'] = 0,
            ['mask_1'] = -1,  ['mask_2'] = 0,
            ['bproof_1'] = 14,  ['bproof_2'] = 0,
            ['ears_1'] = 2,     ['ears_2'] = 0,
            ['bags_1'] = 52,    ['bags_2'] = 0,
        }
	},

	sheriff2 = {
        male = {
            ['tshirt_1'] = 55,  ['tshirt_2'] = 0,
            ['torso_1'] = 99,   ['torso_2'] = 0,
            ['decals_1'] = 0,   ['decals_2'] = 0,
            ['arms'] = 1,
            ['pants_1'] = 48,   ['pants_2'] = 0,
            ['shoes_1'] = 51,   ['shoes_2'] = 0,
            ['helmet_1'] = -1,  ['helmet_2'] = 0,
            ['chain_1'] = -1,    ['chain_2'] = 0,
            ['mask_1'] = -1,  ['mask_2'] = 0,
            ['bproof_1'] = 13,  ['bproof_2'] = 0,
            ['ears_1'] = 5,     ['ears_2'] = 4,
            ['bags_1'] = 0,    ['bags_2'] = 0
        },
        female = {
            ['tshirt_1'] = 27,  ['tshirt_2'] = 0,
            ['torso_1'] = 192,   ['torso_2'] = 0,
            ['decals_1'] = 0,   ['decals_2'] = 0,
            ['arms'] = 14,
            ['pants_1'] = 54,   ['pants_2'] = 1,
            ['shoes_1'] = 24,   ['shoes_2'] = 0,
            ['helmet_1'] = -1,  ['helmet_2'] = 0,
            ['chain_1'] = 8,    ['chain_2'] = 0,
            ['mask_1'] = -1,  ['mask_2'] = 0,
            ['bproof_1'] = 14,  ['bproof_2'] = 0,
            ['ears_1'] = 2,     ['ears_2'] = 0,
            ['bags_1'] = 52,    ['bags_2'] = 0,
        }
    },
    sheriff3 = {
        male = {
            ['tshirt_1'] = 55,  ['tshirt_2'] = 0,
            ['torso_1'] = 94,   ['torso_2'] = 1,
            ['decals_1'] = 0,   ['decals_2'] = 0,
            ['arms'] = 0,
            ['pants_1'] = 32,   ['pants_2'] = 0,
            ['shoes_1'] = 13,   ['shoes_2'] = 0,
            ['helmet_1'] = -1,  ['helmet_2'] = 0,
            ['chain_1'] = -1,    ['chain_2'] = 0,
            ['mask_1'] = -1,  ['mask_2'] = 0,
            ['bproof_1'] = 13,  ['bproof_2'] = 0,
            ['ears_1'] = 5,     ['ears_2'] = 4,
            ['bags_1'] = 0,    ['bags_2'] = 0
        },
        female = {
            ['tshirt_1'] = 27,  ['tshirt_2'] = 0,
            ['torso_1'] = 192,   ['torso_2'] = 0,
            ['decals_1'] = 0,   ['decals_2'] = 0,
            ['arms'] = 14,
            ['pants_1'] = 54,   ['pants_2'] = 1,
            ['shoes_1'] = 24,   ['shoes_2'] = 0,
            ['helmet_1'] = -1,  ['helmet_2'] = 0,
            ['chain_1'] = 8,    ['chain_2'] = 0,
            ['mask_1'] = -1,  ['mask_2'] = 0,
            ['bproof_1'] = 14,  ['bproof_2'] = 0,
            ['ears_1'] = 2,     ['ears_2'] = 0,
            ['bags_1'] = 52,    ['bags_2'] = 0,
        }
	},

	casquette = {
		male = {
			['helmet_1'] = 33,  ['helmet_2'] = 0
		},
		female = {
			['helmet_1'] = 1,  ['helmet_2'] = 0
		}
    },
    casquette_moto = {
		male = {
			['helmet_1'] = 17,  ['helmet_2'] = 1
		},
		female = {
			['helmet_1'] = 1,  ['helmet_2'] = 0
		}
	},

	bullet_wear = {
		male = {
			['bproof_1'] = 12,  ['bproof_2'] = 1
		},
		female = {
			['bproof_1'] = 11,  ['bproof_2'] = 1
		}
	},

}
