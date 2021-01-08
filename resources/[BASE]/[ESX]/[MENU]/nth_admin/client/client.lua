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
	Droite = "→",
	Annonce = "📢",
	Pied = "👣",
	Feuille = "📃",
	Permis = "📇",
  Dossier = "📁",
  Parametre = "⚙️",
  Lettre = "📩",
  Attention = "⚠️",
  Interdit = "⛔",
  Cloche = "🔔"
}

local player = {
  group = "user",
  money = 0,
  banque = 0,
  black_money = 0,
  nom = "invalide",
  prenom = "invalide",
  PlayerTP = 1,
  PlayerFreeze = false,
  Setjob = 1
}

local ServersIdSession = {}

Citizen.CreateThread(function()
  while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj)
			ESX = obj
		end)
		Citizen.Wait(10)
	end
    ESX.PlayerData = ESX.GetPlayerData()
    while ESX.GetPlayerData().job == nil do
        Citizen.Wait(10)
    end
  ESX.GetWeaponList = ESX.GetWeaponList()
end)

Citizen.CreateThread(function()
    while true do
        Wait(500)
        for k,v in pairs(GetActivePlayers()) do
            local found = false
            for _,j in pairs(ServersIdSession) do
                if GetPlayerServerId(v) == j then
                    found = true
                end
            end
            if not found then
                table.insert(ServersIdSession, GetPlayerServerId(v))
            end
        end
    end
end)

RegisterNetEvent('returnSteamID')
AddEventHandler('returnSteamID', function(steamid, licenceid, xblid, liveid, discordid, ipid)
  
  steam = steamid
  licence = licenceid
  xbl = xblid
  live = liveid
  discord = discordid
  ip = ipid
end)



RegisterNetEvent("nth_admin:envoyer")
AddEventHandler("nth_admin:envoyer", function(msg)
	PlaySoundFrontend(-1, "CHARACTER_SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 1)
	local head = RegisterPedheadshot(PlayerPedId())
	while not IsPedheadshotReady(head) or not IsPedheadshotValid(head) do
		Wait(1)
	end
	headshot = GetPedheadshotTxdString(head)
	ESX.ShowAdvancedNotification('MESSAGE STAFF', '~r~Message privé', '~r~Message ~w~: ' ..msg, headshot, 3)
end)

RegisterNetEvent('nth_admin:Returngroup')
AddEventHandler('nth_admin:Returngroup', function(group, money, banque, black_money, nom, prenom)
  player.group = group
  player.money = money
  player.banque = banque
  player.black_money = black_money
  player.nom = nom
  player.prenom = prenom

end)

local adminMenu = RageUI.CreateMenu("Menu admin", "Menu admin")
adminMenu:SetRectangleBanner(2, 140, 4, 1.00)
local playerGestionMenu = RageUI.CreateSubMenu(adminMenu, "Gestion des joueurs", "Gestion des joueurs")
playerGestionMenu:SetRectangleBanner(2, 140, 4, 1.00)
local playerActionMenu = RageUI.CreateSubMenu(playerGestionMenu, "Action joueurs", "Action joueurs")
playerActionMenu:SetRectangleBanner(2, 140, 4, 1.00)
local playerInformationMenu = RageUI.CreateSubMenu(playerActionMenu, "Information", "Information joueurs")
playerInformationMenu:SetRectangleBanner(2, 140, 4, 1.00)
local playerIdentifieurMenu = RageUI.CreateSubMenu(playerInformationMenu, "Identifieur", "Identifieur joueurs")
playerIdentifieurMenu:SetRectangleBanner(2, 140, 4, 1.00)
local playerInformationMoneyMenu = RageUI.CreateSubMenu(playerInformationMenu, "Argent joueur", "Argent joueur")
playerInformationMoneyMenu:SetRectangleBanner(2, 140, 4, 1.00)
local playerInformationIdentiterMenu = RageUI.CreateSubMenu(playerInformationMenu, "Identiter joueur", "Identiter joueur")
playerInformationIdentiterMenu:SetRectangleBanner(2, 140, 4, 1.00)
local playerSubActionMenu = RageUI.CreateSubMenu(playerActionMenu, "Action joueur", "Action joueur")
playerSubActionMenu:SetRectangleBanner(2, 140, 4, 1.00)
local playerSanctionMenu = RageUI.CreateSubMenu(playerSubActionMenu, "Sanction joueur", "Sanction joueur")
playerSanctionMenu:SetRectangleBanner(2, 140, 4, 1.00)
local playerSetjobMenu = RageUI.CreateSubMenu(playerSubActionMenu, "Setjob joueur", "Setjob joueur")
playerSetjobMenu:SetRectangleBanner(2, 140, 4, 1.00)

Citizen.CreateThread(function()
  while (true) do
    Citizen.Wait(1.0)
    --Menu admin début
    RageUI.IsVisible(adminMenu, function()
      RageUI.Button('Gestion des joueurs', nil, {RightLabel = "→"}, true, {onSelected = function() end}, playerGestionMenu);
    end)
    --Menu admin fin

    --Menu gestion joueur début
    RageUI.IsVisible(playerGestionMenu, function()
      RageUI.Button('En ligne', nil, {RightLabel = #GetActivePlayers() .."/64", Color = { HightLightColor = { 0, 155, 0, 150 }, BackgroundColor = { 0, 155, 0, 150 } }}, true, {onSelected = function()end});
      RageUI.Separator("~r~   ============================================")

      for k,v in ipairs(ServersIdSession) do
        if GetPlayerName(GetPlayerFromServerId(v)) == "**Invalid**" then 
          table.remove(ServersIdSession, k) 
        end
        RageUI.Button("~r~[ID : "..v.."] ~s~- "..GetPlayerName(GetPlayerFromServerId(v)).." | ", nil, {RightLabel = Emoticon.Parametre}, true, {
          onSelected = function()
            IdSelected = v
          end,
        }, playerActionMenu);
      end
    end)
    --Menu gestion joueur fin

    --Menu action joueur début
    RageUI.IsVisible(playerActionMenu, function()
      RageUI.Button("INFORMATION", nil, {RightLabel = Emoticon.Droite}, true, {onSelected = function()TriggerServerEvent("nth_admin:Usergroup", IdSelected)end}, playerInformationMenu);
      RageUI.Button("ACTION", nil, {RightLabel = Emoticon.Droite}, true, {
        onSelected = function()
      
      end}, playerSubActionMenu);
    end)
    --Menu action joueur fin

    --Menu information joueur début
    RageUI.IsVisible(playerInformationMenu, function()
      RageUI.Button("IDENTIFIEUR", nil, {RightLabel = Emoticon.Loupe}, true, {onSelected = function() TriggerServerEvent("getSteamID", IdSelected) end}, playerIdentifieurMenu);
      RageUI.Button("ARGENT", nil, {RightLabel = Emoticon.Loupe}, true, {}, playerInformationMoneyMenu);
      RageUI.Button("IDENTITER", nil, {RightLabel = Emoticon.Loupe}, true, {}, playerInformationIdentiterMenu);
      RageUI.Button("Vie:", nil, {RightLabel = "~g~"..GetEntityHealth(GetPlayerPed(GetPlayerFromServerId(IdSelected))).."/"..GetEntityMaxHealth(GetPlayerPed(GetPlayerFromServerId(IdSelected)))}, true, {});
      RageUI.Button("Armure:", nil, {RightLabel = "~b~"..GetPedArmour(GetPlayerPed(GetPlayerFromServerId(IdSelected))).."/200"}, true, {});
      RageUI.Button("Groupe:", nil, {RightLabel = "~g~"..player.group.."~s~"}, true, {});
      RageUI.Button("Entreprise:", nil, {RightLabel = "~g~Patron | Unicorne(WIP)"}, true, {});
      RageUI.Button("Organisation:", nil, {RightLabel = "~g~OG | Ballas(WIP)"}, true, {});
    end)
    --Menu information joueur fin

    --Menu information money joueur début
    RageUI.IsVisible(playerInformationMoneyMenu, function()
      RageUI.Button("Liquide:", nil, {RightLabel = "~g~"..ESX.Math.GroupDigits(player.money).."$~s~"}, true, {});
      RageUI.Button("Banque:", nil, {RightLabel = "~b~"..ESX.Math.GroupDigits(player.banque).."$~s~"}, true, {});
      RageUI.Button("Argent sale:", nil, {RightLabel = "~r~"..ESX.Math.GroupDigits(player.black_money).."$~s~"}, true, {});
    end)
    --Menu information money joueur fin

    --Menu information money joueur début
    RageUI.IsVisible(playerInformationIdentiterMenu, function()
      RageUI.Button("Nom:", nil, {RightLabel = "~g~"..player.nom.."~s~"}, true, {});
      RageUI.Button("Prenom:", nil, {RightLabel = "~g~"..player.prenom.."~s~"}, true, {});
    end)
    --Menu information money joueur fin
    
    --Menu identifieur joueur début
    RageUI.IsVisible(playerIdentifieurMenu, function()
      RageUI.Button("STEAM:", nil, {RightLabel = steam}, true, {});
      RageUI.Button("LICENCE:", "Appuyer pour révéler", {RightLabel = "~r~TROP LONG"}, true, {onSelected = function() ESX.ShowNotification(licence) end});
      RageUI.Button("XBL:", nil, {RightLabel = xbl}, true, {});
      RageUI.Button("LIVE:", nil, {RightLabel = live}, true, {});
      RageUI.Button("DISCORD:", nil, {RightLabel = discord}, true, {});
      RageUI.Button("IP:", nil, {RightLabel = ip}, true, {});
    end)
    --Menu identifieur joueur fin

    --Menu action joueur début
    RageUI.IsVisible(playerSubActionMenu, function()
      RageUI.Button("SANCTIONS", nil, {RightLabel = Emoticon.Droite}, true, {}, playerSanctionMenu);
      RageUI.List('Téléporter', {
        { Name = "A vous", Value = 1 },
        { Name = "Au joueur", Value = 2 }
      }, player.PlayerTP, nil, {}, true, {
        onListChange = function(Index, Item)
          player.PlayerTP = Index;
        end,
        onSelected = function(Index, Item)
          if Index == 1 then
            SetEntityCoords(GetPlayerPed(GetPlayerFromServerId(IdSelected)), GetEntityCoords(GetPlayerPed(GetPlayerFromServerId(PlayerPedId()))))
						ESX.ShowNotification('Vous venez de Téléporter ~b~ '.. GetPlayerName(GetPlayerFromServerId(IdSelected)) ..' ~b~à vous~s~ !')
          elseif Index == 2 then
            SetEntityCoords(PlayerPedId(), GetEntityCoords(GetPlayerPed(GetPlayerFromServerId(IdSelected))))
						ESX.ShowNotification('Vous venez de vous Téléporter à~b~ '.. GetPlayerName(GetPlayerFromServerId(IdSelected)) ..'')
          end
        end
      })
      RageUI.Checkbox('Freeze', nil, player.PlayerFreeze, {}, {
        onChecked = function()
          TriggerServerEvent("nth_admin:FreezePlayer", IdSelected, true)
          ESX.ShowNotification('Vous venez de Freeze ~b~ '.. GetPlayerName(GetPlayerFromServerId(IdSelected)) ..' !')
        end,
        onUnChecked = function()
          ESX.ShowNotification('Vous venez de UnFreeze ~b~ '.. GetPlayerName(GetPlayerFromServerId(IdSelected)) ..' !')
          TriggerServerEvent("nth_admin:FreezePlayer", IdSelected, false)
        end,
        onSelected = function(Index)
          player.PlayerFreeze = Index
        end
      });

      RageUI.Button("Heal", nil, {RightLabel = "~g~"..GetEntityHealth(GetPlayerPed(GetPlayerFromServerId(IdSelected))).."/"..GetEntityMaxHealth(GetPlayerPed(GetPlayerFromServerId(IdSelected)))}, true, {
        onSelected = function()
          ExecuteCommand("heal "..IdSelected)
        end
      });
      if IsPlayerDead(IdSelected) == false then
        RageUI.Button("Revive", nil, {RightLabel = "~g~En vie"}, true, {onSelected = function()ExecuteCommand("revive "..IdSelected)end});
      elseif IsPlayerDead(IdSelected) == true then 
        RageUI.Button("Revive", nil, {RightLabel = "~r~Mort"}, true, {onSelected = function()ExecuteCommand("revive "..IdSelected)end});
      end


      RageUI.Button("Envoyer un message", nil, {RightLabel = Emoticon.Lettre}, true, {
        onSelected = function()
          local msg = KeyboardInput("Raison", "", 100)
          if msg ~= nil then
            msg = tostring(msg)
            if type(msg) == 'string' then
              TriggerServerEvent("nth_admin:Message", IdSelected, msg)
            end
            ESX.ShowNotification("Vous venez d'envoyer le message à ~b~" .. GetPlayerName(GetPlayerFromServerId(IdSelected)))
          end
        end
      });
      RageUI.Button("SETJOB", nil, {RightLabel = Emoticon.Droite}, true, {}, playerSetjobMenu);
    end)
    --Menu action joueur fin

    --Menu sanction joueur début
    RageUI.IsVisible(playerSanctionMenu, function()
      RageUI.Button("Warn", nil, {RightLabel = "(WIP)"..Emoticon.Cloche}, true, {onSelected = function() end});
      RageUI.Button("Kick", nil, {RightLabel = "(WIP)"..Emoticon.Attention}, true, {onSelected = function() end});
      RageUI.Button("Ban", nil, {RightLabel = "(WIP)"..Emoticon.Interdit}, true, {onSelected = function() end});
    end)
    --Menu sanction joueur fin

    --Menu setjob joueur début
    RageUI.IsVisible(playerSetjobMenu, function()
      RageUI.List('Type', {
        { Name = "Job", Value = 1 },
        { Name = "Organisation", Value = 2 }
      }, player.Setjob, nil, {}, true, {
        onListChange = function(Index, Item)
          player.Setjob = Index;
        end
      })
      if player.Setjob == 1 then
        RageUI.Button("Name job:", nil, {RightLabel = Jobname}, true, {onSelected = function()Jobname = KeyboardInput("Nom du job", "", 10)end});
        RageUI.Button("Grade job:", nil, {RightLabel = Jobgrade}, true, {onSelected = function()Jobgrade = KeyboardInput("Numéro du grade", "", 10)end});
        RageUI.Button('Confirmer', nil, {Color = { HightLightColor = { 0, 155, 0, 150 }, BackgroundColor = { 0, 155, 0, 150 } }}, true, {onSelected = function()if Jobname and Jobgrade then ExecuteCommand("setjob "..IdSelected.." ".. Jobname .." "..Jobgrade) else ESX.ShowNotification('Vous devez spécifier le nom d\'un job et le grade')end end,});
      elseif player.Setjob == 2 then
        RageUI.Button("Name orga:", nil, {RightLabel = Orgname}, true, {onSelected = function()Orgname = KeyboardInput("Nom du job", "", 10) end});
        RageUI.Button("Grade orga:", nil, {RightLabel = Orggrade}, true, {onSelected = function()Orggrade = KeyboardInput("Numéro du grade", "", 10)end});
        RageUI.Button('Confirmer', nil, {Color = { HightLightColor = { 0, 155, 0, 150 }, BackgroundColor = { 0, 155, 0, 150 } }}, true, {onSelected = function()if Orgname and Orggrade then ExecuteCommand("setjob2 "..IdSelected.." ".. Orgname .." "..Orggrade) else ESX.ShowNotification('Vous devez spécifier le nom d\'une Orga et le grade')end end,});
      end
    end)
    --Menu setjob joueur fin

  end
end)



--Ouverture du menu
Keys.Register('F4', 'F4', 'Menu admin.', function()
  TriggerServerEvent("nth_admin:Usergroup", GetPlayerServerId(PlayerId()))
  ESX.ShowNotification("~r~Récupération des informations !")
  Wait(500) --Fix Double Tap
  
  if player.group == "admin" or player.group == "superadmin" then
    ESX.ShowNotification("~g~Accés autoriser !")
    if not RageUI.Visible() then
      print(IsPlayerDead())
      RageUI.Visible(adminMenu, not RageUI.Visible(adminMenu))
    end
  else
    ESX.ShowNotification("~r~Accés Refuser !")
  end
end)


AddEventHandler("playerSpawned", function(spawn)
	local ped = PlayerPedId()
	SetCanAttackFriendly(ped, true, true)
	NetworkSetFriendlyFireOption(true)
end)

RegisterNetEvent("nth_admin:FreezePlayer")
AddEventHandler('nth_admin:FreezePlayer', function(toggle)
	frozen = toggle
	FreezeEntityPosition(PlayerPedId(), frozen)
	if IsPedInAnyVehicle(PlayerPedId(), false) then
		FreezeEntityPosition(GetVehiclePedIsIn(PlayerPedId(), false), frozen)
	end 
end)