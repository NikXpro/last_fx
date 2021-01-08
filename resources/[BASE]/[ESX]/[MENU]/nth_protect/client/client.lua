

local function ResourceListCollect()
    local resourceList = {}
    for i=0,GetNumResources()-1 do
        resourceList[i+1] = GetResourceByFindIndex(i)
    end
    TriggerServerEvent(data.config.prefix.."ResourceCheck", resourceList)
end

CreateThread(function()
	while true do
		TriggerServerEvent(data.config.prefix.."AC-Check")
		if data.config.commandCheck == true then 
			TriggerServerEvent(data.config.prefix.."CommandCheck", GetRegisteredCommands())
		end
		if data.config.resourceCheck == true then
			ResourceListCollect()
		end
		Wait(15000)
	end
end)