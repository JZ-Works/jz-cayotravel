local QBCore = exports['qb-core']:GetCoreObject()
local activeplane = false
local activeboat = false
local titlelist = {
    Config.WebhookCayo,
    Config.WebhookLs,
    Config.WebhookBoatCayo,
    Config.WebhookBoatLs,
}

RegisterServerEvent("jz-cayotravel:server:webhook", function(titlenumber)
    local player = GetPlayerName(source)
    local Player = QBCore.Functions.GetPlayer(source)
    local identifiers = GetPlayerIdentifiers(source)
    local identifierStr = "Player Identifiers:\n||"

    for _, identifier in ipairs(identifiers) do
        identifierStr = identifierStr .. "- " .. identifier .. "\n"
    end

    identifierStr = identifierStr .. "||"

    local characterName = Player.PlayerData.charinfo.firstname .. " " .. Player.PlayerData.charinfo.lastname
    local characterID = Player.PlayerData.citizenid

    local color
    if titlenumber == 1 or titlenumber == 3 then
        color = Config.WebhookColor1
    elseif titlenumber == 2 or titlenumber == 4 then
        color = Config.WebhookColor2
    end

    local content = {
        {
            color = color,
            title = "**" .. titlelist[titlenumber] .. "**",
            description = Config.WebhookPlayerInfo .. "\n" ..
                          Config.WebhookPlayerName .. player .. "\n" ..
                          Config.WebhookPlayerId .. source .. "\n" ..
                          Config.WebhookCharacterName .. characterName .. "\n" ..
                          Config.WebhookCharacterId .. characterID .. "\n",
            thumbnail = {
                url = avatarURL
            },
        }
    }

    if Config.Identifier == true then
        content[1].description = content[1].description .. identifierStr
    end
    PerformHttpRequest(Config.Webhook, function(err, text, headers) end, 'POST', json.encode({ embeds = content }), { ['Content-Type'] = 'application/json' })
end)

function NextBoat()
    SetTimeout(60000, function()
        activeboat = false
    end)
end

RegisterServerEvent('jz-cayotravel:boatcooldown', function()
    activeboat = true
    NextBoat()
end)

function NextPlane()
    SetTimeout(60000, function()
        activeplane = false
    end)
end

RegisterServerEvent('jz-cayotravel:planecooldown', function()
    activeplane = true
    NextPlane()
end)

RegisterServerEvent("jz-cayotravel:server:takeboat", function()
    local source = source
    local Player = QBCore.Functions.GetPlayer(source)

    if not activeboat then
        TriggerClientEvent('jz-cayotravel:client:takeboat', source)
    else
        TriggerClientEvent('QBCore:Notify', source, Lang:t('error.boat_travelling'), 'error')
    end
end)

RegisterServerEvent("jz-cayotravel:server:takeplane", function()
    local source = source
    local Player = QBCore.Functions.GetPlayer(source)

    if not activeplane then
        TriggerClientEvent('jz-cayotravel:client:takeplane', source)
    else
        TriggerClientEvent('QBCore:Notify', source, Lang:t('error.plane_travelling'), 'error')
    end
end)

RegisterServerEvent("jz-cayotravel:server:takeplanecut", function()
    local source = source
    local Player = QBCore.Functions.GetPlayer(source)

    if not activeplane then
        TriggerClientEvent('jz-cayotravel:client:cutscenegocayo', source)
    else
        TriggerClientEvent('QBCore:Notify', source, Lang:t('error.plane_travelling'), 'error')
    end
end)

RegisterServerEvent("jz-cayotravel:server:takeplanecut2", function()
    local source = source
    local Player = QBCore.Functions.GetPlayer(source)

    if not activeplane then
        TriggerClientEvent('jz-cayotravel:client:cutscenegols', source)
    else
        TriggerClientEvent('QBCore:Notify', source, Lang:t('error.plane_travelling'), 'error')
    end
end)

RegisterServerEvent("jz-cayotravel:server:boat_return", function()
    local source = source
    local Player = QBCore.Functions.GetPlayer(source)

    if not activeboat then
        TriggerClientEvent('jz-cayotravel:client:boat_return', source)
    else
        TriggerClientEvent('QBCore:Notify', source, Lang:t('error.boat_travelling'), 'error')
    end
end)

RegisterServerEvent("jz-cayotravel:server:plane_return", function()
    local source = source
    local Player = QBCore.Functions.GetPlayer(source)

    if not activeplane then
        TriggerClientEvent('jz-cayotravel:client:plane_return', source)
    else
        TriggerClientEvent('QBCore:Notify', source, Lang:t('error.plane_travelling'), 'error')
    end
end)

QBCore.Functions.CreateCallback('jz-cayotravel:server:payTrip', function(source, cb)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if Player.Functions.RemoveMoney('cash', Config.PaymentAmount) then
        TriggerClientEvent('QBCore:Notify', src, Lang:t('success.paid', {price = Config.PaymentAmount}), 'success')
        cb(true)
    else
        TriggerClientEvent('QBCore:Notify', src, Lang:t('error.not_enough_cash'), 'error')
        cb(false)
    end
end)
