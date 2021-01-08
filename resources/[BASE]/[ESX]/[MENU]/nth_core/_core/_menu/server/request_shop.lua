ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)


RegisterServerEvent("nth_store:Buy")
AddEventHandler("nth_store:Buy", function(prix, item, weapon)
     local xPlayer = ESX.GetPlayerFromId(source) 
     local xMoney = xPlayer.getMoney()
     if xMoney >= prix then
          if (weapon == true) then
               xPlayer.addWeapon(item, 162)
          else
               xPlayer.addInventoryItem(item, 1)
          end
          xPlayer.removeMoney(prix)
          TriggerClientEvent('esx:showNotification', source, "~g~Achats~w~ effectué !")
          exports.JD_logs:discord('**Joueur:** *' .. GetPlayerName(source) .. '*\n**Item:** *' .. item .. '* \n**Nombre:** *1*\n**Prix:** *' .. prix .. '$*', source, 0, '1752220', 'BUY_MAGASIN')
     else
          TriggerClientEvent('esx:showNotification', source, "Vous n'avez assez d'argent, il vous manque: ~r~"..prix - xMoney.."$")
     end
end)