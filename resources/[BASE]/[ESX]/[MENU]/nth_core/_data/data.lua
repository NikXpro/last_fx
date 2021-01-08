data = {}

data.positions = {
    {{-1337.45, -1161.55, 3.51, 265.02}, {20.09, 114.39, 82.27, 248.5}, {36,237,157}, "Appuyer sur ~INPUT_CONTEXT~ pour ~g~Entrer~s~/~r~Sortir~s~ de chez ~b~D.K~s~"}, -- 410th appartement chef
	{{-12.93, 89.05, 39.54, 1.02}, {92.72, 49.26, 72.52, 62.96}, {255, 157, 0}, "Appuyer sur ~INPUT_CONTEXT~ pour ~g~Entrer~s~/~r~Sortir~s~ de chez les ~b~Yute~s~"},
	{{-1382.26, -609.86, 29.82, 206.75}, {-1385.02, -606.47, 29.32, 116.22}, {255, 157, 0}, "Appuyer sur ~INPUT_CONTEXT~ pour ~g~Entrer~s~/~r~Sortir~s~ du comptoir avant."},
	{{-1386.25, -627.48, 29.82, 295.72}, {-1371.33, -625.97, 29.82, 121.9}, {255, 157, 0}, "Appuyer sur ~INPUT_CONTEXT~ pour ~g~Entrer~s~/~r~Sortir~s~ du comptoir arriére."}
}


data.keylist = {
  {Action = "Téléphone", Key = "F1"},
  {Action = "Menu personnel", Key = "F5"},
  {Action = "Menu entreprise", Key = "F6"},
  {Action = "Menu organisation", Key = "F7"},
  {Action = "Vérouiller/Dévérouiller vehicule", Key = "MAJUSCULE"},
  {Action = "Pointer du doight", Key = "B"}
}

data.sounds = {
  {Name = "LSPD! Stop...", Sound = "stop_vehicle", Distance = 100, Volume = 0.6},
  {Name = "Driver! Stop...", Sound = "stop_vehicle-2", Distance = 100, Volume = 0.6},
  {Name = "Stop the fucking car...", Sound = "stop_the_f_car", Distance = 100, Volume = 0.6},
  {Name = "Stop or executed...", Sound = "stop_or_executed", Distance = 100, Volume = 0.6},
  {Name = "Stop or I kill ya...", Sound = "stop_or_i_kill", Distance = 100, Volume = 0.6},

  {Name = "Dont make me...", Sound = "dont_make_me", Distance = 100, Volume = 0.6},
  {Name = "Dont move a muscle...", Sound = "stop_dont_move", Distance = 100, Volume = 0.6},
  {Name = "Give yourself up...", Sound = "give_yourself_up", Distance = 100, Volume = 0.6},
  {Name = "Stay right there...", Sound = "stay_right_there", Distance = 100, Volume = 0.6},
  {Name = "Freeze...", Sound = "freeze_lspd", Distance = 100, Volume = 0.6},

  {Name = "Clear the area...", Sound = "clear_the_area", Distance = 100, Volume = 0.6},
  {Name = "Go away now...", Sound = "this_is_the_lspd", Distance = 100, Volume = 0.6},
  {Name = "Move along people...", Sound = "move_along_people", Distance = 100, Volume = 0.6},
  {Name = "Get out of here...", Sound = "get_out_of_here_now", Distance = 100, Volume = 0.6},
  {Name = "Disperse now...", Sound = "disperse_now", Distance = 100, Volume = 0.6},

  {Name = "It's over...", Sound = "its_over_for_you", Distance = 100, Volume = 0.6},
  {Name = "You are finished..", Sound = "you_are_finished_dhead", Distance = 100, Volume = 0.6},
  {Name = "You can't hide boy..", Sound = "cant_hide_boi", Distance = 100, Volume = 0.6},
  {Name = "Drop a missile..", Sound = "drop_a_missile", Distance = 100, Volume = 0.6},
  {Name = "Shoot to kill..", Sound = "shoot_to_kill", Distance = 100, Volume = 0.6}
}

data.menu = {

	--LocationSpawn = {
	--	MenuId = "locationspawn",
	--	MenuType = "Location",
	--	TitreMenu = "Location",
	--	DescriptionMenu = "~b~Location de vehicule en tout genre~w~",
--
	--	MessageZone = "Appuyer sur [~b~E~w~] pour parler a Jean Louis.",
--
	--	BlipId = 403, -- https://docs.fivem.net/docs/game-references/blips/
	--	BlipScale = 0.85, -- Taille du blip sur la minimap
	--	BlipColor = 8, -- https://wiki.gtanet.work/index.php?title=Blips
	--	BlipName = "Marina Location",
--
	--	ped = "s_m_m_scientist_01",
	--	TailleZone = 2.0,
	--	zone = vector3(-764.86, -1316.3, 4.15),
    --	heading = 226.04,
	--	
	--	vehicule = {
	--		fagio = {
	--			nom = "Fagio",
	--			NomVehicule = "fagio",
	--			prix = 50,
	--			spawnPoint = {
	--				{pos = vector3(-766.46, -1324.58, 5),heading = 140.15,}
	--			}
	--		}
	--	}
	--},


	police = {
		MenuId = "police",
		MenuType = "service",
		ServiceOff = "policeoff", --nom du job hors service
		ServiceOn = "police", --nom du job en service
		TitreMenu = "Service police",
		DescriptionMenu = "Prendre/quitter son service~",

		MessageZone = "Appuyer sur ~INPUT_CONTEXT~ pour parler a Bob.",

		ped = "s_m_y_cop_01",
		TailleZone = 2.5,
		zone = vector3(443.5, -986.5, 29.69),
    	heading = 95.9,
	},
	ambulance = {
		MenuId = "ambulance",
		MenuType = "service",
		ServiceOff = "ambulanceoff", --nom du job hors service
		ServiceOn = "ambulance", --nom du job en service
		TitreMenu = "Service médical",
		DescriptionMenu = "Prendre/quitter son service~",

		MessageZone = "Appuyer sur ~INPUT_CONTEXT~ pour parler a Jacqueline.",

		ped = "ig_jewelass",
		TailleZone = 2.5,
		zone = vector3(312.35, -594.19, 42.28),
    	heading = 357.99,
	},
	cardealer = {
		MenuId = "cardealer",
		MenuType = "service",
		ServiceOff = "cardealeroff", --nom du job hors service
		ServiceOn = "cardealer", --nom du job en service
		TitreMenu = "Service vendeur",
		DescriptionMenu = "Prendre/quitter son service~",

		MessageZone = "Appuyer sur ~INPUT_CONTEXT~ pour parler a Simeon.",

		ped = "ig_siemonyetarian",
		TailleZone = 2,
		zone = vector3(-55.58, -1098.03, 25.42),
    	heading = 333.21,
	},

	PharmaciePaleto = {
		MenuId = "Pharmacie", -- Identifiant unique pour chaque shop
		MenuType = "shop",
		illegal = false,
		property = false,
		TitreMenu = "Pharmacie",
		DescriptionMenu = "~b~Vente de matériel médical~w~",

		MessageZone = "Appuyer sur [~b~E~w~] pour parler a Louis.",

		-- Inutile si shop illégal, le blip ne sera pas afficher
		BlipId = 403, -- https://docs.fivem.net/docs/game-references/blips/
		BlipScale = 0.85, -- Taille du blip sur la minimap
		BlipColor = 8, -- https://wiki.gtanet.work/index.php?title=Blips
		BlipName = "Pharmacie",

		ped = "s_m_m_scientist_01",
		TailleZone = 2.0,
		zone = vector3(-177.43, 6384.67, 30.5),
    	heading = 231.53,
		
		items = {
			bandage = {
				licence = false,
				weapon = false,
				nom = "Bandage",
				NomItem = "bandage",
				prix = 340
			},
			medikit = {
				licence = false,
				weapon = false,
				nom = "Kit de soin",
				NomItem = "medikit",
				prix = 720
			}
		}
	},

	LsTelecom = {
		MenuId = "LsTelecom", -- Identifiant unique pour chaque shop
		MenuType = "shop",
		illegal = false,
		property = false,
		TitreMenu = "LsTelecom",
		DescriptionMenu = "~b~Vente d'objets high tech~w~",

		MessageZone = "Appuyer sur [~b~E~w~] pour parler a Max.",

		-- Inutile si shop illégal, le blip ne sera pas afficher
		BlipId = 459, -- https://docs.fivem.net/docs/game-references/blips/
		BlipScale = 0.85, -- Taille du blip sur la minimap
		BlipColor = 1, -- https://wiki.gtanet.work/index.php?title=Blips
		BlipName = "LsTelecom",

		ped = "a_m_y_business_02",
		TailleZone = 2.0,
		zone = vector3(-86.63, 31.52, 70.95),
    	heading = 74.65,
		
		items = {
			phone = {
				licence = false,
				weapon = false,
				nom = "Téléphone",
				NomItem = "phone",
				prix = 250
			},
		}
	},

	AmmunationSandy = {
		MenuId = "AmmunationSandy", -- Identifiant unique pour chaque shop
		MenuType = "shop",
		illegal = false,
		property = false,
		TitreMenu = "Ammunation",
		DescriptionMenu = "~b~Vente d'armes ~w~",

		MessageZone = "Appuyer sur [~b~E~w~] pour parler a Joe.",

		-- Inutile si shop illégal, le blip ne sera pas afficher
		BlipId = 110, -- https://docs.fivem.net/docs/game-references/blips/
		BlipScale = 0.85, -- Taille du blip sur la minimap
		BlipColor = 47, -- https://wiki.gtanet.work/index.php?title=Blips
		BlipName = "Ammunation",

		ped = "s_m_y_ammucity_01",
		TailleZone = 2.0,
		zone = vector3(1692.03, 3760.83, 33.71),
		heading = 219.64,
		
		items = {
			knife = {
				licence = false,
				weapon = true,
				nom = "Couteau",
				NomItem = "weapon_knife",
				prix = 250
			},
			pistol = {
				licence = true,
				weapon = true,
				nom = "Pistolet",
				NomItem = "weapon_pistol",
				prix = 3500
			}
		}
	},

	AmmunationPaleto = {
		MenuId = "AmmunationPaleto", -- Identifiant unique pour chaque shop
		MenuType = "shop",
		illegal = false,
		property = false,
		TitreMenu = "Ammunation",
		DescriptionMenu = "~b~Vente d'armes ~w~",

		MessageZone = "Appuyer sur [~b~E~w~] pour parler a Oussama.",

		-- Inutile si shop illégal, le blip ne sera pas afficher
		BlipId = 110, -- https://docs.fivem.net/docs/game-references/blips/
		BlipScale = 0.85, -- Taille du blip sur la minimap
		BlipColor = 47, -- https://wiki.gtanet.work/index.php?title=Blips
		BlipName = "Ammunation",

		ped = "s_m_y_ammucity_01",
		TailleZone = 2.0,
		zone = vector3(-331.79, 6084.73, 30.45),
		heading = 219.64,
		
		items = {
			knife = {
				licence = false,
				weapon = true,
				nom = "Couteau",
				NomItem = "weapon_knife",
				prix = 250
			},
			pistol = {
				licence = true,
				weapon = true,
				nom = "Pistolet",
				NomItem = "weapon_pistol",
				prix = 3500
			}
		}
	},

	MagasinRouge = {
		MenuId = "Rouge", -- Identifiant unique pour chaque shop
		MenuType = "shop",
		illegal = false,
		property = false,
		TitreMenu = "Magasin",
		DescriptionMenu = "~b~Vente en tout genre~w~",

		MessageZone = "Appuyer sur [~b~E~w~] pour parler a Apu.",

		-- Inutile si shop illégal, le blip ne sera pas afficher
		BlipId = 59, -- https://wiki.gtanet.work/index.php?title=Blips
		BlipScale = 0.85, -- Taille du blip sur la minimap
		BlipColor = 2, -- https://wiki.gtanet.work/index.php?title=Blips
		BlipName = "Magasin",

		ped = "mp_m_shopkeep_01",
		TailleZone = 2.0,
		zone = vector3(-47.227, -1758.68, 28.421),
    heading = 39.77,
		items = {
			bread = {
				licence = false,
				weapon = false,
				nom = "Pain",
				NomItem = "bread",
				  prix = 3,
      },
			eau = {    
        licence = false,
				weapon = false,
				nom = "Bouteille d'eau",
				NomItem = "water",
				  prix = 2,
			},
			jumelle = {    
        licence = false,
				weapon = false,
				nom = "Jumelle",
				NomItem = "jumelle",
				  prix = 137,
			},
			coca = {    
        licence = false,
				weapon = false,
				nom = "Coca",
				NomItem = "coca",
				  prix = 5,
			},
			chocolat = {    
        licence = false,
				weapon = false,
				nom = "Tablette de chocolat",
				NomItem = "chocolat",
				  prix = 6,
			}
		}
	},

	MagasinOrange = {
		MenuId = "Orange", -- Identifiant unique pour chaque shop
		MenuType = "shop",
		illegal = false,
		property = false,
		TitreMenu = "Magasin",
		DescriptionMenu = "~b~Vente en tout genre ~w~",

		MessageZone = "Appuyer sur [~b~E~w~] pour parler a George.",

		-- Inutile si shop illégal, le blip ne sera pas afficher
		BlipId = 59, -- https://wiki.gtanet.work/index.php?title=Blips
		BlipScale = 0.85, -- Taille du blip sur la minimap
		BlipColor = 2, -- https://wiki.gtanet.work/index.php?title=Blips
		BlipName = "Magasin",

		ped = "mp_m_shopkeep_01",
		TailleZone = 2.0,
		zone = vector3(-706.07, -913.825, 18.21),
		heading = 91.73,

		items = {
			sandwich = {    
        licence = false,
				weapon = false,
				nom = "Sandwich",
				NomItem = "sandwich",
				  prix = 8,
			},
			oasis = {    
        licence = false,
				weapon = false,
				nom = "Oasis",
				NomItem = "oasis",
				  prix = 6,
			},
			chips = {    
        licence = false,
				weapon = false,
				nom = "Chips",
				NomItem = "chips",
				  prix = 5,
			},
			eau = {    
        licence = false,
				weapon = false,
				nom = "Bouteille d'eau",
				NomItem = "water",
				  prix = 4,
			}
		}
	},


	MagasinViolet = {
		MenuId = "Violet", -- Identifiant unique pour chaque shop
		MenuType = "shop",
		illegal = false,
		property = false,
		TitreMenu = "Magasin",
		DescriptionMenu = "~b~Vente en tout genre ~w~",

		MessageZone = "Appuyer sur [~b~E~w~] pour parler a Chaban.",

		-- Inutile si shop illégal, le blip ne sera pas afficher
		BlipId = 59, -- https://wiki.gtanet.work/index.php?title=Blips
		BlipScale = 0.85, -- Taille du blip sur la minimap
		BlipColor = 2, -- https://wiki.gtanet.work/index.php?title=Blips
		BlipName = "Magasin",

		ped = "u_m_m_aldinapoli",
		TailleZone = 2.0,
		zone = vector3(1164.86, -323.029, 68.205),
		heading = 103.08,

		items = {
			pizza = {    
        licence = false,
				weapon = false,
				nom = "Pizza",
				NomItem = "pizza",
				  prix = 15,
			},
			biere = {    
        licence = false,
				weapon = false,
				nom = "Bière",
				NomItem = "biere",
				  prix = 10,
			},
			eau = {    
        licence = false,
				weapon = false,
				nom = "Bouteille d'eau",
				NomItem = "water",
				  prix = 6,
			},
			donuts = {    
        licence = false,
				weapon = false,
			  nom = "Donuts",
			  NomItem = "donuts",
				prix = 6,
		  }
		}
	},

	MagasinJaune = {
		MenuId = "Jaune", -- Identifiant unique pour chaque shop
		MenuType = "shop",
		illegal = false,
		property = false,
		TitreMenu = "Magasin",
		DescriptionMenu = "~b~Vente en tout genre ~w~",

		MessageZone = "Appuyer sur [~b~E~w~] pour parler a Natacha.",

		-- Inutile si shop illégal, le blip ne sera pas afficher
		BlipId = 59, -- https://wiki.gtanet.work/index.php?title=Blips
		BlipScale = 0.85, -- Taille du blip sur la minimap
		BlipColor = 2, -- https://wiki.gtanet.work/index.php?title=Blips
		BlipName = "Magasin",

		ped = "a_f_y_bevhills_01",
		TailleZone = 2.0,
		zone = vector3(372.58, 326.55, 102.56),
		heading = 251.18,

		items = {
			hamburger = {    
        		licence = false,
				weapon = false,
				nom = "Hamburger",
				NomItem = "hamburger",
				prix = 17,
			},
			limonade = {    
        		licence = false,
				weapon = false,
				nom = "Limonade",
				NomItem = "limonade",
				prix = 13,
			},
			sprite = {    
        		licence = false,
				weapon = false,
				nom = "Sprite",
				NomItem = "sprite",
				prix = 14,
			},
			eau = {    
        		licence = false,
				weapon = false,
			  	nom = "Bouteille d'eau",
			  	NomItem = "water",
				prix = 12,
			},
			pain = {    
        		licence = false,
				weapon = false,
			  	nom = "Pain",
			  	NomItem = "bread",
				prix = 10,
			}
		}
	},

	MagasinMaron = {
		MenuId = "Maron", -- Identifiant unique pour chaque shop
		MenuType = "shop",
		illegal = false,
		property = false,
		TitreMenu = "Magasin",
		DescriptionMenu = "~b~Vente en tout genre ~w~",

		MessageZone = "Appuyer sur [~b~E~w~] pour parler a Kashalena.",

		-- Inutile si shop illégal, le blip ne sera pas afficher
		BlipId = 59, -- https://wiki.gtanet.work/index.php?title=Blips
		BlipScale = 0.85, -- Taille du blip sur la minimap
		BlipColor = 2, -- https://wiki.gtanet.work/index.php?title=Blips
		BlipName = "Magasin",

		ped = "a_f_y_eastsa_03",
		TailleZone = 2.0,
		zone = vector3(-3242.27, 999.96, 11.83),
		heading = 359.51,

		items = {
			eau = {    
        licence = false,
				weapon = false,
			  nom = "Bouteille d'eau",
			  NomItem = "water",
				prix = 9,
			},
			pain = {    
        licence = false,
				weapon = false,
			  nom = "Pain",
			  NomItem = "bread",
				prix = 8,
			},
			coca = {    
        licence = false,
				weapon = false,
				nom = "Coca",
				NomItem = "coca",
				  prix = 10,
			},
			pizza = {    
        licence = false,
				weapon = false,
			  nom = "Pizza",
			  NomItem = "pizza",
				prix = 16,
			},
			chips = {    
        licence = false,
				weapon = false,
			  nom = "Chips",
			  NomItem = "chips",
				prix = 6,
			}
		}
	},

	MagasinBleu = {
		MenuId = "Bleu", -- Identifiant unique pour chaque shop
		MenuType = "shop",
		illegal = false,
		property = false,
		TitreMenu = "Magasin",
		DescriptionMenu = "~b~Vente en tout genre ~w~",

		MessageZone = "Appuyer sur [~b~E~w~] pour parler a Pamela.",

		-- Inutile si shop illégal, le blip ne sera pas afficher
		BlipId = 59, -- https://wiki.gtanet.work/index.php?title=Blips
		BlipScale = 0.85, -- Taille du blip sur la minimap
		BlipColor = 2, -- https://wiki.gtanet.work/index.php?title=Blips
		BlipName = "Magasin",

		ped = "ig_denise",
		TailleZone = 2.0,
		zone = vector3(2557.10, 380.821, 107.62),
		heading = 359.69,

		items = {
			hamburger = {    
        licence = false,
				weapon = false,
			  nom = "Hamburger",
			  NomItem = "hamburger",
				prix = 20,
			},
			biere = {    
        licence = false,
				weapon = false,
			  nom = "Bière",
			  NomItem = "biere",
				prix = 17,
			},
			donuts = {    
        licence = false,
				weapon = false,
			  nom = "Donuts",
			  NomItem = "donuts",
				prix = 14,
			},
			chips = {    
        licence = false,
				weapon = false,
			  nom = "Chips",
			  NomItem = "chips",
				prix = 10,
			},
			oasis = {    
        licence = false,
				weapon = false,
			  nom = "Oasis",
			  NomItem = "oasis",
				prix = 12,
			},
			eau = {    
        licence = false,
				weapon = false,
			  nom = "Bouteille d'eau",
			  NomItem = "water",
				prix = 9,
			}
		}
	},

	MagasinVert = {
		MenuId = "Vert",
		MenuType = "shop",
		illegal = false,
		property = false,
		TitreMenu = "Magasin",
		DescriptionMenu = "~b~Vente en tout genre ~w~",

		MessageZone = "Appuyer sur [~b~E~w~] pour parler a Cheryl.",

		BlipId = 59,
		BlipScale = 0.85,
		BlipColor = 2,
		BlipName = "Magasin",

		ped = "a_f_m_fatwhite_01",
		TailleZone = 2.0,
		zone = vector3(1960.04, 3740.001, 31.34),
		heading = 294.193,

		items = {
			eau = {    
        licence = false,
				weapon = false,
			  nom = "Bouteille d'eau",
			  NomItem = "water",
				prix = 3,
			},
			pain = {    
        licence = false,
				weapon = false,
			  nom = "Pain",
			  NomItem = "bread",
				prix = 4,
			},
			biere = {    
        licence = false,
				weapon = false,
			  nom = "Bière",
			  NomItem = "biere",
				prix = 5,
			},
			sandwich = {    
        licence = false,
				weapon = false,
			  nom = "Sandwich",
			  NomItem = "sandwich",
				prix = 4,
			},
			chocolat = {    
        licence = false,
				weapon = false,
			  nom = "Tablette de chocolat",
			  NomItem = "chocolat",
			  prix = 6,
			}
		}
	},

	MagasinBleuClaire = {
		MenuId = "BleuClaire",
		MenuType = "shop",
		illegal = false,
		property = false,
		TitreMenu = "Magasin",
		DescriptionMenu = "~b~Vente en tout genre ~w~",

		MessageZone = "Appuyer sur [~b~E~w~] pour parler a Andrea.",

		BlipId = 59,
		BlipScale = 0.85,
		BlipColor = 2,
		BlipName = "Magasin",

		ped = "s_f_y_shop_mid",
		TailleZone = 2.0,
		zone = vector3(1727.85, 6415.19, 34.037),
		heading = 237.97,

		items = {
			eau = {    
        		licence = false,
				weapon = false,
				nom = "Bouteille d'eau",
				NomItem = "water",
				prix = 10,
			},
			pain = {    
        		licence = false,
				weapon = false,
				nom = "Pain",
				NomItem = "bread",
				prix = 11,
			},
			coca = {    
        		licence = false,
				weapon = false,
				nom = "Coca",
				NomItem = "coca",
				prix = 11,
			},
			sprite = {    
        		licence = false,
				weapon = false,
				nom = "Sprite",
				NomItem = "sprite",
				prix = 9,
			},  
			oasis = {    
        		licence = false,
				weapon = false,
				nom = "Oasis",
				NomItem = "oasis",
				prix = 10,
			},
			biere = {    
        		licence = false,
				weapon = false,
				nom = "Bière",
				NomItem = "biere",
				prix = 9,
			},
			limonade = {    
        		licence = false,
				weapon = false,
				nom = "Limonade",
				NomItem = "limonade",
				prix = 8,
			},
			sandwich = {    
        		licence = false,
				weapon = false,
				nom = "Sandwich",
				NomItem = "sandwich",
				prix = 14,
			},
			hamburger = {    
        		licence = false,
				weapon = false,
				nom = "Hamburger",
				NomItem = "hamburger",
				prix = 16,
			},
			pizza = {    
        		licence = false,
				weapon = false,
				nom = "Pizza",
				NomItem = "pizza",
				prix = 20,
			},
			chocolat = {    
        		licence = false,
				weapon = false,
				nom = "Tablette de chocolat",
				NomItem = "chocolat",
				prix = 9,
			},
			chips = {    
        		licence = false,
				weapon = false,
				nom = "Chips",
				NomItem = "chips",
				prix = 6,
			},
			donuts = {    
        		licence = false,
				weapon = false,
				nom = "Donuts",
				NomItem = "donuts",
				prix = 5,
			},
			frite = {    
        		licence = false,
				weapon = false,
				nom = "Barquette de frite",
				NomItem = "frite",
				prix = 21,
			},
		},
	},
}
