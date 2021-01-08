local Keys = {
	['ESC'] = 322, ['F1'] = 288, ['F2'] = 289, ['F3'] = 170, ['F5'] = 166, ['F6'] = 167, ['F7'] = 168, ['F8'] = 169, ['F9'] = 56, ['F10'] = 57, 
	['~'] = 243, ['1'] = 157, ['2'] = 158, ['3'] = 160, ['4'] = 164, ['5'] = 165, ['6'] = 159, ['7'] = 161, ['8'] = 162, ['9'] = 163, ['-'] = 84, ['='] = 83, ['BACKSPACE'] = 177, 
	['TAB'] = 37, ['Q'] = 44, ['W'] = 32, ['E'] = 38, ['R'] = 45, ['T'] = 245, ['Y'] = 246, ['U'] = 303, ['P'] = 199, ['['] = 39, [']'] = 40, ['ENTER'] = 18,
	['CAPS'] = 137, ['A'] = 34, ['S'] = 8, ['D'] = 9, ['F'] = 23, ['G'] = 47, ['H'] = 74, ['K'] = 311, ['L'] = 182,
	['LEFTSHIFT'] = 21, ['Z'] = 20, ['X'] = 73, ['C'] = 26, ['V'] = 0, ['B'] = 29, ['N'] = 249, ['M'] = 244, [','] = 82, ['.'] = 81,
	['LEFTCTRL'] = 36, ['LEFTALT'] = 19, ['SPACE'] = 22, ['RIGHTCTRL'] = 70, 
	['HOME'] = 213, ['PAGEUP'] = 10, ['PAGEDOWN'] = 11, ['DELETE'] = 178,
	['LEFT'] = 174, ['RIGHT'] = 175, ['TOP'] = 27, ['DOWN'] = 173,
	['NENTER'] = 201, ['N4'] = 108, ['N5'] = 60, ['N6'] = 107, ['N+'] = 96, ['N-'] = 97, ['N7'] = 117, ['N8'] = 61, ['N9'] = 118
}

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
end)

positions = { --tp
    {{-1337.45, -1161.55, 3.51, 265.02}, {20.09, 114.39, 82.27, 248.5}, {36,237,157}, "Appuyer sur ~INPUT_CONTEXT~ pour ~g~Entrer~s~/~r~Sortir~s~ de chez ~b~D.K~s~"}, -- 410th appartement chef
	{{-12.93, 89.05, 39.54, 1.02}, {92.72, 49.26, 72.52, 62.96}, {255, 157, 0}, "Appuyer sur ~INPUT_CONTEXT~ pour ~g~Entrer~s~/~r~Sortir~s~ de chez les ~b~Yute~s~"},
	{{-1382.26, -609.86, 29.82, 206.75}, {-1385.02, -606.47, 29.32, 116.22}, {255, 157, 0}, "Appuyer sur ~INPUT_CONTEXT~ pour ~g~Entrer~s~/~r~Sortir~s~ du comptoir avant."},
	{{-1386.25, -627.48, 29.82, 295.72}, {-1371.33, -625.97, 29.82, 121.9}, {255, 157, 0}, "Appuyer sur ~INPUT_CONTEXT~ pour ~g~Entrer~s~/~r~Sortir~s~ du comptoir arriére."}
}

--local enableWeatherControl = false
--Citizen.CreateThread(function()
--    
--    local showHelp = true
--    local loaded = false
--    
--    while true do
--        if enableWeatherControl then
--            SetWeatherTypePersist("XMAS")
--            SetWeatherTypeNowPersist("XMAS")
--            SetWeatherTypeNow("XMAS")
--            SetOverrideWeather("XMAS")
--            SetForcePedFootstepsTracks(true)
--            SetForceVehicleTrails(true)
--        end
--        Citizen.Wait(0)
--        if IsNextWeatherType('XMAS') then
--            N_0xc54a08c85ae4d410(3.0)
--            
--            SetForceVehicleTrails(true)
--            SetForcePedFootstepsTracks(true)
--            
--            if not loaded then
--                RequestScriptAudioBank("ICE_FOOTSTEPS", false)
--                RequestScriptAudioBank("SNOW_FOOTSTEPS", false)
--                RequestNamedPtfxAsset("core_snow")
--                while not HasNamedPtfxAssetLoaded("core_snow") do
--                    Citizen.Wait(0)
--                end
--                UseParticleFxAssetNextCall("core_snow")
--                loaded = true
--            end
--            RequestAnimDict('anim@mp_snowball')
--            if IsControlJustReleased(0, 119) and not IsPedInAnyVehicle(GetPlayerPed(-1), true) and not IsPlayerFreeAiming(PlayerId()) and not IsPedSwimming(PlayerPedId()) and not IsPedSwimmingUnderWater(PlayerPedId()) and not IsPedRagdoll(PlayerPedId()) and not IsPedFalling(PlayerPedId()) and not IsPedRunning(PlayerPedId()) and not IsPedSprinting(PlayerPedId()) and GetInteriorFromEntity(PlayerPedId()) == 0 and not IsPedShooting(PlayerPedId()) and not IsPedUsingAnyScenario(PlayerPedId()) and not IsPedInCover(PlayerPedId(), 0) then -- check if the snowball should be picked up
--                TaskPlayAnim(PlayerPedId(), 'anim@mp_snowball', 'pickup_snowball', 8.0, -1, -1, 0, 1, 0, 0, 0)
--                Citizen.Wait(1950) 
--                GiveWeaponToPed(GetPlayerPed(-1), GetHashKey('WEAPON_SNOWBALL'), 2, false, true)
--            end
--            if not IsPedInAnyVehicle(GetPlayerPed(-1), true) then
--                if showHelp then
--                    showHelpNotification()
--                end
--                showHelp = false
--            else
--                showHelp = true
--            end
--        else
--            if loaded then N_0xc54a08c85ae4d410(0.0) end
--            loaded = false
--            RemoveNamedPtfxAsset("core_snow")
--            ReleaseNamedScriptAudioBank("ICE_FOOTSTEPS")
--            ReleaseNamedScriptAudioBank("SNOW_FOOTSTEPS")
--            SetForceVehicleTrails(false)
--            SetForcePedFootstepsTracks(false)
--        end
--        if GetSelectedPedWeapon(PlayerPedId()) == GetHashKey('WEAPON_SNOWBALL') then
--            SetPlayerWeaponDamageModifier(PlayerId(), 0.0)
--        end
--    end
--end)
--
--function showHelpNotification()
--    BeginTextCommandDisplayHelp("STRING")
--    AddTextComponentSubstringPlayerName("Appuyer sur ~INPUT_CONTEXT~ pour ramasser 2 boules de neige!")
--    EndTextCommandDisplayHelp(0, 0, 1, -1)
--end
--
--AddEventHandler('playerSpawned', function()
--    showHelpNotification()
--end)

-- MONTER A L'ARRIERE DU VEHICULE

local doors = {
	{"seat_dside_f", -1},
	{"seat_pside_f", 0},
	{"seat_dside_r", 1},
	{"seat_pside_r", 2}
}

local function VehicleInFront(ped)
    local pos = GetEntityCoords(ped)
    local entityWorld = GetOffsetFromEntityInWorldCoords(ped, 0.0, 5.0, 0.0)
    local rayHandle = CastRayPointToPoint(pos.x, pos.y, pos.z, entityWorld.x, entityWorld.y, entityWorld.z, 10, ped, 0)
    local _, _, _, _, result = GetRaycastResult(rayHandle)
	
    return result
end

Citizen.CreateThread(function()
	while true do
    	Citizen.Wait(8)
			
		local ped = PlayerPedId()
			
   		if IsControlJustReleased(0, 23) and running ~= true and GetVehiclePedIsIn(ped, false) == 0 then
      		local vehicle = VehicleInFront(ped)
				
      		running = true
				
      		if vehicle ~= nil then
				local plyCoords = GetEntityCoords(ped, false)
        		local doorDistances = {}
					
        		for k, door in pairs(doors) do
          			local doorBone = GetEntityBoneIndexByName(vehicle, door[1])
          			local doorPos = GetWorldPositionOfEntityBone(vehicle, doorBone)
          			local distance = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, doorPos.x, doorPos.y, doorPos.z)
						
          			table.insert(doorDistances, distance)
        		end
					
        		local key, min = 1, doorDistances[1]
					
        		for k, v in ipairs(doorDistances) do
          			if doorDistances[k] < min then
           				key, min = k, v
          			end
        		end
					
        		TaskEnterVehicle(ped, vehicle, -1, doors[key][2], 1.5, 1, 0)
     		end
				
      		running = false
    	end
  	end
end)

-- KEYBIND CHANGEMENT PLACE VEHICLE
Citizen.CreateThread(function()
    while true do
        local plyPed = PlayerPedId()
        if IsPedSittingInAnyVehicle(plyPed) then
            local plyVehicle = GetVehiclePedIsIn(plyPed, false)
			CarSpeed = GetEntitySpeed(plyVehicle) * 3.6 -- On définit la vitesse du véhicule en km/h
			if CarSpeed <= 40.0 then -- On ne peux pas changer de place si la vitesse du véhicule est au dessus ou égale à 60 km/h
				if IsControlJustReleased(0, 157) then -- conducteur
					SetPedIntoVehicle(plyPed, plyVehicle, -1)
					Citizen.Wait(10)
				end
				if IsControlJustReleased(0, 158) then -- avant droit
					SetPedIntoVehicle(plyPed, plyVehicle, 0)
					Citizen.Wait(10)
				end
				if IsControlJustReleased(0, 160) then -- arriere gauche
					SetPedIntoVehicle(plyPed, plyVehicle, 1)
					Citizen.Wait(10)
				end
				if IsControlJustReleased(0, 164) then -- arriere gauche
					SetPedIntoVehicle(plyPed, plyVehicle, 2)
					Citizen.Wait(10)
				end
			end
		end
		Citizen.Wait(10) -- Fix Crash Client
	end
end)

-- NO DROP PNJ 

local function SetWeaponDrops()
    local handle, ped = FindFirstPed()
    local finished = false

    repeat
        if not IsEntityDead(ped) then
            SetPedDropsWeaponsWhenDead(ped, false)
        end
        finished, ped = FindNextPed(handle)
    until not finished

    EndFindPed(handle)
end

Citizen.CreateThread(function()
    while true do
        SetWeaponDrops()
        Citizen.Wait(500)
    end
end)


----- Plus de point pour les armes
--Citizen.CreateThread(function()
--    local isSniper = false
--    while true do
--        Citizen.Wait(6)
--
--        local ped = GetPlayerPed(-1)
--        local currentWeaponHash = GetSelectedPedWeapon(ped)
--
--        if currentWeaponHash == 100416529 then
--            isSniper = true
--        elseif currentWeaponHash == 205991906 then
--            isSniper = true
--        elseif currentWeaponHash == -952879014 then
--            isSniper = true
--        elseif currentWeaponHash == GetHashKey('WEAPON_HEAVYSNIPER_MK2') then
--            isSniper = true
--        else
--            isSniper = false
--        end
--
--        if not isSniper then
--            HideHudComponentThisFrame(14)
--        end
--    end
--end)


-- PVP

AddEventHandler("playerSpawned", function()
    NetworkSetFriendlyFireOption(true)
    SetCanAttackFriendly(PlayerPedId(), true, true)
end)


-- Disable dispatch & Weapon POLICE
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(3000)
       
        if GetPlayerWantedLevel(PlayerId()) ~= 0 then
            SetPlayerWantedLevel(PlayerId(), 0, false)
            SetPlayerWantedLevelNow(PlayerId(), false)
        end
    end
end)

Citizen.CreateThread(function()
	for i = 1, 12 do
		Citizen.InvokeNative(0xDC0F817884CDD856, i, false)
	end
    while true do
        Citizen.Wait(500)
        local myCoords = GetEntityCoords(GetPlayerPed(-1))
		ClearAreaOfCops(myCoords.x, myCoords.y, myCoords.z, 100.0, 0)
		DisablePlayerVehicleRewards(PlayerId())
    end
end)

--------------- KNOCKOUT

local knockedOut = false
local wait = 15
local count = 60

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(5)
		local myPed = GetPlayerPed(-1)
		if IsPedInMeleeCombat(myPed) then
			if GetEntityHealth(myPed) < 115 then
				SetPlayerInvincible(PlayerId(), true)
				SetPedToRagdoll(myPed, 1000, 1000, 0, 0, 0, 0)
				ESX.ShowNotification("~r~Vous êtes KO!")
				wait = 15
				knockedOut = true
				SetEntityHealth(myPed, 116)
			end
		end
		if knockedOut == true then
			SetPlayerInvincible(PlayerId(), true)
			DisablePlayerFiring(PlayerId(), true)
			SetPedToRagdoll(myPed, 1000, 1000, 0, 0, 0, 0)
			ResetPedRagdollTimer(myPed)
			
			if wait >= 0 then
				count = count - 1
				if count == 0 then
					count = 60
					wait = wait - 1
					SetEntityHealth(myPed, GetEntityHealth(myPed)+4)
				end
			else
				SetPlayerInvincible(PlayerId(), false)
				knockedOut = false
			end
		end
	end
end)



Player = {
    crouched = false,
    handsUp = false,
}

Controls = {
	HandsUP = {keyboard = Keys['H']},
	Crouch = {keyboard = Keys['LEFTCTRL']},
}

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(7)
		DisableControlAction(1, 36, true)

		if IsDisabledControlJustReleased(1, 36) and IsInputDisabled(2) then
			local plyPed = PlayerPedId()

			if (DoesEntityExist(plyPed)) and (not IsEntityDead(plyPed)) and (IsPedOnFoot(plyPed)) then
				Player.crouched = not Player.crouched

				if Player.crouched then 
					ESX.Streaming.RequestAnimSet('move_ped_crouched', function()
						SetPedMovementClipset(plyPed, 'move_ped_crouched', 0.25)
						RemoveAnimSet('move_ped_crouched')
					end)
				else
					ResetPedMovementClipset(plyPed, 0)
				end
			end
		end

		if IsControlJustReleased(1, Controls.HandsUP.keyboard) and IsInputDisabled(2) then
			local plyPed = PlayerPedId()

			if (DoesEntityExist(plyPed)) and not (IsEntityDead(plyPed)) and (IsPedOnFoot(plyPed)) then
				if Player.pointing then
					Player.pointing = false
				end

				Player.handsUp = not Player.handsUp

				if Player.handsUp then
					ESX.Streaming.RequestAnimDict('random@mugging3', function()
						TaskPlayAnim(plyPed, 'random@mugging3', 'handsup_standing_base', 8.0, -8, -1, 49, 0, 0, 0, 0)
						RemoveAnimDict('random@mugging3')
					end)
				else
					ClearPedSecondaryTask(plyPed)
				end
			end
		end

		if Player.crouched or Player.handsUp then
			if not IsPedOnFoot(PlayerPedId()) then
				ResetPedMovementClipset(plyPed, 0)
				stopPointing()
				Player.crouched, Player.handsUp, Player.pointing = false, false, false
			end
		end
	end
end)

--Boite quand on et bléser
local hurt = false
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(5000)
        if GetEntityHealth(GetPlayerPed(-1)) <= 159 then
            setHurt()
        elseif hurt and GetEntityHealth(GetPlayerPed(-1)) > 160 then
            setNotHurt()
        end
    end
end)

function setHurt()
    hurt = true
    RequestAnimSet("move_m@injured")
    SetPedMovementClipset(GetPlayerPed(-1), "move_m@injured", true)
end

function setNotHurt()
    hurt = false
    ResetPedMovementClipset(GetPlayerPed(-1))
    ResetPedWeaponMovementClipset(GetPlayerPed(-1))
    ResetPedStrafeClipset(GetPlayerPed(-1))
end

----text en haut a gauche
--servername = "Night City - discord.gg/nUgyr6j"
--
---- Default: 0.005, 0.001
--offset = {x = 0.005, y = 0.001}
--
---- Default: 64, 64, 64 (gray)
--rgb = {r = 26, g = 73, b = 255}
--
---- Default: 255
--alpha = 255
--
---- Default: 0.4
---- NOTE: Number needs to be a float (so instead of 1 do 1.0)
--scale = 0.5
--
---- 0 - 5 possible
---- Default: 1
--font = 1
--
--Citizen.CreateThread(function()
--	while true do
--		
--
--		SetTextColour(rgb.r, rgb.g, rgb.b, alpha)
--
--		SetTextFont(font)
--		SetTextScale(scale, scale)
--		SetTextWrap(0.0, 1.0)
--		SetTextCentre(false)
--		SetTextDropshadow(2, 2, 0, 0, 0)
--		SetTextEdge(1, 0, 0, 0, 205)
--		SetTextEntry("STRING")
--		AddTextComponentString(servername)
--		DrawText(offset.x, offset.y)
--		Wait(10000)
--	end
--end)
--


--Siren 
local sirene = 1
Citizen.CreateThread(function()
	while true do
		attenteSiren = 1500
		-- Check si le joueurs est dans un véhicule
		local playerped = GetPlayerPed(-1)		
		if IsPedInAnyVehicle(playerped, false) then	
			-- Check si le joueurs est conducteur
			local veh = GetVehiclePedIsUsing(playerped)	
			local NetId = NetworkGetNetworkIdFromEntity(veh)
			if GetPedInVehicleSeat(veh, -1) == playerped then
				-- Check si il est dans un véhicule de police / EMS
				if GetVehicleClass(veh) == 18 then
					attenteSiren = 11
					--DisableControlAction(0, 34, true)
					if IsDisabledControlJustReleased(0, 19) then
						if sirene == 0 then
							-- on
							TriggerServerEvent("siren:sync", sirene, NetId)
							sirene = 1
						else
							-- off
							TriggerServerEvent("siren:sync", sirene, NetId)
							sirene = 0
						end
					end
				end
			end
		end
		Citizen.Wait(attenteSiren)
	end
end)





-- Server side sync
RegisterNetEvent("siren:ClientSync")
AddEventHandler("siren:ClientSync", function(sync, NetId)
	local veh = NetworkGetEntityFromNetworkId(NetId)
	if sync == 0 then
		DisableVehicleImpactExplosionActivation(veh, 0)
	elseif sync == 1 then
		DisableVehicleImpactExplosionActivation(veh, 1)
	end
end)


--Debut point tp
key_to_teleport = 38

local function CheckPos(x, y, z, cx, cy, cz, radius)
    local t1 = x - cx
    local t12 = t1^2

    local t2 = y-cy
    local t21 = t2^2

    local t3 = z - cz
    local t31 = t3^2

    return (t12 + t21 + t31) <= radius^2
end

local function alert(msg)
    SetTextComponentFormat("STRING")
    AddTextComponentString(msg)
    DisplayHelpTextFromStringLabel(0,0,1,-1)
end

local player = GetPlayerPed(-1)

Citizen.CreateThread(function ()
    while true do
        Citizen.Wait(6)
        local player = GetPlayerPed(-1)
        local playerLoc = GetEntityCoords(player)

        for _,location in ipairs(positions) do
            teleport_text = location[4]
            loc1 = {
                x=location[1][1],
                y=location[1][2],
                z=location[1][3],
                heading=location[1][4]
            }
            loc2 = {
                x=location[2][1],
                y=location[2][2],
                z=location[2][3],
                heading=location[2][4]
            }
            Red = location[3][1]
            Green = location[3][2]
            Blue = location[3][3]

            --DrawMarker(1, loc1.x, loc1.y, loc1.z, 0, 0, 0, 0, 0, 0, 1.501, 1.5001, 0.5001, Red, Green, Blue, 100, 0, 0, 0, 0)
            --DrawMarker(1, loc2.x, loc2.y, loc2.z, 0, 0, 0, 0, 0, 0, 1.501, 1.5001, 0.5001, Red, Green, Blue, 100, 0, 0, 0, 0)

            if CheckPos(playerLoc.x, playerLoc.y, playerLoc.z, loc1.x, loc1.y, loc1.z, 2) then 
                alert(teleport_text)
                
                if IsControlJustReleased(1, key_to_teleport) then
                    if IsPedInAnyVehicle(player, true) then
                        SetEntityCoords(GetVehiclePedIsUsing(player), loc2.x, loc2.y, loc2.z)
                        SetEntityHeading(GetVehiclePedIsUsing(player), loc2.heading)
                    else
                        SetEntityCoords(player, loc2.x, loc2.y, loc2.z)
                        SetEntityHeading(player, loc2.heading)
                    end
                end

            elseif CheckPos(playerLoc.x, playerLoc.y, playerLoc.z, loc2.x, loc2.y, loc2.z, 2) then
                alert(teleport_text)

                if IsControlJustReleased(1, key_to_teleport) then
                    if IsPedInAnyVehicle(player, true) then
                        SetEntityCoords(GetVehiclePedIsUsing(player), loc1.x, loc1.y, loc1.z)
                        SetEntityHeading(GetVehiclePedIsUsing(player), loc1.heading)
                    else
                        SetEntityCoords(player, loc1.x, loc1.y, loc1.z)
                        SetEntityHeading(player, loc1.heading)
                    end
                end
            end            
        end
    end
end)

