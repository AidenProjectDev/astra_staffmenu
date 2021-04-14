local ESX, players, items = nil,{},{}

MySQL.ready(function()
    MySQL.Async.fetchAll("SELECT * FROM items", {}, function(result)
        for k,v in pairs(result) do
            items[k] = {label = v.label, name = v.name}
        end
    end)
end)

local function getLicense(source)
    if (source ~= nil) then
        local identifiers = {}
        local playerIdentifiers = GetPlayerIdentifiers(source)
        for _, v in pairs(playerIdentifiers) do
            local before, after = playerIdentifiers[_]:match("([^:]+):([^:]+)")
            identifiers[before] = playerIdentifiers
        end
        return identifiers
    end
end

local function isStaff(source)
    return players[source].rank ~= "user"
end

TriggerEvent('::{korioz#0110}::esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('::{korioz#0110}::esx:playerLoaded')
AddEventHandler('::{korioz#0110}::esx:playerLoaded', function(source, xPlayer)
    if players[source] then return end
    TriggerClientEvent("astra_staff:cbPermLevel", source, xPlayer.getGroup())
    print(("^1Player loaded with group %s ! ^7"):format(xPlayer.getGroup()))
    players[source] = {
        timePlayed = {0,0},
        rank = xPlayer.getGroup(),
        name = GetPlayerName(source),
        license = getLicense(source)["license"],
    }
    if players[source].rank ~= "user" then
        TriggerClientEvent("astra_staff:cbItemsList", source, items)
    end
end)

AddEventHandler("playerDropped", function(reason)
    local source = source
    players[source] = nil
end)

RegisterNetEvent("astra_staff:goto")
AddEventHandler("astra_staff:goto", function(target)
    -- TODO -> Add log
    local _src = source
    local license = getLicense(_src)
    if not players[_src] or players[_src].rank == "user" then return end
    local coords = GetEntityCoords(GetPlayerPed(target))
    TriggerClientEvent("astra_staff:setCoords", _src, coords)
end)

RegisterNetEvent("astra_staff:bring")
AddEventHandler("astra_staff:bring", function(target,coords)
    -- TODO -> Add log
    local _src = source
    local license = getLicense(_src)
    if not players[_src] or players[_src].rank == "user" then return end
    TriggerClientEvent("astra_staff:setCoords", target, coords)
end)
-- Players updaters task
Citizen.CreateThread(function()
    while true do
        Wait(15000)
        for source,player in pairs(players) do
            if isStaff(source) then
                TriggerClientEvent("astra_staff:updatePlayers", source, players)
            end
        end
    end
end)

-- Session counter task
Citizen.CreateThread(function()
    while true do
        Wait(1000*60)
        for k,v in pairs(players) do
            players[k].timePlayed[1] = players[k].timePlayed[1] + 1
            if players[k].timePlayed[1] > 60 then
                players[k].timePlayed[1] = 0
                players[k].timePlayed[2] = players[k].timePlayed[2] + 1
            end
        end
    end
end)