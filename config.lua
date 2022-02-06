Config = Config or {}

Config.Locations = {
    [1] = {
        ['label'] = 'Depolar',
        ['coords'] = vector3(169.99, -567.51, 43.87),
        ['price'] = 12000,
        ['blip'] = true,  
    },
    [2] = {
        ['label'] = 'Depolar',
        ['coords'] = vector3(1197.24, -3253.56, 7.1),
        ['price'] = 8000,
        ['blip'] = true,  
    }
}

Config.Language = 'tr'
Config.Languages = {
    ['tr'] = {
        -- server
        ['remove_warehouse'] = 'Depo kalıcı olarak silindi.',
        -- client
        ['warehouses'] = 'Depolar',
        ['warehouse_list'] = 'Depo listesini görüntüle.',
        ['buy_warehouse'] = 'Depo Satın Al',
        ['buy_a_warehouse'] = 'Bir depo satın al.',
        ['my_warehouse'] = 'Depolarım',
        ['my_warehouse_list'] = 'Sana ait olan depoları görüntüle.',
        ['name'] = 'İsim',
        ['password'] = 'Şifre (Sadece Sayı)',
        ['process_warehouse'] = 'Depo Satın Alma İşlemi',
        ['warehouse_name'] = 'Depo Adı',
        ['warehouse_password'] = 'Depo Şifresi',
        ['warehouse_location'] = 'Depo Konumu',
        ['success'] = 'Depo satın alındı.',
        ['none_warehouse'] = 'Bu konumda hiç depo bulunmuyor.',
        ['view_warehouse'] = 'Depoyu Görüntüle',
        ['delete_warehouse_button'] = 'Depoyu Sil',
        ['delete_warehouse'] = 'Depoyu kalıcı olarak sil.',
        ['password_error'] = 'Girdiğiniz şifre depo şifresi ile uyuşmuyor.'
    },
    ['en'] = {
        -- server
        ['remove_warehouse'] = 'Warehouse removed.',
        -- client
        ['warehouses'] = 'Warehouses',
        ['warehouse_list'] = 'Show warehouses list.',
        ['buy_warehouse'] = 'Buy Warehouses',
        ['buy_a_warehouse'] = 'Buy a warehouses.',
        ['my_warehouse'] = 'My Warehouse',
        ['my_warehouse_list'] = 'Show my warehouse list.',
        ['name'] = 'Name',
        ['password'] = 'Password',
        ['process_warehouse'] = 'Warehouse buying process',
        ['warehouse_name'] = 'Warehouse Name',
        ['warehouse_password'] = 'Warehouse Password',
        ['warehouse_location'] = 'Warehouse Location',
        ['success'] = 'Warehouse buyed succesfuly.',
        ['none_warehouse'] = 'There is no warehouse at this location.',
        ['view_warehouse'] = 'View Warehouse',
        ['delete_warehouse_button'] = 'Delete Warehouse',
        ['delete_warehouse'] = 'Delete Warehouse forever.',
        ['password_error'] = 'Password incorrect.'
    }
}