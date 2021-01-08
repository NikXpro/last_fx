local ESX = nil
 
-- ESX
Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end
end)
 
-- ESX, playerloaded
RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
    PlayerData = xPlayer
end)
 
-- Use item
RegisterNetEvent('eden_accesories:use')
AddEventHandler('eden_accesories:use', function( type )
    if data.weapons[GetSelectedPedWeapon(PlayerPedId())] and data.weapons[GetSelectedPedWeapon(PlayerPedId())][type] then
        if not HasPedGotWeaponComponent(GetPlayerPed(-1), GetSelectedPedWeapon(PlayerPedId()), data.weapons[GetSelectedPedWeapon(PlayerPedId())][type]) then
            GiveWeaponComponentToPed(GetPlayerPed(-1), GetSelectedPedWeapon(PlayerPedId()), data.weapons[GetSelectedPedWeapon(PlayerPedId())][type])  
            ESX.ShowNotification(string.format('%s %s', "Vous avez équipé votre ", type))
        else
            RemoveWeaponComponentFromPed(GetPlayerPed(-1), GetSelectedPedWeapon(PlayerPedId()), data.weapons[GetSelectedPedWeapon(PlayerPedId())][type])  
            ESX.ShowNotification(string.format('%s %s', "Vous avez déséquipé votre ", type))
        end
    else
        ESX.ShowNotification(string.format('%s %s %s', 'Le/la ', type, " ne vas pas sur votre arme.."))
    end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if IsControlJustPressed(0, 172) then
			if data.weapons[GetSelectedPedWeapon(PlayerPedId())] then
				for k,v in pairs(data.weapons) do
                    if GetSelectedPedWeapon(PlayerPedId()) == k then
                        --Silencieux debut
						if HasPedGotWeaponComponent(GetPlayerPed(-1), GetSelectedPedWeapon(PlayerPedId()), v.suppressor) then
							TriggerServerEvent('eden_accesories:giveBack', 'suppressor')
							ESX.ShowNotification("Vous avez retirer votre silencieux")
                            RemoveWeaponComponentFromPed(GetPlayerPed(-1), GetSelectedPedWeapon(PlayerPedId()), v.suppressor)
                        --Silencieux fin

                        --Compensateur debut
                        elseif HasPedGotWeaponComponent(GetPlayerPed(-1), GetSelectedPedWeapon(PlayerPedId()), v.compensator) then
							TriggerServerEvent('eden_accesories:giveBack', 'compensator')
							ESX.ShowNotification("Vous avez retirer votre compensateur")
                            RemoveWeaponComponentFromPed(GetPlayerPed(-1), GetSelectedPedWeapon(PlayerPedId()), v.compensator)
                        --Compensateur fin

                        --Lampe debut
						elseif HasPedGotWeaponComponent(GetPlayerPed(-1), GetSelectedPedWeapon(PlayerPedId()), v.flashlight) then
							TriggerServerEvent('eden_accesories:giveBack', 'flashlight')
							ESX.ShowNotification("Vous avez retirer votre lampe")
                            RemoveWeaponComponentFromPed(GetPlayerPed(-1), GetSelectedPedWeapon(PlayerPedId()), v.flashlight)
                        --Lampe fin

                        --Poignet debut
                        elseif HasPedGotWeaponComponent(GetPlayerPed(-1), GetSelectedPedWeapon(PlayerPedId()), v.grip) then
							TriggerServerEvent('eden_accesories:giveBack', 'grip')
							ESX.ShowNotification("Vous avez retirer votre poignet")
                            RemoveWeaponComponentFromPed(GetPlayerPed(-1), GetSelectedPedWeapon(PlayerPedId()), v.grip)
                        --Poignet fin

                        --Viseur pour pistolet debut
                        elseif HasPedGotWeaponComponent(GetPlayerPed(-1), GetSelectedPedWeapon(PlayerPedId()), v.scope_sights) then
                            TriggerServerEvent('eden_accesories:giveBack', 'scope_rail')
                            ESX.ShowNotification("Vous avez retirer votre viseur hollographique")
                            RemoveWeaponComponentFromPed(GetPlayerPed(-1), GetSelectedPedWeapon(PlayerPedId()), v.scope_rail)
                        --Viseur pour pistolet fin

                        --Viseur hollographique debut
						elseif HasPedGotWeaponComponent(GetPlayerPed(-1), GetSelectedPedWeapon(PlayerPedId()), v.scope_sights) then
							TriggerServerEvent('eden_accesories:giveBack', 'scope_sights')
							ESX.ShowNotification("Vous avez retirer votre viseur hollographique")
                            RemoveWeaponComponentFromPed(GetPlayerPed(-1), GetSelectedPedWeapon(PlayerPedId()), v.scope_sights)
                        --Viseur hollographique fin
                        
                        --Viseur petit debut
						elseif HasPedGotWeaponComponent(GetPlayerPed(-1), GetSelectedPedWeapon(PlayerPedId()), v.scope_macro) then
							TriggerServerEvent('eden_accesories:giveBack', 'scope_macro')
							ESX.ShowNotification("Vous avez retirer votre petite lunette")
                            RemoveWeaponComponentFromPed(GetPlayerPed(-1), GetSelectedPedWeapon(PlayerPedId()), v.scope_macro)
                        --Viseur petit fin

                        --Viseur moyen debut
                        elseif HasPedGotWeaponComponent(GetPlayerPed(-1), GetSelectedPedWeapon(PlayerPedId()), v.scope_small) then
							TriggerServerEvent('eden_accesories:giveBack', 'scope_small')
							ESX.ShowNotification("Vous avez retirer votre lunette moyenne")
                            RemoveWeaponComponentFromPed(GetPlayerPed(-1), GetSelectedPedWeapon(PlayerPedId()), v.scope_small)
                        --Viseur moyen fin

                        --Viseur grand debut
                        elseif HasPedGotWeaponComponent(GetPlayerPed(-1), GetSelectedPedWeapon(PlayerPedId()), v.scope_medium) then
                            TriggerServerEvent('eden_accesories:giveBack', 'scope_medium')
                            ESX.ShowNotification("Vous avez retirer votre grande lunette")
                            RemoveWeaponComponentFromPed(GetPlayerPed(-1), GetSelectedPedWeapon(PlayerPedId()), v.scope_medium)
                        --Viseur grand fin

                        --chargeur grande capacité debut
                        elseif HasPedGotWeaponComponent(GetPlayerPed(-1), GetSelectedPedWeapon(PlayerPedId()), v.clip_large) then
                            TriggerServerEvent('eden_accesories:giveBack', 'clip_large')
                            ESX.ShowNotification("Vous avez retirer votre chargeur grande capacité")
                            RemoveWeaponComponentFromPed(GetPlayerPed(-1), GetSelectedPedWeapon(PlayerPedId()), v.clip_large)
                        --chargeur grande capacité fin

                        --balle tracente debut
                        elseif HasPedGotWeaponComponent(GetPlayerPed(-1), GetSelectedPedWeapon(PlayerPedId()), v.clip_tracer) then
                            TriggerServerEvent('eden_accesories:giveBack', 'clip_tracer')
                            ESX.ShowNotification("Vous avez retirer vos balle tracente")
                            RemoveWeaponComponentFromPed(GetPlayerPed(-1), GetSelectedPedWeapon(PlayerPedId()), v.clip_tracer)
                        --balle tracente fin

                        --balle incendiaire debut
                        elseif HasPedGotWeaponComponent(GetPlayerPed(-1), GetSelectedPedWeapon(PlayerPedId()), v.clip_incendiary) then
                            TriggerServerEvent('eden_accesories:giveBack', 'clip_incendiary')
                            ESX.ShowNotification("Vous avez retirer vos balle incendiaire")
                            RemoveWeaponComponentFromPed(GetPlayerPed(-1), GetSelectedPedWeapon(PlayerPedId()), v.clip_incendiary)
                        --balle incendiaire fin

                        --balle a téte creuse debut
                        elseif HasPedGotWeaponComponent(GetPlayerPed(-1), GetSelectedPedWeapon(PlayerPedId()), v.clip_hollowpoint) then
                            TriggerServerEvent('eden_accesories:giveBack', 'clip_hollowpoint')
                            ESX.ShowNotification("Vous avez retirer vos balle a téte creuse")
                            RemoveWeaponComponentFromPed(GetPlayerPed(-1), GetSelectedPedWeapon(PlayerPedId()), v.clip_hollowpoint)
                        --balle a téte creuse fin

                        --balle perforante debut
                        elseif HasPedGotWeaponComponent(GetPlayerPed(-1), GetSelectedPedWeapon(PlayerPedId()), v.clip_armorpiercing) then
                            TriggerServerEvent('eden_accesories:giveBack', 'clip_armorpiercing')
                            ESX.ShowNotification("Vous avez retirer vos balle perforante")
                            RemoveWeaponComponentFromPed(GetPlayerPed(-1), GetSelectedPedWeapon(PlayerPedId()), v.clip_armorpiercing)
                        --balle perforantee fin

                        --balle blindé debut
                        elseif HasPedGotWeaponComponent(GetPlayerPed(-1), GetSelectedPedWeapon(PlayerPedId()), v.clip_fmj) then
                            TriggerServerEvent('eden_accesories:giveBack', 'clip_fmj')
                            ESX.ShowNotification("Vous avez retirer vos balle blindé")
                            RemoveWeaponComponentFromPed(GetPlayerPed(-1), GetSelectedPedWeapon(PlayerPedId()), v.clip_fmj)
                        --balle blindé fin

                        --Canon lourd debut
                        elseif HasPedGotWeaponComponent(GetPlayerPed(-1), GetSelectedPedWeapon(PlayerPedId()), v.barrel_heavy) then
                            TriggerServerEvent('eden_accesories:giveBack', 'barrel_heavy')
                            ESX.ShowNotification("Vous avez retirer votre canon lourd")
                            RemoveWeaponComponentFromPed(GetPlayerPed(-1), GetSelectedPedWeapon(PlayerPedId()), v.barrel_heavy)
                        --Canon lourd fin
						end
					end
				end
			end
		end
	end
end)