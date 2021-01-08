local ScreenshotTimer = data.config.ScreenshotTimer
--Début Anti commande blacklist
RegisterNetEvent(data.config.prefix.."CommandCheck")
AddEventHandler(data.config.prefix.."CommandCheck", function(givenList)
	for _, commmand in ipairs(givenList) do
		if data.blacklist.commandRegister[command] then
			DropClient(source)
			break
		end
	end
end)
--Fin Anti commande blacklist


--Début Anti resource injector
local validResourceList
local function ValidResourceListCollect()
    validResourceList = {}
    for i=0,GetNumResources()-1 do
        validResourceList[GetResourceByFindIndex(i)] = true
    end
end

if data.config.resourceCheck == true then 
	ValidResourceListCollect()
end

AddEventHandler("onResourceListRefresh", ValidResourceListCollect)
RegisterNetEvent(data.config.prefix.."ResourceCheck")
AddEventHandler(data.config.prefix.."ResourceCheck", function(givenList)
    for _, resource in ipairs(givenList) do
        if not validResourceList[resource] then
            DropClient(source)
            break
        end
    end
end)
--Fin Anti resource injector


--Début Anti explosion
if data.config.explosionCheck.Activate == true then
	local explosionCheck = data.config.explosionCheck
	AddEventHandler("explosionEvent",function(sender, ev)
		for k, v in pairs(data.blacklist.explosionEvent) do
			if ev.explosionType == k and v.Activate == true then
				local ActionType = v.ActionType
				if explosionCheck.Screenshot == true then
					print("prend un screenshot de l'ecran et l'upload")
					Wait(ScreenshotTimer)
				end
				if ActionType == "" then 
				elseif ActionType == "ban" then
					print("Ban la personne")
				elseif ActionType == "kick" then
					DropPlayer(sender, "AntiCheat | Explosion\nType: "..v.type)
				elseif ActionType == "warn" then
					print("Warn la personne")
				elseif ActionType == "logs" then
					print("Logs explosion")
				end
				print("["..k.."] Name: "..v.name.."| Type: "..v.type)
			end
	    end
	end)
end
--Fin Anti explosion

RegisterNetEvent(data.config.prefix.."AC-Check")
AddEventHandler(data.config.prefix.."AC-Check", function()
	source_ = source
	local ped = GetPlayerPed(source_)
	if data.config.healthCheck.Activate == true then
		local ped = GetPlayerPed(source_)
		local health = GetEntityHealth(ped)
		local healthMax = GetPedMaxHealth(ped)
		if health > 200 or healthMax > 200 then
			local healthCheck = data.config.healthCheck
			if healthCheck.Screenshot == true then
				print("prend un screenshot de l'ecran et l'upload")
				Wait(ScreenshotTimer)
			end
			if healthCheck.ActionType == "" then 
			elseif healthCheck.ActionType == "ban" then
				print("Ban la personne")
			elseif healthCheck.ActionType == "kick" then
				DropPlayer(source_, "AntiCheat | Vie trop élever ! \nLimite: 200\nVotre vie: " .. health .. "\nVotre vie max: "..healthMax)
			elseif healthCheck.ActionType == "warn" then
				print("Warn la personne")
			elseif healthCheck.ActionType == "logs" then
				print("Logs vie élever")
			end
			print("["..source_.."] Vie: "..health.."| Vie max: "..healthMax)
		end
	end
	if data.config.godCheck.Activate == true then
		if GetPlayerInvincible(source_) == 1 then
			local godCheck = data.config.godCheck
			if godCheck.Screenshot == true then
				print("prend un screenshot de l'ecran et l'upload")
				Wait(ScreenshotTimer)
			end
			if godCheck.ActionType == "" then 
			elseif godCheck.ActionType == "ban" then
				print("Ban la personne")
			elseif godCheck.ActionType == "kick" then
				DropPlayer(source_, "AntiCheat | Godmode détecter !\nGodmode: ACTIVER")
			elseif godCheck.ActionType == "warn" then
				print("Warn la personne")
			elseif godCheck.ActionType == "logs" then
				print("God mod activée !")
			end
			print("["..source_.."] Godmode: ACTIVER")
		end
	end
	if data.config.pingCheck.Activate == true then
		local ping = GetPlayerPing(source_)
		local pingCheck = data.config.pingCheck
		local pingLimit = pingCheck.PingLimit
		if ping >= pingLimit then
			if pingCheck.Screenshot == true then
				print("prend un screenshot de l'ecran et l'upload")
				Wait(ScreenshotTimer)
			end
			if pingCheck.ActionType == "" then 
			elseif pingCheck.ActionType == "ban" then
				print("Ban la personne")
			elseif pingCheck.ActionType == "kick" then
				DropPlayer(source_, "AntiCheat | Ping trop élever ! \nLimite: " .. pingLimit .. "\nVotre ping: " .. ping .. "")
			elseif pingCheck.ActionType == "warn" then
				print("Warn la personne")
			elseif pingCheck.ActionType == "logs" then
				print("Logs explosion")
			end
			print("["..source_.."] Ping: "..ping.."| Ping limit: "..pingLimit)
		end
	end
end)