function sanitize(string)
    return string:gsub('%@', '')
end

exports('sanitize', function(string)
    sanitize(string)
end)

RegisterNetEvent("discordLogs")
AddEventHandler("discordLogs", function(message, color, channel)
    discordLog(message, color, channel)
end)

-- Get exports from server side
exports('discord', function(message, id, id2, color, channel)


	local ids = ExtractIdentifiers(id)
	local postal = getPlayerLocation(id)
	if Config.postal then _postal = "\n**CODE POSTAL:** ".. postal .."" else _postal = "" end
	if Config.discordID then if ids.discord ~= "" then _discordID ="\n**ID DISCORD:** <@" ..ids.discord:gsub("discord:", "")..">" else _discordID = "\n**ID DISCORD:** N/A" end else _discordID = "" end
	if Config.steamID then if ids.steam ~= "" then _steamID ="\n**STEAM ID:** " ..ids.steam.."" else _steamID = "\n**STEAM ID:** N/A" end else _steamID = "" end
	if Config.steamURL then  if ids.steam ~= "" then _steamURL ="\nhttps://steamcommunity.com/profiles/" ..tonumber(ids.steam:gsub("steam:", ""),16).."" else _steamURL = "\n**Steam URL:** N/A" end else _steamURL = "" end
	if Config.playerID then _playerID ="\n**ID JOUEUR:** " ..id.."" else _playerID = "" end
	local player1 = message..'\n'.._playerID..''.. _postal ..''.. _discordID..''.._steamID..''.._steamURL
	_message = player1

	if id2 ~= 0 then
	local ids2 = ExtractIdentifiers(id2)
	local postal2 = getPlayerLocation(id2)
	if Config.postal then _postal2 = "\n**CODE POSTAL:** ".. postal2 .."" else _postal2 = "" end
	if Config.discordID then if ids2.discord ~= "" then _discordID2 ="\n**ID DISCORD:** <@" ..ids2.discord:gsub("discord:", "")..">" else _discordID2 = "\n**ID DISCORD:** N/A" end else _discordID2 = "" end
	if Config.steamID then if ids2.steam ~= "" then _steamID2 ="\n**STEAM ID:** " ..ids2.steam.."" else _steamID2 = "\n**STEAM ID:** N/A" end else _steamID2 = "" end
	if Config.steamURL then  if ids2.steam ~= "" then _steamURL2 ="\nhttps://steamcommunity.com/profiles/" ..tonumber(ids2.steam:gsub("steam:", ""),16).."" else _steamURL2 = "\n**Steam URL:** N/A" end else _steamURL2 = "" end
	if Config.playerID then _playerID2 ="\n**ID JOUEUR:** " ..id2.."" else _playerID2 = "" end
	local player2 = _playerID2..''.. _postal2 ..''.. _discordID2..''.._steamID2..''.._steamURL2
	_message = player1..'\n'..player2
	end

    discordLog(_message, color, channel)
end)

-- Sending message to the All Logs channel and to the channel it has listed
function discordLog(message, color, channel)
  if Config.AllLogs then
	PerformHttpRequest(Config.webhooks["all"], function(err, text, headers) end, 'POST', json.encode({username = Config.username, embeds = {{["color"] = color, ["author"] = {["name"] = Config.communtiyName,["icon_url"] = Config.communtiyLogo}, ["description"] = "".. message .."",["footer"] = {["text"] = "Logs Serveur - "..os.date("%x %X %p"),["icon_url"] = "https://cdn.discordapp.com/attachments/740879768865603604/741840956470591518/icon-safe-14.jpg",},}}, avatar_url = Config.avatar}), { ['Content-Type'] = 'application/json' })
  end
	PerformHttpRequest(Config.webhooks[channel], function(err, text, headers) end, 'POST', json.encode({username = Config.username, embeds = {{["color"] = color, ["author"] = {["name"] = Config.communtiyName,["icon_url"] = Config.communtiyLogo}, ["description"] = "".. message .."",["footer"] = {["text"] = "Logs Serveur - "..os.date("%x %X %p"),["icon_url"] = "https://cdn.discordapp.com/attachments/740879768865603604/741840956470591518/icon-safe-14.jpg",},}}, avatar_url = Config.avatar}), { ['Content-Type'] = 'application/json' })
end

-- Event Handlers

-- Send message when Player connects to the server.
AddEventHandler("playerConnecting", function(name, setReason, deferrals)
	local ids = ExtractIdentifiers(source)
	if Config.discordID then if ids.discord ~= "" then _discordID ="\n**ID DISCORD:** <@" ..ids.discord:gsub("discord:", "")..">" else _discordID = "\n**ID DISCORD:** N/A" end else _discordID = "" end
	if Config.steamID then if ids.steam ~= "" then _steamID ="\n**STEAM ID:** " ..ids.steam.."" else _steamID = "\n**STEAM ID:** N/A" end else _steamID = "" end
	if Config.steamURL then  if ids.steam ~= "" then _steamURL ="\nhttps://steamcommunity.com/profiles/" ..tonumber(ids.steam:gsub("steam:", ""),16).."" else _steamURL = "\n**Steam URL:** N/A" end else _steamID = "" end
	discordLog('**' .. sanitize(GetPlayerName(source)) .. '** se connecte au serveur.'.. _discordID..''.._steamID..'', Config.joinColor, 'joins')
end)

-- Send message when Player disconnects from the server
AddEventHandler('playerDropped', function(reason)
	local ids = ExtractIdentifiers(source)
	local postal = getPlayerLocation(source)
	if Config.postal then _postal = "\n**CODE POSTAL:** ".. postal .."" else _postal = "" end
	if Config.discordID then if ids.discord ~= "" then _discordID ="\n**ID DISCORD:** <@" ..ids.discord:gsub("discord:", "")..">" else _discordID = "\n**ID DISCORD:** N/A" end else _discordID = "" end
	if Config.steamID then if ids.steam ~= "" then _steamID ="\n**STEAM ID:** " ..ids.steam.."" else _steamID = "\n**STEAM ID:** N/A" end else _steamID = "" end
	if Config.steamURL then  if ids.steam ~= "" then _steamURL ="\nhttps://steamcommunity.com/profiles/" ..tonumber(ids.steam:gsub("steam:", ""),16).."" else _steamURL = "\n**Steam URL:** N/A" end else _steamID = "" end
	if Config.playerID then _playerID ="\n**ID JOUEUR:** " ..source.."" else _playerID = "" end
	discordLog('**' .. sanitize(GetPlayerName(source)) .. '** a quitté le serveur. (Raison: ' .. reason .. ')'.._playerID..''.. _postal ..''.. _discordID..''.._steamID..'', Config.leaveColor, 'leaving')
end)

-- Send message when Player creates a chat message (Does not show commands)
AddEventHandler('chatMessage', function(source, name, msg)
	local ids = ExtractIdentifiers(source)
	local postal = getPlayerLocation(source)
	if Config.postal then _postal = "\n**CODE POSTAL:** ".. postal .."" else _postal = "" end
	if Config.discordID then if ids.discord ~= "" then _discordID ="\n**ID DISCORD:** <@" ..ids.discord:gsub("discord:", "")..">" else _discordID = "\n**ID DISCORD:** N/A" end else _discordID = "" end
	if Config.steamID then if ids.steam ~= "" then _steamID ="\n**STEAM ID:** " ..ids.steam.."" else _steamID = "\n**STEAM ID:** N/A" end else _steamID = "" end
	if Config.steamURL then  if ids.steam ~= "" then _steamURL ="\nhttps://steamcommunity.com/profiles/" ..tonumber(ids.steam:gsub("steam:", ""),16).."" else _steamURL = "\n**Steam URL:** N/A" end else _steamID = "" end
	if Config.playerID then _playerID ="\n**ID JOUEUR:** " ..source.."" else _playerID = "" end

	discordLog('**' .. sanitize(GetPlayerName(source)) .. '**: ``' .. msg .. '``'.._playerID..''.. _postal ..''.. _discordID..''.._steamID..'', Config.chatColor, 'chat')
end)

-- Send message when Player died (including reason/killer check) (Not always working)
RegisterServerEvent('playerDied')
AddEventHandler('playerDied',function(id,player,killer,DeathReason,Weapon)
	local ids = ExtractIdentifiers(source)
	local postal = getPlayerLocation(source)
	if DeathReason then _DeathReason = "`"..DeathReason.."`" else _DeathReason = "`died`" end
	if Weapon then _Weapon = ""..Weapon.."" else _Weapon = "" end
	if Config.postal then _postal = "\n**CODE POSTAL:** ".. postal .."" else _postal = "" end
	if Config.discordID then if ids.discord ~= "" then _discordID ="\n**ID DISCORD:** <@" ..ids.discord:gsub("discord:", "")..">" else _discordID = "\n**ID DISCORD:** N/A" end else _discordID = "" end
	if Config.steamID then if ids.steam ~= "" then _steamID ="\n**STEAM ID:** " ..ids.steam.."" else _steamID = "\n**STEAM ID:** N/A" end else _steamID = "" end
	if Config.steamURL then  if ids.steam ~= "" then _steamURL ="\nhttps://steamcommunity.com/profiles/" ..tonumber(ids.steam:gsub("steam:", ""),16).."" else _steamURL = "\n**Steam URL:** N/A" end else _steamID = "" end
	if Config.playerID then _playerID ="\n**ID JOUEUR:** " ..source.."" else _playerID = "" end

	if id == 1 then  -- Suicide/died
        discordLog('**' .. sanitize(GetPlayerName(source)) .. '** '.._DeathReason..''.._Weapon..''.._playerID..''.. _postal ..''.. _discordID..''.._steamID..'', Config.deathColor, 'deaths') -- sending to deaths channel
	elseif id == 2 then -- Killed by other player
	local ids2 = ExtractIdentifiers(killer)
	local postal2 = getPlayerLocation(killer)
	if Config.postal then _postal2 = "\n**CODE POSTAL:** ".. postal2 .."" else _postal2 = "" end
	if Config.discordID then if ids2.discord ~= "" then _KillDiscordID ="\n**ID DISCORD:** <@" ..ids2.discord:gsub("discord:", "")..">" else _KillDiscordID = "\n**ID DISCORD:** N/A" end else _KillDiscordID = "" end
	if Config.steamID then if ids2.steam ~= "" then _KillSteamID ="\n**STEAM ID:** " ..ids2.steam.."" else _KillSteamID = "\n**STEAM ID:** N/A" end else _KillSteamID = "" end
	if Config.steamURL then  if ids2.steam ~= "" then _KillSteamURL ="\nhttps://steamcommunity.com/profiles/" ..tonumber(ids2.steam:gsub("steam:", ""),16).."" else _KillSteamURL = "\n**Steam URL:** N/A" end else _steamID = "" end
	if Config.playerID then _killPlayerID ="\n**ID JOUEUR:** " ..killer.."" else _killPlayerID = "" end
		discordLog('**' .. GetPlayerName(killer) .. '** '.._DeathReason..' ' .. GetPlayerName(source).. ' `('.._Weapon..')`\n\n**[INFO JOUEUR]**'.._playerID..''.. _postal ..''.. _discordID..''.._steamID..'\n\n**[INFO TUEUR]**'.._killPlayerID..''.. _postal2 ..''.. _KillDiscordID..''.._KillSteamID..''.._KillSteamURL..'', Config.deathColor, 'deaths') -- sending to deaths channel
	else -- When gets killed by something else
        discordLog('**' .. sanitize(GetPlayerName(source)) .. '** ` et décédés`'.._playerID..''.. _postal ..''.. _discordID..''.._steamID..'', Config.deathColor, 'deaths') -- sending to deaths channel
	end
end)

-- Send message when Player fires a weapon
RegisterServerEvent('playerShotWeapon')
AddEventHandler('playerShotWeapon', function(weapon)
	local ids = ExtractIdentifiers(source)
	local postal = getPlayerLocation(source)
	if Config.postal then _postal = "\n**CODE POSTAL:** ".. postal .."" else _postal = "" end
	if Config.discordID then if ids.discord ~= "" then _discordID ="\n**ID DISCORD:** <@" ..ids.discord:gsub("discord:", "")..">" else _discordID = "\n**ID DISCORD:** N/A" end else _discordID = "" end
	if Config.steamID then if ids.steam ~= "" then _steamID ="\n**STEAM ID:** " ..ids.steam.."" else _steamID = "\n**STEAM ID:** N/A" end else _steamID = "" end
	if Config.steamURL then  if ids.steam ~= "" then _steamURL ="\nhttps://steamcommunity.com/profiles/" ..tonumber(ids.steam:gsub("steam:", ""),16).."" else _steamURL = "\n**Steam URL:** N/A" end else _steamID = "" end
	if Config.playerID then _playerID ="\n**ID JOUEUR:** " ..source.."" else _playerID = "" end
	if Config.weaponLog then
		discordLog('**' .. sanitize(GetPlayerName(source))  .. '**a tiré avec `' .. weapon .. '`'.._playerID..''.. _postal ..''.. _discordID..'', Config.shootingColor, 'shooting')
    end
end)

-- Getting exports from clientside
RegisterServerEvent('ClientDiscord')
AddEventHandler('ClientDiscord', function(message, id, id2, color, channel)
	local ids = ExtractIdentifiers(id)
end)

-- Send message when a resource is being stopped
AddEventHandler('onResourceStop', function (resourceName)
    discordLog('**' .. resourceName .. '** a été arrêté.', Config.resourceColor, 'resources')
end)

-- Send message when a resource is being started
AddEventHandler('onResourceStart', function (resourceName)
    Wait(100)
    discordLog('**' .. resourceName .. '** a été lancer.', Config.resourceColor, 'resources')
end)

RegisterServerEvent('JDlogs:GetIdentifiers')
AddEventHandler('JDlogs:GetIdentifiers', function(src)
	local ids = ExtractIdentifiers(src)
	return ids
end)

function ExtractIdentifiers(src)
    local identifiers = {
        steam = "",
        ip = "",
        discord = "",
        license = "",
        xbl = "",
        live = ""
    }

    for i = 0, GetNumPlayerIdentifiers(src) - 1 do
        local id = GetPlayerIdentifier(src, i)

        if string.find(id, "steam") then
            identifiers.steam = id
        elseif string.find(id, "ip") then
            identifiers.ip = id
        elseif string.find(id, "discord") then
            identifiers.discord = id
        elseif string.find(id, "license") then
            identifiers.license = id
        elseif string.find(id, "xbl") then
            identifiers.xbl = id
        elseif string.find(id, "live") then
            identifiers.live = id
        end
    end

    return identifiers
end

function getPlayerLocation(src)

local raw = LoadResourceFile(GetCurrentResourceName(), GetResourceMetadata(GetCurrentResourceName(), 'postal_file'))
local postals = json.decode(raw)
local nearest = nil

local player = src
local ped = GetPlayerPed(player)
local playerCoords = GetEntityCoords(ped)

local x, y = table.unpack(playerCoords)

	local ndm = -1
	local ni = -1
	for i, p in ipairs(postals) do
		local dm = (x - p.x) ^ 2 + (y - p.y) ^ 2
		if ndm == -1 or dm < ndm then
			ni = i
			ndm = dm
		end
	end

	if ni ~= -1 then
		local nd = math.sqrt(ndm)
		nearest = {i = ni, d = nd}
	end
	_nearest = postals[nearest.i].code
	return _nearest
end