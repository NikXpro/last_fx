Config = {}
Config.Locale = 'fr'

Config.NourritureList = {
	frite = {
        --itemName = "",
		itemType = {
			AnimeType = "Eat", --Eat, Drink
			Message = ""
		},
		
		GiveEat = {
			Activate = true,
			AddNumber = 200000
		},
		GiveDrink = {
			Activate = false,
			AddNumber = 200000
		}
	},

	donuts = {
       -- itemName = "",
		itemType = {
			AnimeType = "Eat", --Eat, Drink
			Message = "Vous avez manger un donuts"
		},
		GiveEat = {
			Activate = true,
			AddNumber = 200000
		},
		GiveDrink = {
			Activate = false,
			AddNumber = 200000
		}
	},

	bread = {
       -- itemName = "",
		itemType = {
			AnimeType = "Eat", --Eat, Drink
			Message = "Vous avez manger du pain"
		},
		GiveEat = {
			Activate = true,
			AddNumber = 200000
		},
		GiveDrink = {
			Activate = true,
			AddNumber = 200000
		}
	}
}