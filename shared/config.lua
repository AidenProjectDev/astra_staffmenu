Config = {
    openKey = 57, -- Correspond au F10

    --[[
        -1  ->  Tous les groupes (sauf user)
    --]]
    authorizations = {
        ["vehicles"] = -1,
        ["kick"] = -1,
        ["mess"] = -1,
        ["jail"] = -1,
        ["unjail"] = -1,
        ["teleport"] = -1,
        ["ban"] = {"_dev", "superadmin"},
        ["give"] = {"_dev"}
    },

    webhook = {
        onTeleport = "https://discord.com/api/webhooks/832189755608530975/wy7JJUC19eUwHeQRGEgam1klq7_dmEV3TqN5WNPaR_36FofmmlmYDAsF-g79cqIq6eEd",
        onVehicleAction = "https://discord.com/api/webhooks/832189755608530975/wy7JJUC19eUwHeQRGEgam1klq7_dmEV3TqN5WNPaR_36FofmmlmYDAsF-g79cqIq6eEd",
        onBan = "https://discord.com/api/webhooks/832189755608530975/wy7JJUC19eUwHeQRGEgam1klq7_dmEV3TqN5WNPaR_36FofmmlmYDAsF-g79cqIq6eEd",
        onKick = "https://discord.com/api/webhooks/832189755608530975/wy7JJUC19eUwHeQRGEgam1klq7_dmEV3TqN5WNPaR_36FofmmlmYDAsF-g79cqIq6eEd",
        onWarn = "https://discord.com/api/webhooks/832189755608530975/wy7JJUC19eUwHeQRGEgam1klq7_dmEV3TqN5WNPaR_36FofmmlmYDAsF-g79cqIq6eEd",
        onItemGive = "https://discord.com/api/webhooks/832189755608530975/wy7JJUC19eUwHeQRGEgam1klq7_dmEV3TqN5WNPaR_36FofmmlmYDAsF-g79cqIq6eEd",
    }
}