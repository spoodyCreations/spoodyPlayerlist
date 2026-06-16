local server = {
    list = {}
}

function server:has(src)
    for _, id in ipairs(self.list) do
        if id == src then
            return true
        end
    end

    return false
end

function server:add(src)
    if self:has(src) then
        return
    end

    self.list[#self.list + 1] = src
end

function server:remove(src)
    for i = #self.list, 1, -1 do
        if self.list[i] == src then
            table.remove(self.list, i)
        end
    end
end

function server:sync()
    TriggerClientEvent('spoodyPlayerlist:sync', -1, self.list)
end

RegisterNetEvent('spoodyPlayerlist:onClientConnected', function()
    local src = source

    server:add(src)
    server:sync()
end)

AddEventHandler('playerDropped', function()
    local src = source

    server:remove(src)
    server:sync()
end)

lib.callback.register('spoodyPlayerlist:getPlayers', function()
    return server.list
end)

AddEventHandler('onResourceStart', function(resource)
    if resource ~= GetCurrentResourceName() then
        return
    end

    for _, id in ipairs(GetPlayers()) do
        server:add(tonumber(id))
    end

    server:sync()
end)