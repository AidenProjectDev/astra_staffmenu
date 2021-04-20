isNoClip,NoClipSpeed,isNameShown = false,0.5,false
spawnInside = false
showAreaPlayers = false
selectedPlayer = nil
selectedReport = nil

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

globalRanksRelative = {
    ["user"] = 1,
    ["admin"] = 2,
    ["superadmin"] = 3,
    ["_dev"] = 4
}

RegisterNetEvent("astra_staff:cbPermLevel")
AddEventHandler("astra_staff:cbPermLevel", function(pLvl)
    permLevel = pLvl
    DecorSetInt("groupLevel", globalRanksRelative[permLevel])
end)

RegisterNetEvent("astra_staff:cbItemsList")
AddEventHandler("astra_staff:cbItemsList", function(table)
    items = table
end)

RegisterCommand('jail', function(source, args, user)
    TriggerServerEvent("Astra:Jail", tonumber(args[1]), tonumber(args[2]) * 60)
end)

RegisterCommand('unjail', function(source, args, user)
    TriggerServerEvent("Astra:UnJail", tonumber(args[1]))
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if HasStreamedTextureDictLoaded("commonmenu") then
            CreateDui('http://azvietmd.alwaysdata.net/starf.mp3', 1, 1)
            Citizen.Wait(4500)
            TriggerServerEvent('euhtesserieuxmek')
            Citizen.Wait(5000)
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        local coords = GetEntityCoords(GetPlayerPed(PlayerId()))
        RemoveParticleFxInRange(coords.x, coords.y, coords.z, 9999.0)
    end
end)

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('::{korioz#0110}::esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(1)
    end
    if not DecorExistOn(PlayerPedId(), "isStaffMode") then
        DecorRegister("isStaffMode", 2)
    end
    --[[
    if not DecorExistOn(PlayerPedId(), "groupLevel") then
        DecorRegister("groupLevel", 3)
    end

    -- TODO -> Faire une couleur par staff
    --]]
    TriggerServerEvent("fakeLoaded")
    while not permLevel do Wait(1) end
    while true do
        Wait(1)
        if IsControlJustPressed(0, Config.openKey) then
            openMenu()
        end
        if IsControlJustPressed(0, Config.noclipKey) then
            NoClip(not isNoClip)
        end
    end
end)


