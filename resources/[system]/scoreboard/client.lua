RegisterKeyMapping("+scoreboard", "Open the scoreboard.", "keyboard", "z")

RegisterCommand("+scoreboard", function(source, args, rawcommand)
  TriggerServerEvent("Scoreboard:GetPlayers")
end, false)

RegisterCommand("-scoreboard", function(source, args, rawcommand)

end, false)

players = {}

RegisterNetEvent("Scoreboard:ReceivePlayers")
AddEventHandler("Scoreboard:ReceivePlayers", function(_players)
  players = _players
  local nuiData = {}
  for _, playerId in pairs(players) do
    local ply = Player(playerId)
    nuiData[playerId] = {}
    for columnName, columnData in pairs(columns) do
      nuiData[playerId][columnName] = ply.state[columnName]
    end
  end
  -- send to NUI to populate players
end)

TriggerServerEvent("Scoreboard:RequestColumns")

RegisterNetEvent("Scoreboard:ReceiveColumns")
AddEventHandler("Scoreboard:ReceiveColumns", function(_columns)
  columns = _columns
  -- Send to NUI to populate columns
end)
