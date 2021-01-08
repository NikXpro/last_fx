--[[ ============================================================ ]]--
--[[ |       FIVEM ESX DELIVERY PLUGIN REMAKE BY AKKARIIN       | ]]--
--[[ ============================================================ ]]--

ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

-- Register events

RegisterServerEvent('esx_deliveries:returnSafe:server')
RegisterServerEvent('esx_deliveries:finishDelivery:server')
RegisterServerEvent('esx_deliveries:removeSafeMoney:server')
RegisterServerEvent('esx_deliveries:getPlayerJob:server')

-- Return safe deposit event

AddEventHandler('esx_deliveries:returnSafe:server', function(deliveryType, safeReturn)
	local xPlayer = ESX.GetPlayerFromId(source)
	if safeReturn then
		local SafeMoney = 4000
		for k, v in pairs(Config.Safe) do
			if k == deliveryType then
				SafeMoney = v
				break
			end
		end
		xPlayer.addAccountMoney("bank", SafeMoney)
		TriggerClientEvent('esx:showNotification', source, _U("safe_deposit_returned"))
	else
		TriggerClientEvent('esx:showNotification', source, _U("safe_deposit_withheld"))
	end
end)

-- Finish delivery mission event

AddEventHandler('esx_deliveries:finishDelivery:server', function(deliveryType)
	local xPlayer = ESX.GetPlayerFromId(source)
	local PrixFinal = 0
	if deliveryType == "scooter" then
		PrixFinal = (Config.Rewards.scooter * 1)
		xPlayer.addMoney(PrixFinal)
		TriggerClientEvent('esx:showNotification', source, _U("delivery_point_reward") .. tostring(PrixFinal))
	elseif deliveryType == "van" then
		local deliveryMoney = math.random(100, 150)
		xPlayer.addMoney(deliveryMoney)
	elseif deliveryType == "truck" then
		local deliveryMoney = math.random(100, 150)
		xPlayer.addMoney(deliveryMoney)
	end
end)

-- Remove safe deposit event (On start mission)

AddEventHandler('esx_deliveries:removeSafeMoney:server', function(deliveryType)
    local xPlayer = ESX.GetPlayerFromId(source)
	local SafeMoney = 4000
	for k, v in pairs(Config.Safe) do
		if k == deliveryType then
			SafeMoney = v
			break
		end
	end
	local PlayerMoney = xPlayer.getAccount('bank').money
	if PlayerMoney >= SafeMoney then
		xPlayer.removeAccountMoney("bank", SafeMoney)
		TriggerClientEvent('esx:showNotification', source, _U("safe_deposit_received"))
		TriggerClientEvent('esx_deliveries:startJob:client', source, deliveryType)
	else
		TriggerClientEvent('esx:showNotification', source, _U("not_enough_money"))
	end
end)