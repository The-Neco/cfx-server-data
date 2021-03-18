RegisterNetEvent("scoreboard:getPlayers")
AddEventHandler("scoreboard:getPlayers", function()
  TriggerClientEvent("scoreboard:receivePlayers", source, GetPlayers())
end)

columns = {
  {
    friendlyName = "Player ID",
    defaultValue = 0,
    position = 0
  },
  {
    friendlyName = "Name",
    defaultValue = "***Invalid***",
    position = 1
  }
}


RegisterNetEvent("scoreboard:requestColumns")
AddEventHandler("scoreboard:requestColumns", function()
  local ply = Player(source)
  for columnName, columnData in pairs(columns) do
    ply.state[columnName] = columnData.defaultValue
  end
  ply.state.ID = source
  ply.state.Name = GetPlayerName(source)
  TriggerClientEvent("scoreboard:receiveColumns", source, columns)
end)

AddEventHandler("scoreboard:addColumn", function(name, _friendlyName, _defaultValue, _position)
  columns[name] = {
    friendlyName = _friendlyName,
    defaultValue = _defaultValue,
    posititon = _position
  }
  for _, playerId in pairs(GetPlayers()) do
    Player(playerId).state[name] = _defaultValue
  end
  TriggerClientEvent("scoreboard:receiveColumns", -1, columns)
end)

AddEventHandler("scoreboard:removeColumn", function(name)
  columns[name] = nil
  TriggerClientEvent("scoreboard:receiveColumns", -1, columns)
end)

AddEventHandler("scoreboard:updateColumnValue", function(src, name, value)
  Player(src).state[name] = value
end)
