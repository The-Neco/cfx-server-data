RegisterNetEvent("scoreboard:getPlayers")
AddEventHandler("scoreboard:getPlayers", function()
  TriggerClientEvent("scoreboard:receivePlayers", source, players)
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

players = {}

RegisterNetEvent("scoreboard:requestColumns")
AddEventHandler("scoreboard:requestColumns", function()
  players[source] = {}
  for id, columnData in pairs(columns) do
    players[source][columnData.friendlyName] = columnData.defaultValue
  end
  players[source]["Player ID"] = source
  players[source]["Name"] = GetPlayerName(source)
  TriggerClientEvent("scoreboard:receiveColumns", source, columns)
end)

AddEventHandler("scoreboard:addColumn", function(_friendlyName, _defaultValue, _position)
  columns[#columns+1] = {
    friendlyName = _friendlyName,
    defaultValue = _defaultValue,
    posititon = _position
  }
  for _, playerId in pairs(GetPlayers()) do
    players[tonumber(playerId)][_friendlyName] = _defaultValue
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
    players[src][name] = value
  end
end)

AddEventHandler("playerDropped", function(reason)
  players[source] = nil
end)

function getColumnFromName(name)
  for id, data in pairs(columns) do
    if data.friendlyName == name then
      return id
    end
  end
  return false
end
