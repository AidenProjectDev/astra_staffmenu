ESX, players, items = nil, {}, {}
inService = {}

MySQL.ready(function()
    MySQL.Async.fetchAll("SELECT * FROM items", {}, function(result)
        for k, v in pairs(result) do
            items[k] = { label = v.label, name = v.name }
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

local function isWebhookSet(val)
    return val ~= nil and val ~= ""
end

TriggerEvent('::{korioz#0110}::esx:getSharedObject', function(obj)
    ESX = obj
end)

-- TODO -> Change method
--[[
RegisterServerEvent('::{korioz#0110}::esx:playerLoaded')
AddEventHandler('::{korioz#0110}::esx:playerLoaded', function(source, xPlayer)
--]]

RegisterNetEvent("fakeLoaded")
AddEventHandler("fakeLoaded", function()
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    if players[source] then
        return
    end
    TriggerClientEvent("astra_staff:cbPermLevel", source, xPlayer.getGroup())
    print(("^1Player loaded with group %s ! ^7"):format(xPlayer.getGroup()))
    players[source] = {
        timePlayed = { 0, 0 },
        rank = xPlayer.getGroup(),
        name = GetPlayerName(source),
        license = getLicense(source)["license"],
    }
    if players[source].rank ~= "user" then
        TriggerClientEvent("astra_staff:cbItemsList", source, items)
        TriggerClientEvent("astra_staff:cbReportTable", source, reportsTable)
    end
end)

AddEventHandler("playerDropped", function(reason)
    local source = source
    players[source] = nil
end)

RegisterNetEvent("astra_staff:setStaffState")
AddEventHandler("astra_staff:setStaffState", function(newVal, sneaky)
    local source = source
    TriggerClientEvent("astra_staff:cbStaffState", source, newVal)
    local byState = {
        [true] = "~r~[Staff] ~y~%s ~s~est désormais ~g~actif ~s~en staffmode.",
        [false] = "~r~[Staff] ~y~%s ~s~a ~r~désactivé ~s~son staffmode."
    }
    if newVal then
        inService[source] = true
    else
        inService[source] = nil
    end
    if not sneaky then
        for k,player in pairs(players) do
            if player.rank ~= "user" then
                TriggerClientEvent("::{korioz#0110}::esx:showNotification", k, byState[newVal]:format(GetPlayerName(source)))
            end
        end
    end
end)

RegisterNetEvent("astra_staff:goto")
AddEventHandler("astra_staff:goto", function(target)
    local source = source
    local rank = players[source].rank
    if not canUse("teleport", rank) then
        DropPlayer(source, "Permission invalide")
        return
    end
    local coords = GetEntityCoords(GetPlayerPed(target))
    TriggerClientEvent("astra_staff:setCoords", source, coords)
    if isWebhookSet(Config.webhook.onTeleport) then
        sendWebhook(("L'utilisateur %s s'est téléporté sur %s"):format(GetPlayerName(source), GetPlayerName(target)), "grey", Config.webhook.onItemGive)
    end
end)

RegisterNetEvent("astra_staff:bring")
AddEventHandler("astra_staff:bring", function(target, coords)
    local source = source
    local rank = players[source].rank
    if not canUse("teleport", rank) then
        DropPlayer(source, "Permission invalide")
        return
    end
    TriggerClientEvent("astra_staff:setCoords", target, coords)
    if isWebhookSet(Config.webhook.onTeleport) then
        sendWebhook(("L'utilisateur %s a téléporté %s sur lui"):format(GetPlayerName(source), GetPlayerName(target)), "grey", Config.webhook.onItemGive)
    end
end)

RegisterNetEvent("astra_staff:give")
AddEventHandler("astra_staff:give", function(target, itemName, qty)
    local source = source
    local rank = players[source].rank
    if not canUse("give", rank) then
        DropPlayer(source, "Permission invalide")
        return
    end
    local xPlayer = ESX.GetPlayerFromId(tonumber(target))
    xPlayer.addInventoryItem(itemName, tonumber(qty))
    TriggerClientEvent("::{korioz#0110}::esx:showNotification", source, ("~g~Give de %sx%s au joueur %s effectué"):format(qty, itemName, GetPlayerName(target)))
    if isWebhookSet(Config.webhook.onItemGive) then
        sendWebhook(("L'utilisateur %s a give %sx%s a %s"):format(GetPlayerName(source), qty, itemName, GetPlayerName(target)), "grey", Config.webhook.onItemGive)
    end
end)

RegisterNetEvent("astra_staff:message")
AddEventHandler("astra_staff:message", function(target, message)
    local source = source
    local rank = players[source].rank
    if not canUse("mess", rank) then
        DropPlayer(source, "Permission invalide")
        return
    end
    TriggerClientEvent("::{korioz#0110}::esx:showNotification", source, ("~g~Message envoyé à %s"):format(GetPlayerName(target)))
    TriggerClientEvent("::{korioz#0110}::esx:showNotification", target, ("~r~Message du staff: ~s~%s"):format(message))
    if isWebhookSet(Config.webhook.onWarn) then
        sendWebhook(("L'utilisateur %s a envoyé un message à %s:\n\n__%s__"):format(GetPlayerName(source), GetPlayerName(target), message), "grey", Config.webhook.onWarn)
    end
end)

RegisterNetEvent("astra_staff:kick")
AddEventHandler("astra_staff:kick", function(target, message)
    local source = source
    local rank = players[source].rank
    if not canUse("kick", rank) then
        DropPlayer(source, "Permission invalide")
        return
    end
    TriggerClientEvent("::{korioz#0110}::esx:showNotification", source, ("~g~Expulsion de %s effectuée"):format(GetPlayerName(target)))
    local name = GetPlayerName(target)
    DropPlayer(target, ("[Astra] Expulsé: %s"):format(message))
    if isWebhookSet(Config.webhook.onKick) then
        sendWebhook(("L'utilisateur %s a expulsé %s pour la raison:\n\n__%s__"):format(GetPlayerName(source), name, message), "grey", Config.webhook.onKick)
    end
end)

RegisterNetEvent("astra_staff:clearInv")
AddEventHandler("astra_staff:clearInv", function(target)
    local source = source
    local rank = players[source].rank
    if not canUse("clearInventory", rank) then
        DropPlayer(source, "Permission invalide")
        return
    end
    local xPlayer = ESX.GetPlayerFromId(target)
    for i = 1, #xPlayer.inventory, 1 do
        if xPlayer.inventory[i].count > 0 then
            xPlayer.setInventoryItem(xPlayer.inventory[i].name, 0)
        end
    end
    TriggerClientEvent("::{korioz#0110}::esx:showNotification", source, ("~g~Clear inventaire de %s effectuée"):format(GetPlayerName(target)))
    if isWebhookSet(Config.webhook.onClear) then
        sendWebhook(("L'utilisateur %s a clear inventaire %s"):format(GetPlayerName(source), GetPlayerName(target)), "grey", Config.webhook.onClear)
    end
end)


RegisterNetEvent("astra_staff:clearLoadout")
AddEventHandler("astra_staff:clearLoadout", function(target)
    local source = source
    local rank = players[source].rank
    if not canUse("clearLoadout", rank) then
        DropPlayer(source, "Permission invalide")
        return
    end
    local xPlayer = ESX.GetPlayerFromId(target)
    for i = #xPlayer.loadout, 1, -1 do
        xPlayer.removeWeapon(xPlayer.loadout[i].name)
    end
    TriggerClientEvent("::{korioz#0110}::esx:showNotification", source, ("~g~Clear des armes de %s effectuée"):format(GetPlayerName(target)))
    if isWebhookSet(Config.webhook.onClear) then
        sendWebhook(("L'utilisateur %s a clear les armes de %s"):format(GetPlayerName(source), GetPlayerName(target)), "grey", Config.webhook.onClear)
    end
end)

RegisterNetEvent("astra_staff:addMoney")
AddEventHandler("astra_staff:addMoney", function(target, ammount)
    local source = source
    local rank = players[source].rank
    if not canUse("giveMoney", rank) then
        DropPlayer(source, "Permission invalide")
        return
    end
    local xPlayer = ESX.GetPlayerFromId(target)
    xPlayer.addAccountMoney("cash", ammount)
    TriggerClientEvent("::{korioz#0110}::esx:showNotification", source, ("~g~Give d'argent à %s effectuée"):format(GetPlayerName(target)))
    if isWebhookSet(Config.webhook.onMoneyGive) then
        sendWebhook(("L'utilisateur %s a give %s$ à %s"):format(GetPlayerName(source), ammount, GetPlayerName(target)), "grey", Config.webhook.onMoneyGive)
    end
end)

-- Players updaters task
Citizen.CreateThread(function()
    while true do
        Wait(15000)
        for source, player in pairs(players) do
            if isStaff(source) then
                TriggerClientEvent("astra_staff:updatePlayers", source, players)
            end
        end
    end
end)

-- Session counter task
Citizen.CreateThread(function()
    while true do
        Wait(1000 * 60)
        for k, v in pairs(players) do
            players[k].timePlayed[1] = players[k].timePlayed[1] + 1
            if players[k].timePlayed[1] > 60 then
                players[k].timePlayed[1] = 0
                players[k].timePlayed[2] = players[k].timePlayed[2] + 1
            end
        end
    end
end)