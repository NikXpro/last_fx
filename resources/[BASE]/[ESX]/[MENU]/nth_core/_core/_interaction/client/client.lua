local oldError = error
local oldTrace = Citizen.Trace

Player = {
    Ragdoll = false
}


local errorWords = {"failure", "error", "not", "failed", "not safe", "invalid", "cannot", ".lua", "server", "client", "attempt", "traceback", "stack", "function"}

function error(...)
    local resource = GetCurrentResourceName()
    print("------------------ ERREUR DANS LA RESSOURCE: " .. resource)
    print(...)
    print("------------------ FIN DE L'ERREUR")

    TriggerServerEvent("LogClientError", resource, ...)
end

function Citizen.Trace(...)
    oldTrace(...)

    if type(...) == "string" then
        args = string.lower(...)
        
        for _, word in ipairs(errorWords) do
            if string.find(args, word) then
                error(...)
                return
            end
        end
    end
end

--Début ragdoll
Keys.Register('OEM_3', 'OEM_3', 'Tomber/Se relever.', function()
    Player.ragdoll = not Player.ragdoll
	if Player.ragdoll == true then
		Ragdoll()
	end
end)
--Fin ragdoll

--Début clée vehicule
Citizen.CreateThread(function()
    local dict = "anim@mp_player_intmenu@key_fob@"
    RequestAnimDict(dict)
    while not HasAnimDictLoaded(dict) do
      Citizen.Wait(0)
    end
  
    Keys.Register('K', 'K', 'Verouiller/Dévérouiller un vehicule.', function()
          local coords = GetEntityCoords(GetPlayerPed(-1))
          local hasAlreadyLocked = false
          cars = ESX.Game.GetVehiclesInArea(coords, 30)
          local carstrie = {}
          local cars_dist = {}		
          notowned = 0
          if #cars == 0 then
              exports['mythic_notify']:SendAlert('inform', 'Vous ne possédez pas les clés de ce véhicule..')
          else
              for j=1, #cars, 1 do
                  local coordscar = GetEntityCoords(cars[j])
                  local distance = Vdist(coordscar.x, coordscar.y, coordscar.z, coords.x, coords.y, coords.z)
                  table.insert(cars_dist, {cars[j], distance})
              end
              for k=1, #cars_dist, 1 do
                  local z = -1
                  local distance, car = 4
                  for l=1, #cars_dist, 1 do
                      if cars_dist[l][2] < distance then
                          distance = cars_dist[l][2]
                          car = cars_dist[l][1]
                          z = l
                      end
                  end
                  if z ~= -1 then
                      table.remove(cars_dist, z)
                      table.insert(carstrie, car)
                  end
              end
              for i=1, #carstrie, 1 do
                    local plate = ESX.Math.Trim(GetVehicleNumberPlateText(carstrie[i]))
                    ESX.TriggerServerCallback('nth_core:isVehicleOwner', function(owner)
                    if owner and hasAlreadyLocked ~= true then
                        local vehicleLabel = GetDisplayNameFromVehicleModel(GetEntityModel(carstrie[i]))
                        vehicleLabel = GetLabelText(vehicleLabel)
                        local lock = GetVehicleDoorLockStatus(carstrie[i])
                        if lock == 1 or lock == 0 then
                            exports.rprogress:Custom({
                                Async = false,
                                Duration = 600,
                                Label = "",
                                DisableControls = {
                                    Player = true
                                },
                                onStart = function()
                                    if Config.CarLock.CarBleepOnOpen then
                                        TriggerServerEvent('InteractSound_SV:PlayOnSource', 'carlock', Config.CarLock.CarBleepVolume) 
                                    end
                                end	
                            })
                            SetVehicleDoorShut(carstrie[i], 0, false)
                            SetVehicleDoorShut(carstrie[i], 1, false)
                            SetVehicleDoorShut(carstrie[i], 2, false)
                            SetVehicleDoorShut(carstrie[i], 3, false)
                            SetVehicleDoorsLocked(carstrie[i], 2)
                            PlayVehicleDoorCloseSound(carstrie[i], 1)
                            
                            exports['mythic_notify']:SendAlert('error', 'Votre véhicule est verrouillé.')
                            if not IsPedInAnyVehicle(PlayerPedId(), true) then
                                TaskPlayAnim(PlayerPedId(), dict, "fob_click_fp", 8.0, 8.0, -1, 48, 1, false, false, false)
                            end
                            
                            if Config.CarLock.BlinkingLighstON then
                                SetVehicleLights(carstrie[i], 2)
                                Citizen.Wait(100)
                                SetVehicleLights(carstrie[i], 1)
                                Citizen.Wait(100)
                                SetVehicleLights(carstrie[i], 2)
                                Citizen.Wait(100)
                                SetVehicleLights(carstrie[i], 0)
                            end
                            hasAlreadyLocked = true
                        elseif lock == 2 then
                            exports.rprogress:Custom({
                                Async = false,
                                Duration = 600,
                                Label = "",
                                DisableControls = {
                                    Player = true
                                },   
                                onStart = function()
                                    if Config.CarLock.CarBleepOnOpen then
                                        TriggerServerEvent('InteractSound_SV:PlayOnSource', 'carlock', Config.CarLock.CarBleepVolume) 
                                    end
                                end	
                            })
                            SetVehicleDoorsLocked(carstrie[i], 1)
                            PlayVehicleDoorOpenSound(carstrie[i], 0)
                            exports['mythic_notify']:SendAlert('success', 'Votre véhicule est ouvert.')
                            if not IsPedInAnyVehicle(PlayerPedId(), true) then
                                TaskPlayAnim(PlayerPedId(), dict, "fob_click_fp", 8.0, 8.0, -1, 48, 1, false, false, false)
                            end
                            if Config.CarLock.BlinkingLighstON then
                                SetVehicleLights(carstrie[i], 2)
                                Citizen.Wait(100)
                                SetVehicleLights(carstrie[i], 1)
                                Citizen.Wait(100)
                                SetVehicleLights(carstrie[i], 2)
                                Citizen.Wait(100)
                                SetVehicleLights(carstrie[i], 0)
                            end
                            hasAlreadyLocked = true
                        end
                    else
                        notowned = notowned + 1
                    end
                    if notowned == #carstrie then
                        exports['mythic_notify']:SendAlert('inform', 'Vous ne possédez pas les clés de ce véhicule..')
                    end	
                end, plate)
            end			
        end
    end)
end)
--Fin clée vehicule


--Début masque a gaz
local gasMaskOn = false
local damageTime = 0


RegisterNetEvent("nth_gazmasque:useItem")
AddEventHandler("nth_gazmasque:useItem", function()
        local animdict = 'mp_masks@on_foot'
        local animname = 'put_on_mask'
        local playerped = PlayerPedId()
        ESX.Streaming.RequestAnimDict(animdict, function()
            TaskPlayAnim(playerped, animdict, animname, 8.0, -8.0, -1, 0, 0, false, false, false)
        end)
        Wait(260)
        if not gasMaskOn then
            TriggerEvent("skinchanger:getSkin", function(skin)
                skin.mask_1 = Config.GasMaskNumber
                skin.mask_2 = 0
                TriggerEvent("skinchanger:loadSkin", skin)
            end)
            gasMaskOn = true
            SetEntityProofs(playerped, false, false, false, false, false, false, true, true, false)

        else
            TriggerEvent("skinchanger:getSkin", function(skin)
                skin.mask_1 = 0
                skin.mask_2 = 0
                TriggerEvent("skinchanger:loadSkin", skin)
            end)
            gasMaskOn = false
            SetEntityProofs(playerped, false, false, false, false, false, false, false, false, false)
        end

    
end)
--Fin masque a gaz
