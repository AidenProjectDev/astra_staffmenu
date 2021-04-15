reportsTable = {}

local function updateReportsForStaff()
    for k,player in pairs(players) do
        if player.rank ~= "user" then
            TriggerClientEvent("astra_staff:cbReportTable", k, reportsTable)
        end
    end
end

RegisterCommand("report", function(source, args)
    if source == 0 then return end
    if reportsTable[source] ~= nil then
        TriggerClientEvent("::{korioz#0110}::esx:showNotification", source, "~r~Vous avez déjà un report actif.")
        return
    end
    reportsTable[source] = {id = source, reason = table.concat(args, " "), taken = false, createdAt = os.date('%c')}
    for k,player in pairs(players) do
        if player.rank ~= "user" then
            if inService[k] ~= nil then
                TriggerClientEvent("::{korioz#0110}::esx:showNotification", k, "~r~[Report] ~s~Un nouveau report a été reçu par l'ID ~y~"..source.." ~s~!")
            end
            --TriggerClientEvent('chatMessage', k, "[REPORT]", {255, 0, 0}, (" Report reçu (^2%s^7)"):format(table.concat(args, " ")))
        end
    end
    updateReportsForStaff()
end, false)

-- TODO -> faire un reminder si beaucoup de reports non traités