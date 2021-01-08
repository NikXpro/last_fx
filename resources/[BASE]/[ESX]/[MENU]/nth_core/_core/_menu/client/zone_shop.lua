
ESX = nil
Citizen.CreateThread(function()
     for k,v in pairs(data.menu) do
          LoadModel(v.ped)
          local ped = CreatePed(5, v.ped, v.zone, v.heading, false, 1)
          FreezeEntityPosition(ped, 1)
          SetBlockingOfNonTemporaryEvents(ped, true)

          if v.MenuType == "shop" then
               if not v.illegal then
                    local blip = AddBlipForCoord(v.zone)
                    SetBlipSprite(blip, v.BlipId)
                    SetBlipScale(blip, v.BlipScale)
                    SetBlipColour(blip, v.BlipColor)
                    SetBlipAsShortRange(blip, true)
                    if v.property then
                         SetBlipCategory(blip, 10)
                    end
                    BeginTextCommandSetBlipName('STRING')
		          AddTextComponentString(v.BlipName)
		          EndTextCommandSetBlipName(blip)
               end
          elseif v.MenuType == "Location" then
               local blip = AddBlipForCoord(v.zone)
               SetBlipSprite(blip, v.BlipId)
               SetBlipScale(blip, v.BlipScale)
               SetBlipColour(blip, v.BlipColor)
               SetBlipAsShortRange(blip, true)
               BeginTextCommandSetBlipName('STRING')
               AddTextComponentString(v.BlipName)
               EndTextCommandSetBlipName(blip)
          end
     end
end)


Citizen.CreateThread(function()
     while true do
          attente = 500
          for k,v in pairs(data.menu) do
               local pPed = GetPlayerPed(-1)
               local pCoords = GetEntityCoords(pPed, true)
               local dst = GetDistanceBetweenCoords(pCoords, v.zone, true)
               if dst <= v.TailleZone then
                    attente = 1
                    dst = GetDistanceBetweenCoords(pCoords, v.zone, true)
                    ESX.ShowHelpNotification(string.format(v.MessageZone))
                    if IsControlJustReleased(0, 38) then
                         if v.MenuType == "shop" then
                              MenuActuel = v.MenuId
                              CreateShop()
                         elseif v.MenuType == "service" then
                              MenuService = v.MenuId
                              CreateService()
                         elseif v.MenuType == "Location" then
                              MenuLocation = v.MenuId
                              CreateLocation()
                         end
                    end  
               end
          end
          Citizen.Wait(attente)
     end
end)


function LoadModel(model)
     while not HasModelLoaded(model) do
          RequestModel(model)
          Wait(100)
     end
end