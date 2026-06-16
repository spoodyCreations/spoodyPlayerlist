local client = {
    shown = false,
    players = {},
    stored = {}
}

function client:store(id, data)
    local entry = self.stored[id] or { muted = false, volume = 100 }

    if data.muted ~= nil then
        entry.muted = data.muted
    end

    if data.volume ~= nil then
        entry.volume = data.volume
    end

    self.stored[id] = entry
end

function client:build()
    local me = GetPlayerServerId(PlayerId())
    local out = {}

    for _, id in ipairs(self.players) do
        if id ~= me then
            local entry = self.stored[id]

            out[#out + 1] = {
                id = id,
                muted = entry and entry.muted or false,
                volume = entry and entry.volume or 100
            }
        end
    end

    table.sort(out, function(a, b)
        return a.id < b.id
    end)

    return out
end

function client:setMute(id, muted)
    id = math.tointeger(id) or id

    self:store(id, { muted = muted })

    if muted then
        MumbleSetVolumeOverrideByServerId(id, 0.0)
    else
        MumbleSetVolumeOverrideByServerId(id, self.stored[id].volume / 100.0)
    end
end

function client:setVolume(id, volume)
    id = math.tointeger(id) or id

    self:store(id, { volume = volume })

    if not self.stored[id].muted then
        MumbleSetVolumeOverrideByServerId(id, volume / 100.0)
    end
end

function client:open()
    local callback = lib.callback.await('spoodyPlayerlist:getPlayers', false) or {}
    if not callback then return end

    self.players = callback
    self.shown = true

    SetNuiFocus(true, true)
    SendNUIMessage({
        action = 'setPlayerlistVisibility',
        data = {
            visible = true,
            serverName = Config.ServerName,
            players = self:build()
        }
    })
end

function client:close()
    self.shown = false

    SetNuiFocus(false, false)
    SendNUIMessage({
        action = 'setPlayerlistVisibility',
        data = { visible = false }
    })
end

function client:toggle()
    if self.shown then
        self:close()
    else
        self:open()
    end
end

RegisterNetEvent('spoodyPlayerlist:sync', function(list)
    client.players = list

    if client.shown then
        SendNUIMessage({
            action = 'updatePlayers',
            data = { players = client:build() }
        })
    end
end)

RegisterNUICallback('toggleMute', function(data, cb)
    client:setMute(data.id, data.muted)
    cb('ok')
end)

RegisterNUICallback('setVolume', function(data, cb)
    client:setVolume(data.id, data.volume)
    cb('ok')
end)

RegisterNUICallback('closePlayerlist', function(_, cb)
    client.shown = false
    SetNuiFocus(false, false)
    cb('ok')
end)

if Config.Keybind.Enabled then
    lib.addKeybind({
        name = 'playerlist',
        description = 'Open the playerlist',
        defaultKey = Config.Keybind.Button,

        onPressed = function()
            client:toggle()
        end
    })
end

if Config.Command.Enabled then
    RegisterCommand(Config.Command.Name, function()
        client:toggle()
    end, false)
end

CreateThread(function()
    while not NetworkIsSessionStarted() do
        Wait(250)
    end

    TriggerServerEvent('spoodyPlayerlist:onClientConnected')
end)