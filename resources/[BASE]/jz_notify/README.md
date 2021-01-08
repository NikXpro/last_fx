Types: success, error, info, danger

Server side:
    TriggerClientEvent('jz_notify:sendMessage', source, {type='success', delay = 5000, message = 'Message'})
    (Show success message for 5 seconds)
Client side:
    exports['jz_notify']:sendMessage('error', 3000, 'message')
    (Show error message for 3 seconds)
	
