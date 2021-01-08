function VehiculeList(use)
  local car = Config.vehiculeMegaphone

  for i=1, #car, 1 do
    if IsVehicleModel(use, GetHashKey(car[i])) then
      return true
    end
  end
end 


function KeyboardInput(TextEntry, ExampleText, MaxStringLenght)
	AddTextEntry('FMMC_KEY_TIP1', TextEntry)
	blockinput = true
    DisplayOnscreenKeyboard(1, "FMMC_KEY_TIP1", "", ExampleText, "", "", "", MaxStringLenght)
	while UpdateOnscreenKeyboard() ~= 1 and UpdateOnscreenKeyboard() ~= 2 do
		Citizen.Wait(0)
	end
	if UpdateOnscreenKeyboard() ~= 2 then
		local result = GetOnscreenKeyboardResult()
		Citizen.Wait(500)
		blockinput = false
		return result
	else
		Citizen.Wait(500)
		blockinput = false
		return nil
	end
end

function retire_argent()
    local amount = KeyboardInput('Somme a retirer', '', 7)

    if amount ~= nil then
        amount = tonumber(amount)

        if type(amount) == 'number' then
            TriggerServerEvent('RetiréArgent', amount)
        end
    end
end

function depot_argent()
    local amount = KeyboardInput('Somme a déposer', '', 7)

    if amount ~= nil then
        amount = tonumber(amount)

        if type(amount) == 'number' then
            TriggerServerEvent('PoserArgent', amount)
        end
    end
end