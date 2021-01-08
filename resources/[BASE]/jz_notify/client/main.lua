RegisterNetEvent('jz_notify:sendMessage')
AddEventHandler('jz_notify:sendMessage', function(data)
	sendMessage(data.type, data.delay, data.message)
end)

function sendMessage(type, delay, message)
	SendNUIMessage({
		type = type,
		delay = delay,
		message = message,
	})
end
