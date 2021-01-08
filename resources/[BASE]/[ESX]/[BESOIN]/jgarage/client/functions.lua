OpenGarageMenu = function()
    local currentGarage = cachedData["currentGarage"]

    if not currentGarage then return end

    HandleCamera(currentGarage, true)

    ESX.TriggerServerCallback("garage:fetchPlayerVehicles", function(fetchedVehicles)
        local menuElements = {}

        for key, vehicleData in ipairs(fetchedVehicles) do
            local vehicleProps = vehicleData["props"]

            table.insert(menuElements, {
                ["label"] = "" .. GetLabelText(GetDisplayNameFromVehicleModel(vehicleProps["model"])) .. " avec plaque - " .. vehicleData["plate"],
                ["vehicle"] = vehicleData
            })
        end

        if #menuElements == 0 then
            table.insert(menuElements, {
                ["label"] = "Vous n'avez garé aucun véhicule ici."
            })
        elseif #menuElements > 0 then
            SpawnLocalVehicle(menuElements[1]["vehicle"]["props"], currentGarage)
        end

        ESX.UI.Menu.Open("default", GetCurrentResourceName(), "main_garage_menu", {
            ["title"] = "Garage - " .. currentGarage,
            ["align"] = Config.AlignMenu,
            ["elements"] = menuElements
        }, function(menuData, menuHandle)
            local currentVehicle = menuData["current"]["vehicle"]

            if currentVehicle then
                menuHandle.close()

                SpawnVehicle(currentVehicle["props"])
            end
        end, function(menuData, menuHandle)
            HandleCamera(currentGarage, false)

            menuHandle.close()
        end, function(menuData, menuHandle)
            local currentVehicle = menuData["current"]["vehicle"]

            if currentVehicle then
                SpawnLocalVehicle(currentVehicle["props"])
            end
        end)
    end, currentGarage)
end

OpenVehicleMenu = function()
    ESX.TriggerServerCallback("garage:fetchPlayerVehicles", function(fetchedVehicles)
        local menuElements = {}

        local gameVehicles = ESX.Game.GetVehicles()
        local pedCoords = GetEntityCoords(PlayerPedId())

        for key, vehicleData in ipairs(fetchedVehicles) do
            local vehicleProps = vehicleData["props"]

            for _, vehicle in ipairs(gameVehicles) do
                if DoesEntityExist(vehicle) then
                    local dstCheck = math.floor(#(pedCoords - GetEntityCoords(vehicle)))

                    if Config.Trim(GetVehicleNumberPlateText(vehicle)) == Config.Trim(vehicleProps["plate"]) then
                        table.insert(menuElements, {
                            ["label"] = GetLabelText(GetDisplayNameFromVehicleModel(vehicleProps["model"])) .. " with plate - " .. vehicleData["plate"] .. " - " .. dstCheck .. " mètres plus loin.",
                            ["vehicleData"] = vehicleData,
                            ["vehicleEntity"] = vehicle
                        })
                    end
                end
            end
        end

        if #menuElements == 0 then
            table.insert(menuElements, {
                ["label"] = "Vous n'avez aucun véhicule"
            })
        end

        ESX.UI.Menu.Open("default", GetCurrentResourceName(), "main_vehicle_menu", {
            ["title"] = "Véhicules actuels.",
            ["align"] = Config.AlignMenu,
            ["elements"] = menuElements
        }, function(menuData, menuHandle)
            local currentVehicle = menuData["current"]["vehicleEntity"]

            if currentVehicle then
                ChooseVehicleAction(currentVehicle, function(actionChosen)
                    VehicleAction(currentVehicle, actionChosen)
                end)
            end
        end, function(menuData, menuHandle)
            menuHandle.close()
        end, function(menuData, menuHandle)
            local currentVehicle = menuData["current"]["vehicle"]

            if currentVehicle then
                SpawnLocalVehicle(currentVehicle["props"])
            end
        end)
    end)
end

ChooseVehicleAction = function(vehicleEntity, callback)
    if not cachedData["blips"] then cachedData["blips"] = {} end

    local menuElements = {
        {
            ["label"] = (GetVehicleDoorLockStatus(vehicleEntity) == 1 and "Fermer à clé" or "Ouvrir") .. " véhicule.",
            ["action"] = "change_lock_state"
        },
    }

    ESX.UI.Menu.Open("default", GetCurrentResourceName(), "second_vehicle_menu", {
        ["title"] = "Choisissez une action pour - " .. GetVehicleNumberPlateText(vehicleEntity),
        ["align"] = Config.AlignMenu,
        ["elements"] = menuElements
    }, function(menuData, menuHandle)
        local currentAction = menuData["current"]["action"]

        if currentAction then
            menuHandle.close()

            callback(currentAction)
        end
    end, function(menuData, menuHandle)
        menuHandle.close()
    end)
end

SpawnLocalVehicle = function(vehicleProps)
	local spawnpoint = Config.Garages[cachedData["currentGarage"]]["positions"]["vehicle"]

	WaitForModel(vehicleProps["model"])

	if DoesEntityExist(cachedData["vehicle"]) then
		DeleteEntity(cachedData["vehicle"])
	end
	
	if not ESX.Game.IsSpawnPointClear(spawnpoint["position"], 3.0) then 
		ESX.ShowNotification("Please move the vehicle that is in the way.")

		return
	end
	
	if not IsModelValid(vehicleProps["model"]) then
		return
	end

	ESX.Game.SpawnLocalVehicle(vehicleProps["model"], spawnpoint["position"], spawnpoint["heading"], function(yourVehicle)
		cachedData["vehicle"] = yourVehicle

		SetVehicleProperties(yourVehicle, vehicleProps)

		SetModelAsNoLongerNeeded(vehicleProps["model"])
	end)
end

SpawnVehicle = function(vehicleProps)
	local spawnpoint = Config.Garages[cachedData["currentGarage"]]["positions"]["vehicle"]

	WaitForModel(vehicleProps["model"])

	if DoesEntityExist(cachedData["vehicle"]) then
		DeleteEntity(cachedData["vehicle"])
	end
	
	if not ESX.Game.IsSpawnPointClear(spawnpoint["position"], 3.0) then 
		ESX.ShowNotification("Veuillez déplacer le véhicule qui se trouve sur le chemin.")

		return
	end
	
	local gameVehicles = ESX.Game.GetVehicles()

	for i = 1, #gameVehicles do
		local vehicle = gameVehicles[i]

        if DoesEntityExist(vehicle) then
			if Config.Trim(GetVehicleNumberPlateText(vehicle)) == Config.Trim(vehicleProps["plate"]) then
				ESX.ShowNotification("Ce véhicule est dans la rue, vous ne pouvez pas retirer 2 des mêmes véhicules.")

				return HandleCamera(cachedData["currentGarage"])
			end
		end
	end

	ESX.Game.SpawnVehicle(vehicleProps["model"], spawnpoint["position"], spawnpoint["heading"], function(yourVehicle)
		SetVehicleProperties(yourVehicle, vehicleProps)

        NetworkFadeInEntity(yourVehicle, true, true)

		SetModelAsNoLongerNeeded(vehicleProps["model"])

		TaskWarpPedIntoVehicle(PlayerPedId(), yourVehicle, -1)

        SetEntityAsMissionEntity(yourVehicle, true, true)
        
        ESX.ShowNotification("Vous avez récupérer votre véhicule.")

        HandleCamera(cachedData["currentGarage"])
	end)
end

PutInVehicle = function()
    local vehicle = GetVehiclePedIsUsing(PlayerPedId())

	if DoesEntityExist(vehicle) then
		local vehicleProps = GetVehicleProperties(vehicle)

		ESX.TriggerServerCallback("garage:validateVehicle", function(valid)
			if valid then
				TaskLeaveVehicle(PlayerPedId(), vehicle, 0)
	
				while IsPedInVehicle(PlayerPedId(), vehicle, true) do
					Citizen.Wait(0)
				end
	
				Citizen.Wait(500)
	
				NetworkFadeOutEntity(vehicle, true, true)
	
				Citizen.Wait(100)
	
				ESX.Game.DeleteVehicle(vehicle)

				ESX.ShowNotification("Vous avez garé votre véhicule.")
			else
				ESX.ShowNotification("Possédez-vous vraiment ce véhicule?")
			end

		end, vehicleProps, cachedData["currentGarage"])
	end
end

SetVehicleProperties = function(vehicle, vehicleProps)
    ESX.Game.SetVehicleProperties(vehicle, vehicleProps)

    SetVehicleEngineHealth(vehicle, vehicleProps["engineHealth"] and vehicleProps["engineHealth"] + 0.0 or 1000.0)
    SetVehicleBodyHealth(vehicle, vehicleProps["bodyHealth"] and vehicleProps["bodyHealth"] + 0.0 or 1000.0)
    SetVehicleFuelLevel(vehicle, vehicleProps["fuelLevel"] and vehicleProps["fuelLevel"] + 0.0 or 1000.0)

    if vehicleProps["windows"] then
        for windowId = 1, 13, 1 do
            if vehicleProps["windows"][windowId] == false then
                SmashVehicleWindow(vehicle, windowId)
            end
        end
    end

    if vehicleProps["tyres"] then
        for tyreId = 1, 7, 1 do
            if vehicleProps["tyres"][tyreId] ~= false then
                SetVehicleTyreBurst(vehicle, tyreId, true, 1000)
            end
        end
    end

    if vehicleProps["doors"] then
        for doorId = 0, 5, 1 do
            if vehicleProps["doors"][doorId] ~= false then
                SetVehicleDoorBroken(vehicle, doorId - 1, true)
            end
        end
    end
end

GetVehicleProperties = function(vehicle)
    if DoesEntityExist(vehicle) then
        local vehicleProps = ESX.Game.GetVehicleProperties(vehicle)

        vehicleProps["tyres"] = {}
        vehicleProps["windows"] = {}
        vehicleProps["doors"] = {}

        for id = 1, 7 do
            local tyreId = IsVehicleTyreBurst(vehicle, id, false)
        
            if tyreId then
                vehicleProps["tyres"][#vehicleProps["tyres"] + 1] = tyreId
        
                if tyreId == false then
                    tyreId = IsVehicleTyreBurst(vehicle, id, true)
                    vehicleProps["tyres"][ #vehicleProps["tyres"]] = tyreId
                end
            else
                vehicleProps["tyres"][#vehicleProps["tyres"] + 1] = false
            end
        end

        for id = 1, 13 do
            local windowId = IsVehicleWindowIntact(vehicle, id)

            if windowId ~= nil then
                vehicleProps["windows"][#vehicleProps["windows"] + 1] = windowId
            else
                vehicleProps["windows"][#vehicleProps["windows"] + 1] = true
            end
        end
        
        for id = 0, 5 do
            local doorId = IsVehicleDoorDamaged(vehicle, id)
        
            if doorId then
                vehicleProps["doors"][#vehicleProps["doors"] + 1] = doorId
            else
                vehicleProps["doors"][#vehicleProps["doors"] + 1] = false
            end
        end

        vehicleProps["engineHealth"] = GetVehicleEngineHealth(vehicle)
        vehicleProps["bodyHealth"] = GetVehicleBodyHealth(vehicle)
        vehicleProps["fuelLevel"] = GetVehicleFuelLevel(vehicle)

        return vehicleProps
    end
end

HandleAction = function(action)
    if action == "menu" then
        OpenGarageMenu()
    elseif action == "vehicle" then
        PutInVehicle()
    end
end

HandleCamera = function(garage, toggle)
    local Camerapos = Config.Garages[garage]["camera"]

    if not Camerapos then return end

	if not toggle then
		if cachedData["cam"] then
			DestroyCam(cachedData["cam"])
		end
		
		if DoesEntityExist(cachedData["vehicle"]) then
			DeleteEntity(cachedData["vehicle"])
		end

		RenderScriptCams(0, 1, 750, 1, 0)

		return
	end

	if cachedData["cam"] then
		DestroyCam(cachedData["cam"])
	end

	cachedData["cam"] = CreateCam("DEFAULT_SCRIPTED_CAMERA", true)

	SetCamCoord(cachedData["cam"], Camerapos["x"], Camerapos["y"], Camerapos["z"])
	SetCamRot(cachedData["cam"], Camerapos["rotationX"], Camerapos["rotationY"], Camerapos["rotationZ"])
	SetCamActive(cachedData["cam"], true)

	RenderScriptCams(1, 1, 750, 1, 1)

	Citizen.Wait(500)
end

DrawScriptMarker = function(markerData)
    DrawMarker(markerData["type"] or 1, markerData["pos"] or vector3(0.0, 0.0, 0.0), 0.0, 0.0, 0.0, (markerData["type"] == 6 and -90.0 or markerData["rotate"] and -180.0) or 0.0, 0.0, 0.0, markerData["sizeX"] or 1.0, markerData["sizeY"] or 1.0, markerData["sizeZ"] or 1.0, markerData["r"] or 1.0, markerData["g"] or 1.0, markerData["b"] or 1.0, 100, false, true, 2, false, false, false, false)
end

PlayAnimation = function(ped, dict, anim, settings)
	if dict then
        Citizen.CreateThread(function()
            RequestAnimDict(dict)

            while not HasAnimDictLoaded(dict) do
                Citizen.Wait(100)
            end

            if settings == nil then
                TaskPlayAnim(ped, dict, anim, 1.0, -1.0, 1.0, 0, 0, 0, 0, 0)
            else 
                local speed = 1.0
                local speedMultiplier = -1.0
                local duration = 1.0
                local flag = 0
                local playbackRate = 0

                if settings["speed"] then
                    speed = settings["speed"]
                end

                if settings["speedMultiplier"] then
                    speedMultiplier = settings["speedMultiplier"]
                end

                if settings["duration"] then
                    duration = settings["duration"]
                end

                if settings["flag"] then
                    flag = settings["flag"]
                end

                if settings["playbackRate"] then
                    playbackRate = settings["playbackRate"]
                end

                TaskPlayAnim(ped, dict, anim, speed, speedMultiplier, duration, flag, playbackRate, 0, 0, 0)
            end
      
            RemoveAnimDict(dict)
		end)
	else
		TaskStartScenarioInPlace(ped, anim, 0, true)
	end
end

WaitForModel = function(model)
    local DrawScreenText = function(text, red, green, blue, alpha)
        SetTextFont(4)
        SetTextScale(0.0, 0.5)
        SetTextColour(red, green, blue, alpha)
        SetTextDropshadow(0, 0, 0, 0, 255)
        SetTextEdge(1, 0, 0, 0, 255)
        SetTextDropShadow()
        SetTextOutline()
        SetTextCentre(true)
    
        BeginTextCommandDisplayText("STRING")
        AddTextComponentSubstringPlayerName(text)
        EndTextCommandDisplayText(0.5, 0.5)
    end

    if not IsModelValid(model) then
        return ESX.ShowNotification("Ce modèle n'existe pas en jeu.")
    end

	if not HasModelLoaded(model) then
		RequestModel(model)
	end
	
	while not HasModelLoaded(model) do
		Citizen.Wait(0)

		DrawScreenText("Chargement du model " .. GetLabelText(GetDisplayNameFromVehicleModel(model)) .. "...", 255, 255, 255, 150)
	end
end