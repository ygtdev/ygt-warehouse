local QBCore = exports['qb-core']:GetCoreObject()

RegisterServerEvent('ygt-warehouse:server:RemoveWarehouse', function(data)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)

    exports.oxmysql:execute('DELETE FROM warehouse WHERE citizenid = ? AND location = ? AND name = ? AND id = ?',{Player.PlayerData.citizenid, data.location, data.name, data.id})
    TriggerClientEvent('QBCore:Notify', src, Config.Languages[Config.Language]['remove_warehouse'], 'error')
end)

QBCore.Functions.CreateCallback('ygt-warehouse:server:BuyWarehouse', function(source, cb, data)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)

    if data.money >= Config.Locations[data.location]['price'] then
        Player.Functions.RemoveMoney('bank', Config.Locations[data.location]['price'])
        exports.oxmysql:insert('INSERT INTO warehouse (`location`, `name`, `password`, `citizenid`) VALUES (?, ?, ?, ?)', {data.location, data.name, data.password, Player.PlayerData.citizenid})
        cb(true)
    else
        cb(false)
    end
end)

QBCore.Functions.CreateCallback('ygt-warehouse:server:GetWarehouse', function(source, cb, location)
    local src = source

    exports.oxmysql:execute('SELECT * FROM warehouse WHERE location = ?', {location}, function(result)
        if result[1] then
            cb(result)
        else
            cb(nil)
        end
    end)
end)

QBCore.Functions.CreateCallback('ygt-warehouse:server:GetWarehouseCitizenId', function(source, cb, location)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)

    exports.oxmysql:execute('SELECT * FROM warehouse WHERE location = ? AND citizenid = ?', {location, Player.PlayerData.citizenid}, function(result)
        if result[1] then
            cb(result)
        else
            cb(nil)
        end
    end)
end)