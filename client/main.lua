local QBCore = exports['qb-core']:GetCoreObject()

RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
    PlayerData = QBCore.Functions.GetPlayerData()
end)

RegisterNetEvent('QBCore:Client:OnJobUpdate', function(JobInfo)
    PlayerData.job = JobInfo
end)

RegisterNetEvent('ygt-warehouse:client:OpenMenu', function(warehouse)
    QBCore.Functions.TriggerCallback('ygt-warehouse:server:GetWarehouseCitizenId', function(result)
        if result == nil then
            exports['qb-menu']:openMenu({
                {
                    header = Config.Locations[warehouse]['label'],
                    isMenuHeader = true,
                },
                {
                    header = 'Depo Satın Al',
                    txt = 'Bir depo satın al.',
                    params = {
                        event = 'ygt-warehouse:client:BuyWarehouse',
                        args = {
                            warehouse = warehouse,
                        }
                    }
                },
                {
                    header = 'Depolar',
                    txt = 'Depo listesini görüntüle.',
                    params = {
                        event = 'ygt-warehouse:client:OpenWarehouseList',
                        args = {
                            warehouse = warehouse,
                        }
                    }
                },
            })
        else
            exports['qb-menu']:openMenu({
                {
                    header = Config.Locations[warehouse]['label'],
                    isMenuHeader = true,
                },
                {
                    header = 'Depolarım',
                    txt = 'Sana ait olan depoları görüntüle.',
                    params = {
                        event = 'ygt-warehouse:client:MyWarehouseList',
                        args = {
                            warehouse = warehouse,
                        }
                    }
                },
                {
                    header = 'Depolar',
                    txt = 'Depo listesini görüntüle.',
                    params = {
                        event = 'ygt-warehouse:client:OpenWarehouseList',
                        args = {
                            warehouse = warehouse,
                        }
                    }
                },
            })
        end
    end, warehouse)
end)

RegisterNetEvent('ygt-warehouse:client:BuyWarehouse', function(data)
    local warehouse = data.warehouse

    local keyboard, name, password = exports['nh-keyboard']:Keyboard({
        header = 'Depo Satın Al ($'..Config.Locations[warehouse]['price']..')',
        rows = {'İsim', 'Şifre (Sadece Sayı)'}
    })

    if keyboard then
        if name and tonumber(password) then
            QBCore.Functions.TriggerCallback('ygt-warehouse:server:BuyWarehouse', function(cb)
                if cb then
                    TriggerServerEvent('qb-phone:server:sendNewMail', {
                        sender = 'Depolar',
                        subject = 'Depo Satın Alma İşlemi',
                        message = 'Depo Adı: '..name..' | Depo Şifresi: '..password..' | Depo Konumu: '..warehouse
                    })
                    QBCore.Functions.Notify('Depo satın alındı.', 'success')
                else
                    QBCore.Functions.Notify('Depo almak için banka hesabında $'..Config.Locations[warehouse]['price']..' yok.', 'error')
                end
            end, {
                location = warehouse,
                name = name,
                password = password,
                money = QBCore.Functions.GetPlayerData().money['bank'],
            })
        end
    end
end)

RegisterNetEvent('ygt-warehouse:client:OpenWarehouseList', function(data)
    local data = data.warehouse
    QBCore.Functions.TriggerCallback('ygt-warehouse:server:GetWarehouse', function(result)
        if result == nil then
            QBCore.Functions.Notify('Bu konumda hiç depo bulunmuyor.', 'error')
        else
            local menu = {
                {
                    header = 'Depo Listesi',
                    isMenuHeader = false
                },
            }

            for k, v in pairs(result) do
                menu[#menu+1] = {
                    header = v.name,
                    txt = v.citizenid,
                    params = {
                        event = 'ygt-warehouse:client:OpenWarehouse',
                        args = {
                            v = v,
                        }
                    }
                }
            end
            exports['qb-menu']:openMenu(menu)
        end
    end, data)
end)

RegisterNetEvent('ygt-warehouse:client:MyWarehouseList', function(data)
    local data = data.warehouse
    QBCore.Functions.TriggerCallback('ygt-warehouse:server:GetWarehouseCitizenId', function(result)
        if result == nil then
            QBCore.Functions.Notify('Bu konumda hiç depon bulunmuyor.', 'error')
        else
            local menu = {
                {
                    header = 'Depoların',
                    isMenuHeader = false
                },
            }

            for k, v in pairs(result) do
                menu[#menu+1] = {
                    header = v.name,
                    txt = v.citizenid,
                    params = {
                        event = 'ygt-warehouse:client:MyWarehouse',
                        args = {
                            warehouse = v,
                        }
                    }
                }
            end
            exports['qb-menu']:openMenu(menu)
        end
    end, data)
end)

RegisterNetEvent('ygt-warehouse:client:MyWarehouse', function(data)
    local data = data.warehouse

    exports['qb-menu']:openMenu({
        {
            header = data.name,
            isMenuHeader = false,
        },
        {
            header = 'Depoyu Görüntüle',
            txt = 'Depoyu aç.',
            params = {
                event = 'ygt-warehouse:client:OpenWarehouse',
                args = {
                    v = data,
                }
            }
        },
        {
            header = 'Depoyu Sil',
            txt = 'Depoyu kalıcı olarak sil.',
            params = {
                event = 'ygt-warehouse:client:RemoveWarehouse',
                args = {
                    v = data,
                }
            }
        },
    })
end)

RegisterNetEvent('ygt-warehouse:client:OpenWarehouse', function(data)
    local v = data.v

    local keyboard, password = exports['nh-keyboard']:Keyboard({
        header = v.name,
        rows = {'Şifre (Sadece Sayı)'}
    })

    if keyboard then
        if tonumber(password)then
            if password == v.password then
                TriggerServerEvent('inventory:server:OpenInventory', 'stash', 'Warehouse_'..v.location..'_'..v.name..'_'..v.citizenid)
                TriggerEvent('inventory:client:SetCurrentStash', 'Warehouse_'..v.location..'_'..v.name..'_'..v.citizenid)
            else
                QBCore.Functions.Notify('Girdiğiniz şifre depo şifresi ile uyuşmuyor.', 'error')
            end
        end
    end
end)

RegisterNetEvent('ygt-warehouse:client:RemoveWarehouse', function(data)
    local v = data.v

    local keyboard, password = exports['nh-keyboard']:Keyboard({
        header = v.name,
        rows = {'Şifre (Sadece Sayı)'}
    })

    if keyboard then
        if tonumber(password)then
            if password == v.password then
                TriggerServerEvent('ygt-warehouse:server:RemoveWarehouse', v)
            else
                QBCore.Functions.Notify('Girdiğiniz şifre depo şifresi ile uyuşmuyor.', 'error')
            end
        end
    end
end)

CreateThread(function()
    while true do
        local InRange = false
        local ped = PlayerPedId()
        local pos = GetEntityCoords(ped)

        for warehouse, _ in pairs(Config.Locations) do
            local dist = #(pos - vector3(Config.Locations[warehouse]['coords']['x'], Config.Locations[warehouse]['coords']['y'], Config.Locations[warehouse]['coords']['z']))
            if dist < 10 then
                InRange = true
                DrawMarker(2, Config.Locations[warehouse]['coords']['x'], Config.Locations[warehouse]['coords']['y'], Config.Locations[warehouse]['coords']['z'], 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.25, 0.2, 0.1, 255, 255, 255, 155, 0, 0, 0, 1, 0, 0, 0)
                if dist < 2 then
                    QBCore.Functions.DrawText3D(Config.Locations[warehouse]['coords']['x'], Config.Locations[warehouse]['coords']['y'], Config.Locations[warehouse]['coords']['z'] + 0.2, '[E] '..Config.Locations[warehouse]['label'])
                    if IsControlJustPressed(0, 38) then -- E
                        TriggerEvent('ygt-warehouse:client:OpenMenu', warehouse)
                    end
                end
            end
        end

        if not InRange then
            Wait(5000)
        end
        Wait(5)
    end
end)

CreateThread(function()
    for warehouse, _ in pairs(Config.Locations) do
        if Config.Locations[warehouse]['blip'] then
            blip = AddBlipForCoord(Config.Locations[warehouse]['coords']['x'], Config.Locations[warehouse]['coords']['y'], Config.Locations[warehouse]['coords']['z'])
            SetBlipColour(blip, 0)
            SetBlipSprite(blip, 355)
            SetBlipScale(blip, 0.6)
            SetBlipDisplay(blip, 4)
            SetBlipAsShortRange(blip, true)
            BeginTextCommandSetBlipName('STRING')
            AddTextComponentSubstringPlayerName(Config.Locations[warehouse]['label'])
            EndTextCommandSetBlipName(blip)
        end
    end
end)