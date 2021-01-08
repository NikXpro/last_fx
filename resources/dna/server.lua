local MFD = MF_DnaTracker

RegisterNetEvent("MF_DnaTracker:PlaceEvidenceS")
AddEventHandler("MF_DnaTracker:PlaceEvidenceS", function(pos, obj, weapon, weaponType)
  local xPlayer = ESX.GetPlayerFromId(source)
  while not xPlayer do
    Citizen.Wait(0)
    ESX.GetPlayerFromId(source)
  end
  local playername = ""
  local playerident = xPlayer.identifier
  local data = MySQL.Sync.fetchAll("SELECT * FROM users WHERE identifier=@identifier", {["@identifier"] = playerident})
  for key, val in pairs(data) do
    playername = val.firstname .. " " .. val.lastname
  end
  TriggerClientEvent("MF_DnaTracker:PlaceEvidenceC", -1, pos, obj, playername, playerident, weapon, weaponType)
end)

ESX.RegisterServerCallback("MF_DnaTracker:PickupEvidenceS", function(source, cb, evidence, deleteIt)
  local xPlayer = ESX.GetPlayerFromId(source)
  while not xPlayer do
    Citizen.Wait(0)
    ESX.GetPlayerFromId(source)
  end
  local cbData
  if evidence.obj == MFD.BloodObject then
    local count = xPlayer.getInventoryItem("bloodsample")
    if count and count.count and count.count > 0 and not deleteIt then
      cbData = false
    else
      if not deleteIt then
        xPlayer.addInventoryItem("bloodsample", 1)
      end
      TriggerClientEvent("MF_DnaTracker:PickupEvidenceC", -1, evidence)
      cbData = true
    end
  elseif evidence.obj == MFD.ResidueObject then
    local count = xPlayer.getInventoryItem("bulletsample")
    if count and count.count and count.count > 0 and not deleteIt then
      cbData = false
    else
      if not deleteIt then
        xPlayer.addInventoryItem("bulletsample", 1)
      end
      TriggerClientEvent("MF_DnaTracker:PickupEvidenceC", -1, evidence)
      cbData = true
    end
  end
  cb(cbData)
end)

ESX.RegisterServerCallback("MF_DnaTracker:GetJob", function(source, cb, evidence)
  local xPlayer = ESX.GetPlayerFromId(source)
  while not xPlayer do
    Citizen.Wait(0)
    ESX.GetPlayerFromId(source)
  end
  local cbData = xPlayer.getJob()
  cb(cbData)
end)

ESX.RegisterUsableItem("dnaanalyzer", function(source)
  local xPlayer = ESX.GetPlayerFromId(source)
  while not xPlayer do
    Citizen.Wait(0)
    ESX.GetPlayerFromId(source)
  end
  if xPlayer.getInventoryItem("bloodsample").count > 0 then
    xPlayer.removeInventoryItem("bloodsample", 1)
    TriggerClientEvent("MF_DnaTracker:AnalyzeDNA", source)
  end
end)

ESX.RegisterUsableItem("ammoanalyzer", function(source)
  local xPlayer = ESX.GetPlayerFromId(source)
  while not xPlayer do
    Citizen.Wait(0)
    ESX.GetPlayerFromId(source)
  end
  if xPlayer.getInventoryItem("bulletsample").count > 0 then
    xPlayer.removeInventoryItem("bulletsample", 1)
    TriggerClientEvent("MF_DnaTracker:AnalyzeAmmo", source)
  end
end)