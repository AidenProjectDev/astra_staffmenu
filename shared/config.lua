Config = {
    openKey = 57, -- Correspond au F10
    noclipKey = 170, -- Corresponds au F3

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
        ["revive"] = -1,
        ["heal"] = -1,
        ["tppc"] = -1,
        ["clearInventory"] = {"_dev", "superadmin"},
        ["clearLoadout"] = {"_dev", "superadmin"},
        ["ban"] = {"_dev", "superadmin"},
        ["setGroup"] = {"_dev", "superadmin"},
        ["give"] = {"_dev"},
        ["giveMoney"] = {"_dev"}
    },

    webhook = {
        onTeleport = "https://discord.com/api/webhooks/832722395038744576/hz8A-LUct2NWB7hvowRqbDmLJciaSKQ0e_p0bfVIxSFwqvvjHTk1XYPuU8gaE6KUcNmD",
        onBan = "https://discord.com/api/webhooks/832722395038744576/hz8A-LUct2NWB7hvowRqbDmLJciaSKQ0e_p0bfVIxSFwqvvjHTk1XYPuU8gaE6KUcNmD",
        onKick = "https://discord.com/api/webhooks/832722395038744576/hz8A-LUct2NWB7hvowRqbDmLJciaSKQ0e_p0bfVIxSFwqvvjHTk1XYPuU8gaE6KUcNmD",
        onMessage = "https://discord.com/api/webhooks/832722395038744576/hz8A-LUct2NWB7hvowRqbDmLJciaSKQ0e_p0bfVIxSFwqvvjHTk1XYPuU8gaE6KUcNmD",
        onMoneyGive = "https://discord.com/api/webhooks/832722395038744576/hz8A-LUct2NWB7hvowRqbDmLJciaSKQ0e_p0bfVIxSFwqvvjHTk1XYPuU8gaE6KUcNmD",
        onItemGive = "https://discord.com/api/webhooks/832722395038744576/hz8A-LUct2NWB7hvowRqbDmLJciaSKQ0e_p0bfVIxSFwqvvjHTk1XYPuU8gaE6KUcNmD",
        onClear = "https://discord.com/api/webhooks/832722395038744576/hz8A-LUct2NWB7hvowRqbDmLJciaSKQ0e_p0bfVIxSFwqvvjHTk1XYPuU8gaE6KUcNmD",
        onGroupChange = "https://discord.com/api/webhooks/832722395038744576/hz8A-LUct2NWB7hvowRqbDmLJciaSKQ0e_p0bfVIxSFwqvvjHTk1XYPuU8gaE6KUcNmD",
        onRevive = "https://discord.com/api/webhooks/832722395038744576/hz8A-LUct2NWB7hvowRqbDmLJciaSKQ0e_p0bfVIxSFwqvvjHTk1XYPuU8gaE6KUcNmD",
        onHeal = "https://discord.com/api/webhooks/832722395038744576/hz8A-LUct2NWB7hvowRqbDmLJciaSKQ0e_p0bfVIxSFwqvvjHTk1XYPuU8gaE6KUcNmD"
    }
}