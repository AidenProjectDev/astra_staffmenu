isNoClip,NoClipSpeed,isNameShown = false,0.5,false
spawnInside = false
selectedPlayer = nil

localPlayers, connecteds, staff, items = {},0,0, {}
permLevel = nil

RegisterNetEvent("astra_staff:updatePlayers")
AddEventHandler("astra_staff:updatePlayers", function(table)
    localPlayers = table
    local count, sCount = 0, 0
    for source, player in pairs(table) do
        count = count + 1
        if player.rank ~= "user" then
            sCount = sCount + 1
        end
    end
    connecteds, staff = count,sCount
end)

RegisterNetEvent("astra_staff:setCoords")
AddEventHandler("astra_staff:setCoords", function(coords)
    SetEntityCoords(PlayerPedId(), coords, false, false, false, false)
end)

RegisterNetEvent("astra_staff:cbPermLevel")
AddEventHandler("astra_staff:cbPermLevel", function(pLvl)
    permLevel = pLvl
end)

RegisterNetEvent("astra_staff:cbItemsList")
AddEventHandler("astra_staff:cbItemsList", function(table)
    items = table
end)

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('::{korioz#0110}::esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(1)
    end
    TriggerServerEvent("fakeLoaded")
    while not permLevel do Wait(1) end
    while true do
        Wait(1)
        if IsControlJustPressed(0, Config.openKey) then
            openMenu()
        end
    end
end)


