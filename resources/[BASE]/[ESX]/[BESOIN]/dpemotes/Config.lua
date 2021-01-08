Config = {
-- Change the language of the menu here!.
-- Note fr and de are google translated, if you would like to help out with translation / just fix it for your server check below and change translations yourself
-- try en, fr, de or sv.
	MenuLanguage = 'en',	
-- Set this to true to enable some extra prints
	DebugDisplay = false,
-- Set this to false if you have something else on X, and then just use /e c to cancel emotes.
	EnableXtoCancel = true,
-- Set this to true if you want to disarm the player when they play an emote.
	DisarmPlayer= false,
-- Set this if you really wanna disable emotes in cars, as of 1.7.2 they only play the upper body part if in vehicle
    AllowedInCars = true,
-- You can disable the (F3) menu here / change the keybind.
	MenuKeybindEnabled = true,
	MenuKeybind = 170, -- Get the button number here https://docs.fivem.net/game-references/controls/
-- You can disable the Favorite emote keybinding here.
	FavKeybindEnabled = true,
	FavKeybind = 171, -- Get the button number here https://docs.fivem.net/game-references/controls/
-- You can change the header image for the f3 menu here
-- Use a 512 x 128 image!
-- NOte this might cause an issue of the image getting stuck on peoples screens
	CustomMenuEnabled = false,
	MenuImage = "https://i.imgur.com/kgzvDwQ.png",
-- You can change the menu position here
	MenuPosition = "right", -- (left, right)
-- You can disable the Ragdoll keybinding here.
	RagdollEnabled = false,
	RagdollKeybind = 314, -- Get the button number here https://docs.fivem.net/game-references/controls/
-- You can disable the Facial Expressions menu here.
	ExpressionsEnabled = true,
-- You can disable the Walking Styles menu here.
	WalkingStylesEnabled = true,	
-- You can disable the Shared Emotes here.
    SharedEmotesEnabled = true,
    CheckForUpdates = true,
-- If you have the SQL imported enable this to turn on keybinding.
    SqlKeybinding = true,
}

Config.KeybindKeys = {
    ['num4'] = 108,
    ['num5'] = 110,
    ['num6'] = 109,
    ['num7'] = 117,
    ['num8'] = 111,
    ['num9'] = 118
}

Config.Languages = {
  ['en'] = {
        ['emotes'] = 'Animations',
        ['danceemotes'] = "🕺 Animations de danse",
        ['propemotes'] = "📦 Animations avec objet",
        ['favoriteemotes'] = "🌟 Favoris",
        ['gesteemotes'] = "✌ Gestes",
        ['autreemotes'] = "❓ Autre",
        ['activiteemotes'] = "🔨 Activité",
        ['positionemotes'] = "🧍 Position",
        ['sportemotes'] = "⚽ Sport",
        ['santeemotes'] = "🏪 Santé",
        ['favoriteinfo'] = "Sélectionnez un emote ici pour le définir comme votre favori.",
        ['rfavorite'] = "Réinitialiser les favoris",
        ['prop2info'] = "❓ Les emotes d'accessoires peuvent être situés à la fin",
        ['set'] = "Set (",
        ['setboundemote'] = ") vos emote lié ?",
        ['newsetemote'] = "~w~ est maintenant votre emote est lié, appuyez sur ~ g ~ CapsLock ~ w ~ pour l'utiliser.",
        ['cancelemote'] = "Annuler l'animation",
        ['cancelemoteinfo'] = "~ r ~ X ~ w ~ à annuler l'émote en cours de lecture",
        ['walkingstyles'] = "Styles de marche",
        ['resetdef'] = "Rétablir les valeurs par défaut",
        ['normalreset'] = "Normal (Reset)",
        ['moods'] = "Humeurs",
        ['infoupdate'] = "Informations",
        ['infoupdateav'] = "Informations (Update available)",
        ['infoupdateavtext'] = "Une mise à jour est disponible, obtenez la dernière version sur ~y~https://github.com/andristum/dpemotes~w~",
        ['suggestions'] = "Suggestions ?",
        ['suggestionsinfo'] = "'dullpear_dev ' est disponible sur les forums FiveM pour toute suggestion de fonctionnalité / emote! ✉️",
        ['notvaliddance'] = "n'est pas une danse valide.",
        ['notvalidemote'] = "n'est pas un emote valide.",
        ['nocancel'] = "Aucun emote à annuler.",
        ['maleonly'] = "Cet emote est réservé aux hommes, désolé!",
        ['emotemenucmd'] = "Do /emotemenu pour un menu",
        ['shareemotes'] = "👫 Animations partagées",
        ['shareemotesinfo'] = "Inviter une personne proche à emoter",
        ['sharedanceemotes'] = "🕺 Dances partagées",
        ['notvalidsharedemote'] = "n'est pas un emote partagé valide.",
        ['sentrequestto'] = "Demande envoyée à ~g~",
        ['nobodyclose'] = "Personne assez proche.",
        ['doyouwanna'] = "~y~Y~w~ accepter, ~r~L~w~ refuser (~g~",
        ['refuseemote'] = "Emote refusée.",
        ['makenearby'] = "fait jouer le joueur à proximité",
        ['camera'] = "Appuyer sur ~y~G~w~ pour utiliser le flash de l'appareil.",
        ['makeitrain'] = "Appuyer sur ~y~G~w~ pour jeter de l'argent.",
        ['pee'] = "Tenir ~y~G~w~ faire pipi.",
        ['spraychamp'] = "Tenir ~y~G~w~ vaporiser du champagne.",
        ['bound'] = "Liée ",
        ['to'] = "à",
        ['currentlyboundemotes'] = " Emotes actuellement liés:",
        ['notvalidkey'] = "n'est pas une clé valide.",
        ['keybinds'] = "🔢 Liens Clés",
        ['keybindsinfo'] = "utiliser"
  },
  ['fr'] = {
        ['emotes'] = 'Animations',
        ['danceemotes'] = "🕺 Emotes de danse",
        ['propemotes'] = "📦 Em Prop Emotes",
        ['favoriteemotes'] = "🌟 Favori",
        ['favoriteinfo'] = "Définir un emote comme favori.",
        ['rfavorite'] = "réinitialiser le favori.",
        ['prop2info'] = "❓ Prop Emotes peuvent être situés à la fin",
        ['set'] = "Set (",
        ['setboundemote'] = ") pour être votre emote lié?",
        ['newsetemote'] = "~w~ est maintenant votre emote liée, appuyez sur ~g~CapsLock~w~ pour l'utiliser.",
        ['cancelemote'] = "Annuler Emote",
        ['cancelemoteinfo'] = "~r~X~w~ Annule l'emote en cours de lecture",
        ['walkingstyles'] = "Styles de marche",
        ['resetdef'] = "Réinitialiser aux valeurs par défaut",
        ['normalreset'] = "Normal (réinitialiser)",
        ['moods'] = "Humeurs",
        ['infoupdate'] = "Information",
        ['infoupdateav'] = "Information (Mise à jour disponible)",
        ['infoupdateavtext'] = "Une mise à jour est disponible ~y~https://github.com/andristum/dpemotes~w~",
        ['suggestions'] = "Suggestions?",
        ['suggestionsinfo'] = "'dullpear_dev' sur les forums FiveM pour toutes les suggestions de fonction / emote! ✉️",
		['notvaliddance'] = "n'est pas une danse valide",
        ['notvalidemote'] = "n'est pas un emote valide",
        ['nocancel'] = "Pas d'emote à annuler",
        ['maleonly'] = "Cet emote est réservé aux hommes, désolé!",
        ['emotemenucmd'] = "Do /emotemenu pour un menu",
        ['shareemotes'] = "👫 Em Emotes partagées",
        ['shareemotesinfo'] = "Inviter une personne proche à emoter",
        ['sharedanceemotes'] = "🕺 Dances partagées",
        ['notvalidsharedemote'] = "n'est pas un emote partagé valide.",
        ['sentrequestto'] = "Demande envoyée à ~g~",
        ['nobodyclose'] = "Personne assez proche.",
        ['doyouwanna'] = "~y~Y~w~ accepter, ~r~L~w~ refuser (~g~",
        ['refuseemote'] = "Emote refusée.",
        ['makenearby'] = "fait jouer le joueur à proximité",
        ['camera'] = "Presse ~y~G~w~ utiliser le flash de l'appareil.",
        ['makeitrain'] = "Presse ~y~G~w~ jeter de l'argent.",
        ['pee'] = "Tenir ~y~G~w~ faire pipi.",
        ['spraychamp'] = "Tenir ~y~G~w~ vaporiser du champagne.",
        ['bound'] = "Liée ",
        ['to'] = "à",
        ['currentlyboundemotes'] = " Emotes actuellement liés:",
        ['notvalidkey'] = "n'est pas une clé valide.",
        ['keybinds'] = "🔢 Liens Clés",
        ['keybindsinfo'] = "utiliser"
  }
}