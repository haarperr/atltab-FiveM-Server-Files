--[[------------------------------------------------------------------------
    Vehicle Damage Shit
------------------------------------------------------------------------]]--
local levelOfDamageToKillThisBitch = 900.0 
local isEngineOff = false
local isAllOpen = false

function IsValidVehicle(veh)
    local model = GetEntityModel(veh)

    if (IsThisModelACar(model) or IsThisModelABike(model) or IsThisModelAQuadbike(model)) then  
        return true 
    else 
        return false 
    end 
end 

function ManageVehicleDamage()
    local ped = GetPlayerPed(-1)

    if (DoesEntityExist(ped) and not IsEntityDead(ped)) then 
        if ( IsPedSittingInAnyVehicle(ped)) then 
            local veh = GetVehiclePedIsIn(ped, false)

            if (GetPedInVehicleSeat(veh, -1 ) == ped) then 
                local damage = GetVehicleEngineHealth(veh)

                if (damage < levelOfDamageToKillThisBitch and IsValidVehicle(veh)) then
                    SetVehicleEngineHealth(veh, 300)
                    SetVehicleEngineOn(veh, false, true)
                    SetVehicleUndriveable(veh,true)
                end 
            end  
        end 
    end 
end 

Citizen.CreateThread(function()
    while true do 
        ManageVehicleDamage()
        Citizen.Wait(7000)
    end 
end)

RegisterCommand('door', function(source, args)
    local player = GetPlayerPed(-1)
    local argh = tostring(args[1])
    local veh = GetVehiclePedIsIn(player,true)
    if (IsPedSittingInAnyVehicle(player)) and not IsEntityDead(player) then
        if argh == "1" then
            local isOpen = GetVehicleDoorAngleRatio(veh, 0) 
            if (isOpen == 0) then
                SetVehicleDoorOpen(veh, 0, false, false)
            else
                SetVehicleDoorShut(veh, 0, false)
            end
        elseif argh == "2" then
            local isOpen = GetVehicleDoorAngleRatio(veh, 1) 
            if (isOpen == 0) then
                SetVehicleDoorOpen(veh, 1, false, false)
            else
                SetVehicleDoorShut(veh, 1, false)
            end
        elseif argh == "3" then
            local isOpen = GetVehicleDoorAngleRatio(veh, 2) 
            if (isOpen == 0) then
                SetVehicleDoorOpen(veh, 2, false, false)
            else
                SetVehicleDoorShut(veh, 2, false)
            end
        elseif argh == "4" then
            local isOpen = GetVehicleDoorAngleRatio(veh, 3) 
            if (isOpen == 0) then
                SetVehicleDoorOpen(veh, 3, false, false)
            else
                SetVehicleDoorShut(veh, 3, false)
            end
        elseif argh == "0" then
            local isOpen = GetVehicleDoorAngleRatio(veh, 4) 
            if (isOpen == 0) then
                SetVehicleDoorOpen(veh, 4, false, false)
            else
                SetVehicleDoorShut(veh, 4, false)
            end
        elseif argh == "5" then
            local isOpen = GetVehicleDoorAngleRatio(veh, 5) 
            if (isOpen == 0) then
                SetVehicleDoorOpen(veh, 5, false, false)
            else
                SetVehicleDoorShut(veh, 5, false)
            end
        elseif argh == "all" then
            if isAllOpen then
                SetVehicleDoorShut(veh, 0, false)
                SetVehicleDoorShut(veh, 1, false)
                SetVehicleDoorShut(veh, 2, false)
                SetVehicleDoorShut(veh, 3, false)
                SetVehicleDoorShut(veh, 4, false)
                SetVehicleDoorShut(veh, 5, false)
                print(tostring(isAllOpen) .. " 1")
                isAllOpen = false
            else
                print(tostring(isAllOpen) .. " 2")
                SetVehicleDoorOpen(veh, 0, false, false)
                SetVehicleDoorOpen(veh, 1, false, false)
                SetVehicleDoorOpen(veh, 2, false, false)
                SetVehicleDoorOpen(veh, 3, false, false)
                SetVehicleDoorOpen(veh, 4, false, false)
                SetVehicleDoorOpen(veh, 5, false, false)
                isAllOpen = true
            end
        end
    end
    
end, false)

RegisterCommand('engine', function(source, args)
    local player = GetPlayerPed(-1)
    if (IsPedSittingInAnyVehicle(player)) and not IsEntityDead(player) then 
        local veh = GetVehiclePedIsIn(player,false)
        print(GetIsVehicleEngineRunning(veh))
        if GetIsVehicleEngineRunning(veh) then
            print("running")
			isEngineOff = true
			while (isEngineOff) do
			SetVehicleEngineOn(veh,false,false,false)
			SetVehicleUndriveable(veh,true)
			Citizen.Wait(0)
			end
        else
			isEngineOff = false
			SetVehicleUndriveable(veh,false)
			SetVehicleEngineOn(veh,true,false,false)
        end
	end
end, false)