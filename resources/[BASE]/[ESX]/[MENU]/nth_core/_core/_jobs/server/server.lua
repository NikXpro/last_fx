ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

Citizen.CreateThread(function()
    Citizen.Wait(0)
    print("^7[^1nth_core^7] - ^2LANCER! ^0") 
    while Jobs == nil do 
        Citizen.Wait(100)
    end
    TriggerClientEvent("cylex_jobs:client:getJobsData", -1, Jobs) --for restart
end)

AddEventHandler('esx:playerLoaded', function(data)
    Citizen.Wait(0)
    local player = ESX.GetPlayerFromId(data)
    while Jobs == nil do 
        Citizen.Wait(100)
    end
    TriggerClientEvent("cylex_jobs:client:getJobsData", player.source, Jobs)
end)

RegisterServerEvent("cylex_jobs:server:process")
AddEventHandler("cylex_jobs:server:process", function(coords, k, v, id)
    local player = ESX.GetPlayerFromId(source)
    if not player or k == nil or coords == nil or id == nil or v == nil then return TriggerClientEvent('mythic_notify:client:SendAlert', player.source, { type = 'error', text = "An error occurred. Please try again."}) end
    local jobData = Jobs[k].location[id]
    if #(jobData.coords - coords) <= 10 then

        local item = player.getInventoryItem(jobData.item["itemName"])
        local requiredItem = player.getInventoryItem(jobData.item["requiredItem"])

        if item or jobData.item["process"] == "sell" then

            if jobData.item["process"] == "pickup" then
                if item.limit ~= -1 and item.count >= item.limit then
                    TriggerClientEvent('mythic_notify:client:SendAlert', player.source, { type = 'error', text = "Vous avez atteint la limit d'item"})
                else
                    player.addInventoryItem(jobData.item["itemName"], jobData.item["addCount"])
                    TriggerClientEvent('mythic_notify:client:SendAlert', player.source, { type = 'inform', text = "Vous récolter "..jobData.item["addCount"].."x ".. ESX.GetItemLabel(jobData.item["itemName"])})
                end
            elseif jobData.item["process"] == "exchange" then
                if requiredItem.count >= jobData.item["removeCount"] then
                    if item.limit ~= -1 and item.count >= item.limit then
                        TriggerClientEvent('mythic_notify:client:SendAlert', player.source, { type = 'error', text = "Vous avez atteint la limit d'item"})
                    else
                        player.removeInventoryItem(jobData.item["requiredItem"], jobData.item["removeCount"])
                        player.addInventoryItem(jobData.item["itemName"], jobData.item["addCount"])
                        TriggerClientEvent('mythic_notify:client:SendAlert', player.source, { type = 'inform', text = "Vous avez traité "..jobData.item["addCount"].."x ".. ESX.GetItemLabel(jobData.item["itemName"])})
                    end
                else
                    TriggerClientEvent('mythic_notify:client:SendAlert', player.source, { type = 'error', text = "Vous n'avez pas assez d'items!"})
                end
            elseif jobData.item["process"] == "package" then
                if requiredItem.count >= jobData.item["removeCount"] then
                    if item.limit ~= -1 and item.count >= item.limit then
                        TriggerClientEvent('mythic_notify:client:SendAlert', player.source, { type = 'error', text = "Vous avez atteint la limit d'item"})
                    else
                        player.removeInventoryItem(jobData.item["requiredItem"], jobData.item["removeCount"])
                        player.addInventoryItem(jobData.item["itemName"], jobData.item["addCount"])
                        TriggerClientEvent('mythic_notify:client:SendAlert', player.source, { type = 'inform', text = "Vous avez emballé "..jobData.item["addCount"].."x "..ESX.GetItemLabel(jobData.item["itemName"])})
                    end
                else
                    TriggerClientEvent('mythic_notify:client:SendAlert', player.source, { type = 'error', text = "Vous n'avez pas assez d'items!"})
                end
            elseif jobData.item["process"] == "sell" then
                if requiredItem.count >= jobData.item["removeCount"] then
                    player.removeInventoryItem(jobData.item["requiredItem"], jobData.item["removeCount"])
                    if jobData.item["moneyType"] == "money" then
                        player.addMoney(jobData.item["price"])
                    elseif jobData.item["moneyType"] == "black_money" then
                        player.addAccountMoney('black_money', jobData.item["price"])
                    elseif jobData.item["moneyType"] == "bank" then
                        player.addAccountMoney('bank', jobData.item["price"])
                    else
                        print("Le type d'argent na pas etait spécifier")
                    end
                    TriggerClientEvent('mythic_notify:client:SendAlert', player.source, { type = 'inform', text = "Vous avez vendu "..jobData.item["removeCount"].."x "..ESX.GetItemLabel(jobData.item["requiredItem"]).. " pour $"..jobData.item["price"]})
                else
                    TriggerClientEvent('mythic_notify:client:SendAlert', player.source, { type = 'error', text = "Vous n'avez pas assez d'items!"})
                end
            end
        else
            TriggerClientEvent('mythic_notify:client:SendAlert', player.source, { type = 'error', text = "Une erreur s'est produite."})
            print("[nth_jobs] - ERROR - nth_jobs:server:process Tried to query an item that isn't included in the 'items' table.") 
            print("[nth_jobs] Item must be "..jobData.item["itemName"])
        end
    else
        print("[nth_jobs] - WARNING - nth_jobs:server:process event called without close to the process coords. User Identifier:"..player.identifier)
        DropPlayer(player.source, "Kicked pour avoir utilisé un exploit!")
    end
end)

ESX.RegisterServerCallback('cylex_jobs:checkCount', function(source, cb, itemName) 
    local player = ESX.GetPlayerFromId(source)
    local item = player.getInventoryItem(itemName)
    if item then
        cb(item.count)
    else
        cb(0)
    end
end)
