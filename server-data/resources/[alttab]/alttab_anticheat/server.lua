-- security
RegisterServerEvent('alttab:anticheat')
AddEventHandler('alttab:anticheat', function(playerName, type)
  MySQL.Async.execute('INSERT INTO cheaters (identifier, type) VALUES (@identifier, @type)', {
    ['@identifier']		= playerName,
    ['@type']		= type
  })
end)