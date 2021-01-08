ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('LogClientError')
AddEventHandler('LogClientError', function(resource, error)
    local log = {
        {
            ["color"] = "9312783",
            ["title"] = "Log d'erreur (" .. resource .. ") par " .. GetPlayerName(source),
            ["description"] = error,
        }
    }

    print("------------------ ERREUR DANS LA RESSOURCE: " .. resource.. '   par: '.. GetPlayerName(source))
    print(error)
    print("------------------ FIN DE L'ERREUR (client)")

    PerformHttpRequest("https://discord.com/api/webhooks/780484151689084928/2e5oiASM6V9ZQrLL2eihQa55u4k17iuW19YLYQkvW4EDE0D_KZR7694LPiA8WexEXiVr", function(err, text, headers) end, 'POST', json.encode({username = "Error Logs", embeds = log}), { ['Content-Type'] = 'application/json' })
end)


print('[nth_core] carlock chargée !')
ESX.RegisterServerCallback('nth_core:isVehicleOwner', function(source, cb, plate)
	local identifier = GetPlayerIdentifier(source, 0)

	MySQL.Async.fetchAll('SELECT owner FROM owned_vehicles WHERE owner = @owner AND plate = @plate', {
		['@owner'] = identifier,
		['@plate'] = plate
	}, function(result)
		if result[1] then
			cb(result[1].owner == identifier)
		else
			cb(false)
		end
	end)
end)

ESX.RegisterUsableItem("gasmask", function(source) 
    TriggerClientEvent("nth_gazmasque:useItem", source)
end)

