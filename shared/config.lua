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
        onTeleport = "https://discord.com/api/webhooks/843425120134496256/BlYMiBfCQfzM69Is-agtRNUbqOGkiQVi-moz75UtScHWTd-m7QMNYM51I2U7MIeHO9zK",
        onBan = "https://discord.com/api/webhooks/843425120134496256/BlYMiBfCQfzM69Is-agtRNUbqOGkiQVi-moz75UtScHWTd-m7QMNYM51I2U7MIeHO9zK",
        onKick = "hhttps://discord.com/api/webhooks/843425120134496256/BlYMiBfCQfzM69Is-agtRNUbqOGkiQVi-moz75UtScHWTd-m7QMNYM51I2U7MIeHO9zK",
        onMessage = "https://discord.com/api/webhooks/843425120134496256/BlYMiBfCQfzM69Is-agtRNUbqOGkiQVi-moz75UtScHWTd-m7QMNYM51I2U7MIeHO9zK",
        onMoneyGive = "https://discord.com/api/webhooks/843425120134496256/BlYMiBfCQfzM69Is-agtRNUbqOGkiQVi-moz75UtScHWTd-m7QMNYM51I2U7MIeHO9zK",
        onItemGive = "https://discord.com/api/webhooks/843425120134496256/BlYMiBfCQfzM69Is-agtRNUbqOGkiQVi-moz75UtScHWTd-m7QMNYM51I2U7MIeHO9zK",
        onClear = "https://discord.com/api/webhooks/843425120134496256/BlYMiBfCQfzM69Is-agtRNUbqOGkiQVi-moz75UtScHWTd-m7QMNYM51I2U7MIeHO9zK",
        onGroupChange = "https://discord.com/api/webhooks/843425120134496256/BlYMiBfCQfzM69Is-agtRNUbqOGkiQVi-moz75UtScHWTd-m7QMNYM51I2U7MIeHO9zK",
        onRevive = "https://discord.com/api/webhooks/843425120134496256/BlYMiBfCQfzM69Is-agtRNUbqOGkiQVi-moz75UtScHWTd-m7QMNYM51I2U7MIeHO9zK",
        onHeal = "https://discord.com/api/webhooks/843425120134496256/BlYMiBfCQfzM69Is-agtRNUbqOGkiQVi-moz75UtScHWTd-m7QMNYM51I2U7MIeHO9zK"
    }
}