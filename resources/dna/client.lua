local MFD = MF_DnaTracker
local plyData = nil

RegisterNetEvent("rrp_charselect:CharSelected")
AddEventHandler("rrp_charselect:CharSelected", function()
	plyData = ESX.GetPlayerData()
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	plyData.job = job
end)

Citizen.CreateThread(function(...)
  while not ESX do
    Citizen.Wait(0)
  end
  while not ESX.IsPlayerLoaded() do
    Citizen.Wait(0)
  end

	plyData = ESX.GetPlayerData()

  Citizen.CreateThread(
    function(...)
      MFD:Update(...)
    end
  )
  Citizen.CreateThread(
    function(...)
      MFD:PositionUpdate(...)
    end
  )
end)

function MFD:PositionUpdate()
  Citizen.Wait(5000)
  local tick = 0
  while true do
    Citizen.Wait(0)
    tick = tick + 1
    if tick % 200 == 0 then
      ESX.TriggerServerCallback("MF_DnaTracker:GetJob", function(job)
        plyData.job.name = job.name
      end)
    end
    if plyData.job.name == self.AmbulanceJob or plyData.job.name == self.PoliceJob then
      local plyPed = GetPlayerPed(-1)
      local plyPos = GetEntityCoords(plyPed)
      local distA = Utils:GetVecDist(plyPos, self.AmmoAnalyzePos)
      local distB = Utils:GetVecDist(plyPos, self.DNAAnalyzePos)
      local drawing = false
      if distA and distA < self.DrawTextDist then
        drawing = "ammo"
        self:DrawText3D(self.AmmoAnalyzePos.x, self.AmmoAnalyzePos.y, self.AmmoAnalyzePos.z, "Press [~g~9~s~] to analyze ammo casings.")
      elseif distB and distB < self.DrawTextDist then
        drawing = "blood"
        self:DrawText3D(self.DNAAnalyzePos.x, self.DNAAnalyzePos.y, self.DNAAnalyzePos.z, "Press [~g~9~s~] to analyze DNA.")
      end
      if drawing then
        if (IsControlJustPressed(0, Keys["9"]) or IsDisabledControlJustPressed(0, Keys["9"])) then
          if drawing == "ammo" then
            TriggerEvent("MF_DnaTracker:AnalyzeAmmo")
          elseif drawing == "blood" then
            TriggerEvent("MF_DnaTracker:AnalyzeDNA")
          end
        end
      end
    end
  end
end

function MFD:Update()
  Citizen.Wait(5000)
  local startHealth = GetEntityHealth(GetPlayerPed(-1))
  self.timer = GetGameTimer()
  local tick = 0
  while true do
    Citizen.Wait(0)
    tick = tick + 1
    local plyPed = GetPlayerPed(-1)
    local plyHealth = GetEntityHealth(plyPed)
    local plyShooting = IsPedShooting(plyPed)

    if plyHealth > startHealth then
      startHealth = plyHealth
    end

    if plyHealth < startHealth then
      startHealth = plyHealth
      self:TakeDamage(plyPed)
    end

    if plyShooting then
      self:PlayerShooting(plyPed)
    end

    if self.SpawnedObjs then
      self:HandleObjects(timer)
    end

    if self.CurDNA and #self.CurDNA > 0 then
      if tick % 100 == 1 then
        self:GetClosest(plyPed)
      end
      self:HandleDrawText(plyPed)
    end
  end
end

--[[
function MFD:GetClosestOld(plyPed)
  if plyData.job.name == self.AmbulanceJob or plyData.job.name == self.PoliceJob then
    local closest, closestDist
    for k, v in pairs(self.CurDNA) do
      if v and type(v) ~= "boolean" then
        local dist = Utils:GetVecDist(GetEntityCoords(plyPed), v.pos)
        if not closestDist or dist < closestDist then
          closest = v
          closestDist = dist
        end
      end
    end
    self.Closest = closest or false
    self.ClosestDist = closestDist or false
  else
    self.Closest = false
    self.ClosestDist = false
  end
end]]

function MFD:GetClosest(plyPed)
  local closest, closestDist
  local foundObject = false
  for k, v in pairs(self.CurDNA) do
    if v and type(v) ~= "boolean" then
      local dist = Utils:GetVecDist(GetEntityCoords(plyPed), v.pos)
      if not closestDist or dist < closestDist then
        if plyData.job.name == self.AmbulanceJob or plyData.job.name == self.PoliceJob then
          closest = v
          closestDist = dist
          foundObject = true
        else
          if v.ident == plyData.identifier then
            closest = v
            closestDist = dist
            foundObject = true
          end
        end
      end
    end
  end
  if not foundObject then
    self.Closest = false
    self.ClosestDist = false
  else
    self.Closest = closest or false
    self.ClosestDist = closestDist or false
  end
end

function MFD:HandleDrawText(plyPed)
  local closest = self.Closest or false
  local closestDist = self.ClosestDist or false
  local deleteIt = false
  local plyPed = GetPlayerPed(-1)

  if closestDist and closestDist < 5.0 then
    local str = ""
    if closest.obj == self.BloodObject then
      if closest.ident == plyData.identifier then
        deleteIt = true
        str = "Press [~r~ 9 ~s~] to clean up your blood."
      else
        str = "[ ~r~DNA~s~ ] : Human blood : Press [~r~ 9 ~s~] to take sample."
      end
    else
      if closest.ident == plyData.identifier then
        deleteIt = true
        if plyData.job.name == MFD.PoliceJob then
          str = "Press [~r~ 9 ~s~] to pick up your shell."
        else
          str = "Press [~r~ 9 ~s~] to clean up your gunshot evidence."
        end
      else
        str = "[ ~r~EVIDENCE ~s~] : Bullet casing : Press [~r~ 9 ~s~] to pick up."
      end
    end
    self:DrawText3D(closest.pos.x, closest.pos.y, closest.pos.z + 1.0, str)
    if (IsControlJustPressed(1, Keys["9"]) or IsDisabledControlJustPressed(0, Keys["9"])) and (GetGameTimer() - self.timer) > 150 and not IsPlayerDead(PlayerId()) then
      self.timer = GetGameTimer()

      if deleteIt then
        if closest.obj == self.BloodObject then
          MFD:CleanAnim("Cleaning up blood...", 10000)
        else
          if plyData.job.name == MFD.PoliceJob then
            MFD:CleanAnim("Picking up shell...", 3500)
          else
            MFD:CleanAnim("Cleaning up gunshot residue...", 10000)
          end
        end
      end

      ESX.TriggerServerCallback("MF_DnaTracker:PickupEvidenceS", function(canPickup)
        if not canPickup then
          ESX.ShowNotification("You can't pick up any more of these.")
        else
          if closest.obj == self.BloodObject then
            self.CurBlood = closest
          elseif closest.obj == self.ResidueObject then
            self.CurBullet = closest
          end
        end
      end,
      closest, deleteIt)
    end
  end
end

function MFD:CleanAnim(text, time)
  local playerPed = GetPlayerPed(-1)
    TaskStartScenarioInPlace(playerPed, "CODE_HUMAN_MEDIC_TEND_TO_DEAD", -1, true)
    Citizen.Wait(time)
    TaskStartScenarioInPlace(playerPed, "CODE_HUMAN_MEDIC_TEND_TO_DEAD", -1, false)
    --Citizen.Wait(3000)
    ClearPedTasksImmediately(playerPed)
    ClearPedTasks(playerPed)
end

MFD.Age = 1
MFD.DeathAge = 1
function MFD:HandleObjects()
  if not self.CurPlacing then
    if (self.Age - self.DeathAge) > self.MaxObjCount then
      SetEntityAsMissionEntity(self.SpawnedObjs[self.DeathAge], false, false)
      DeleteObject(self.SpawnedObjs[self.DeathAge])
      self.CurDNA[self.DeathAge] = false
      self.SpawnedObjs[self.DeathAge] = false
      self.DeathAge = self.DeathAge + 1
    end
  end
end

function MFD:PickupEvidence(evidence)
  if not self or not self.CurDNA then
    return
  end
  for k, v in pairs(self.CurDNA) do
    if v and v.pos and evidence and evidence.pos then
      if v.pos == evidence.pos then
        DeleteObject(v.go)
        table.remove(self.CurDNA, k)
      end
    end
  end
end

RegisterNetEvent("MF_DnaTracker:PickupEvidenceC")
AddEventHandler("MF_DnaTracker:PickupEvidenceC", function(evidence)
  MFD:PickupEvidence(evidence)
end)

function MFD:TakeDamage(ped)
  if not self or not ped or self.TakingDamage then
    return
  end
  self.TakingDamage = true
  local plyPos = GetEntityCoords(ped)
  local found, newZ = GetGroundZFor_3dCoord(plyPos.x, plyPos.y, plyPos.z, newZ, false)
  local newPos = vector3(plyPos.x, plyPos.y, newZ - 0.2)
  TriggerServerEvent("MF_DnaTracker:PlaceEvidenceS", newPos, self.BloodObject)
  self.TakingDamage = false
end

function MFD:PlayerShooting(ped)
  if not self or not ped or self.IsShooting then
    return
  end
  self.IsShooting = true
  local plyPos = GetEntityCoords(ped)
  local pedWeapon = GetSelectedPedWeapon(ped)
  if pedWeapon < 0 then
    pedWeapon = pedWeapon % 0x100000000
  end
  local weapon, weaponType = nil, nil
  for weaType, val in pairs(Weapons) do
    for _, weaModel in pairs(val) do
      if Utils.GetHashKey(weaModel) == pedWeapon then
        weapon = weaModel
        weaponType = weaType
      end
    end
  end
  if weapon ~= nil and weaponType ~= nil then
    local found, newZ = GetGroundZFor_3dCoord(plyPos.x, plyPos.y, plyPos.z, newZ, false)
    local newPos = vector3(plyPos.x, plyPos.y, newZ)
    TriggerServerEvent("MF_DnaTracker:PlaceEvidenceS", newPos, self.ResidueObject, weapon, weaponType)
  end
  self.IsShooting = false
end

RegisterNetEvent("MF_DnaTracker:AnalyzeDNA")
AddEventHandler("MF_DnaTracker:AnalyzeDNA", function()
  local self = MFD
  if not self.CurDNA or not self.CurBlood or not ESX then
    return
  end
  local street, crossing = GetStreetNameAtCoord(self.CurBlood.pos.x, self.CurBlood.pos.y, self.CurBlood.pos.z)
  local elements = {
    [1] = {label = "Name: " .. self.CurBlood.name},
    [2] = {label = "Type: Blood"},
    [3] = {label = "Street: " .. GetStreetNameFromHashKey(street)},
    [4] = {label = "Loc: [ X : " .. math.floor(self.CurBlood.pos.x) .. " ] [ Y : " .. math.floor(self.CurBlood.pos.y) .. "] : [ Z : " .. math.floor(self.CurBlood.pos.z) .. " ]"}
  }
  ESX.UI.Menu.Open(
    "default",
    GetCurrentResourceName(),
    "Blood_Info",
    {title = "DNA Analyzer", align = "right", elements = elements},
    function(data, menu)
      menu.close()
      ESX.UI.Menu.CloseAll()
    end,
    function(data, menu)
      menu.close()
      ESX.UI.Menu.CloseAll()
    end
  )
end)

RegisterNetEvent("MF_DnaTracker:AnalyzeAmmo")
AddEventHandler("MF_DnaTracker:AnalyzeAmmo", function()
  local self = MFD
  if not self.CurBullet or not self.CurBullet.wea or not ESX then
    return
  end

  local st, fn = string.find(self.CurBullet.wea, "WEAPON_")
  local newStr = string.lower(string.sub(self.CurBullet.wea, fn + 1))
  newStr = newStr:sub(1, 1):upper() .. newStr:sub(2)
  local street, crossing = GetStreetNameAtCoord(self.CurBullet.pos.x, self.CurBullet.pos.y, self.CurBullet.pos.z)

  local elements = {
    [1] = {label = "Weapon: " .. newStr},
    [2] = {label = "Type: " .. self.CurBullet.weaType},
    [3] = {label = "Street: " .. GetStreetNameFromHashKey(street)},
    [4] = {label = "Loc: [ X : " .. math.floor(self.CurBullet.pos.x) .. " ] : [ Y : " .. math.floor(self.CurBullet.pos.y) .. "] : [ Z : " .. math.floor(self.CurBullet.pos.z) .. " ]"}
  }
  ESX.UI.Menu.Open(
    "default",
    GetCurrentResourceName(),
    "AnalyzeAmmo",
    {title = "Ammo Analyzer", align = "right", elements = elements},
    function(data, menu)
      menu.close()
      ESX.UI.Menu.CloseAll()
    end,
    function(data, menu)
      menu.close()
      ESX.UI.Menu.CloseAll()
    end
  )
end)

RegisterNetEvent("MF_DnaTracker:PlaceEvidenceC")
AddEventHandler("MF_DnaTracker:PlaceEvidenceC", function(pos, obj, name, ident, weapon, weaponType)
  if not ESX then
    return
  end
  if not ESX.IsPlayerLoaded() then
    return
  end
  MFD.CurPlacing = true

  local plyPed = GetPlayerPed(-1)

  local isPlayerObject = false
  if ident == plyData.identifier then
    isPlayerObject = true
  end

  if obj == MFD.BloodObject and (plyData.job.name == MFD.PoliceJob or plyData.job.name == MFD.AmbulanceJob or isPlayerObject) then
    MFD.CurDNA = MFD.CurDNA or {}
    MFD.SpawnedObjs = MFD.SpawnedObjs or {}

    local closestPed = ESX.Game.GetClosestPed(pos, {plyPed})
    local closestVeh = ESX.Game.GetClosestVehicle(pos)
    local plyPos = GetEntityCoords(plyPed)
    local pedPos = GetEntityCoords(closestPed)
    local vehPos = GetEntityCoords(closestVeh)
    local distPed
    if pedpos and plyPos then
      distPed = Utils:GetVecDist(pedPos, plyPo)
    end
    local distVeh
    if vehPos and plyPos then
      distVeh = Utils:GetVecDist(plyPos, vehPos)
    end

    if distPed and distPed < 5.0 then
      SetEntityAsMissionEntity(closestPed, true, true)
    end

    if distVeh and distVeh < 5.0 then
      SetEntityAsMissionEntity(closestVeh, true, true)
    end

    local targetPosition = vector3(pos.x, pos.y, pos.z)
    local newObj = CreateObject(Utils.GetHashKey(obj), targetPosition)
    FreezeEntityPosition(newObj, true)
    SetEntityAsMissionEntity(newObj, true, true)
    SetEntityRotation(newObj, -90.0, 0.0, 0.0, 2, false)

    table.insert(MFD.CurDNA, {pos = pos, obj = obj, name = name, ident = ident, go = newObj})

    if IsEntityAMissionEntity(closestPed) then
      SetEntityAsMissionEntity(closestPed, false, false)
    end
    if IsEntityAMissionEntity(closestVeh) then
      SetEntityAsMissionEntity(closestVeh, false, false)
    end

    MFD.SpawnedObjs[MFD.Age] = newObj
    MFD.Age = MFD.Age + 1

    for k, v in pairs(MFD.CurDNA) do
      if v and type(v) ~= boolean and type(v) == table then
        SetEntityNoCollisionEntity(v.go, newObj, true)
      end
    end
  elseif obj == MFD.ResidueObject and (plyData.job.name == MFD.PoliceJob or isPlayerObject) then
    MFD.CurDNA = MFD.CurDNA or {}
    MFD.SpawnedObjs = MFD.SpawnedObjs or {}
    local newObj = CreateObject(Utils.GetHashKey(obj), pos.x, pos.y, pos.z, false, false, false)
    SetEntityRotation(newObj, -90.0, 0.0, 0.0, 2, false)
    SetEntityAsMissionEntity(newObj, true, true)
    FreezeEntityPosition(newObj, true)
    table.insert(MFD.CurDNA, {pos = pos, obj = obj, name = name, ident = ident, go = newObj, wea = weapon, weaType = weaponType})

    MFD.SpawnedObjs[MFD.Age] = newObj
    MFD.Age = MFD.Age + 1
  end
  SetModelAsNoLongerNeeded(Utils.GetHashKey(obj))
  MFD.CurPlacing = false
end)

local color = {r = 220, g = 220, b = 220, alpha = 255} -- Color of the text
local font = 4 -- Font of the text
local time = 7000 -- Duration of the display of the text : 1000ms = 1sec
local background = {enable = false, color = {r = 35, g = 35, b = 35, alpha = 200}}
local chatMessage = true
local dropShadow = true
local nbrDisplaying = 1

function MFD:DrawText3D(x, y, z, text)
  local onScreen, _x, _y = World3dToScreen2d(x, y, z)
  local px, py, pz = table.unpack(GetGameplayCamCoord())
  local dist = GetDistanceBetweenCoords(px, py, pz, x, y, z, 1)

  local scale = ((1 / dist) * 2) * (1 / GetGameplayCamFov()) * 100

  if onScreen then
    -- Formalize the text
    SetTextColour(color.r, color.g, color.b, color.alpha)
    SetTextScale(0.0 * scale, 0.35 * scale)
    SetTextFont(font)
    SetTextProportional(1)
    SetTextCentre(true)
    if dropShadow then
      SetTextDropshadow(15, 100, 100, 100, 255)
    end

    -- Calculate width and height
    BeginTextCommandWidth("STRING")
    AddTextComponentString(text)
    local height = GetTextScaleHeight(0.45 * scale, font)
    local width = EndTextCommandGetWidth(font)

    -- Diplay the text
    SetTextEntry("STRING")
    AddTextComponentString(text)
    EndTextCommandDisplayText(_x, _y)

    if background.enable then
      DrawRect(_x, _y + scale / 73, width, height, background.color.r, background.color.g, background.color.b, background.color.alpha)
    end
  end
end