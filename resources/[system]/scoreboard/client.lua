RegisterKeyMapping("+scoreboard", "Open the scoreboard.", "keyboard", "z")

RegisterCommand("+scoreboard", function(source, args, rawcommand)
  TriggerServerEvent("scoreboard:getPlayers")
  SendNUIMessage({
      app = 'CfxScoreboard',
      method = 'setVisibility',
      data = true
    })
end, false)

RegisterCommand("-scoreboard", function(source, args, rawcommand)
SendNUIMessage({
    app = 'CfxScoreboard',
    method = 'setVisibility',
    data = false
  })
end, false)

players = {}

RegisterNetEvent("scoreboard:receivePlayers")
AddEventHandler("scoreboard:receivePlayers", function(_players)
  players = _players
  local nuiData = {}
  for _, playerId in pairs(players) do
    local ply = Player(playerId)
    local nextId = #nuiData+1
    nuiData[nextId] = {}
    for id, columnData in pairs(columns) do
      nuiData[nextId][id] = ply.state[columnData.friendlyName]
    end
  end
  -- send to NUI to populate players
  SendNUIMessage({
      app = 'CfxScoreboard',
      method = 'setPlayers',
      data = nuiData
    })
end)

TriggerServerEvent("scoreboard:requestColumns")

RegisterNetEvent("scoreboard:receiveColumns")
AddEventHandler("scoreboard:receiveColumns", function(_columns)
  columns = _columns

  -- Send to NUI to populate columns
  SendNUIMessage({
    app = 'CfxScoreboard',
    method = 'setColumns',
    data = columns
  })
end)

--[[
The following is stolen from the chat resource to allow for themes.
All credit for this goes to moscovium for writing the theme logic (03362d2).
]]
local function refreshThemes()
  local themes = {}

  for resIdx = 0, GetNumResources() - 1 do
    local resource = GetResourceByFindIndex(resIdx)

    if GetResourceState(resource) == 'started' then
      local numThemes = GetNumResourceMetadata(resource, 'scoreboard_theme')

      if numThemes > 0 then
        local themeName = GetResourceMetadata(resource, 'scoreboard_theme')
        local themeData = json.decode(GetResourceMetadata(resource, 'scoreboard_theme_extra') or 'null')

        if themeName and themeData then
          themeData.baseUrl = 'nui://' .. resource .. '/'
          themes[themeName] = themeData
        end
      end
    end
  end

  SendNUIMessage({
    type = 'ON_UPDATE_THEMES',
    themes = themes
  })
end

AddEventHandler('onClientResourceStart', function(resName)
  Wait(500)

  refreshThemes()
end)

AddEventHandler('onClientResourceStop', function(resName)
  Wait(500)

  refreshThemes()
end)
