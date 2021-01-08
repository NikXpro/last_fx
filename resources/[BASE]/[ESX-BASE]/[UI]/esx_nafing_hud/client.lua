local ESX	 = nil
local currLevel = 2
-- ESX
Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
	DisplayRadar(true)
end)


Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1500)
		local health = (GetEntityHealth(GetPlayerPed(-1)) -100)
		local armor = GetPedArmour(GetPlayerPed(-1)) 
	
		SendNUIMessage({action = "hud",
						health = health,
						armor = armor,
						thirst = thrist,
						hunger = hunger,
						})

		TriggerEvent('esx_status:getStatus', 'thirst', function(status)
			thrist = status.getPercent()
		end)
		
		TriggerEvent('esx_status:getStatus', 'hunger', function(status)
			hunger = status.getPercent()
		end)
	end
end)

Keys.Register('F11', 'F11', 'Cacher/Montrer le HUD', function()
	showUi = not showUi
	if showUi then
		SendNUIMessage({
			action = 'showui'
		})
	else
		SendNUIMessage({
			action = 'hideui'
		})
	end
end)


Citizen.CreateThread(function()
	while true do
		attente = 1500
		local speedMultiplicator = 3.6
		local ped = GetPlayerPed(-1)
		local vehicleSpeedSource = GetEntitySpeed(GetVehiclePedIsIn(ped, false))
		local vehicleSpeed

		if IsPedInAnyVehicle(ped, false) then
			attente = 100
			DisplayRadar(true)
			local vehicle = GetVehiclePedIsIn(ped, false)
			local carSpeed = GetEntitySpeed(vehicle) * speedMultiplicator
			fuel = math.floor(GetVehicleFuelLevel(GetVehiclePedIsIn(ped, false))+0.0)	
			SendNUIMessage({
				action = 'car',
				showhud = true,
				speed = math.floor(carSpeed),
				fuel = fuel,
			})
		else
			DisplayRadar(true)
			SendNUIMessage({
				action = 'car',
				showhud = false,
			})
		end
		Citizen.Wait(attente)
	end
end)