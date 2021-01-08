ESX = nil
local PlayerData = {}

local GUI = {}
GUI.Time = 0

local HasAlreadyEnteredMarker = false
local LastPart = nil

local CurrentAction, isHandcuffed = nil, false
local CurrentActionMsg = ''
local CurrentActionData, dragStatus = {}, {}
dragStatus.isDragged = false

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(10)
	end

	while ESX.GetPlayerData().job2 == nil do
		Citizen.Wait(10)
	end

	PlayerData = ESX.GetPlayerData()
	TriggerServerEvent('gb:requestSync')
	
	while ActualGang == nil do
		Citizen.Wait(0)
	end
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	PlayerData = xPlayer
end)

RegisterNetEvent('esx:setJob2')
AddEventHandler('esx:setJob2', function(job2)
	PlayerData.job2 = job2
end)

function setUniform(job, playerPed)
	TriggerEvent('skinchanger:getSkin', function(skin)
		if skin.sex == 0 then
			if Config.Uniforms[job].male ~= nil then
				TriggerEvent('skinchanger:loadClothes', skin, Config.Uniforms[job].male)
			else
				ESX.ShowNotification(_U('no_outfit'))
			end
		else
			if Config.Uniforms[job].female ~= nil then
				TriggerEvent('skinchanger:loadClothes', skin, Config.Uniforms[job].female)
			else
				ESX.ShowNotification(_U('no_outfit'))
			end
		end
	end)
end

function OpenCloakroomMenu()
	local elements = {
		{label = _U('citizen_wear'), value = 'citizen_wear'},
		{label = 'Mettre le sac', value = 'sac_wear'},
		{label = 'Enlever le sac', value = 'sac_wear1'},
	}

	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'cloakroom', {
		title = _U('cloakroom'),
		elements = elements
	}, function(data, menu)
	menu.close()
		local playerPed = PlayerPedId()
		SetPedArmour(playerPed, 0)
		ClearPedBloodDamage(playerPed)
		ResetPedVisibleDamage(playerPed)
		ClearPedLastWeaponDamage(playerPed)
		ResetPedMovementClipset(playerPed, 0)

		if data.current.value == 'citizen_wear' then
			ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
				TriggerEvent('skinchanger:loadSkin', skin)
			end)
		end

		if data.current.value == 'robbery_wear' or data.current.value == 'sac_wear' or data.current.value == 'sac_wear1' then
			setUniform(data.current.value, playerPed)
		end
	end, function(data, menu)
		menu.close()
		CurrentAction = 'menu_cloakroom'
		CurrentActionMsg = _U('open_cloackroom')
		CurrentActionData = {}
	end)
end

function OpenArmoryMenu()
	local elements = {}

	if PlayerData.job2.grade_name == 'boss' then
		table.insert(elements, {label = _U('buy_weapons'), value = 'buy_weapons'})
	end
	
	table.insert(elements, {label = _U('get_weapon'), value = 'get_weapon'})
	table.insert(elements, {label = _U('put_weapon'), value = 'put_weapon'})
	table.insert(elements, {label = 'Prendre objet', value = 'get_stock'})
	table.insert(elements, {label = 'Déposer objet', value = 'put_stock'})

	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'armory', {
		title = _U('armory'),
		elements = elements
	}, function(data, menu)
		if data.current.value == 'buy_weapons' then
			OpenBuyWeaponsMenu()
		end

		if data.current.value == 'get_weapon' then
			OpenGetWeaponMenu()
		end

		if data.current.value == 'put_weapon' then
			OpenPutWeaponMenu()
		end

		if data.current.value == 'put_stock' then
			OpenPutStocksMenu()
		end

		if data.current.value == 'get_stock' then
			OpenGetStocksMenu()
		end
	end, function(data, menu)
	menu.close()
		CurrentAction = 'menu_armory'
		CurrentActionMsg = _U('open_armory')
		CurrentActionData = {}
	end)
end

function OpenVehicleSpawnerMenu()
	local vehSpawnPoint = ActualGang.VehSpawnPoint
	local vehSpawnHeading = ActualGang.VehSpawnHeading

	ESX.UI.Menu.CloseAll()

	local elements = {}

	ESX.TriggerServerCallback('esx_society:getVehiclesInGarage', function(vehicles)
		for i = 1, #vehicles, 1 do
			table.insert(elements, {
				label = GetDisplayNameFromVehicleModel(vehicles[i].model) .. ' [' .. (vehicles[i].plate or 'AUCUN') .. ']',
				value = vehicles[i]
			})
		end

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'vehicle_spawner', {
			title = _U('vehicle_menu'),
			elements = elements
		}, function(data, menu)
			menu.close()
			local vehicleProps = data.current.value

			ESX.Game.SpawnVehicle(vehicleProps.model, vehSpawnPoint, vehSpawnHeading, function(vehicle)
				ESX.Game.SetVehicleProperties(vehicle, vehicleProps)
			end)

			TriggerServerEvent('esx_society:removeVehicleFromGarage', ActualGang.Name, vehicleProps)
		end, function(data, menu)
		menu.close()
			CurrentAction = 'menu_vehicle_spawner'
			CurrentActionMsg = _U('vehicle_spawner')
			CurrentActionData = {}
		end)
	end, ActualGang.Name)
end

function OpenGangActionsMenu()
	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'gang_actions', {
		title = ActualGang.Label,
		elements = {
			{label = _U('search'), value = 'body_search'},
			{label = _U('handcuff'),    value = 'handcuff'},
			{label = _U('drag'),      value = 'drag'},
			{label = _U('put_in_vehicle'), value = 'put_in_vehicle'},
			{label = _U('out_the_vehicle'), value = 'out_the_vehicle'}
		}
	}, function(data, menu)
		local player, distance = ESX.Game.GetClosestPlayer()

		if distance ~= -1 and distance <= 3.0 then
			if data.current.value == 'body_search' then
				OpenBodySearchMenu(GetPlayerServerId(player))
			elseif data.current.value == 'handcuff' then
				TriggerServerEvent('GangsBuilderJob:handcuff', GetPlayerServerId(player))
			elseif data.current.value == 'drag' then
				TriggerServerEvent('GangsBuilderJob:drag', GetPlayerServerId(player))
			elseif data.current.value == 'put_in_vehicle' then
				TriggerServerEvent('GangsBuilderJob:putInVehicle', GetPlayerServerId(player))
			elseif data.current.value == 'out_the_vehicle' then
				TriggerServerEvent('GangsBuilderJob:OutVehicle', GetPlayerServerId(player))
			end
		else
			ESX.ShowNotification(_U('no_players_nearby'))
		end
	end, function(data, menu)
	menu.close()
	end)
end

function OpenBodySearchMenu(player)
	ESX.TriggerServerCallback('GangsBuilderJob:getOtherPlayerData', function(data)
		if data.foundPlayer then
			local elements = {}
			table.insert(elements, {label = '--- Argents ---', value = nil})
			
			for i = 1, #data.accounts, 1 do
				if data.accounts[i].name == 'black_money' then
					table.insert(elements, {
						label = _U('confiscate_dirty') .. ' $' .. data.accounts[i].money,
						value = 'black_money',
						itemType = 'item_account',
						amount = data.accounts[i].money
					})
				end
			end

			table.insert(elements, {label = '--- Armes ---', value = nil})

			for i = 1, #data.weapons, 1 do
				table.insert(elements, {
					label = ESX.GetWeaponLabel(data.weapons[i].name) .. ' [' .. data.weapons[i].ammo .. ']',
					value = data.weapons[i].name,
					itemType = 'item_weapon',
					amount = data.weapons[i].ammo
				})
			end

			table.insert(elements, {label = _U('inventory_label'), value = nil})

			for i = 1, #data.inventory, 1 do
				if data.inventory[i].count > 0 then
					table.insert(elements, {
						label = data.inventory[i].label .. ' (' .. data.inventory[i].count .. ')',
						value = data.inventory[i].name,
						itemType = 'item_standard',
						amount = data.inventory[i].count
					})
				end
			end

			ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'body_search', {
				title = _U('search'),
				elements = elements
			}, function(data2, menu2)
				if data2.current.value ~= nil then
					menu2.close()
					TriggerServerEvent('GangsBuilderJob:confiscatePlayerItem', player, data2.current.itemType, data2.current.value, data2.current.amount)

					ESX.SetTimeout(300, function()
						OpenBodySearchMenu(player)
					end)
				end
			end, function(data2, menu2)
			menu2.close()
			end)
		else
			ESX.UI.Menu.CloseAll()
			ESX.ShowNotification('Le joueur a déconnecté vous ne pouvez pas le fouillez.')
		end
	end, player)
end

function OpenBuyWeaponsMenu()
	local elements = {}

	for i = 1, #ActualGang.Weapons, 1 do
		table.insert(elements, {label = ESX.GetWeaponLabel(ActualGang.Weapons[i].name) .. ' $' .. ActualGang.Weapons[i].price, value = ActualGang.Weapons[i].name, price = ActualGang.Weapons[i].price})
	end

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'armory_buy_weapons', {
		title = _U('buy_weapon_menu'),
		elements = elements
	}, function(data, menu)
		ESX.TriggerServerCallback('GangsBuilderJob:buyWeapon', function(hasEnoughMoney)
		end, data.current.value)
	end, function(data, menu)
	menu.close()
	end)
end

function OpenGetWeaponMenu()
	ESX.TriggerServerCallback('GangsBuilderJob:getArmoryWeapons', function(weapons)
		local elements = {}

		for i = 1, #weapons, 1 do
			table.insert(elements, {label = ESX.GetWeaponLabel(weapons[i].name) .. ' [' .. weapons[i].ammo .. ']', value = weapons[i].name, ammo = weapons[i].ammo})
		end

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'armory_get_weapon', {
			title = _U('get_weapon_menu'),
			elements = elements
		}, function(data, menu)
			menu.close()

			ESX.TriggerServerCallback('GangsBuilderJob:removeArmoryWeapon', function()
				OpenGetWeaponMenu()
			end, data.current.value, data.current.ammo)
		end, function(data, menu)
		menu.close()
		end)
	end)
end

function OpenPutWeaponMenu()
	local elements = {}
	local playerPed = PlayerPedId()
	local weaponList = ESX.GetWeaponList()

	for i = 1, #weaponList, 1 do
		local weaponHash = GetHashKey(weaponList[i].name)

		if HasPedGotWeapon(playerPed, weaponHash, false) and weaponList[i].name ~= 'WEAPON_UNARMED' then
			local ammo = GetAmmoInPedWeapon(playerPed, weaponHash)
			table.insert(elements, {label = weaponList[i].label .. ' [' .. ammo .. ']', value = weaponList[i].name, ammo = ammo})
		end
	end

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'armory_put_weapon', {
		title = _U('put_weapon_menu'),
		elements = elements
	}, function(data, menu)
		menu.close()

		ESX.TriggerServerCallback('GangsBuilderJob:addArmoryWeapon', function()
			OpenPutWeaponMenu()
		end, data.current.value, data.current.ammo)
	end, function(data, menu)
	menu.close()
	end)
end

function OpenGetStocksMenu()
	ESX.TriggerServerCallback('GangsBuilderJob:getStockItems', function(items)
		local elements = {}

		for i = 1, #items, 1 do
			table.insert(elements, {label = items[i].label .. ' (' .. items[i].count .. ')', value = items[i].name})
		end

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'stocks_menu', {
			title = _U('gang_stock'),
			elements = elements
		}, function(data, menu)
			ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'stocks_menu_get_item_count', {
				title = _U('quantity')
			}, function(data2, menu2)
				local count = tonumber(data2.value)

				if count == nil then
					ESX.ShowNotification(_U('quantity_invalid'))
				else
					menu2.close()
					menu.close()
					
					TriggerServerEvent('GangsBuilderJob:getStockItem', data.current.value, count)

					Citizen.Wait(300)
					OpenGetStocksMenu()
				end
			end,
			function(data2, menu2)
				menu2.close()
			end
			)
		end,
		function(data, menu)
			menu.close()
		end
		)
	end)
end

function OpenPutStocksMenu()
	ESX.TriggerServerCallback('GangsBuilderJob:getPlayerInventory', function(inventory)
		local elements = {}

		for i = 1, #inventory.items, 1 do
			local item = inventory.items[i]

			if item.count > 0 then
				table.insert(elements, {label = item.label .. ' (' .. item.count .. ')', type = 'item_standard', value = item.name})
			end
		end

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'stocks_menu', {
			title = _U('inventory'),
			elements = elements
		}, function(data, menu)
			ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'stocks_menu_put_item_count', {
				title = _U('quantity')
			}, function(data2, menu2)
				local count = tonumber(data2.value)

				if count == nil then
					ESX.ShowNotification(_U('quantity_invalid'))
				else
					menu2.close()
					menu.close()
					TriggerServerEvent('GangsBuilderJob:putStockItems', data.current.value, count)
					Citizen.Wait(300)
					OpenPutStocksMenu()
				end
			end,
			function(data2, menu2)
				menu2.close()
			end
			)
		end,
		function(data, menu)
			menu.close()
		end
		)
	end)
end

AddEventHandler('GangsBuilderJob:hasEnteredMarker', function(part)
	if part == 'Cloakroom' then
		CurrentAction = 'menu_cloakroom'
		CurrentActionMsg = _U('open_cloackroom')
		CurrentActionData = {}
	end

	if part == 'Armory' then
		CurrentAction = 'menu_armory'
		CurrentActionMsg = _U('open_armory')
		CurrentActionData = {}
	end

	if part == 'VehicleSpawner' then
		CurrentAction = 'menu_vehicle_spawner'
		CurrentActionMsg = _U('vehicle_spawner')
		CurrentActionData = {}
	end

	if part == 'VehicleDeleter' then
		local playerPed = PlayerPedId()
		local coords = GetEntityCoords(playerPed, false)

		if IsPedInAnyVehicle(playerPed, false) then
			local vehicle = GetVehiclePedIsIn(playerPed, false)

			if DoesEntityExist(vehicle) then
				CurrentAction = 'delete_vehicle'
				CurrentActionMsg = _U('store_vehicle')
				CurrentActionData = {vehicle = vehicle}
			end
		end
	end

	if part == 'BossActions' then
		CurrentAction = 'menu_boss_actions'
		CurrentActionMsg = _U('open_bossmenu')
		CurrentActionData = {}
	end
end)

AddEventHandler('GangsBuilderJob:hasExitedMarker', function(part)
	ESX.UI.Menu.CloseAll()
	CurrentAction = nil
end)

RegisterNetEvent('GangsBuilder:handcuff')
AddEventHandler('GangsBuilder:handcuff', function()
	isHandcuffed = not isHandcuffed
	local playerPed = PlayerPedId()

	if isHandcuffed then
		RequestAnimDict('mp_arresting')
		while not HasAnimDictLoaded('mp_arresting') do
			Citizen.Wait(100)
		end

		TaskPlayAnim(playerPed, 'mp_arresting', 'idle', 8.0, -8, -1, 49, 0, 0, 0, 0)

		SetEnableHandcuffs(playerPed, true)
		DisablePlayerFiring(playerPed, true)
		SetCurrentPedWeapon(playerPed, GetHashKey('WEAPON_UNARMED'), true) -- unarm player
		SetPedCanPlayGestureAnims(playerPed, false)
		FreezeEntityPosition(playerPed, true)
		DisplayRadar(false)
	else
		ClearPedSecondaryTask(playerPed)
		SetEnableHandcuffs(playerPed, false)
		DisablePlayerFiring(playerPed, false)
		SetPedCanPlayGestureAnims(playerPed, true)
		FreezeEntityPosition(playerPed, false)
		DisplayRadar(true)
	end
end)

RegisterNetEvent('GangsBuilder:drag')
AddEventHandler('GangsBuilder:drag', function(copId)
	if isHandcuffed then
		dragStatus.isDragged = not dragStatus.isDragged
		dragStatus.CopId = copId
	end
end)

Citizen.CreateThread(function()
	local wasDragged

	while true do
		Citizen.Wait(0)
		local playerPed = PlayerPedId()

		if isHandcuffed and dragStatus.isDragged then
			local targetPed = GetPlayerPed(GetPlayerFromServerId(dragStatus.CopId))

			if DoesEntityExist(targetPed) and IsPedOnFoot(targetPed) and not IsPedDeadOrDying(targetPed, true) then
				if not wasDragged then
					AttachEntityToEntity(playerPed, targetPed, 11816, 0.54, 0.54, 0.0, 0.0, 0.0, 0.0, false, false, false, false, 2, true)
					wasDragged = true
				else
					Citizen.Wait(1000)
				end
			else
				wasDragged = false
				dragStatus.isDragged = false
				DetachEntity(playerPed, true, false)
			end
		elseif wasDragged then
			wasDragged = false
			DetachEntity(playerPed, true, false)
		else
			Citizen.Wait(500)
		end
	end
end)

RegisterNetEvent('GangsBuilder:putInVehicle')
AddEventHandler('GangsBuilder:putInVehicle', function()
	if isHandcuffed then
		local playerPed = PlayerPedId()
		local coords = GetEntityCoords(playerPed)

		if IsAnyVehicleNearPoint(coords, 5.0) then
			local vehicle = GetClosestVehicle(coords, 5.0, 0, 71)

			if DoesEntityExist(vehicle) then
				local maxSeats, freeSeat = GetVehicleMaxNumberOfPassengers(vehicle)

				for i=maxSeats - 1, 0, -1 do
					if IsVehicleSeatFree(vehicle, i) then
						freeSeat = i
						break
					end
				end

				if freeSeat then
					TaskWarpPedIntoVehicle(playerPed, vehicle, freeSeat)
					dragStatus.isDragged = false
				end
			end
		end
	end
end)

RegisterNetEvent('GangsBuilder:OutVehicle')
AddEventHandler('GangsBuilder:OutVehicle', function()
	local playerPed = PlayerPedId()

	if IsPedSittingInAnyVehicle(playerPed) then
		local vehicle = GetVehiclePedIsIn(playerPed, false)
		TaskLeaveVehicle(playerPed, vehicle, 64)
	end
end)

-- Handcuff
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		local playerPed = PlayerPedId()

		if isHandcuffed then
			DisableControlAction(0, 24, true) -- Attack
			DisableControlAction(0, 257, true) -- Attack 2
			DisableControlAction(0, 25, true) -- Aim
			DisableControlAction(0, 263, true) -- Melee Attack 1

			DisableControlAction(0, 45, true) -- Reload
			DisableControlAction(0, 22, true) -- Jump
			DisableControlAction(0, 44, true) -- Cover
			DisableControlAction(0, 37, true) -- Select Weapon
			DisableControlAction(0, 23, true) -- Also 'enter'?

			DisableControlAction(0, 288,  true) -- Disable phone
			DisableControlAction(0, 289, true) -- Inventory
			DisableControlAction(0, 170, true) -- Animations
			DisableControlAction(0, 167, true) -- Job
			DisableControlAction(0, 73, true) -- Disable clearing animation
			DisableControlAction(2, 199, true) -- Disable pause screen

			DisableControlAction(0, 59, true) -- Disable steering in vehicle
			DisableControlAction(0, 71, true) -- Disable driving forward in vehicle
			DisableControlAction(0, 72, true) -- Disable reversing in vehicle

			DisableControlAction(2, 36, true) -- Disable going stealth

			DisableControlAction(0, 47, true)  -- Disable weapon
			DisableControlAction(0, 264, true) -- Disable melee
			DisableControlAction(0, 257, true) -- Disable melee
			DisableControlAction(0, 140, true) -- Disable melee
			DisableControlAction(0, 141, true) -- Disable melee
			DisableControlAction(0, 142, true) -- Disable melee
			DisableControlAction(0, 143, true) -- Disable melee
			DisableControlAction(0, 75, true)  -- Disable exit vehicle
			DisableControlAction(27, 75, true) -- Disable exit vehicle

			if IsEntityPlayingAnim(playerPed, 'mp_arresting', 'idle', 3) ~= 1 then
				ESX.Streaming.RequestAnimDict('mp_arresting', function()
					TaskPlayAnim(playerPed, 'mp_arresting', 'idle', 8.0, -8, -1, 49, 0.0, false, false, false)
				end)
			end
		else
			Citizen.Wait(500)
		end
	end
end)
-- Display markers
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)

		if PlayerData.job2 ~= nil and ActualGang then
			local coords = GetEntityCoords(PlayerPedId(), false)

			if GetDistanceBetweenCoords(coords, ActualGang.Cloakroom.x, ActualGang.Cloakroom.y, ActualGang.Cloakroom.z,  true) < Config.DrawDistance then
				DrawMarker(Config.MarkerType, ActualGang.Cloakroom.x, ActualGang.Cloakroom.y, ActualGang.Cloakroom.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, Config.MarkerSize, Config.MarkerColor, 100, false, true, 2, false, false, false, false)
			end

			if GetDistanceBetweenCoords(coords, ActualGang.Armory.x, ActualGang.Armory.y, ActualGang.Armory.z,  true) < Config.DrawDistance then
				DrawMarker(Config.MarkerType, ActualGang.Armory.x, ActualGang.Armory.y, ActualGang.Armory.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, Config.MarkerSize, Config.MarkerColor, 100, false, true, 2, false, false, false, false)
			end

			if GetDistanceBetweenCoords(coords, ActualGang.VehSpawner.x, ActualGang.VehSpawner.y, ActualGang.VehSpawner.z,  true) < Config.DrawDistance then
				DrawMarker(Config.MarkerType, ActualGang.VehSpawner.x, ActualGang.VehSpawner.y, ActualGang.VehSpawner.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, Config.MarkerSize, Config.MarkerColor, 100, false, true, 2, false, false, false, false)
			end

			if GetDistanceBetweenCoords(coords, ActualGang.VehDeleter.x, ActualGang.VehDeleter.y, ActualGang.VehDeleter.z,  true) < Config.DrawDistance then
				DrawMarker(Config.MarkerType, ActualGang.VehDeleter.x, ActualGang.VehDeleter.y, ActualGang.VehDeleter.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, Config.MarkerSize, Config.MarkerColor, 100, false, true, 2, false, false, false, false)
			end

			if PlayerData.job2 ~= nil and PlayerData.job2.grade_name == 'boss' then
				if GetDistanceBetweenCoords(coords, ActualGang.BossActions.x, ActualGang.BossActions.y, ActualGang.BossActions.z, true) < Config.DrawDistance then
					DrawMarker(Config.MarkerType, ActualGang.BossActions.x, ActualGang.BossActions.y, ActualGang.BossActions.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, Config.MarkerSize, Config.MarkerColor, 100, false, true, 2, false, false, false, false)
				end
			end
		end
	end
end)

-- Enter / Exit marker events
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)

		if PlayerData.job2 ~= nil and ActualGang then
			local coords = GetEntityCoords(PlayerPedId(), false)
			local isInMarker = false
			local currentPart = nil

			if GetDistanceBetweenCoords(coords, ActualGang.Cloakroom.x, ActualGang.Cloakroom.y, ActualGang.Cloakroom.z, true) < Config.MarkerSize.x then
				isInMarker = true
				currentPart = 'Cloakroom'
			end

			if GetDistanceBetweenCoords(coords, ActualGang.Armory.x, ActualGang.Armory.y, ActualGang.Armory.z, true) < Config.MarkerSize.x then
				isInMarker = true
				currentPart = 'Armory'
			end

			if GetDistanceBetweenCoords(coords, ActualGang.VehSpawner.x, ActualGang.VehSpawner.y, ActualGang.VehSpawner.z, true) < Config.MarkerSize.x then
				isInMarker = true
				currentPart = 'VehicleSpawner'
			end

			if GetDistanceBetweenCoords(coords, ActualGang.VehDeleter.x, ActualGang.VehDeleter.y, ActualGang.VehDeleter.z, true) < Config.MarkerSize.x then
				isInMarker = true
				currentPart = 'VehicleDeleter'
			end

			if PlayerData.job2 ~= nil and PlayerData.job2.grade_name == 'boss' then
				if GetDistanceBetweenCoords(coords, ActualGang.BossActions.x, ActualGang.BossActions.y, ActualGang.BossActions.z, true) < Config.MarkerSize.x then
					isInMarker = true
					currentPart = 'BossActions'
				end
			end

			local hasExited = false

			if isInMarker and not HasAlreadyEnteredMarker or (isInMarker and (LastPart ~= currentPart)) then
				if (LastPart ~= nil) and (LastPart ~= currentPart) then
					TriggerEvent('GangsBuilderJob:hasExitedMarker', LastPart)
					hasExited = true
				end

				HasAlreadyEnteredMarker = true
				LastPart = currentPart

				TriggerEvent('GangsBuilderJob:hasEnteredMarker', currentPart)
			end

			if not hasExited and not isInMarker and HasAlreadyEnteredMarker then
				HasAlreadyEnteredMarker = false
				TriggerEvent('GangsBuilderJob:hasExitedMarker', LastPart)
			end
		end
	end
end)

-- Key Controls
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)

		if CurrentAction ~= nil then
			ESX.ShowHelpNotification(CurrentActionMsg)

			if IsControlPressed(0, 38) and PlayerData.job2 ~= nil and ActualGang and (GetGameTimer() - GUI.Time) > 150 then
				if CurrentAction == 'menu_cloakroom' then
					OpenCloakroomMenu()
				end

				if CurrentAction == 'menu_armory' then
					OpenArmoryMenu()
				end

				if CurrentAction == 'menu_vehicle_spawner' then
					OpenVehicleSpawnerMenu()
				end

				if CurrentAction == 'delete_vehicle' then
					local vehicleProps = ESX.Game.GetVehicleProperties(CurrentActionData.vehicle)
					TriggerServerEvent('esx_society:putVehicleInGarage', ActualGang.Name, vehicleProps)

					ESX.Game.DeleteVehicle(CurrentActionData.vehicle)
				end

				if CurrentAction == 'menu_boss_actions' then
					ESX.UI.Menu.CloseAll()

					TriggerEvent('esx_society:openBossMenu', ActualGang.Name, function(data, menu)
						menu.close()
						CurrentAction = 'menu_boss_actions'
						CurrentActionMsg = _U('open_bossmenu')
						CurrentActionData = {}
					end, {wash = false})
				end		

				CurrentAction = nil
				GUI.Time = GetGameTimer()
			end
		end

		if IsControlPressed(0, 168) and PlayerData.job2 ~= nil and ActualGang and not ESX.UI.Menu.IsOpen('default', GetCurrentResourceName(), 'gang_actions') and (GetGameTimer() - GUI.Time) > 150 then
			OpenGangActionsMenu()
			GUI.Time = GetGameTimer()
		end
	end
end)