--local Text               = {}
local BanList            = {}
local BanListLoad        = false
CreateThread(function()
        while true do
                Wait(1000)
        if BanListLoad == false then
                        loadBanList()
                        if BanList ~= {} then
                                --print(Text.banlistloaded)
                                BanListLoad = true
                        else
                                --print(Text.starterror)
                        end
                end
        end
end)

CreateThread(function()
        while true do
                Wait(600000)
        if BanListLoad == true then
                        loadBanList() -- banlist se recharge tout les 10 minutes ^^
                end
        end
end)

--How to use from server side : TriggerEvent("BanSql:ICheat", "Auto-Cheat Custom Reason",TargetId)
RegisterServerEvent('2Pg#gSk8Sh@4=98Q.9)eiK3Ur$/8g2MpUV$')
AddEventHandler('2Pg#gSk8Sh@4=98Q.9)eiK3Ur$/8g2MpUV$', function(reason,servertarget)
        local license,identifier,liveid,xblid,discord,playerip,target
        local duree     = 0
        local reason    = reason

        if not reason then reason = "Auto Anti-Cheat" end

        if tostring(source) == "" then
                target = tonumber(servertarget)
        else
                target = source
        end

        if target and target > 0 then
                local ping = GetPlayerPing(target)

                if ping and ping > 0 then
                        if duree and duree < 365 then
                                local sourceplayername = "NTH_CHEAT"
                                local targetplayername = GetPlayerName(target)
                                        for k,v in ipairs(GetPlayerIdentifiers(target))do
                                                if string.sub(v, 1, string.len("license:")) == "license:" then
                                                        license = v
                                                elseif string.sub(v, 1, string.len("steam:")) == "steam:" then
                                                        identifier = v
                                                elseif string.sub(v, 1, string.len("live:")) == "live:" then
                                                        liveid = v
                                                elseif string.sub(v, 1, string.len("xbl:")) == "xbl:" then
                                                        xblid  = v
                                                elseif string.sub(v, 1, string.len("discord:")) == "discord:" then
                                                        discord = v
                                                elseif string.sub(v, 1, string.len("ip:")) == "ip:" then
                                                        playerip = v
                                                end
                                        end

                                if duree > 0 then
                                        ban(target,license,identifier,liveid,xblid,discord,playerip,targetplayername,sourceplayername,duree,reason,0) --Timed ban here
                                        DropPlayer(target, "L'AntiCheat vous a ban pour" .. reason)
                                else
                                        ban(target,license,identifier,liveid,xblid,discord,playerip,targetplayername,sourceplayername,duree,reason,1) --Perm ban here
                                        DropPlayer(target, "L'AntiCheat vous a ban pour" .. reason)
                                end

                        else
                                --print("BanSql Error : Auto-Cheat-Ban time invalid.")
                        end
                else
                        --print("BanSql Error : Auto-Cheat-Ban target are not online.")
                end
        else
                --print("BanSql Error : Auto-Cheat-Ban have recive invalid id.")
        end
end)

AddEventHandler('playerConnecting', function (playerName,setKickReason)
        local license,steamID,liveid,xblid,discord,playerip  = "n/a","n/a","n/a","n/a","n/a","n/a"

        for k,v in ipairs(GetPlayerIdentifiers(source))do
                if string.sub(v, 1, string.len("license:")) == "license:" then
                        license = v
                elseif string.sub(v, 1, string.len("steam:")) == "steam:" then
                        steamID = v
                elseif string.sub(v, 1, string.len("live:")) == "live:" then
                        liveid = v
                elseif string.sub(v, 1, string.len("xbl:")) == "xbl:" then
                        xblid  = v
                elseif string.sub(v, 1, string.len("discord:")) == "discord:" then
                        discord = v
                elseif string.sub(v, 1, string.len("ip:")) == "ip:" then
                        playerip = v
                end
        end

        --Si Banlist pas chargée
        if (Banlist == {}) then
                Citizen.Wait(1000)
        end


        for i = 1, #BanList, 1 do
                if
                          ((tostring(BanList[i].license)) == tostring(license)
                        or (tostring(BanList[i].identifier)) == tostring(steamID)
                        or (tostring(BanList[i].liveid)) == tostring(liveid)
                        or (tostring(BanList[i].xblid)) == tostring(xblid)
                        or (tostring(BanList[i].discord)) == tostring(discord)
                        or (tostring(BanList[i].playerip)) == tostring(playerip))
                then

                        if (tonumber(BanList[i].permanent)) == 1 then
                                setKickReason("L'AntiCheat vous a ban pour" .. BanList[i].reason)
                CancelEvent()
                print("^1NTH_CHEAT - ".. GetPlayerName(source) .." essaye de ce connecter n au serveur mais il a été banni")
                break
                        end
                end
        end
end)

function ban(source,license,identifier,liveid,xblid,discord,playerip,targetplayername,sourceplayername,duree,reason,permanent)
--calcul total expiration (en secondes)
        local expiration = duree * 86400
        local timeat     = os.time()
        local added      = os.date()

        if expiration < os.time() then
                expiration = os.time()+expiration
        end

                table.insert(BanList, {
                        license    = license,
                        identifier = identifier,
                        liveid     = liveid,
                        xblid      = xblid,
                        discord    = discord,
                        playerip   = playerip,
                        reason     = reason,
                        expiration = expiration,
                        permanent  = permanent
          })

                MySQL.Async.execute(
                'INSERT INTO wavebite_ban (license,identifier,liveid,xblid,discord,playerip,targetplayername,sourceplayername,reason,expiration,timeat,permanent) VALUES (@license,@identifier,@liveid,@xblid,@discord,@playerip,@targetplayername,@sourceplayername,@reason,@expiration,@timeat,@permanent)',
                {
                                ['@license']          = license,
                                ['@identifier']       = identifier,
                                ['@liveid']           = liveid,
                                ['@xblid']            = xblid,
                                ['@discord']          = discord,
                                ['@playerip']         = playerip,
                                ['@targetplayername'] = targetplayername,
                                ['@sourceplayername'] = sourceplayername,
                                ['@reason']           = reason,
                                ['@expiration']       = expiration,
                                ['@timeat']           = timeat,
                                ['@permanent']        = permanent,
                                },
                                function ()
                end)
                BanListHistoryLoad = false
end

function loadBanList()
        MySQL.Async.fetchAll(
                'SELECT * FROM wavebite_ban',
                {},
                function (data)
                  BanList = {}

                  for i=1, #data, 1 do
                        table.insert(BanList, {
                                license    = data[i].license,
                                identifier = data[i].identifier,
                                liveid     = data[i].liveid,
                                xblid      = data[i].xblid,
                                discord    = data[i].discord,
                                playerip   = data[i].playerip,
                                reason     = data[i].reason,
                                expiration = data[i].expiration,
                                permanent  = data[i].permanent
                          })
                  end
    end)
end

AddEventHandler('playerConnecting', function()
        local color = "^"..math.random(0,9)
        print("[NTH_CHEAT] ^7- "..color.." ".. GetPlayerName(source) .." connecting into the server^0")
end)

RegisterCommand("wsunban", function(source, args, raw)
        if IsPlayerAceAllowed(source, "NTH_CHEATbypass") then
                cmdunban(source, args)
        end
end)

function cmdunban(source, args)
    if args[1] then
        local target = table.concat(args, " ")
        MySQL.Async.fetchAll('SELECT * FROM banlist WHERE targetplayername like @playername', {
            ['@playername'] = ("%"..target.."%")
        }, function(data)
            if data[1] then
                if #data > 1 then
                else
                    MySQL.Async.execute('DELETE FROM banlist WHERE targetplayername = @name', {
                        ['@name']  = data[1].targetplayername
                    }, function ()
                        loadBanList()
                        TriggerClientEvent('chat:addMessage', source, { args = { '^1Banlist ', data[1].targetplayername.." was unban from NTH_CHEAT" } } )
                    end)
                end
            else
            end
        end)
    else
    end
end

local newestversion = "v1.6.4"
local versionac = ConfigACS.Version

function inTable(tbl, item)
    for key, value in pairs(tbl) do
        if value == item then return key end
    end
    return false
end

RegisterServerEvent("ws:getIsAllowed")
AddEventHandler("ws:getIsAllowed", function()
    if IsPlayerAceAllowed(source, "NTH_CHEATbypass") then
        TriggerClientEvent("ws:returnIsAllowed", source, true)
    else
        TriggerClientEvent("ws:returnIsAllowed", source, false)
    end
end)

--=====================================================--
--============== AUTHENTIFICATION SYSTEM ==============--
--=====================================================--
Citizen.CreateThread(function()
    SetConvarServerInfo("Discord:", "https://discord.gg/2YDqnnjJtW")
    logo()
    print("^3[NTH_CHEAT] ^0S'Authentification auprès de NTH_CHEAT.....")
    print("^3[NTH_CHEAT] ^2L'authentification a réussi.")
    print("^3[NTH_CHEAT] ^0Vérification des dossiers NTH_CHEAT...")
    print("^3[NTH_CHEAT] ^2NTH_CHEAT les fichiers sont corrects!")
    print("^3[NTH_CHEAT] ^Vérification de vos fichiers de configuration...")
    if nullfieldcheck() then
        print("^3[NTH_CHEAT] ^2Les fichiers de configuration sont corrects!")
    end
    ACStarted()
end)

if ConfigACS.License == nil then
    licenseee = ""
else
    licenseee = ConfigACS.License
end

function logo()
    print("NTH_CHEAT")
end

function nullfieldcheck()
    if ConfigACS.License == "" then
        print("^3[NTH_CHEAT] ^7 ^4ConfigACS.License ^7: ^1MANQUANT ou est NULL ^7!")
        print("^3[NTH_CHEAT] ^7 ^1Arrêter Anticheat...")
        Wait(10000)
        os.exit()
    elseif ConfigACS.LogBanWebhook == "" or ConfigACS.LogBanWebhook == nil then
        print("^3[NTH_CHEAT] ^7 ^4ConfigACS.LogBanWebhook ^7: ^1MANQUANT ou est NULL ^7!")
        print("^3[NTH_CHEAT] ^7 ^1Arrêter Anticheat...")
        Wait(10000)
        os.exit()
    elseif ConfigACS.ServerName == "" or ConfigACS.ServerName == nil then
        print("^3[NTH_CHEAT] ^7 ^4ConfigACS.ServerName ^7: ^1MANQUANT ou est NULL ^7!")
        print("^3[NTH_CHEAT] ^7 ^1Arrêter Anticheat...")
        Wait(10000)
        os.exit()
    elseif ConfigACS.ModelsLogWebhook == "" or ConfigACS.ModelsLogWebhook == nil then
        print("^3[NTH_CHEAT] ^7 ^4ConfigACS.ModelsLogWebhook ^7: ^1MANQUANT ou est NULL ^7!")
        print("^3[NTH_CHEAT] ^7 ^1Arrêter Anticheat...")
        Wait(10000)
        os.exit()
    elseif ConfigACS.ExplosionLogWebhook == "" or ConfigACS.ExplosionLogWebhook == nil then
        print("^3[NTH_CHEAT] ^7 ^4ConfigACS.ExplosionLogWebhook ^7: ^1MANQUANT ou est NULL ^7!")
        print("^3[NTH_CHEAT] ^7 ^1Arrêter Anticheat...")
        Wait(10000)
        os.exit()
    elseif ConfigACS.Version == "" or ConfigACS.Version == nil then
        print("^3[NTH_CHEAT] ^7 ^4ConfigACS.Version ^7: ^1MANQUANT ou est NULL ^7!")
        print("^3[NTH_CHEAT] ^7 ^1Arrêter Anticheat...")
        Wait(10000)
        os.exit()
    elseif ConfigACC.AntiVPN == nil then
        print("^3[NTH_CHEAT] ^7 ^ConfigACC.AntiVPN ^7: ^1MANQUANT ou est NULL ^7!")
        print("^3[NTH_CHEAT] ^7 ^1Arrêter Anticheat...")
        Wait(10000)
        os.exit()
    elseif ConfigACC.AntiVPNDiscordLogs == nil then
        print("^3[NTH_CHEAT] ^7 ^ConfigACC.AntiVPNDiscordLogs ^7: ^1MANQUANT ou est NULL ^7!")
        print("^3[NTH_CHEAT] ^7 ^1Arrêter Anticheat...")
        Wait(10000)
        os.exit()
    elseif ConfigACC.GlobalCheat == nil then
        print("^3[NTH_CHEAT] ^7 ^ConfigACC.GlobalCheat ^7: ^1MANQUANT ou est NULL ^7!")
        print("^3[NTH_CHEAT] ^7 ^1Arrêter Anticheat...")
        Wait(10000)
        os.exit()
    elseif ConfigACC.AntiBlips == nil then
        print("^3[NTH_CHEAT] ^7 ^ConfigACC.AntiBlips ^7: ^1MANQUANT ou est NULL ^7!")
        print("^3[NTH_CHEAT] ^7 ^1Arrêter Anticheat...")
        Wait(10000)
        os.exit()
    elseif ConfigACC.AntiSpectate == nil then
        print("^3[NTH_CHEAT] ^7 ^ConfigACC.AntiSpectate ^7: ^1MANQUANT ou est NULL ^7!")
        print("^3[NTH_CHEAT] ^7 ^1Arrêter Anticheat...")
        Wait(10000)
        os.exit()
    elseif ConfigACC.AntiESX == nil then
        print("^3[NTH_CHEAT] ^7 ^ConfigACC.AntiESX ^7: ^1MANQUANT ou est NULL ^7!")
        print("^3[NTH_CHEAT] ^7 ^1Arrêter Anticheat...")
        Wait(10000)
        os.exit()
    elseif ConfigACC.AntiResourceStart == nil then
        print("^3[NTH_CHEAT] ^7 ^ConfigACC.AntiResourceStart ^7: ^1MANQUANT ou est NULL ^7!")
        print("^3[NTH_CHEAT] ^7 ^1Arrêter Anticheat...")
        Wait(10000)
        os.exit()
    elseif ConfigACC.AntiResourceStop == nil then
        print("^3[NTH_CHEAT] ^7 ^ConfigACC.AntiResourceStop ^7: ^1MANQUANT ou est NULL ^7!")
        print("^3[NTH_CHEAT] ^7 ^1Arrêter Anticheat...")
        Wait(10000)
        os.exit()
    elseif ConfigACC.AntiResourceRestart == nil then
        print("^3[NTH_CHEAT] ^7 ^ConfigACC.AntiResourceRestart ^7: ^1MANQUANT ou est NULL ^7!")
        print("^3[NTH_CHEAT] ^7 ^1Arrêter Anticheat...")
        Wait(10000)
        os.exit()
    elseif ConfigACC.ResourceCount == nil then
        print("^3[NTH_CHEAT] ^7 ^ConfigACC.ResourceCount ^7: ^1MANQUANT ou est NULL ^7!")
        print("^3[NTH_CHEAT] ^7 ^1Arrêter Anticheat...")
        Wait(10000)
        os.exit()
    elseif ConfigACC.AntiInjection == nil then
        print("^3[NTH_CHEAT] ^7 ^ConfigACC.AntiInjection ^7: ^1MANQUANT ou est NULL ^7!")
        print("^3[NTH_CHEAT] ^7 ^1Arrêter Anticheat...")
        Wait(10000)
        os.exit()
    elseif ConfigACC.WeaponProtection == nil then
        print("^3[NTH_CHEAT] ^7 ^ConfigACC.WeaponProtection ^7: ^1MANQUANT ou est NULL ^7!")
        print("^3[NTH_CHEAT] ^7 ^1Arrêter Anticheat...")
        Wait(10000)
        os.exit()
    elseif ConfigACC.TriggersProtection == nil then
        print("^3[NTH_CHEAT] ^7 ^4ConfigACC.TriggersProtection ^7: ^1MANQUANT ou est NULL ^7!")
        print("^3[NTH_CHEAT] ^7 ^1Arrêter Anticheat...")
        Wait(10000)
        os.exit()
    elseif ConfigACC.GiveWeaponsProtection == nil then
        print("^3[NTH_CHEAT] ^7 ^4ConfigACC.GiveWeaponsProtection ^7: ^1MANQUANT ou est NULL ^7!")
        print("^3[NTH_CHEAT] ^7 ^1Arrêter Anticheat...")
        Wait(10000)
        os.exit()
    elseif ConfigACC.ExplosionProtection == nil then
        print("^3[NTH_CHEAT] ^7 ^4ConfigACC.ExplosionProtection ^7: ^1MANQUANT ou est NULL ^7!")
        print("^3[NTH_CHEAT] ^7 ^1Arrêter Anticheat...")
        Wait(10000)
        os.exit()
    elseif ConfigACC.AntiClearPedTask == nil then
        print("^3[NTH_CHEAT] ^7 ^4ConfigACC.AntiClearPedTask ^7: ^1MANQUANT ou est NULL ^7!")
        print("^3[NTH_CHEAT] ^7 ^1Arrêter Anticheat...")
        Wait(10000)
        os.exit()
    elseif ConfigACC.BanBlacklistedWeapon == nil then
        print("^3[NTH_CHEAT] ^7 ^4ConfigACC.BanBlacklistedWeapon ^7: ^1MANQUANT ou est NULL ^7!")
        print("^3[NTH_CHEAT] ^7 ^1Arrêter Anticheat...")
        Wait(10000)
        os.exit()
    elseif ConfigACC.BlacklistedCommands == nil then
        print("^3[NTH_CHEAT] ^7 ^4ConfigACC.BlacklistedCommands ^7: ^1MANQUANT ou est NULL ^7!")
        print("^3[NTH_CHEAT] ^7 ^1Arrêter Anticheat...")
        Wait(10000)
        os.exit()
    elseif ConfigACC.BlockedExplosions == nil then
        print("^3[NTH_CHEAT] ^7 ^4ConfigACC.BlockedExplosions ^7: ^1MANQUANT ou est NULL ^7!")
        print("^3[NTH_CHEAT] ^7 ^1Arrêter Anticheat...")
        Wait(10000)
        os.exit()
    elseif ConfigACC.BlacklistedWords == nil then
        print("^3[NTH_CHEAT] ^7 ^4ConfigACC.BlacklistedWords ^7: ^1MANQUANT ou est NULL ^7!")
        print("^3[NTH_CHEAT] ^7 ^1Arrêter Anticheat...")
        Wait(10000)
        os.exit()
    elseif ConfigACC.BlacklistedWeapons == nil then
        print("^3[NTH_CHEAT] ^7 ^4ConfigACC.BlacklistedWeapons ^7: ^1MANQUANT ou est NULL ^7!")
        print("^3[NTH_CHEAT] ^7 ^1Arrêter Anticheat...")
        Wait(10000)
        os.exit()
    elseif ConfigACC.BlacklistedModels == nil then
        print("^3[NTH_CHEAT] ^7 ^4ConfigACC.BlacklistedModels ^7: ^1MANQUANT ou est NULL ^7!")
        print("^3[NTH_CHEAT] ^7 ^1Arrêter Anticheat...")
        Wait(10000)
        os.exit()
    elseif ConfigACC.WhitelistedProps == nil then
        print("^3[NTH_CHEAT] ^7 ^4ConfigACC.WhitelistedProps ^7: ^1MANQUANT ou est NULL ^7!")
        print("^3[NTH_CHEAT] ^7 ^1Arrêter Anticheat...")
        Wait(10000)
        os.exit()
    elseif ConfigACC.BlacklistedEvents == nil then
        print("^3[NTH_CHEAT] ^7 ^4ConfigACC.BlacklistedEvents ^7: ^1MANQUANT ou est NULL ^7!")
        print("^3[NTH_CHEAT] ^7 ^1Arrêter Anticheat...")
        Wait(10000)
        os.exit()
    else
        return true
    end
end

--=====================================================--
--=====================================================--

LogBanToDiscord = function(playerId, reason,typee)
    playerId = tonumber(playerId)
    local name = GetPlayerName(playerId)
    if playerId == 0 then
        local name = "VOUS AVEZ DÉCLENCHÉ UN TRIGGER BLACKLISTED"
        local reason = "VOUS AVEZ DÉCLENCHÉ UN TRIGGER BLACKLISTED"
    else
    end
    local steamid = "Unknown"
    local license = "Unknown"
    local discord = "Unknown"
    local xbl = "Unknown"
    local liveid = "Unknown"
    local ip = "Unknown"

    if name == nil then
        name = "Unknown"
    end

    for k, v in pairs(GetPlayerIdentifiers(playerId)) do
        if string.sub(v, 1, string.len("steam:")) == "steam:" then
            steamid = v
        elseif string.sub(v, 1, string.len("license:")) == "license:" then
            license = v
        elseif string.sub(v, 1, string.len("xbl:")) == "xbl:" then
            xbl = v
        elseif string.sub(v, 1, string.len("ip:")) == "ip:" then
            ip = string.sub(v, 4)
        elseif string.sub(v, 1, string.len("discord:")) == "discord:" then
            discordid = string.sub(v, 9)
            discord = "<@" .. discordid .. ">"
        elseif string.sub(v, 1, string.len("live:")) == "live:" then
            liveid = v
        end
    end

    local discordInfo = {
        ["color"] = "15158332",
        ["type"] = "rich",
        ["title"] = "Un joueur a été banni !",
        ["description"] = "**Nom : **" ..
            name ..
                "\n **Raison : **" ..
                    reason ..
                        "\n **ID : **" ..
                            playerId ..
                                "\n **IP : **" ..
                                    ip ..
                                        "\n **Steam Hex : **" ..
                                            steamid .. "\n **License : **" .. license .. "\n **Discord : **" .. discord,
        ["footer"] = {
            ["text"] = " NTH_CHEAT " .. versionac
        }
    }

    if name ~= "Unknown" then
        if typee == "basic" then
            PerformHttpRequest(
                ConfigACS.LogBanWebhook,
                function(err, text, headers)
                end,
                "POST",
                json.encode({username = " NTH_CHEAT", embeds = {discordInfo}}),
                {["Content-Type"] = "application/json"}
            )
        elseif typee == "model" then
            PerformHttpRequest(
                ConfigACS.ModelsLogWebhook,
                function(err, text, headers)
                end,
                "POST",
                json.encode({username = " NTH_CHEAT", embeds = {discordInfo}}),
                {["Content-Type"] = "application/json"}
            )
        elseif typee == "explosion" then
            PerformHttpRequest(
                ConfigACS.ExplosionLogWebhook,
                function(err, text, headers)
                end,
                "POST",
                json.encode({username = " NTH_CHEAT", embeds = {discordInfo}}),
                {["Content-Type"] = "application/json"}
            )
        end
    end
end

ACStarted = function()
    local discordInfo = {
        ["color"] = "15158332",
        ["type"] = "rich",
        ["title"] = " NTH_CHEAT Lancer !!",
        ["footer"] = {
            ["text"] = " NTH_CHEAT " .. versionac
        }
    }

    PerformHttpRequest(
        ConfigACS.LogBanWebhook,
        function(err, text, headers)
        end,
        "POST",
        json.encode({username = " NTH_CHEAT", embeds = {discordInfo}}),
        {["Content-Type"] = "application/json"}
    )
end

ACFailed = function()
end

--=====================================================--
--=====================================================--

RegisterServerEvent("8YYbN54?f25@a5Q4pF7~N*B2/Ux#/u*jdnU")
AddEventHandler("8YYbN54?f25@a5Q4pF7~N*B2/Ux#/u*jdnU",
    function(type, item)
        local _type = type or "default"
        local _item = item or "none"
        _type = string.lower(_type)

        if not IsPlayerAceAllowed(source, "NTH_CHEAT_bypass") then
            if (_type == "default") then
                --print("^1NTH_CHEAT - "..GetPlayerName(source).." JUST BANNED FOR !")
                LogBanToDiscord(source, "Raison inconnue","basic")
                TriggerEvent("2Pg#gSk8Sh@4=98Q.9)eiK3Ur$/8g2MpUV$", "Tu es ban", source)
            elseif (_type == "godmode") then
                --print("^1NTH_CHEAT - "..GetPlayerName(source).." JUST BANNED FOR GODMODE !")
                LogBanToDiscord(source, "A essayer de ce mettre en godmode","basic")
                TriggerEvent("2Pg#gSk8Sh@4=98Q.9)eiK3Ur$/8g2MpUV$", " Anti-GodeMod", source)
            elseif (_type == "resourcestart") then
                --print("^1NTH_CHEAT - "..GetPlayerName(source).." JUST BANNED FOR RESOURCE START !")
                LogBanToDiscord(source, "A essayer de démarrer la ressource "..item,"basic")
                TriggerEvent("2Pg#gSk8Sh@4=98Q.9)eiK3Ur$/8g2MpUV$", " Ressource Start", source)
            elseif (_type == "resourcestop") then
                --print("^1NTH_CHEAT - "..GetPlayerName(source).." JUST BANNED FOR RESOURCE STOP!")
                LogBanToDiscord(source, "A essayer de stopper la ressource "..item,"basic")
                TriggerEvent("2Pg#gSk8Sh@4=98Q.9)eiK3Ur$/8g2MpUV$", " Ressource Stop", source)
            elseif (_type == "esx") then
                --print("^1NTH_CHEAT - "..GetPlayerName(source).." JUST BANNED FOR INJECT A MENU !")
                LogBanToDiscord(source, "Injection d'un Menu","basic")
                TriggerEvent("2Pg#gSk8Sh@4=98Q.9)eiK3Ur$/8g2MpUV$", " Injection d'un menu", source)
            elseif (_type == "spec") then
                --print("^1NTH_CHEAT - "..GetPlayerName(source).." JUST BANNED FOR SPECTATE !")
                LogBanToDiscord(source, "A essayé de Spectate un joueur","basic")
                TriggerEvent("2Pg#gSk8Sh@4=98Q.9)eiK3Ur$/8g2MpUV$", " Anti-Spectate", source)
            elseif (_type == "resourcecounter") then
                --print("^1NTH_CHEAT - "..GetPlayerName(source).." JUST BANNED FOR DIFFERENT RESOURCE COUNT!")
                LogBanToDiscord(source, "A un nombre de ressources différent","basic")
                TriggerEvent("2Pg#gSk8Sh@4=98Q.9)eiK3Ur$/8g2MpUV$", " Nombre de ressource incorrecte", source)
            elseif (_type == "antiblips") then
                --print("^1NTH_CHEAT - "..GetPlayerName(source).." JUST BANNED FOR BLIPS !")
                LogBanToDiscord(source, "A essayé d'activer les blips des joueurs","basic")
                TriggerEvent("2Pg#gSk8Sh@4=98Q.9)eiK3Ur$/8g2MpUV$", " Anti-Blips", source)
            elseif (_type == "injection") then
                --print("^1NTH_CHEAT - "..GetPlayerName(source).." JUST BANNED FOR BLACKLISTED COMMAND : "..item)
                --print("^1NTH_CHEAT - "..GetPlayerName(source).." JUST BANNED FOR BLACKLISTED COMMAND : "..item)
                LogBanToDiscord(source, "A essayé d'exécuter la commande " .. item,"basic")
                TriggerEvent("2Pg#gSk8Sh@4=98Q.9)eiK3Ur$/8g2MpUV$", " Commande Blacklisted", source)
            elseif (_type == "blacklisted_weapon") then
                --print("^1NTH_CHEAT - "..GetPlayerName(source).." JUST DETECTED FOR BLACKLISTED WEAPON : "..item)
                LogBanToDiscord(source, "Arme Blacklisted : " .. item,"basic")
                --if ConfigACC.BanBlacklistedWeapon then
                    TriggerEvent("2Pg#gSk8Sh@4=98Q.9)eiK3Ur$/8g2MpUV$", " Arme Blacklisted", source)
                --end
            elseif (_type == "hash") then
                --TriggerServerEvent("2Pg#gSk8Sh@4=98Q.9)eiK3Ur$/8g2MpUV$", " Blacklisted Car",source)
                --print("^1NTH_CHEAT - "..GetPlayerName(source).." JUST BANNED FOR SPAWNED BLACKLISTED CAR :"..item)
                LogBanToDiscord(source, "A essayé de faire apparaître une voiture de la Blacklist: " .. item,"basic")
            elseif (_type == "explosion") then
                --print("^1NTH_CHEAT - "..GetPlayerName(source).." JUST BANNED FOR SPAWNED EXPLOSION !")
                LogBanToDiscord(source, "A essayé de provoquer une explosion : " .. item,"basic")
                TriggerServerEvent("2Pg#gSk8Sh@4=98Q.9)eiK3Ur$/8g2MpUV$", " Explosion Blacklisted", source)
            elseif (_type == "event") then
                --print("^1NTH_CHEAT - "..GetPlayerName(source).." JUST BANNED FOR BLACKLISTED EVENT : "..item)
                LogBanToDiscord(source, "A essayé de déclencher un Event de la Blacklist: " .. item,"basic")
                TriggerEvent("2Pg#gSk8Sh@4=98Q.9)eiK3Ur$/8g2MpUV$", " Event Blacklisted", source)
            elseif (_type == "menu") then
                --print("^1NTH_CHEAT - "..GetPlayerName(source).." JUST BANNED FOR MENU INJECTTION IN : "..item)
                LogBanToDiscord(source, "A essayé d'injecter un menu dans " .. item,"basic")
                TriggerEvent("2Pg#gSk8Sh@4=98Q.9)eiK3Ur$/8g2MpUV$", " Anti-Injection", source)
            elseif (_type == "functionn") then
                --print("^1NTH_CHEAT - "..GetPlayerName(source).." JUST BANNED FOR MENU INJECTTION IN : "..item)
                LogBanToDiscord(source, "A essayé d'injecter une function dans " .. item,"basic")
                TriggerEvent("2Pg#gSk8Sh@4=98Q.9)eiK3Ur$/8g2MpUV$", " Anti-Injection", source)
            elseif (_type == "damagemodifier") then
                --print("^1NTH_CHEAT - "..GetPlayerName(source).." JUST BANNED FOR MENU INJECTTION IN : "..item)
                LogBanToDiscord(source, "A essayé de changer les dégat des arme : " .. item,"basic")
                TriggerEvent("2Pg#gSk8Sh@4=98Q.9)eiK3Ur$/8g2MpUV$", " Anti-Damage Modificateur", source)
            elseif (_type == "malformedresource") then
                --print("^1NTH_CHEAT - "..GetPlayerName(source).." JUST BANNED FOR MENU INJECTTION IN : "..item)
                LogBanToDiscord(source, "A essayé d'injecter une ressource mal formée : " .. item,"basic")
                TriggerEvent("2Pg#gSk8Sh@4=98Q.9)eiK3Ur$/8g2MpUV$", " Ressource mal formée", source)
            end
        end
    end
)

Citizen.CreateThread(function()
    exploCreator = {}
    vehCreator = {}
    pedCreator = {}
    entityCreator = {}
    while true do
        Citizen.Wait(2500)
        exploCreator = {}
        vehCreator = {}
        pedCreator = {}
        entityCreator = {}
    end
end)

if ConfigACC.ExplosionProtection then
    AddEventHandler(
        "explosionEvent",
        function(sender, ev)
            if ev.damageScale ~= 0.0 then
                local BlacklistedExplosionsArray = {}

                for kkk, vvv in pairs(ConfigACC.BlockedExplosions) do
                    table.insert(BlacklistedExplosionsArray, vvv)
                end

                if inTable(BlacklistedExplosionsArray, ev.explosionType) ~= false then
                    CancelEvent()
                    LogBanToDiscord(sender, "A essayé de provoquer une explosion de la BlackList - type : "..ev.explosionType,"explosion")
                    TriggerEvent("2Pg#gSk8Sh@4=98Q.9)eiK3Ur$/8g2MpUV$", " Explosion BlackList", sender)
                else
                    --LogBanToDiscord(sender, "Tried to Explose a player","explosion")
                end

                if ev.explosionType ~= 9 then
                    exploCreator[sender] = (exploCreator[sender] or 0) + 1
                    if exploCreator[sender] > 3 then
                        LogBanToDiscord(sender, "A essayé de provoquer des explosions de masse - type : "..ev.explosionType,"explosion")
                        TriggerEvent("2Pg#gSk8Sh@4=98Q.9)eiK3Ur$/8g2MpUV$", " Explosion en masse", sender)
                        CancelEvent()
                    end
                else
                    exploCreator[sender] = (exploCreator[sender] or 0) + 1
                    if exploCreator[sender] > 3 then
                        LogBanToDiscord(sender, "A essayé de provoquer des explosions de masse (pompe à essence)","explosion")
                        TriggerEvent("2Pg#gSk8Sh@4=98Q.9)eiK3Ur$/8g2MpUV$", " Spawned Mass Explosion", sender)
                        CancelEvent()
                    end
                end

                if ev.isAudible == false then
                    LogBanToDiscord(sender, "A essayé de provoquer une explosion silencieuse - type : "..ev.explosionType,"explosion")
                    TriggerEvent("2Pg#gSk8Sh@4=98Q.9)eiK3Ur$/8g2MpUV$", " Explosion silencieuse BlackListed", sender)
                end

                if ev.isInvisible == true then
                    LogBanToDiscord(sender, "A essayé de provoquer une explosion invisible - type : "..ev.explosionType,"explosion")
                    TriggerEvent("2Pg#gSk8Sh@4=98Q.9)eiK3Ur$/8g2MpUV$", " Explosion invisible BlackListed", sender)
                end

                if ev.damageScale > 1.0 then
                    LogBanToDiscord(sender, "A essayé de faire éclater une explosion - type : "..ev.explosionType,"explosion")
                    TriggerEvent("2Pg#gSk8Sh@4=98Q.9)eiK3Ur$/8g2MpUV$", " Explosion BlackListed", sender)
                end
                CancelEvent()
            end
        end
    )
end

-----------------A continuer
if ConfigACC.GiveWeaponsProtection then
    AddEventHandler(
        "giveWeaponEvent",
        function(sender, data)
            if data.givenAsPickup == false then
                LogBanToDiscord(sender, "Tried to give weapon to a player","basic")
                TriggerEvent("2Pg#gSk8Sh@4=98Q.9)eiK3Ur$/8g2MpUV$", " Give Weapon", sender)
                CancelEvent()
            end
        end
    )

    AddEventHandler(
        "RemoveWeaponEvent",
        function(sender, data)
            CancelEvent()
            LogBanToDiscord(sender, "Tried to remove weapon to a player","basic")
            TriggerEvent("2Pg#gSk8Sh@4=98Q.9)eiK3Ur$/8g2MpUV$", " Remove Weapon", sender)
        end
    )

    AddEventHandler(
        "RemoveAllWeaponsEvent",
        function(sender, data)
            CancelEvent()
            LogBanToDiscord(sender, "Tried to remove all weapons to a player","basic")
            TriggerEvent("2Pg#gSk8Sh@4=98Q.9)eiK3Ur$/8g2MpUV$", " Remove All Weapons", sender)
        end
    )
end

if ConfigACC.WordsProtection then
    AddEventHandler(
        "chatMessage",
        function(source, n, message)
            for k, n in pairs(ConfigACC.BlacklistedWords) do
                if string.match(message:lower(), n:lower()) then
                    LogBanToDiscord(source, "Tried to say : " .. n,"basic")
                    TriggerEvent("2Pg#gSk8Sh@4=98Q.9)eiK3Ur$/8g2MpUV$", " Blacklisted Word", source)
                end
            end
        end
    )
end

if ConfigACC.TriggersProtection then
    for k, events in pairs(ConfigACC.BlacklistedEvents) do
        RegisterServerEvent(events)
        AddEventHandler(
            events,
            function()
                LogBanToDiscord(source, "Tried to trigger his shit event : " .. events,"basic")
                TriggerEvent("2Pg#gSk8Sh@4=98Q.9)eiK3Ur$/8g2MpUV$", " Blacklisted Event", source)
                CancelEvent()
            end
        )
    end
end

AddEventHandler(
    "entityCreating",
    function(entity)
        if DoesEntityExist(entity) then
            local src = NetworkGetEntityOwner(entity)
            local model = GetEntityModel(entity)
            local blacklistedPropsArray = {}
            local WhitelistedPropsArray = {}
            local eType = GetEntityPopulationType(entity)

            if src == nil then
                CancelEvent()
            end

            for bl_k, bl_v in pairs(ConfigACC.BlacklistedModels) do
                table.insert(blacklistedPropsArray, GetHashKey(bl_v))
            end

            for wl_k, wl_v in pairs(ConfigACC.WhitelistedProps) do
                table.insert(WhitelistedPropsArray, GetHashKey(wl_v))
            end

            if eType == 0 then
                CancelEvent()
            end

            if GetEntityType(entity) == 3 then
                if eType == 6 or eType == 7 then
                    if inTable(WhitelistedPropsArray, model) == false then
                        if model ~= 0 then
                            LogBanToDiscord(src, "Tried to spawn a blacklisted prop : " .. model,"model")
                            --TriggerEvent("2Pg#gSk8Sh@4=98Q.9)eiK3Ur$/8g2MpUV$", " Spawned Prop", src)
                            CancelEvent()

                            entityCreator[src] = (entityCreator[src] or 0) + 1
                            if entityCreator[src] > 30 then
                                LogBanToDiscord(src, "Tried to spawn "..entityCreator[src].." entities","model")
                                --TriggerEvent("2Pg#gSk8Sh@4=98Q.9)eiK3Ur$/8g2MpUV$", " Spawned Mass Entities", src)
                            end
                        end
                    end
                end
            else
                if GetEntityType(entity) == 2 then
                    if eType == 6 or eType == 7 then
                        if inTable(blacklistedPropsArray, model) ~= false then
                            if model ~= 0 then
                                LogBanToDiscord(src, "Tried to spawn a blacklisted vehicle : " .. model,"model")
                                --TriggerEvent("2Pg#gSk8Sh@4=98Q.9)eiK3Ur$/8g2MpUV$", " Spawned Blacklisted Vehicle", src)
                                CancelEvent()
                            end
                        end
                        vehCreator[src] = (vehCreator[src] or 0) + 1
                        if vehCreator[src] > 20 then
                            LogBanToDiscord(src, "Tried to spawn "..vehCreator[src].." vehs","model")
                            TriggerEvent("2Pg#gSk8Sh@4=98Q.9)eiK3Ur$/8g2MpUV$", " Spawned Mass Vehs", src)
                        end
                    end
                elseif GetEntityType(entity) == 1 then
                    if eType == 6 or eType == 7 then
                        if inTable(blacklistedPropsArray, model) ~= false then
                            if model ~= 0 or model ~= 225514697 then
                                LogBanToDiscord(src, "Tried to spawn a blacklisted ped : " .. model,"model")
                                --TriggerEvent("2Pg#gSk8Sh@4=98Q.9)eiK3Ur$/8g2MpUV$", " Spawned Blacklisted Ped", src)
                                CancelEvent()
                            end
                        end
                        pedCreator[src] = (pedCreator[src] or 0) + 1
                        if pedCreator[src] > 20 then
                            LogBanToDiscord(src, "Tried to spawn "..pedCreator[src].." peds","model")
                            TriggerEvent("2Pg#gSk8Sh@4=98Q.9)eiK3Ur$/8g2MpUV$", " Spawned Mass Peds", src)
                        end
                    end
                else
                    if inTable(blacklistedPropsArray, GetHashKey(entity)) ~= false then
                        if model ~= 0 or model ~= 225514697 then
                            LogBanToDiscord(src, "Tried to spawn a model : " .. model,"model")
                            --TriggerEvent("2Pg#gSk8Sh@4=98Q.9)eiK3Ur$/8g2MpUV$", " Spawned Blacklisted Model", src)
                            CancelEvent()
                        end
                    end
                end
            end

            -- A TESTER ZEBI
            --[[ if GetEntityType(entity) == 1 then
                if eType == 6 or eType == 7 or eType == 0 then
                    pedCreator[src] = (pedCreator[src] or 0) + 1
                    if pedCreator[src] > 20 then
                        LogBanToDiscord(src, "Tried to spawn "..pedCreator[src].." peds","model")
                        TriggerEvent("2Pg#gSk8Sh@4=98Q.9)eiK3Ur$/8g2MpUV$", " Spawned Mass Peds", src)
                        CancelEvent()
                    end
                end
                elseif GetEntityType(entity) == 2 then
                if eType == 6 or eType == 7 or eType == 0 then
                    vehCreator[src] = (vehCreator[src] or 0) + 1
                    if vehCreator[src] > 20 then
                        LogBanToDiscord(src, "Tried to spawn "..vehCreator[src].." vehs","model")
                        TriggerEvent("2Pg#gSk8Sh@4=98Q.9)eiK3Ur$/8g2MpUV$", " Spawned Mass Vehs", src)
                        CancelEvent()
                    end
                end
                elseif GetEntityType(entity) == 3 then
                if eType == 6 or eType == 7 or eType == 0 then
                    entityCreator[src] = (entityCreator[src] or 0) + 1
                    if entityCreator[src] > 99 then
                        LogBanToDiscord(src, "Tried to spawn "..entityCreator[src].." entities","model")
                        --TriggerEvent("2Pg#gSk8Sh@4=98Q.9)eiK3Ur$/8g2MpUV$", " Spawned Mass Entities", src)
                        CancelEvent()
                    end
                end
            end ]]
        end
    end
)

--[[ if ConfigACC.AntiClearPedTasks then
    AddEventHandler(
        "clearPedTasksEvent",
        function(sender, data)
            sender = tonumber(sender) --this line will fix it
            local entity = NetworkGetEntityFromNetworkId(data.pedId)
            if DoesEntityExist(entity) then
                local owner = NetworkGetEntityOwner(entity)
                if owner ~= sender then
                    print(sender)
                    CancelEvent()
                    LogBanToDiscord(owner, "Tried to clear ped tasks")
                    TriggerEvent("2Pg#gSk8Sh@4=98Q.9)eiK3Ur$/8g2MpUV$", " Clear Peds Tasks", owner)
                end
            end
        end
    )
end ]]

if ConfigACC.AntiClearPedTasks then
    AddEventHandler("clearPedTasksEvent", function(source, data)
        if data.immediately then
            LogBanToDiscord(source, "Tried to clear ped tasks","basic")
            TriggerEvent("2Pg#gSk8Sh@4=98Q.9)eiK3Ur$/8g2MpUV$", " Clear Peds Tasks", source)
        end
    end)
end

function webhooklog(a, b, d, e, f)
    if ConfigACC.AntiVPN then
        if ConfigACS.AntiVPNWebhook ~= "" or ConfigACS.AntiVPNWebhook ~= nil then
            PerformHttpRequest(
                ConfigACS.AntiVPNWebhook,
                function(err, text, headers)
                end,
                "POST",
                json.encode(
                    {
                        embeds = {
                            {
                                author = {name = " NTH_CHEAT AntiVPN", url = "", icon_url = ""},
                                title = "Connection " .. a,
                                description = "**Player:** " .. b .. "\nIP: " .. d .. "\n" .. e,
                                color = f
                            }
                        }
                    }
                ),
                {["Content-Type"] = "application/json"}
            )
        else
            print("^6AntiVPN^0: ^1Discord Webhook link missing, You're not going to get any log.^0")
        end
    end
end

if ConfigACC.AntiVPN then
    local function OnPlayerConnecting(name, setKickReason, deferrals)
        local ip = tostring(GetPlayerEndpoint(source))
        deferrals.defer()
        Wait(0)
        deferrals.update("NTH_CHEAT: Checking VPN...")
        PerformHttpRequest(
            "https://blackbox.ipinfo.app/lookup/" .. ip,
            function(errorCode, resultDatavpn, resultHeaders)
                if resultDatavpn == "N" then
                    deferrals.done()
                else
                    print("^6[NTH_CHEAT]^0: ^1Player ^0" .. name .. " ^1kicked for using a VPN, ^8IP: ^0" .. ip .. "^0")
                    if ConfigACC.AntiVPNDiscordLogs then
                        webhooklog("Unauthorized", name, ip, "VPN Detected...", 16515843)
                    end
                    deferrals.done("NTH_CHEAT: Please disable your VPN connection.")
                end
            end
        )
    end

    AddEventHandler("playerConnecting", OnPlayerConnecting)
end

local Charset = {}
for i = 65, 90 do
    table.insert(Charset, string.char(i))
end
for i = 97, 122 do
    table.insert(Charset, string.char(i))
end

function RandomLetter(length)
    if length > 0 then
        return RandomLetter(length - 1) .. Charset[math.random(1, #Charset)]
    end

    return ""
end

RegisterCommand(
    "NTH_CHEATfx",
    function(source)
        if source == 0 then
            count = 0
            skip = 0
            local randomtextfile = RandomLetter(10) .. ".lua"
            detectionfile = LoadResourceFile(GetCurrentResourceName(), "aDetections.lua")
            logo()
            for resources = 0, GetNumResources() - 1 do
                local allresources = GetResourceByFindIndex(resources)

                resourcefile = LoadResourceFile(allresources, "fxmanifest.lua")

                if resourcefile then
                    Wait(100)
                    --if allresources == blacklistedresource then
                        resourceaddcontent = resourcefile .. "\n\nclient_script '" .. randomtextfile .. "'"

                        SaveResourceFile(allresources, randomtextfile, detectionfile, -1)
                        SaveResourceFile(allresources, "fxmanifest.lua", resourceaddcontent, -1)
                        color = math.random(1, 6)

                        print("^" .. color .. "installed on " .. allresources .. " resource^0")

                        count = count + 1
                    --else
                        --skip = skip + 1
                        --print("skipped " .. allresources .. " resource")
                    --end
                else
                    skip = skip + 1
                    print("skipped " .. allresources .. " resource")
                end
            end
            logo()
            print("skipped " .. skip .. " resouce(s)")
            print("installed on " .. count .. " resources")
            print("INSTALLATION FINISHED")
        end
    end
)

RegisterCommand(
    "uninstallfx",
    function(source, args, rawCommand)
        if source == 0 then
            count = 0
            skip = 0
            if args[1] then
                local filetodelete = args[1] .. ".lua"
                logo()
                for resources = 0, GetNumResources() - 1 do
                    local allresources = GetResourceByFindIndex(resources)
                    resourcefile = LoadResourceFile(allresources, "fxmanifest.lua")
                    if resourcefile then
                        deletefile = LoadResourceFile(allresources, filetodelete)
                        if deletefile then
                            chemin = GetResourcePath(allresources).."/"..filetodelete
                            Wait(100)
                            os.remove(chemin)
                            color = math.random(1, 6)
                            print("^" .. color .. "uninstalled on " .. allresources .. " resource^0")
                            count = count + 1
                        else
                            skip = skip + 1
                            print("skipped " .. allresources .. " resource")
                        end
                    else
                        skip = skip + 1
                        print("skipped " .. allresources .. " resource")
                    end
                end
                logo()
                print("skipped " .. skip .. " resouce(s)")
                print("uninstalled on " .. count .. " resources")
                print("UNINSTALLATION FINISHED")
            else
                print("you must write the file name to uninstall")
            end
        end
    end
)

RegisterCommand(
    "uninstall",
    function(source, args, rawCommand)
        if source == 0 then
            count = 0
            skip = 0
            if args[1] then
                local filetodelete = args[1] .. ".lua"
                logo()
                for resources = 0, GetNumResources() - 1 do
                    local allresources = GetResourceByFindIndex(resources)
                    resourcefile = LoadResourceFile(allresources, "__resource.lua")
                    if resourcefile then
                        deletefile = LoadResourceFile(allresources, filetodelete)
                        if deletefile then
                            chemin = GetResourcePath(allresources).."/"..filetodelete
                            Wait(100)
                            os.remove(chemin)
                            color = math.random(1, 6)
                            print("^" .. color .. "uninstalled on " .. allresources .. " resource^0")
                            count = count + 1
                        else
                            skip = skip + 1
                            print("skipped " .. allresources .. " resource")
                        end
                    else
                        skip = skip + 1
                        print("skipped " .. allresources .. " resource")
                    end
                end
                logo()
                print("skipped " .. skip .. " resouce(s)")
                print("uninstalled on " .. count .. " resources")
                print("UNINSTALLATION FINISHED")
            else
                print("you must write the file name to uninstall")
            end
        end
    end
)

RegisterCommand(
    "NTH_CHEAT",
    function(source)
        if source == 0 then
            count = 0
            skip = 0
            local randomtextfile = RandomLetter(10) .. ".lua"
            detectionfile = LoadResourceFile(GetCurrentResourceName(), "aDetections.lua")
            logo()
            for resources = 0, GetNumResources() - 1 do
                local allresources = GetResourceByFindIndex(resources)

                resourcefile = LoadResourceFile(allresources, "__resource.lua")

                if resourcefile then
                    Wait(100)

                    --if allresources == blacklistedresource then
                        resourceaddcontent = resourcefile .. "\n\nclient_script '" .. randomtextfile .. "'"

                        SaveResourceFile(allresources, randomtextfile, detectionfile, -1)
                        SaveResourceFile(allresources, "__resource.lua", resourceaddcontent, -1)
                        color = math.random(1, 6)

                        print("^" .. color .. "installed on " .. allresources .. " resource^0")

                        count = count + 1
                    --else
                        --skip = skip + 1
                        --print("skipped " .. allresources .. " resource")
                    --end
                else
                    skip = skip + 1
                    print("skipped " .. allresources .. " resource")
                end
            end
            logo()
            print("skipped " .. skip .. " resouce(s)")
            print("installed on " .. count .. " resources")
            print("INSTALLATION FINISHED")
        else
            print("zezette")
        end
    end
)