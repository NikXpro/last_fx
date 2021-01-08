ESX = nil

local Emoticon = {
	Couleur = {
		Rouge = "🔴",
		Bleu = "🔵",
		Blanc = "⚪",
		Noir = "⚫", 
		Orange = "🟠",
		Jaune = "🟡",
		Vert = "🟢",
		Violet = "🟣",
		Maron = "🟤",
	},
	Poubelle = "🗑️",
	Donner = "📤",
	Recevoir = "📥",
	Utilliser = "✅",
	Loupe = "🔎",
	Cheval = "🐎",
	Menotte = "🔗",
	Dollard = "💲",
	Objet = "🧊",
	Reparer = "🔧",
	Netoyer = "🧼",
	Sang = "🩸",
	Droite = ">",
	Annonce = "📢",
	Pied = "👣",
	Feuille = "📃",
	Permis = "📇",
	Dossier = "📁"
}

Citizen.CreateThread(function()
  while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj)
			ESX = obj
		end)
		Citizen.Wait(10)
	end
end)

function RefreshMoney()
	if ESX.PlayerData.job ~= nil and ESX.PlayerData.job.grade_name == 'boss' then
		ESX.TriggerServerCallback('esx_society:getSocietyMoney', function(money)
			societymoney = ESX.Math.GroupDigits(money)
		end, ESX.PlayerData.job.name)
	end
end


--Ouverture du menu
Keys.Register('F5', 'F5', 'Menu personnel.', function()
  if not RageUI.Visible() then
    ESX.TriggerServerCallback('nth_f5:billing', function(bills)
      PM.facture = bills
      ESX.PlayerData = ESX.GetPlayerData()
      RageUI.Visible(personalMenu, not RageUI.Visible(personalMenu))
    end)
  end
end)