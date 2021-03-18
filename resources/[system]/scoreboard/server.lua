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
  for id, columnData in pairs(columns) do
    ply.state[columnData.friendlyName] = columnData.defaultValue
  end
  ply.state["Player ID"] = source
  ply.state["Name"] = GetPlayerName(source)
  TriggerClientEvent("scoreboard:receiveColumns", source, columns)
end)

AddEventHandler("scoreboard:addColumn", function(_friendlyName, _defaultValue, _position)
  columns[#columns+1] = {
    friendlyName = _friendlyName,
    defaultValue = _defaultValue,
    posititon = _position
  }
  for _, playerId in pairs(GetPlayers()) do
    Player(playerId).state[_friendlyName] = _defaultValue
  end
  TriggerClientEvent("scoreboard:receiveColumns", -1, columns)
end)

AddEventHandler("scoreboard:removeColumn", function(name)
  local columnId = getColumnFromName(name)
  if columnId then
    columns[columnId] = nil
    TriggerClientEvent("scoreboard:receiveColumns", -1, columns)
  end
end)

AddEventHandler("scoreboard:updateColumnValue", function(src, name, value)
  local columnId = getColumnFromName(name)
  if columnId then
    Player(src).state[name] = value
  end
end)

function getColumnFromName(name)
  for id, data in pairs(column) do
    if data.friendlyName == name then
      return id
    end
  end
  return false
end
