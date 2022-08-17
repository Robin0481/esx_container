ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterNetEvent('Rb_vuilnisbak:dropItem', function(item, amount)
    local xPlayer = ESX.GetPlayerFromId(source)
    xPlayer.addInventoryItem(item, amount)
    TriggerEvent('esx-log:server:CreateLog', 'Container', 'Container doorzoeken', 'lightgreen', "\n Speler: **" .. xPlayer.getName() .. "** \n License: **" .. xPlayer.getIdentifier() .. "** \n Item ontvangen: **" .. item .. "** \n Aantal: **" .. amount .. "**") 
end)

local Webhooks = {
    ['Container'] = '', -- Eigen webhook hier neerzetten
}

local Colors = { -- https://www.spycolor.com/
    ['default'] = 14423100,
    ['blue'] = 255,
    ['red'] = 16711680,
    ['green'] = 65280,
    ['white'] = 16777215,
    ['black'] = 0,
    ['orange'] = 16744192,
    ['yellow'] = 16776960,
    ['pink'] = 16761035,
    ["lightgreen"] = 65309,
}

RegisterNetEvent('esx-log:server:CreateLog', function(name, title, color, message, tagEveryone)
    local tag = tagEveryone or false
    local webHook = Webhooks[name] or Webhooks['default']
    local embedData = {
        {
            ['title'] = title,
            ['color'] = Colors[color] or Colors['default'],
            ['footer'] = {
                ['text'] = os.date('%c'),
            },
            ['description'] = message,
            ['author'] = {
                ['name'] = 'Aanpassen',
                ['icon_url'] = '', -- Zet hier je eigen link
            },
        }
    }
    PerformHttpRequest(webHook, function() end, 'POST', json.encode({ username = 'Robin Logs', embeds = embedData}), { ['Content-Type'] = 'application/json' })
    Citizen.Wait(100)
    if tag then
        PerformHttpRequest(webHook, function() end, 'POST', json.encode({ username = 'Robin Logs', content = '@everyone'}), { ['Content-Type'] = 'application/json' })
    end
end)