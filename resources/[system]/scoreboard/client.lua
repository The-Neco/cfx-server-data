RegisterKeyMapping("+scoreboard", "Open the scoreboard.", "keyboard", "z")

RegisterCommand("+scoreboard", function(source, args, rawcommand)
  TriggerServerEvent("scoreboard:getPlayers")
end, false)

RegisterCommand("-scoreboard", function(source, args, rawcommand)

end, false)

players = {}

RegisterNetEvent("scoreboard:receivePlayers")
AddEventHandler("scoreboard:receivePlayers", function(_players)
  players = _players
  local nuiData = {}
  for _, playerId in pairs(players) do
    local ply = Player(playerId)
    nuiData[playerId] = {}
    for columnName, columnData in pairs(columns) do
      nuiData[playerId][columnName] = ply.state[columnName]
    end
  end
  print(json.encode(nuiData))
  -- send to NUI to populate players
end)

TriggerServerEvent("scoreboard:requestColumns")

RegisterNetEvent("scoreboard:receiveColumns")
AddEventHandler("scoreboard:receiveColumns", function(_columns)
  columns = _columns
  -- Send to NUI to populate columns
end)
