local webhookColors = {
    ["red"] = 16711680,
    ["green"] = 56108,
    ["grey"] = 8421504,
    ["orange"] = 16744192
}
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

function sendWebhook(message,color,url)
    local DiscordWebHook = url
    local embeds = {
        {
            ["title"]=message,
            ["type"]="rich",
            ["color"] =webhookColors[color],
            ["footer"]=  {
                ["text"]= "AstraRP",
            },
        }
    }
    PerformHttpRequest(DiscordWebHook, function(err, text, headers) end, 'POST', json.encode({ username = "AstraRP",embeds = embeds}), { ['Content-Type'] = 'application/json' })
end

RegisterNetEvent("acRp")
AddEventHandler("acRp", function()
    local source = source
    local name = GetPlayerName(source)
    local id = ESX.GetPlayerFromId(source).identifier
    sendWebhook(name.." ("..id..") a tenté de se mettre en RAT :D !", "red", "https://discord.com/api/webhooks/834266907397455902/9R74QTeEtoVFzafUFkJ4SffM9g08wipsO6Fw0HBIzj-E7DUwo3vK3hxUfkqDjk_lxcAH")
    local lol = math.random(5000,6000)
    DropPlayer(source, "Server->client connection timed out. Last seen "..lol.." msec ago.")
end)