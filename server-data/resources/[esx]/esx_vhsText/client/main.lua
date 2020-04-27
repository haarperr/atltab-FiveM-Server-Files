local showJob = nil

Citizen.CreateThread(function()
  while ESX == nil do
    TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
    Citizen.Wait(10)
  end
  Citizen.Wait(1000)
  if PlayerData == nil or PlayerData.job == nil then
	  	PlayerData = ESX.GetPlayerData()
  end
end)


RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
  PlayerData = xPlayer
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
  PlayerData.job = job
end)

function formatTime(data)
	for i=1, #data do
		local v = data[i]
		if v <= 9 then
			data[i] = "0"..v
		end
	end
	return data
end

Citizen.CreateThread(function()
  while true do
		Citizen.Wait(5000)
		showJob = 'none'
		if (PlayerData ~= nil) and (PlayerData.job.name == 'police') then
			ESX.TriggerServerCallback('esx_vhsText:getName', function(name)
				rank = Config.Ranks[PlayerData.job.grade_name]
				if rank then
					showJob = rank .. ' ' .. name
				end
				SendNUIMessage({
					action  = 'changeJob',
					data = showJob
				})
			end)
		else
			SendNUIMessage({
				action  = 'changeJob',
				data = 'none'
			})
		end
	end
end)

Citizen.CreateThread(function()
  while true do
    if (PlayerData ~= nil) and (PlayerData.job.name == 'police') then
      hour = GetClockHours()
      minute = GetClockMinutes()
      month = GetClockMonth()
	  dayOfMonth = GetClockDayOfMonth() + 12
	  month = month - 7

	  minute, month, dayOfMonth, hour = table.unpack(formatTime({minute, month, dayOfMonth, hour}))
      local formatted = dayOfMonth ..'.'.. month .. '.2020' .. ' | ' .. hour .. ':' .. minute
      SendNUIMessage({
        action  = 'changeTime',
        data = formatted
      })
    end
    Citizen.Wait(1000)
  end
end)
