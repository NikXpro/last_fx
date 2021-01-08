ESX = nil

-- Intéraction pour la banque

RegisterServerEvent("PoserArgent")
AddEventHandler("PoserArgent", function(money)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local total = money
    local xMoney = xPlayer.getMoney()
    
    if xMoney >= total then

    xPlayer.addAccountMoney('bank', total)
    xPlayer.removeMoney(total)
         TriggerClientEvent('esx:showAdvancedNotification', source, 'Banque', 'Information', "Vous avez déposer ~g~ "..total.."$ ~w~ dans votre Compte.", 'CHAR_BANK_FLEECA', 8)
    else
         TriggerClientEvent('esx:showNotification', source, "~r~Somme insuffisante.")
    end    
end)

RegisterServerEvent("RetiréArgent")
AddEventHandler("RetiréArgent", function(money)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local total = money
    local xMoney = xPlayer.getBank()
    
    if xMoney >= total then

    xPlayer.removeAccountMoney('bank', total)
    xPlayer.addMoney(total)

         TriggerClientEvent('esx:showAdvancedNotification', source, 'Banque', 'Information', "Vous avez retiré ~g~ "..total.."$~w~ de votre Compte.", 'CHAR_BANK_FLEECA', 8)
    else
         TriggerClientEvent('esx:showNotification', source, "~r~Solde insuffisant.")
    end    
end)