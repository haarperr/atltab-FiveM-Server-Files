local DynamicWeather = false -- set this to false if you don't want the weather to change automatically every 10 minutes.
local debugprint = false -- enable debug mode

-------------------- DON'T CHANGE THIS --------------------
AvailableWeatherTypes = {
	'EXTRASUNNY', 
	'CLEAR', 
	'NEUTRAL', 
	'SMOG', 
	'FOGGY', 
	'OVERCAST', 
	'CLOUDS', 
	'CLEARING', 
	'RAIN', 
	'THUNDER', 
	'SNOW', 
	'BLIZZARD', 
	'SNOWLIGHT', 
	'XMAS', 
	'HALLOWEEN',
}
CurrentWeather = "EXTRASUNNY"
-- CurrentWeather = "XMAS"
local baseTime = 0
local timeOffset = 0
local freezeTime = false
local blackout = false
local newWeatherTimer = 10

RegisterServerEvent('alttab_weather:requestSync')
AddEventHandler('alttab_weather:requestSync', function()
	TriggerClientEvent('alttab_weather:updateWeather', -1, CurrentWeather, blackout)
	TriggerClientEvent('alttab_weather:updateTime', -1, baseTime, timeOffset, freezeTime)
end)

RegisterServerEvent('alttab_weather:freeze_time')
AddEventHandler('alttab_weather:freeze_time', function(source)
	-- check for console user
	if source ~= 0 then
		freezeTime = not freezeTime
		if freezeTime then
			TriggerClientEvent('esx:showNotification', source, 'Time is now ~b~frozen~s~.')
		else
			TriggerClientEvent('esx:showNotification', source, 'Time is ~y~no longer frozen~s~.')
		end
	else
		freezeTime = not freezeTime
		if freezeTime then
			print("Time is now frozen.")
		else
			print("Time is no longer frozen.")
		end
	end
end)

RegisterServerEvent('alttab_weather:freeze_weather')
AddEventHandler('alttab_weather:freeze_weather', function(source)
	if source ~= 0 then
		DynamicWeather = not DynamicWeather
		if not DynamicWeather then
			TriggerClientEvent('esx:showNotification', source, 'Dynamic weather changes are now ~r~disabled~s~.')
		else
			TriggerClientEvent('esx:showNotification', source, 'Dynamic weather changes are now ~b~enabled~s~.')
		end
	else
		DynamicWeather = not DynamicWeather
		if not DynamicWeather then
			print("Weather is now frozen.")
		else
			print("Weather is no longer frozen.")
		end
	end
end)

TriggerEvent('es:addGroupCommand', 'weather', 'admin', function(source, args, user)
	if source == 0 then
		local validWeatherType = false
		if args[1] == nil then
			print("Invalid syntax, correct syntax is: /weather <weathertype> ")
			return
		else
			for i,wtype in ipairs(AvailableWeatherTypes) do
				if wtype == string.upper(args[1]) then
					validWeatherType = true
					break
				end
			end
			if validWeatherType then
				print("Weather has been updated.")
				CurrentWeather = string.upper(args[1])
				newWeatherTimer = 10
				TriggerEvent('alttab_weather:requestSync')
			else
				print("Invalid weather type, valid weather types are: \nEXTRASUNNY CLEAR NEUTRAL SMOG FOGGY OVERCAST CLOUDS CLEARING RAIN THUNDER SNOW BLIZZARD SNOWLIGHT XMAS HALLOWEEN ")
			end
		end
	else
		local validWeatherType = false
		if args[1] == nil then
			TriggerClientEvent('chatMessage', source, '', {255,255,255}, '^8Error: ^1Invalid syntax, use ^0/weather <weatherType> ^1instead!')
		else
			for i,wtype in ipairs(AvailableWeatherTypes) do
				if wtype == string.upper(args[1]) then
					validWeatherType = true
					break
				end
			end
			if validWeatherType then
				TriggerClientEvent('esx:showNotification', source, 'Weather will change to: ~y~' .. string.lower(args[1]) .. "~s~.")
				CurrentWeather = string.upper(args[1])
				newWeatherTimer = 10
				TriggerEvent('alttab_weather:requestSync')
			else
				TriggerClientEvent('chatMessage', source, '', {255,255,255}, '^8Error: ^1Invalid weather type, valid weather types are: ^0\nEXTRASUNNY CLEAR NEUTRAL SMOG FOGGY OVERCAST CLOUDS CLEARING RAIN THUNDER SNOW BLIZZARD SNOWLIGHT XMAS HALLOWEEN ')
			end
		end
	end
end, function(source, args, user)
	TriggerClientEvent('chatMessage', source, "SYSTEM", {255, 0, 0}, "Insufficient Permissions.")
end, {help = "Set weather type", params = {{name = "weatherType", help = "Available types: extrasunny, clear, neutral, smog, foggy, overcast, clouds, clearing, rain, thunder, snow, blizzard, snowlight, xmas & halloween"}}})

RegisterServerEvent('alttab_weather:blackout')
AddEventHandler('alttab_weather:blackout', function(source)
	if source == 0 then
		blackout = not blackout
		if blackout then
			print("Blackout is now enabled.")
		else
			print("Blackout is now disabled.")
		end
	else
		blackout = not blackout
		if blackout then
			TriggerClientEvent('esx:showNotification', source, 'Blackout is now ~b~enabled~s~.')
		else
			TriggerClientEvent('esx:showNotification', source, 'Blackout is now ~r~disabled~s~.')
		end
		TriggerEvent('alttab_weather:requestSync')
	end
end)

RegisterServerEvent('alttab_weather:morning')
AddEventHandler('alttab_weather:morning', function(source)
	if source == 0 then
		print("For console, use the \"/time <hh> <mm>\" command instead!")
		return
	end
	ShiftToMinute(0)
	ShiftToHour(9)
	TriggerClientEvent('esx:showNotification', source, 'Time set to ~y~morning~s~.')
	TriggerEvent('alttab_weather:requestSync')
end)

RegisterServerEvent('alttab_weather:noon')
AddEventHandler('alttab_weather:noon', function(source)
	if source == 0 then
		print("For console, use the \"/time <hh> <mm>\" command instead!")
		return
	end
	ShiftToMinute(0)
	ShiftToHour(12)
	TriggerClientEvent('esx:showNotification', source, 'Time set to ~y~noon~s~.')
	TriggerEvent('alttab_weather:requestSync')
end)

RegisterServerEvent('alttab_weather:evening')
AddEventHandler('alttab_weather:evening', function(source)
	if source == 0 then
		print("For console, use the \"/time <hh> <mm>\" command instead!")
		return
	end
	ShiftToMinute(0)
	ShiftToHour(18)
	TriggerClientEvent('esx:showNotification', source, 'Time set to ~y~evening~s~.')
	TriggerEvent('alttab_weather:requestSync')
end)

RegisterServerEvent('alttab_weather:night')
AddEventHandler('alttab_weather:night', function(source)
	if source == 0 then
		print("For console, use the \"/time <hh> <mm>\" command instead!")
		return
	end
	ShiftToMinute(0)
	ShiftToHour(23)
	TriggerClientEvent('esx:showNotification', source, 'Time set to ~y~night~s~.')
	TriggerEvent('alttab_weather:requestSync')
end)

function ShiftToMinute(minute)
	timeOffset = timeOffset - ( ( (baseTime+timeOffset) % 60 ) - minute )
end

function ShiftToHour(hour)
	timeOffset = timeOffset - ( ( ((baseTime+timeOffset)/60) % 24 ) - hour ) * 60
end

TriggerEvent('es:addGroupCommand', 'time', 'admin', function(source, args, user)
	if source == 0 then
		if tonumber(args[1]) ~= nil and tonumber(args[2]) ~= nil then
			local argh = tonumber(args[1])
			local argm = tonumber(args[2])
			if argh < 24 then
				ShiftToHour(argh)
			else
				ShiftToHour(0)
			end
			if argm < 60 then
				ShiftToMinute(argm)
			else
				ShiftToMinute(0)
			end
			print("Time has changed to " .. argh .. ":" .. argm .. ".")
			TriggerEvent('alttab_weather:requestSync')
		else
			print("Invalid syntax, correct syntax is: time <hour> <minute> !")
		end
	elseif source ~= 0 then
		if tonumber(args[1]) ~= nil and tonumber(args[2]) ~= nil then
			local argh = tonumber(args[1])
			local argm = tonumber(args[2])
			if argh < 24 then
				ShiftToHour(argh)
			else
				ShiftToHour(0)
			end
			if argm < 60 then
				ShiftToMinute(argm)
			else
				ShiftToMinute(0)
			end
			local newtime = math.floor(((baseTime+timeOffset)/60)%24) .. ":"
			local minute = math.floor((baseTime+timeOffset)%60)
			if minute < 10 then
				newtime = newtime .. "0" .. minute
			else
				newtime = newtime .. minute
			end
			TriggerClientEvent('esx:showNotification', source, 'Time was changed to: ~y~' .. newtime .. "~s~!")
			TriggerEvent('alttab_weather:requestSync')
		else
			TriggerClientEvent('chatMessage', source, '', {255,255,255}, '^8Error: ^1Invalid syntax. Use ^0/time <hour> <minute> ^1instead!')
		end
	end
end, function(source, args, user)
	TriggerClientEvent('chatMessage', source, "SYSTEM", {255, 0, 0}, "Insufficient Permissions.")
end, {help = "Change the time", params = {{ name="hours", help="A number between 0 - 23"}, { name="minutes", help="A number between 0 - 59"}}})

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		local newBaseTime = os.time(os.date("!*t"))/2 + 360
		if freezeTime then
			timeOffset = timeOffset + baseTime - newBaseTime
		end
		baseTime = newBaseTime
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(5000)
		TriggerClientEvent('alttab_weather:updateTime', -1, baseTime, timeOffset, freezeTime)
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(300000)
		TriggerClientEvent('alttab_weather:updateWeather', -1, CurrentWeather, blackout)
	end
end)

Citizen.CreateThread(function()
	while true do
		newWeatherTimer = newWeatherTimer - 1
		Citizen.Wait(60000)
		if newWeatherTimer == 0 then
			if DynamicWeather then
				NextWeatherStage()
			end
			newWeatherTimer = 10
		end
	end
end)

function NextWeatherStage()
	if CurrentWeather == "CLEAR" or CurrentWeather == "CLOUDS" or CurrentWeather == "EXTRASUNNY"  then
		local new = math.random(1,2)
		if new == 1 then
			CurrentWeather = "CLEARING"
		else
			CurrentWeather = "OVERCAST"
		end
	elseif CurrentWeather == "CLEARING" or CurrentWeather == "OVERCAST" then
		local new = math.random(1,6)
		if new == 1 then
			if CurrentWeather == "CLEARING" then CurrentWeather = "FOGGY" else CurrentWeather = "RAIN" end
		elseif new == 2 then
			CurrentWeather = "CLOUDS"
		elseif new == 3 then
			CurrentWeather = "CLEAR"
		elseif new == 4 then
			CurrentWeather = "EXTRASUNNY"
		elseif new == 5 then
			CurrentWeather = "SMOG"
		else
			CurrentWeather = "FOGGY"
		end
	elseif CurrentWeather == "THUNDER" or CurrentWeather == "RAIN" then
		CurrentWeather = "CLEARING"
	elseif CurrentWeather == "SMOG" or CurrentWeather == "FOGGY" then
		CurrentWeather = "CLEAR"
	end
	TriggerEvent("alttab_weather:requestSync")
	if debugprint then
		print("[alttab_weather] New random weather type has been generated: " .. CurrentWeather .. ".\n")
		print("[alttab_weather] Resetting timer to 10 minutes.\n")
	end
end

