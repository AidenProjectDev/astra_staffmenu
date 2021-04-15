local isMenuOpened, cat = false, "astrastaff"
local prefix = "~r~[Astra]~s~"
local filterArray = {"A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z"}
local filter = 1

local function subCat(name)
    return cat..name
end

local function msg(string)
    ESX.ShowNotification(string)
end

local function colorByState(bool)
    if bool then return "~g~" else return "~r~" end
end

local function statsSeparator()
    RageUI.Separator("Connectés: ~g~"..connecteds.." ~b~|~s~ Staff en ligne: ~o~"..staff)
end

local ranksRelative = {
    ["user"] = 4,
    ["admin"] = 3,
    ["superadmin"] = 2,
    ["_dev"] = 1
}

local function getRankDisplay(rank)
    local ranks = {
        ["_dev"] = "~r~[Dev] ~s~",
        ["superadmin"] = "~r~[S.Admin] ~s~",
        ["admin"] = "~r~[Admin] ~s~",
    }
    return ranks[rank] or ""
end
local function starts(String,Start)
    return string.sub(String,1,string.len(Start))==Start
end

function openMenu()
    if menuOpen then return end
    if permLevel == "user" then
        ESX.ShowNotification("~r~Vous n'avez pas accès à ce menu.")
        return
    end
    local selectedColor = 1
    local cVarLongC = {"~p~", "~r~","~o~","~y~","~c~","~g~","~b~"}
    local cVar1, cVar2 = "~y~", "~r~"
    local cVarLong = function()
        return cVarLongC[selectedColor]
    end
    menuOpen = true

    RMenu.Add(cat, subCat("main"), RageUI.CreateMenu("Administration", "Menu administratif", nil, nil, "tespascool", "interaction_bgd"))
    RMenu:Get(cat, subCat("main")).Closed = function() end

    RMenu.Add(cat, subCat("players"), RageUI.CreateSubMenu(RMenu:Get(cat, subCat("main")), "Administration", "Menu administratif", nil, nil, "tespascool", "interaction_bgd"))
    RMenu:Get(cat, subCat("players")).Closed = function() end

    RMenu.Add(cat, subCat("playersManage"), RageUI.CreateSubMenu(RMenu:Get(cat, subCat("players")), "Administration", "Menu administratif", nil, nil, "tespascool", "interaction_bgd"))
    RMenu:Get(cat, subCat("playersManage")).Closed = function() end

    RMenu.Add(cat, subCat("items"), RageUI.CreateSubMenu(RMenu:Get(cat, subCat("playersManage")), "Administration", "Menu administratif", nil, nil, "tespascool", "interaction_bgd"))
    RMenu:Get(cat, subCat("items")).Closed = function() end

    RMenu.Add(cat, subCat("vehicle"), RageUI.CreateSubMenu(RMenu:Get(cat, subCat("main")), "Administration", "Menu administratif", nil, nil, "tespascool", "interaction_bgd"))
    RMenu:Get(cat, subCat("vehicle")).Closed = function() end


    RageUI.Visible(RMenu:Get(cat, subCat("main")), true)
    Citizen.CreateThread(function()
        while menuOpen do
            Wait(800)
            if cVar1 == "~y~" then cVar1 = "~o~" else cVar1 = "~y~" end
            if cVar2 == "~r~" then cVar2 = "~s~" else cVar2 = "~r~" end
        end
    end)
    Citizen.CreateThread(function()
        while menuOpen do
            Wait(250)
            selectedColor = selectedColor + 1
            if selectedColor > #cVarLongC then selectedColor = 1 end
        end
    end)
    Citizen.CreateThread(function()
        while menuOpen do
            local shouldStayOpened = false
            RageUI.IsVisible(RMenu:Get(cat, subCat("main")),true,true,true,function()
                shouldStayOpened = true
                statsSeparator()

                if isStaffMode then
                    RageUI.ButtonWithStyle("~r~Désactiver le Staff Mode", nil, {}, not serverInteraction, function(_,_,s)
                        if s then
                            serverInteraction = true
                            ESX.ShowNotification("~y~Désactivation du StaffMode...")
                            TriggerServerEvent("astra_staff:setStaffState", false)
                        end
                    end)
                else
                    RageUI.ButtonWithStyle("~g~Activer le Staff Mode", nil, {}, not serverInteraction, function(_,_,s)
                        if s then
                            serverInteraction = true
                            ESX.ShowNotification("~y~Activation du StaffMode...")
                            TriggerServerEvent("astra_staff:setStaffState", true)
                        end
                    end)
                end

                RageUI.Separator("↓ ~y~Assistance ~s~↓")
                RageUI.ButtonWithStyle(cVarLong().."→ ~s~Gestion des reports", nil, {RightLabel = "→→"}, true, function(_,_,s)
                end)

                if isStaffMode then
                    RageUI.Separator("↓ ~o~Modération ~s~↓")

                    RageUI.Checkbox(cVarLong().."→ "..colorByState(isNoClip).."NoClip", nil, isNoClip, { Style = RageUI.CheckboxStyle.Tick }, function(Hovered, Selected, Active, Checked)
                        isNoClip = Checked;
                    end, function()
                        NoClip(true)
                    end, function()
                        NoClip(false)
                    end)

                    RageUI.ButtonWithStyle(cVarLong().."→ ~s~Gestion joueurs", nil, {RightLabel = "→→"}, true, function()
                    end, RMenu:Get(cat, subCat("players")))
                    RageUI.ButtonWithStyle(cVarLong().."→ ~s~Gestion véhicules", nil, {RightLabel = "→→"}, true, function()
                    end, RMenu:Get(cat, subCat("vehicle")))
                end
            end, function()
            end, 1)

            RageUI.IsVisible(RMenu:Get(cat, subCat("players")),true,true,true,function()
                shouldStayOpened = true
                statsSeparator()
                RageUI.Separator("↓ ~g~Joueurs ~s~↓")
                for source, player in pairs(localPlayers) do
                    --RageUI.ButtonWithStyle(getRankDisplay(player.rank).."~s~[~o~"..source.."~s~] "..cVarLong().."→ ~s~"..player.name.." (~b~"..player.timePlayed[2].."h "..player.timePlayed[1].."min~s~)", nil, {RightLabel = "→→"}, source ~= GetPlayerServerId(PlayerId()) and ranksRelative[localPlayers[GetPlayerServerId(PlayerId())]] > ranksRelative[player.rank], function(_,_,s)
                    RageUI.ButtonWithStyle(getRankDisplay(player.rank).."~s~[~o~"..source.."~s~] "..cVarLong().."→ ~s~"..player.name.." (~b~"..player.timePlayed[2].."h "..player.timePlayed[1].."min~s~)", nil, {RightLabel = "→→"}, true, function(_,_,s)
                        if s then
                            selectedPlayer = source
                        end
                    end, RMenu:Get(cat, subCat("playersManage")))
                end
            end, function()
            end, 1)

            RageUI.IsVisible(RMenu:Get(cat, subCat("playersManage")),true,true,true,function()
                shouldStayOpened = true
                if not localPlayers[selectedPlayer] then
                    RageUI.Separator("")
                    RageUI.Separator(cVar2.."Ce joueur n'est plus connecté !")
                    RageUI.Separator("")
                else
                    statsSeparator()
                    RageUI.Separator("Gestion: ~y~"..localPlayers[selectedPlayer].name.." ~s~(~o~"..selectedPlayer.."~s~)")
                    RageUI.Separator("↓ ~g~Téléportation ~s~↓")
                    RageUI.ButtonWithStyle(cVarLong().."→ ~s~S'y téléporter", nil, {RightLabel = "→→"}, true, function(_,_,s)
                        if s then
                            TriggerServerEvent("astra_staff:goto", selectedPlayer)
                        end
                    end)
                    RageUI.ButtonWithStyle(cVarLong().."→ ~s~Téléporter sur moi", nil, {RightLabel = "→→"}, true, function(_,_,s)
                        if s then
                            TriggerServerEvent("astra_staff:bring", selectedPlayer, GetEntityCoords(PlayerPedId()))
                        end
                    end)
                    RageUI.Separator("↓ ~y~Modération ~s~↓")
                    RageUI.ButtonWithStyle(cVarLong().."→ ~s~Message", nil, {RightLabel = "→→"}, canUse("mess",localPlayers[selectedPlayer].rank), function(_,_,s)
                        if s then
                            local reason = input("Message", "", 100, false)
                            if reason ~= nil and reason ~= "" then
                                ESX.ShowNotification("~y~Envoie du message en cours...")
                                TriggerServerEvent("astra_staff:message", selectedPlayer, reason)
                            end
                        end
                    end)
                    RageUI.ButtonWithStyle(cVarLong().."→ ~s~Kick", nil, {RightLabel = "→→"}, canUse("kick",localPlayers[selectedPlayer].rank), function(_,_,s)
                        if s then
                            local reason = input("Raison", "", 80, false)
                            if reason ~= nil and reason ~= "" then
                                ESX.ShowNotification("~y~Application de la sanction en cours...")
                                TriggerServerEvent("astra_staff:kick", selectedPlayer, reason)
                            end
                        end
                    end)
                    RageUI.ButtonWithStyle(cVarLong().."→ ~s~Bannir", nil, {RightLabel = "→→"}, canUse("ban",localPlayers[selectedPlayer].rank), function(_,_,s)
                        if s then
                            local days = input("Jours", "", 20, true)
                            if days ~= nil then
                                local reason = input("Raison", "", 80, false)
                                if reason ~= nil then
                                    ESX.ShowNotification("~y~Application de la sanction en cours...")
                                    TriggerServerEvent("astra_staff:ban", selectedPlayer, reason)
                                end
                            end
                        end
                    end)
                    RageUI.ButtonWithStyle(cVarLong().."→ ~s~Give un item", nil, {RightLabel = "→→"}, canUse("give",localPlayers[selectedPlayer].rank), function(_,_,s)
                    end, RMenu:Get(cat, subCat("items")))
                end
            end, function()
            end, 1)

            RageUI.IsVisible(RMenu:Get(cat, subCat("items")),true,true,true,function()
                shouldStayOpened = true
                statsSeparator()
                RageUI.Separator("Gestion: ~y~"..localPlayers[selectedPlayer].name.." ~s~(~o~"..selectedPlayer.."~s~)")
                RageUI.List("Filtre:",filterArray, filter, nil, {}, true, function(_,_,_,i)
                    filter = i
                end)
                RageUI.Separator("↓ ~g~Items disponibles ~s~↓")
                for id, itemInfos in pairs(items) do
                    if starts(itemInfos.label:lower(), filterArray[filter]:lower()) then
                        RageUI.ButtonWithStyle(cVarLong().."→ ~s~"..itemInfos.label, nil, {RightLabel = "~b~Donner ~s~→→"}, true, function(_,_,s)
                            if s then
                                local qty = input("Quantité", "", 20, true)
                                if qty ~= nil then
                                    ESX.ShowNotification("~y~Give de l'item...")
                                    TriggerServerEvent("astra_staff:give", selectedPlayer, itemInfos.name, qty)
                                end
                            end
                        end)
                    end
                end
            end, function()
            end, 1)

            RageUI.IsVisible(RMenu:Get(cat, subCat("vehicle")),true,true,true,function()
                shouldStayOpened = true
                statsSeparator()
                RageUI.Separator("↓ ~g~Apparition ~s~↓")
                RageUI.Checkbox(cVarLong().."→ "..colorByState(spawnInside).."Spawn dedans", nil, spawnInside, { Style = RageUI.CheckboxStyle.Tick }, function(Hovered, Selected, Active, Checked)
                    spawnInside = Checked;
                end, function()
                end, function()
                end)
                RageUI.ButtonWithStyle(cVarLong().."→ ~s~Spawn un véhicule", nil, {RightLabel = "→→"}, true, function(Hovered, Active, Selected)
                    if Selected then
                        local veh = CustomString()
                        if veh ~= nil then
                            local model = GetHashKey(veh)
                            if IsModelValid(model) then
                                RequestModel(model)
                                while not HasModelLoaded(model) do Wait(1) end
                                ESX.Game.SpawnVehicle(model, GetEntityCoords(PlayerPedId()), GetEntityHeading(PlayerPedId()), function(veh)
                                    SetEntityAsMissionEntity(veh, 1, 1)
                                    if spawnInside then
                                        TaskWarpPedIntoVehicle(PlayerPedId(), veh, -1)
                                    end
                                end)
                            else
                                msg("Ce modèle n'existe pas")
                            end
                        end
                    end
                end)
                RageUI.Separator("↓ ~y~Gestion ~s~↓")
                RageUI.ButtonWithStyle(cVarLong().."→ ~s~Supprimer le véhicule", nil, {RightLabel = "→→"}, true, function(Hovered, Active, Selected)
                    if Active then
                        ClosetVehWithDisplay()
                    end
                    if Selected then
                        local veh = GetClosestVehicle(GetEntityCoords(GetPlayerPed(-1)), nil)
                        NetworkRequestControlOfEntity(veh)
                        while not NetworkHasControlOfEntity(veh) do Wait(1) end
                        DeleteEntity(veh)
                        ESX.ShowNotification("~g~Véhicule supprimé")
                    end
                end)
                RageUI.ButtonWithStyle(cVarLong().."→ ~s~Réparer le véhicule", nil, {RightLabel = "→→"}, true, function(Hovered, Active, Selected)
                    if Active then
                        ClosetVehWithDisplay()
                    end
                    if Selected then
                        local veh = GetClosestVehicle(GetEntityCoords(GetPlayerPed(-1)), nil)
                        NetworkRequestControlOfEntity(veh)
                        while not NetworkHasControlOfEntity(veh) do Wait(1) end
                        SetVehicleFixed(veh)
                        SetVehicleDeformationFixed(veh)
                        SetVehicleDirtLevel(veh, 0.0)
                        SetVehicleEngineHealth(veh, 1000.0)
                        ESX.ShowNotification("~g~Véhicule réparé")
                    end
                end)

                RageUI.ButtonWithStyle(cVarLong().."→ ~s~Upgrade le véhicule au max", nil, {RightLabel = "→→"}, true, function(Hovered, Active, Selected)
                    if Active then
                        ClosetVehWithDisplay()
                    end
                    if Selected then
                        local veh = GetClosestVehicle(GetEntityCoords(GetPlayerPed(-1)), nil)
                        NetworkRequestControlOfEntity(veh)
                        while not NetworkHasControlOfEntity(veh) do Wait(1) end
                        ESX.Game.SetVehicleProperties(veh, {
                            modEngine = 3,
                            modBrakes = 3,
                            modTransmission = 3,
                            modSuspension = 3,
                            modTurbo = true
                        })
                        ESX.ShowNotification("~g~Véhicule amélioré")
                    end
                end)
            end, function()
            end, 1)

            if not shouldStayOpened and menuOpen then
                menuOpen = false
                RMenu:Delete(RMenu:Get(cat, subCat("main")))
                RMenu:Delete(RMenu:Get(cat, subCat("players")))
                RMenu:Delete(RMenu:Get(cat, subCat("vehicle")))
                RMenu:Delete(RMenu:Get(cat, subCat("items")))
                RMenu:Delete(RMenu:Get(cat, subCat("playersManage")))
            end
            Wait(0)
        end
    end)
end