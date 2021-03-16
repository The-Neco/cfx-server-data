RegisterNetEvent("Scoreboard:GetPlayers")
AddEventHandler("Scoreboard:GetPlayers", function()
  TriggerClientEvent("Scoreboard:ReceivePlayers", source, GetPlayers())
end)

columns = {
  ["ID"] = {
    friendlyName = "Player ID",
    defaultValue = 0
  },
  ["Name"] = {
    friendlyName = "Name",
    defaultValue = "***Invalid***"
  }
}

RegisterNetEvent("Scoreboard:RequestColumns")
AddEventHandler("Scoreboard:RequestColumns", function()
  local ply = Player(source)
  for columnName, columnData in pairs(columns) do
    ply.state[columnName] = columnData.defaultValue
  end
  ply.state.ID = source
  ply.state.Name = GetPlayerName(source)
  TriggerClientEvent("Scoreboard:ReceiveColumns", source, columns)
end)

AddEventHandler("Scoreboard:AddColumn", function(name, _friendlyName, _defaultValue)
  columns[name] = {
    friendlyName = _friendlyName,
    defaultValue = _defaultValue
  }
  for _, playerId in pairs(GetPlayers()) do
    Player(playerId).state[name] = _defaultValue
  end
  TriggerClientEvent("Scoreboard:ReceiveColumns", -1, columns)
end)

AddEventHandler("Scoreboard:RemoveColumn", function(name)
  columns[name] = nil
  TriggerClientEvent("Scoreboard:ReceiveColumns", -1, columns)
end)

AddEventHandler("Scoreboard:UpdateColumnValue", function(src, name, value)
  Player(src).state[name] = value
end)
