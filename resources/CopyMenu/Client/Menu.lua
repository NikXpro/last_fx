RMenu.Add('PasteMenu', 'Principal', RageUI.CreateMenu("", "Copy/Paste Menu", nil, nil, "IseDict", "Banner"), true)
RMenu:Get('PasteMenu', 'Principal'):DisplayGlare(false);

Copy = {
    First = nil,
    FirstState = false,
}

Citizen.CreateThread( function()
    while true do
        Citizen.Wait(0)
        if IsControlJustReleased(1, 344) then
            RageUI.Visible(RMenu:Get('PasteMenu', 'Principal'), not RageUI.Visible(RMenu:Get('PasteMenu', 'Principal')))
        end
        
        RageUI.IsVisible(RMenu:Get('PasteMenu', 'Principal'), function()
            RageUI.Item.Checkbox("First coords", Copy.First, Copy.FirstState, {}, {
                onChecked = function()
                    local Coords = GetEntityCoords(PlayerPedId())
                    local x, y, z = table.unpack(Coords)
                    local Heading = GetEntityHeading(PlayerPedId())
                    Copy.First = "{x = "..x..", y = "..y..", z = "..z.."},"
                    Copy.FirstState = true
                end,
            })
            if Copy.First ~= nil then
                RageUI.Item.Button("Copy coords", Copy.First, {}, true, {
                    onSelected = function()
                        SendNUIMessage({
                            Copy = Copy.First
                        })
					    Copy.First = nil
					    Copy.FirstState = false
                    end,
                })
            end
        end)
    end
end)

function sendNotif(Txt)
	SetNotificationTextEntry("STRING")
	AddTextComponentString(Txt)
	DrawNotification(0,1)
end

