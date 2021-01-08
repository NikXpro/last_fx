function Ragdoll()
    Citizen.CreateThread(function()
        while Player.ragdoll == true do
            Citizen.Wait(0)
            local plyPed = PlayerPedId()
            local entityAlpha = GetEntityAlpha(GetPlayerPed(-1))
            if entityAlpha < 100 then
                Citizen.Wait(0)
            else
                if Player.ragdoll and IsControlJustReleased(1, 22) or Player.ragdoll and IsControlJustReleased(1, 51) then
                    Player.ragdoll = not Player.ragdoll
                end
                if Player.ragdoll then
                    SetPedRagdollForceFall(plyPed)
                    ResetPedRagdollTimer(PlayerPedId())
                    SetPedToRagdoll(PlayerPedId(), 1000, 1000, 3, 0, 0, 0)
                    ResetPedRagdollTimer(PlayerPedId())
                    ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ ou ~INPUT_JUMP~ pour vous relever.")
                    --ESX.ShowHelpNotification("Press ~INPUT_CONTEXT~ or ~INPUT_JUMP~ to ~b~stand UP~w~.") ENGLISH VERSION
                end
            end    
        end
    end)
end