QBCore = nil
TriggerEvent('QBCore:GetObject', function(obj) QBCore = obj end)

RegisterServerEvent('cui_character:save')
AddEventHandler('cui_character:save', function(model, data)
    local _source = source
    local Player = QBCore.Functions.GetPlayer(_source)
    local citizenid = Player.PlayerData.citizenid

    if citizenid then
        exports.ghmattimysql:execute('SELECT `skin` FROM `playerskins` WHERE `citizenid` = "'..citizenid..'"', function(result)
            if result then
                exports.ghmattimysql:execute('UPDATE `playerskins` SET `skin` = @skin WHERE `citizenid` = "'..citizenid..'"', {['@skin'] = json.encode(data)})
            else
                exports.ghmattimysql:execute('INSERT INTO `playerskins` (`citizenid`, `skin`, `model`) VALUES (@citizenid, @skin, @model) ON DUPLICATE KEY UPDATE `skin` = @skin', {
                    ['@skin'] = json.encode(data),
                    ['@citizenid'] = citizenid,
                    ['@model'] = model
                })
            end
        end)
    end
end)

RegisterServerEvent('cui_character:requestPlayerData')
AddEventHandler('cui_character:requestPlayerData', function()
    local _source = source
    local Player = QBCore.Functions.GetPlayer(_source)
    local citizenid = Player.PlayerData.citizenid

    if citizenid then
        exports.ghmattimysql:execute('SELECT skin FROM playerskins WHERE citizenid = @citizenid', {
            ['@citizenid'] = citizenid
        }, function(users)
            local playerData = { skin = nil, newPlayer = true}
            if users and users[1] ~= nil and users[1].skin ~= nil then
                playerData.skin = json.decode(users[1].skin)
                playerData.newPlayer = false
            end
            TriggerClientEvent('cui_character:recievePlayerData', _source, playerData)
        end)
    end
end)