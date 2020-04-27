--[[------------------------------------------------------------------------

	ActionMenu 
	Created by WolfKnight
	Additional help from lowheartrate, TheStonedTurtle, and Briglair. 

------------------------------------------------------------------------]]--

-- Define the variable used to open/close the menu 
local menuEnabled = false 
--[[------------------------------------------------------------------------
	ActionMenu Toggle
	Calling this function will open or close the ActionMenu. 
------------------------------------------------------------------------]]--
function ToggleActionMenu()
	-- Make the menuEnabled variable not itself 
	-- e.g. not true = false, not false = true 
	menuEnabled = not menuEnabled

	if ( menuEnabled ) then 
		-- Focuses on the NUI, the second parameter toggles the 
		-- onscreen mouse cursor. 
		SetNuiFocus( true, true )

		-- Sends a message to the JavaScript side, telling it to 
		-- open the menu. 
		SendNUIMessage({
			showmenu = true 
		})
	else 
		-- Bring the focus back to the game
		SetNuiFocus( false )

		-- Sends a message to the JavaScript side, telling it to
		-- close the menu.
		SendNUIMessage({
			hidemenu = true 
		})
	end 
end 

--[[------------------------------------------------------------------------
	ActionMenu HTML Callbacks
	This will be called every single time the JavaScript side uses the
	sendData function. The name of the data-action is passed as the parameter
	variable data. 
------------------------------------------------------------------------]]--
RegisterNUICallback( "ButtonClick", function( data, cb ) 
	if ( data == "handsup" ) then 
		handsUp()
                
	elseif ( data == "trunk" ) then
   	 TriggerEvent( 'Trunk' )
                
	elseif ( data == "trunkclose" ) then
   	 TriggerEvent( 'TrunkClose' )
                
	elseif ( data == "engine" ) then 
	       TriggerEvent( 'Engine' )
                
    elseif ( data == "kneel" ) then
            TriggerEvent( 'KneelHU' )

    elseif ( data == "radar" ) then 
        TriggerEvent( 'wk:radarRC' )

    elseif ( data == "cuff" ) then 
        TriggerEvent( 'Handcuff' )

    elseif ( data == "gh" ) then 
        TriggerEvent( 'gunHolster' )
		
	elseif ( data == "r" ) then
        TriggerEvent ( 'Radio' )

	elseif ( data == "exit" ) then 
		-- We toggle the ActionMenu and return here, otherwise the function 
		-- call below would be executed too, which would just open the menu again 
		ToggleActionMenu()
		return 
	end 

	-- This will only be called if any button other than the exit button is pressed
	ToggleActionMenu()
end )


--[[------------------------------------------------------------------------
	ActionMenu Control and Input Blocking 
	This is the main while loop that opens the ActionMenu on keypress. It 
	uses the input blocking found in the ES Banking resource, credits to 
	the authors.
------------------------------------------------------------------------]]--
Citizen.CreateThread( function()
	-- This is just in case the resources restarted whilst the NUI is focused. 
	SetNuiFocus( false )

	while true do 
		-- Control ID 20 is the 'M' key by default 
		-- Use https://wiki.fivem.net/wiki/Controls to find a different key 
		if ( IsControlJustPressed( 1, 244 ) ) then 
			ToggleActionMenu()
		end 

	    if ( menuEnabled ) then
            local ped = GetPlayerPed( -1 )	

            DisableControlAction( 0, 1, true ) -- LookLeftRight
            DisableControlAction( 0, 2, true ) -- LookUpDown
            DisableControlAction( 0, 24, true ) -- Attack
            DisablePlayerFiring( ped, true ) -- Disable weapon firing
            DisableControlAction( 0, 142, true ) -- MeleeAttackAlternate
            DisableControlAction( 0, 106, true ) -- VehicleMouseControlOverride
        end

		Citizen.Wait( 0 )
	end 
end )

function chatPrint( msg )
	TriggerEvent( 'chatMessage', "ActionMenu", { 255, 255, 255 }, msg )
end 

--handsup
local handsup = false

function handsUp()
    local dict = "missminuteman_1ig_2"
    
	RequestAnimDict(dict)
	while not HasAnimDictLoaded(dict) do
		Citizen.Wait(0)
	end
	if not handsup then
		TaskPlayAnim(GetPlayerPed(-1), dict, "handsup_enter", 8.0, 8.0, -1, 50, 0, false, false, false)
		handsup = true
		exports['mythic_notify']:DoHudText('inform', 'you cant move bitch')

	else
		handsup = false
		ClearPedTasks(GetPlayerPed(-1))
	end
end

function ShowNotification( text )
    SetNotificationTextEntry("STRING")
    AddTextComponentSubstringPlayerName(text)
    DrawNotification(false, false)
end


--KneelHU Start
 
function loadAnimDict( dict )
    while ( not HasAnimDictLoaded( dict ) ) do
        RequestAnimDict( dict )
        Citizen.Wait( 5 )
    end
end
 
RegisterNetEvent( 'KneelHU' )
AddEventHandler( 'KneelHU', function()
    local player = GetPlayerPed( -1 )
    if ( DoesEntityExist( player ) and not IsEntityDead( player )) then
        loadAnimDict( "random@arrests" )
        loadAnimDict( "random@arrests@busted" )
        if ( IsEntityPlayingAnim( player, "random@arrests@busted", "idle_a", 3 ) ) then
            TaskPlayAnim( player, "random@arrests@busted", "exit", 8.0, 1.0, -1, 2, 0, 0, 0, 0 )
            Wait (3000)
            TaskPlayAnim( player, "random@arrests", "kneeling_arrest_get_up", 8.0, 1.0, -1, 128, 0, 0, 0, 0 )
        else
            TaskPlayAnim( player, "random@arrests", "idle_2_hands_up", 8.0, 1.0, -1, 2, 0, 0, 0, 0 )
            Wait (4000)
            TaskPlayAnim( player, "random@arrests", "kneeling_arrest_idle", 8.0, 1.0, -1, 2, 0, 0, 0, 0 )
            Wait (500)
            TaskPlayAnim( player, "random@arrests@busted", "enter", 8.0, 1.0, -1, 2, 0, 0, 0, 0 )
            Wait (1000)
            TaskPlayAnim( player, "random@arrests@busted", "idle_a", 8.0, 1.0, -1, 9, 0, 0, 0, 0 )
        end    
    end
end )
 
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if IsEntityPlayingAnim(GetPlayerPed(PlayerId()), "random@arrests@busted", "idle_a", 3) then
            DisableControlAction(1, 140, true)
            DisableControlAction(1, 141, true)
            DisableControlAction(1, 142, true)
            DisableControlAction(0,21,true)
        end
    end
end)

--KneelHU End

--engine
RegisterNetEvent('Engine')
 
local vehicles = {}
local State = {}
 
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if GetSeatPedIsTryingToEnter(GetPlayerPed(-1)) == -1 and not table.contains(vehicles, GetVehiclePedIsTryingToEnter(GetPlayerPed(-1))) then
            table.insert(vehicles, GetVehiclePedIsTryingToEnter(GetPlayerPed(-1)))
            table.insert(State, IsVehicleEngineOn(GetVehiclePedIsTryingToEnter(GetPlayerPed(-1))))
        elseif IsPedInAnyVehicle(GetPlayerPed(-1), false) and not table.contains(vehicles, GetVehiclePedIsIn(GetPlayerPed(-1), false)) then
            table.insert(vehicles, GetVehiclePedIsIn(GetPlayerPed(-1), false))
            table.insert(State, IsVehicleEngineOn(GetVehiclePedIsIn(GetPlayerPed(-1), false)))
        end
        for i = 1, tablelength(vehicles) do
            if (GetPedInVehicleSeat(vehicles[i], -1) == GetPlayerPed(-1)) or IsVehicleSeatFree(vehicles[i], -1) then
                SetVehicleEngineOn(vehicles[i], State[i], State[i], State[i])
            end
        end
    end
end)
 


AddEventHandler('Engine', function()
    local veh
    local StateIndex
    for i = 1, tablelength(vehicles) do
        if vehicles[i] == GetVehiclePedIsIn(GetPlayerPed(-1), false) then
            veh = vehicles[i]
            StateIndex = i
        end
    end
    if IsPedInAnyVehicle(GetPlayerPed(-1), false) then
        if (GetPedInVehicleSeat(veh, -1) == GetPlayerPed(-1)) then
            if IsVehicleEngineOn(veh) then
                State[StateIndex] = false
            else
                State[StateIndex] = true
            end
        end
    end
end)
 
function drawNotification(text) --Just Don't Edit!
    SetNotificationTextEntry("STRING")
    AddTextComponentString(text)
    DrawNotification(false, false)
end
 
function tablelength(T) --Just Don't Edit!
    local count = 0
    for _ in pairs(T) do count = count + 1 end
    return count
end
 
function table.contains(table, element)
  for _, value in pairs(table) do
    if value == element then
      return true
    end
  end
  return false
end


--Trunk start

RegisterNetEvent("Trunk")
AddEventHandler("Trunk", function()
	local Veh = GetVehiclePedIsUsing(GetPlayerPed(-1))
	SetVehicleDoorOpen(Veh, 5, false, false)
end)

RegisterNetEvent("TrunkClose")
AddEventHandler("TrunkClose", function()
	local Veh = GetVehiclePedIsUsing(GetPlayerPed(-1))
	SetVehicleDoorShut(Veh, 5, false)
end)

--Trunk End

--HandCuff start
local handcuffconfig = {
	model = "prop_cs_cuffs_01",
	handcuffs = nil
	}
--[[ HANDCUFF SCRIPT ]]--
RegisterNetEvent("Handcuff")
AddEventHandler("Handcuff", function()
	local lPed = GetPlayerPed(-1)
	if DoesEntityExist(lPed) then
		if IsEntityPlayingAnim(lPed, "mp_arresting", "idle", 3) then
			DetachEntity(handcuffconfig.handcuffs, 0, 0)
			DeleteEntity(handcuffconfig.handcuffs)
			handcuffconfig.handcuffs = nil
			ClearPedSecondaryTask(lPed)
			SetEnableHandcuffs(lPed, false)
			SetCurrentPedWeapon(lPed, GetHashKey("WEAPON_UNARMED"), true)
		else
			RequestAnimDict("mp_arresting")
			while not HasAnimDictLoaded("mp_arresting") do
				Citizen.Wait(100)
			end

			RequestModel(GetHashKey(handcuffconfig.model))
			while not HasModelLoaded(GetHashKey(handcuffconfig.model)) do
				Citizen.Wait(100)
			end

			local plyCoords = GetEntityCoords(GetPlayerPed(PlayerId()), false)
			handcuffconfig.handcuffs = CreateObject(GetHashKey(handcuffconfig.model), plyCoords.x, plyCoords.y, plyCoords.z, 1, 1, 1)

			AttachEntityToEntity(handcuffconfig.handcuffs, GetPlayerPed(PlayerId()), GetPedBoneIndex(GetPlayerPed(PlayerId()), 60309), 0.0, 0.05, 0.0, 0.0, 0.0, 80.0, 1, 0, 0, 0, 0, 1)

			TaskPlayAnim(lPed, "mp_arresting", "idle", 8.0, -8, -1, 49, 0, 0, 0, 0)
			SetEnableHandcuffs(lPed, true)
			SetCurrentPedWeapon(lPed, GetHashKey("WEAPON_UNARMED"), true)
		end
	end
end)
--]]

--[[---------------------]]--

--[[ HANDSUP SCRIPT ]]--
RegisterNetEvent("Handsup")
AddEventHandler("Handsup", function()
	local lPed = GetPlayerPed(-1)
	if DoesEntityExist(lPed) then
		if not IsEntityPlayingAnim(lPed, "mp_arresting", "idle", 3) then
			RequestAnimDict("random@mugging3")
			while not HasAnimDictLoaded("random@mugging3") do
				Citizen.Wait(100)
			end
			
			if IsEntityPlayingAnim(lPed, "random@mugging3", "handsup_standing_base", 3) then
				ClearPedSecondaryTask(lPed)
				SetEnableHandcuffs(lPed, false)
				SetCurrentPedWeapon(lPed, GetHashKey("WEAPON_UNARMED"), true)
				TriggerEvent("chatMessage", "", {255, 0, 0}, "Your have put your hands down.")
			else
				TaskPlayAnim(lPed, "random@mugging3", "handsup_standing_base", 8.0, -8, -1, 49, 0, 0, 0, 0)
				SetEnableHandcuffs(lPed, true)
				SetCurrentPedWeapon(lPed, GetHashKey("WEAPON_UNARMED"), true)
				TriggerEvent("chatMessage", "", {255, 0, 0}, "Your hands are up.")
			end
		else
			TriggerEvent("chatMessage", "You are handcuffed..")
		end
	end
end)
--]]

--[[---------------------]]--

--[[ Other Functions ]]--

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if IsEntityPlayingAnim(GetPlayerPed(PlayerId()), "mp_arresting", "idle", 3) then
			DisableControlAction(1, 140, true)
			DisableControlAction(1, 141, true)
			DisableControlAction(1, 142, true)
			SetPedPathCanUseLadders(GetPlayerPed(PlayerId()), false)
		end

		if IsEntityPlayingAnim(GetPlayerPed(PlayerId()), "random@mugging3", "handsup_standing_base", 3) then
			DisableControlAction(1, 140, true)
			DisableControlAction(1, 141, true)
			DisableControlAction(1, 142, true)
		end
	end
end)

--]]

--HandCuff End

--Model Load Cuff

local handcuffconfig = {
	model = "prop_cs_cuffs_01",
	handcuffs = nil
}

-- Model Load Cuff End

--GunHolster start

RegisterNetEvent('gunHolster')
AddEventHandler('gunHolster', function()

local ped = GetPlayerPed( -1 )
    
if ( DoesEntityExist( ped ) and not IsEntityDead( ped ) ) then 

Citizen.CreateThread( function()
	RequestAnimDict( "move_m@intimidation@cop@unarmed" )
	   while ( not HasAnimDictLoaded( "move_m@intimidation@cop@unarmed" ) ) do 
                Citizen.Wait( 100 )
            end
				if IsEntityPlayingAnim(ped, "move_m@intimidation@cop@unarmed", "idle", 3) then
				ClearPedSecondaryTask(ped)
				SetCurrentPedWeapon(ped, GetHashKey("WEAPON_UNARMED"), true)
				else
				TaskPlayAnim(ped, "move_m@intimidation@cop@unarmed", "idle", 8.0, 2.5, -1, 49, 0, 0, 0, 0 )
				SetCurrentPedWeapon(ped, GetHashKey("WEAPON_UNARMED"), true)
            end 
        end )
    end 
end )

--GunHolster End

--Hand on radio start--

--server.lua

RegisterNetEvent('Radio')
AddEventHandler('Radio', function()

local ped = GetPlayerPed( -1 )
    
if ( DoesEntityExist( ped ) and not IsEntityDead( ped ) ) then 

Citizen.CreateThread( function()
	RequestAnimDict( "random@arrests" )
	   while ( not HasAnimDictLoaded( "random@arrests" ) ) do 
                Citizen.Wait( 100 )
            end
				if IsEntityPlayingAnim(ped, "random@arrests", "generic_radio_chatter", 3) then
				ClearPedSecondaryTask(ped)
				SetCurrentPedWeapon(ped, GetHashKey("GENERIC_RADIO_CHATTER"), true)
				else
				TaskPlayAnim(ped, "random@arrests", "generic_radio_chatter", 8.0, 2.5, -1, 49, 0, 0, 0, 0 )
				SetCurrentPedWeapon(ped, GetHashKey("GENERIC_RADIO_CHATTER"), true)
            end 
        end )
    end 
end )

--client.lua side

AddEventHandler( 'chatMessage', function( source, n, msg )  

    msg = string.lower( msg )
    
    if ( msg == "/r" ) then 
    
        CancelEvent() 

        TriggerClientEvent( 'Radio', source )
    end
end )

--hand on radio end--
