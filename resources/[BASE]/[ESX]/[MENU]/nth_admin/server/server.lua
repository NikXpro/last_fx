ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

--AddEventHandler('es:playerLoaded', function(Source, user)
--	Player = user
--end)

ESX.RegisterServerCallback('nth_admin:Usergroup', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)
	local group = xPlayer.getGroup()
	print(GetPlayerName(source).." - "..group)
	cb(group)
end)

RegisterServerEvent('nth_admin:Usergroup')
AddEventHandler('nth_admin:Usergroup', function(target)
	source_ = source
	local xTarget = ESX.GetPlayerFromId(target)
	local xGroup = xTarget.getGroup()
	local xMoney = xTarget.getMoney()
	local xBanque = MySQL.Sync.fetchScalar("SELECT bank FROM users WHERE identifier = @identifier", {['@identifier'] = xTarget.identifier})
	local xBlackMoney = MySQL.Sync.fetchScalar("SELECT money FROM user_accounts WHERE identifier = @identifier", {['@identifier'] = xTarget.identifier})
	local xNom = MySQL.Sync.fetchScalar("SELECT lastname FROM users WHERE identifier = @identifier", {['@identifier'] = xTarget.identifier})
	local xPrenom = MySQL.Sync.fetchScalar("SELECT firstname FROM users WHERE identifier = @identifier", {['@identifier'] = xTarget.identifier})

  	TriggerClientEvent('nth_admin:Returngroup', source_, xGroup, xMoney, xBanque, xBlackMoney, xNom, xPrenom)
end)

RegisterServerEvent('getSteamID')
AddEventHandler('getSteamID', function(target)
	local steamid = GetPlayerIdentifiers(target, target)[1]
	local licenceid = GetPlayerIdentifiers(target, target)[2]
	local xblid = GetPlayerIdentifiers(target, target)[3]
	local liveid = GetPlayerIdentifiers(target, target)[4]
	local discordid = GetPlayerIdentifiers(target, target)[5]
	local ipid = GetPlayerIdentifiers(target, target)[6]

  TriggerClientEvent('returnSteamID', source, steamid, licenceid, xblid, liveid, discordid, ipid)
end)

RegisterNetEvent("nth_admin:Message")
AddEventHandler("nth_admin:Message", function(id, type)
	TriggerClientEvent("nth_admin:envoyer", id, type)
end)

RegisterServerEvent("nth_admin:FreezePlayer")
AddEventHandler('nth_admin:FreezePlayer', function(playerId,toggle)
	TriggerClientEvent("nth_admin:FreezePlayer", playerId, toggle)
end)