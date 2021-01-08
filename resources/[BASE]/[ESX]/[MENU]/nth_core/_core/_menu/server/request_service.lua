ESX = nil

RegisterServerEvent("service:on")
AddEventHandler("service:on", function(serviceon)
     local xPlayer = ESX.GetPlayerFromId(source)
     local job = xPlayer.job.name
     local grade = xPlayer.job.grade

     xPlayer.setJob(serviceon, grade)
     TriggerClientEvent('esx:showNotification', source, "Vous ètes maintenant ~g~en service")
     
end)

RegisterServerEvent("service:off")
AddEventHandler("service:off", function(serviceoff)
     local xPlayer = ESX.GetPlayerFromId(source)
     local job = xPlayer.job.name
     local grade = xPlayer.job.grade

     xPlayer.setJob(serviceoff, grade)
     TriggerClientEvent('esx:showNotification', source, "Vous ètes maintenant ~r~hors service")
     
end)


