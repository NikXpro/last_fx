ESX = nil

Citizen.CreateThread(function()
  while ESX == nil do
    TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
    Citizen.Wait(0)
  end
  while ESX.GetPlayerData().job == nil do 
    Citizen.Wait(10)
  end
  PlayerData = ESX.GetPlayerData()
  ESX.PlayerData = ESX.GetPlayerData()
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
  ESX.PlayerData = xPlayer
end)

RegisterNetEvent('esx:setJob') 
AddEventHandler('esx:setJob', function(job)  
ESX.PlayerData.job = job 
end)

local PlayerMoney, PlayerCash = 0, 0

local megaphoneMenu = RageUI.CreateMenu("Mégaphone", "Mégaphone")
megaphoneMenu:SetRectangleBanner(2, 140, 4, 1.00)

local keymenu = RageUI.CreateMenu("List touche", "List touche")
keymenu:SetRectangleBanner(2, 140, 4, 1.00)

local atmMenu = RageUI.CreateMenu("ATM", "ATM")
atmMenu:SetRectangleBanner(2, 140, 4, 1.00)
local atmAction = RageUI.CreateSubMenu(atmMenu, "INFORMATION", "ATM INFORMATION")
atmAction:SetRectangleBanner(2, 140, 4, 1.00)


Citizen.CreateThread(function()
  while (true) do
      Citizen.Wait(1.0)
      --Menu mégaphone début
      RageUI.IsVisible(megaphoneMenu, function()
        for k,v in pairs(data.sounds) do  
          RageUI.Button(v.Name, nil, {RightLabel = "🔊"}, true, {
            onSelected = function()
              TriggerServerEvent("InteractSound_SV:PlayWithinDistance", v.Distance, v.Sound, v.Volume)
            end,
          });
        end
      end)
      --Menu mégaphone fin

      --Menu list touche debut
      RageUI.IsVisible(keymenu, function()
        for k,v in pairs(data.keylist) do  
          RageUI.Button(v.Action, nil, {RightLabel = "~b~" .. v.Key}, true, {
            onSelected = function()
              RageUI.CloseAll()
            end,
          });
        end
      end)
      --Menu list touche fin

      --Menu banque debut
      RageUI.IsVisible(atmMenu, function()
        ESX.PlayerData = ESX.GetPlayerData()
        PlayerCash = ESX.Math.GroupDigits(ESX.PlayerData.money)
        RageUI.Button('Information', "Portefeuille: ~g~"..PlayerCash.."$", {RightLabel = "🔎"}, true, {onSelected = function() end}, atmAction);

        RageUI.Button('Dépot', "Portefeuille: ~g~"..PlayerCash.."$", {RightLabel = "📥"}, true, {
          onSelected = function()
            depot_argent()
          end
        });

        RageUI.Button('Retrait', "Portefeuille: ~g~"..PlayerCash.."$", {RightLabel = "📤"}, true, {
            onSelected = function()
              retire_argent()
            end
          });

    end)

    RageUI.IsVisible(atmAction, function()
        RageUI.Button('Propriétaire:', nil, {RightLabel = '~g~' .. GetPlayerName(PlayerId()) .. ''}, true, {
            onSelected = function()
              retire_argent()
            end
        });
        ESX.PlayerData = ESX.GetPlayerData()
        for i = 1, #ESX.PlayerData.accounts, 1 do
            if ESX.PlayerData.accounts[i].name == 'bank' then
                PlayerMoney = ESX.Math.GroupDigits(ESX.PlayerData.accounts[i].money)
                RageUI.Button('Solde:', nil, {RightLabel = "~g~"..PlayerMoney.."$"}, true, {
                    onSelected = function()
                    end
                });
            end
        end
    end)
    --Menu banque fin

  end
end)

function AchatShopNormal(prix, nom, item, weapon)
  RageUI.Button(nom, nil, {RightLabel = "~g~" .. prix .. "$🛒"}, true, {
    onSelected = function()
        TriggerServerEvent("nth_store:Buy", prix, item, weapon)
        print("license desactiver achat confirmer")
    end
  })
end

MenuActuel = ""
function CreateShop()
  ShopActif = true
  ESX.TriggerServerCallback('esx_license:checkLicense', function(hasWeaponLicense) HasLicense = hasWeaponLicense end, GetPlayerServerId(PlayerId()), "weapon")
  for k, v in pairs(data.menu) do
    if v.MenuType == "shop" then
      shopMenu = RageUI.CreateMenu(v.TitreMenu, v.TitreMenu)
      shopMenu:SetRectangleBanner(2, 140, 4, 1.00)
      shopMenu:SetSubtitle(v.DescriptionMenu)
      shopMenu.EnableMouse = false
      shopMenu.Closed = function()
          ShopActif = false
      end
      prix = 0
      if MenuActuel == v.MenuId then
        RageUI.Visible(shopMenu, not RageUI.Visible(shopMenu))
        while ShopActif do
          Citizen.Wait(0)
          
          RageUI.IsVisible(shopMenu, function()
            --Items
            for k, v in pairs(v.items) do
              local prix = v.prix
              local nom = v.nom
              local item = v.NomItem
              local weapon = v.weapon
              
              if (v.licence == false) then
                AchatShopNormal(prix, nom, item, weapon)
              else
                if (HasLicense) then
                  AchatShopNormal(prix, nom, item, weapon)
                else
                  RageUI.Button(nom, nil, {RightLabel = "🔒"}, true, {onSelected = function() ESX.ShowNotification("Vous n'avez pas de port d'arme") print("license non active achat impossible")end})
                end
              end
            end
            end, function()
              --Panels
          end)
        end
      end
    end
  end
end


MenuService = ""
function CreateService()
  ServiceActif = true
  for k, v in pairs(data.menu) do
    if v.MenuType == "service" then
      serviceMenu = RageUI.CreateMenu(v.TitreMenu, v.TitreMenu)
      serviceMenu:SetRectangleBanner(2, 140, 4, 1.00)
      serviceMenu:SetSubtitle(v.DescriptionMenu)
      serviceMenu.Closed = function()
        ServiceActif = false
      end
      if MenuService == v.MenuId then
        RageUI.Visible(serviceMenu, not RageUI.Visible(serviceMenu))
        while ServiceActif do
          Citizen.Wait(0)
          
          RageUI.IsVisible(serviceMenu, function()
            if ESX.PlayerData.job.name == v.ServiceOff then 
              RageUI.Button('Prendre son service', nil, {}, true, {
                onSelected = function()
                  local serviceon = v.ServiceOn
                  TriggerServerEvent('service:on', serviceon)
                end
              });
            elseif ESX.PlayerData.job.name == v.ServiceOn then 
              RageUI.Button('Quitter son service', nil, {}, true, {
                onSelected = function()
                  local serviceoff = v.ServiceOff
                  TriggerServerEvent('service:off', serviceoff)
                end
              });
            else
              RageUI.Separator("Vous n'êtes pas employez ici !")
            end
          end, function()
            --Panels
          end)
        end
      end
    end
  end
end

function CheckSpawnData(data)
  local found = false
  local essaiMax = #data * 2
  local essai = 0
  local pos = vector3(10.0, 10.10, 10.10)
  local heading = 100.0
  while not found do
      Wait(100)
      local r = math.random(1, #data)
      local _pos = data[r]
      if ESX.Game.IsSpawnPointClear(_pos.pos, 2.0) then
          pos = _pos.pos
          heading = _pos.heading
          found = true
      end
      essai = essai + 1
      if essai > essaiMax then
          break
      end
  end
  return found, pos, heading
end

function spawnVeh(model, zone, heading)
  RequestModel(GetHashKey(model))
  while not HasModelLoaded(GetHashKey(model)) do Wait(10) end
  local veh = CreateVehicle(GetHashKey(model), zone, heading, 1, 0)
  for i = 0,14 do
      SetVehicleExtra(veh, i, 0)
  end
  SetVehicleDirtLevel(veh, 0.1)
end

MenuLocation = ""
function CreateLocation()
  LocationActif = true
  for k, v in pairs(data.menu) do
    if v.MenuType == "Location" then
      locationMenu = RageUI.CreateMenu(v.TitreMenu, v.TitreMenu)
      locationMenu:SetRectangleBanner(2, 140, 4, 1.00)
      locationMenu:SetSubtitle(v.DescriptionMenu)
      locationMenu.Closed = function()
        LocationActif = false
      end
      if MenuLocation == v.MenuId then
        RageUI.Visible(locationMenu, not RageUI.Visible(locationMenu))
        while LocationActif do
          Citizen.Wait(0)
          
          RageUI.IsVisible(locationMenu, function()
            for k, v in pairs(v.vehicule) do
              local prix = v.prix
              local nom = v.nom
              local vehicule = v.NomVehicule
              local spawn = v.spawnPoint
              RageUI.Button(nom, nil, {RightLabel = "~g~"..prix.."$"}, true, {
                onSelected = function()
                  print("test")
                  local zone, heading, test = CheckSpawnData(spawn)
                  print(vehicule.." | ".. heading.." | "..test)
                  spawnVeh(vehicule, heading, test)
                  RageUI.CloseAll()
                end
              })
            end
          end, function()
            --Panels
          end)
        end
      end
    end
  end
end


--Keys.Register('X', 'X', 'Menu des touche.', function()
--  RageUI.Visible(keymenu, not RageUI.Visible(keymenu))
--end)


Keys.Register('X', 'X', 'Mégaphone LSPD.', function()
  if VehiculeList(GetVehiclePedIsUsing(GetPlayerPed(-1))) then
    if ESX.PlayerData.job.name == "police" then
      RageUI.Visible(megaphoneMenu, not RageUI.Visible(megaphoneMenu))
    else
       ESX.ShowNotification('Vous n\'avez pas d\'acreditation fédéral')
    end
  end
end)

--Ouverture Menu banque
Citizen.CreateThread(function()
  while true do
    attente = 500
    for k in pairs(Config.kBank) do
      local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
      local dst = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, Config.kBank[k].x, Config.kBank[k].y, Config.kBank[k].z)
      if dst <= 1.5 then
        attente = 5
        ESX.ShowHelpNotification("Press ~g~E~s~ pour accéder a votre compte")
        if IsControlJustReleased(0, 38) then
          RageUI.Visible(atmMenu, not RageUI.Visible(atmMenu))
        end
      end
    end
    Citizen.Wait(attente)
  end
end)