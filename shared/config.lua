Config = {
    openKey = 57, -- Correspond au F10

    --[[
        -1  ->  Tous les groupes (sauf user)
    --]]
    authorizations = {
        ["vehicles"] = -1,
        ["kick"] = -1,
        ["warn"] = -1,
        ["jail"] = -1,
        ["unjail"] = -1,
        ["ban"] = {"_dev", "superadmin"},
        ["give"] = {"_dev"}
    },

    webhook = {
        onTeleport = "",
        onVehicleAction = "",
        onBan = "",
        onKick = "",
        onWarn = "",
        onItemGive = "",
    }
}