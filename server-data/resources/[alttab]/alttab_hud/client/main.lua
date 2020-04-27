-- SCREEN POSITION PARAMETERS
local screenPosX = 0.165                    -- X coordinate (top left corner of HUD)
local screenPosY = 0.882                    -- Y coordinate (top left corner of HUD)

-- GENERAL PARAMETERS
local enableController = false               -- Enable controller inputs

-- SPEEDOMETER PARAMETERS
local speedLimit = 80.0                    -- Speed limit for changing speed color
local speedColorText = {255, 255, 255}      -- Color used to display speed label text
local speedColorUnder = {160, 255, 160}    -- Color used to display speed when under speedLimit
local speedColorOver = {255, 96, 96}        -- Color used to display speed when over speedLimit

-- FUEL PARAMETERS
local fuelShowPercentage = true             -- Show fuel as a percentage (disabled shows fuel in liters)
local fuelWarnLimit = 15.0                  -- Fuel limit for triggering warning color
local fuelColorText = {255, 255, 255}       -- Color used to display fuel text
local fuelColorOver = {160, 255, 160}       -- Color used to display fuel when good
local fuelColorUnder = {255, 96, 96}        -- Color used to display fuel warning

-- SEATBELT PARAMETERS
local seatbeltInput = 29                   -- Toggle seatbelt on/off with B
local seatbeltPlaySound = true              -- Play seatbelt sound
local seatbeltDisableExit = true            -- Disable vehicle exit when seatbelt is enabled
local seatbeltEjectSpeed = 45.0             -- Speed threshold to eject player (MPH)
local seatbeltEjectAccel = 100.0            -- Acceleration threshold to eject player (G's)
local seatbeltColorOn = {160, 255, 160}     -- Color used when seatbelt is on
local seatbeltColorOff = {255, 96, 96}       -- Color used when seatbelt is off

-- CRUISE CONTROL PARAMETERS
local cruiseInput = 137                     -- Toggle cruise on/off with CAPSLOCK(controller)
local cruiseColorOn = {160, 255, 160}       -- Color used when seatbelt is on
local cruiseColorOff = {255, 96, 96}        -- Color used when seatbelt is off

-- LOCATION AND TIME PARAMETERS
local locationAlwaysOn = true              -- Always display location and time
local locationColorText = {255, 255, 255}   -- Color used to display location and time

-- Lookup tables for direction and zone
local directions = { 
    [0] = 'nord', 
    [1] = 'nord-ouest', 
    [2] = 'ouest', 
    [3] = 'sud-ouest', 
    [4] = 'sud', 
    [5] = 'sud-est', 
    [6] = 'est', 
    [7] = 'nord-est', 
    [8] = 'nord' 
} 

-- Globals
local pedInVeh = false
local timeText = ""
local locationText = ""
local currentFuel = 0.0

-- Main thread
Citizen.CreateThread(function()
    -- Initialize local variable
    local currSpeed = 0.0
    local cruiseSpeed = 999.0
    local prevVelocity = {x = 0.0, y = 0.0, z = 0.0}
    local cruiseIsOn = false
    local seatbeltIsOn = false

    while true do
        -- Loop forever and update HUD every frame
        Citizen.Wait(0)

        -- Get player PED, position and vehicle and save to locals
        local player = GetPlayerPed(-1)
        local position = GetEntityCoords(player)
        local vehicle = GetVehiclePedIsIn(player, false)

        -- Set vehicle states
        if IsPedInAnyVehicle(player, false) then
            pedInVeh = true
        else
            -- Reset states when not in car
            pedInVeh = false
            cruiseIsOn = false
            seatbeltIsOn = false
        end
        
        -- Display Location and time when in any vehicle or on foot (if enabled)
        if pedInVeh or locationAlwaysOn then
            -- Get time and display it
            -- drawTxt("Heure", 7, locationColorText, 0.35, 0.839,0.013)
            -- drawTxt(timeText .. "  ~y~|~s~", 7, {41,182,246}, 0.35, 0.870,0.013)

            -- Display ID
            -- drawTxt("ID", 7, {255,255,255}, 0.35, 0.907,0.013)
            -- drawTxt(GetPlayerServerId(PlayerId()), 7, {41,182,246} , 0.35, 0.919, 0.013)
        
            -- Display remainder of HUD when engine is on and vehicle is not a bicycle
            local vehicleClass = GetVehicleClass(vehicle)
            if pedInVeh and GetIsVehicleEngineRunning(vehicle) and vehicleClass ~= 13 then

                -- Display street name and directions
                drawTxt(locationText, 7, locationColorText, 0.35, screenPosX + 0.25 , screenPosY + 0.085)

                -- Save previous speed and get current speed
                local prevSpeed = currSpeed
                currSpeed = GetEntitySpeed(vehicle)

                -- Set PED flags
                SetPedConfigFlag(PlayerPedId(), 32, true)
                
                -- Check if seatbelt button pressed, toggle state and handle seatbelt logic
                if IsControlJustReleased(0, seatbeltInput) and (enableController or GetLastInputMethod(0)) and vehicleClass ~= 8 then
                    -- Toggle seatbelt status and play sound when enabled
                    seatbeltIsOn = not seatbeltIsOn
                    if seatbeltPlaySound then
                        PlaySoundFrontend(-1, "Faster_Click", "RESPAWN_ONLINE_SOUNDSET", 1)
                    end
                end
                if not seatbeltIsOn then
                    -- Eject PED when moving forward, vehicle was going over 45 MPH and acceleration over 100 G's
                    local vehIsMovingFwd = GetEntitySpeedVector(vehicle, true).y > 1.0
                    local vehAcc = (prevSpeed - currSpeed) / GetFrameTime()
                    if (vehIsMovingFwd and (prevSpeed > (seatbeltEjectSpeed/2.237)) and (vehAcc > (seatbeltEjectAccel*9.81))) then
                        SetEntityCoords(player, position.x, position.y, position.z - 0.357, true, true, true)
                        SetEntityVelocity(player, prevVelocity.x, prevVelocity.y, prevVelocity.z)
                        Citizen.Wait(1)
                        SetPedToRagdoll(player, 1000, 1000, 0, 0, 0, 0)
                    else
                        -- Update previous velocity for ejecting player
                        prevVelocity = GetEntityVelocity(vehicle)
                    end
                elseif seatbeltDisableExit then
                    -- Disable vehicle exit when seatbelt is on
                    DisableControlAction(0, 75)
                end

                -- When player in driver seat, handle cruise control
                if (GetPedInVehicleSeat(vehicle, -1) == player) then
                    -- Check if cruise control button pressed, toggle state and set maximum speed appropriately
                    if IsControlJustReleased(0, cruiseInput) and (enableController or GetLastInputMethod(0)) then
                        cruiseIsOn = not cruiseIsOn
                        cruiseSpeed = currSpeed
                    end
                    local maxSpeed = cruiseIsOn and cruiseSpeed or GetVehicleHandlingFloat(vehicle,"CHandlingData","fInitialDriveMaxFlatVel")
                    SetEntityMaxSpeed(vehicle, maxSpeed)
                else
                    -- Reset cruise control
                    cruiseIsOn = false
                end

                -- Get vehicle speed in KPH and draw speedometer
                local speed = currSpeed*3.6
                local speedColor = (speed >= speedLimit) and speedColorOver or speedColorUnder
                drawTxt(("%.3d"):format(math.ceil(speed)), 7, speedColor, 0.50, screenPosX, screenPosY + 0.085)
                drawTxt("Km/h", 7, speedColorText, 0.25, screenPosX + 0.026, screenPosY + 0.088)
                drawTxt("~y~|~s~", 7, locationColorText, 0.35, screenPosX + 0.05, screenPosY + 0.091)


                --Draw fuel gauge
                local fuelColor = (currentFuel >= fuelWarnLimit) and fuelColorOver or fuelColorUnder
                drawTxt(("%.3d"):format(math.ceil(GetVehicleFuelLevel(vehicle))), 7, fuelColor, 0.5, screenPosX + 0.06, screenPosY + 0.085)
                drawTxt("Essence", 7, fuelColorText, 0.25, screenPosX + 0.086, screenPosY + 0.091)

                -- Draw cruise control status
                local cruiseColor = cruiseIsOn and cruiseColorOn or cruiseColorOff
                -- drawTxt("l", 7, cruiseColor, 0.35, screenPosX + 0.019, screenPosY + 0.0610)
                drawTxt("limiteur", 7, cruiseColor, 0.35, screenPosX, screenPosY + 0.0610)
                drawTxt("~y~|~s~", 7, locationColorText, 0.35, screenPosX + 0.05, screenPosY + 0.0610)

                -- Draw seatbelt status if not a motorcyle
                if vehicleClass ~= 8 then
                    local seatbeltColor = seatbeltIsOn and seatbeltColorOn or seatbeltColorOff
                    -- drawTxt("c", 7, seatbeltColor, 0.35, screenPosX, screenPosY + 0.0610)
                    drawTxt("ceinture", 7, seatbeltColor, 0.35, screenPosX + 0.06, screenPosY + 0.0610)
                end
            end
        end
    end
end)

-- Secondary thread to update strings
Citizen.CreateThread(function()
    while true do
        -- Update when player is in a vehicle or on foot (if enabled)
        if pedInVeh or locationAlwaysOn then
            -- Get player, position and vehicle
            local player = GetPlayerPed(-1)
            local position = GetEntityCoords(player)

            -- Update time text string
            local hour = GetClockHours()
            local minute = GetClockMinutes()
            timeText = ("%.2d"):format(hour) .. ":" ..  ("%.2d"):format(minute)
            
            -- Get heading and zone from lookup tables and street name from hash
            local heading = directions[math.floor((GetEntityHeading(player) + 22.5) / 45.0)]
            local streetName = GetStreetNameFromHashKey(GetStreetNameAtCoord(position.x, position.y, position.z))
            
            -- Update location text string
            locationText = heading
            locationText = (streetName == "" or streetName == nil) and (locationText) or (locationText .. "  ~y~|~s~  " .. streetName)

            -- Update fuel when in a vehicle
            if pedInVeh then
                local vehicle = GetVehiclePedIsIn(player, false)
                if fuelShowPercentage then
                    -- Display remaining fuel as a percentage
                    currentFuel = 100 * GetVehicleFuelLevel(vehicle) / GetVehicleHandlingFloat(vehicle,"CHandlingData","fPetrolTankVolume")
                else
                    -- Display remainign fuel in liters
                    currentFuel = GetVehicleFuelLevel(vehicle)
                end
            end

            -- Update every second
            Citizen.Wait(1000)
        else
            -- Wait until next frame
            Citizen.Wait(0)
        end
    end
end)

-- Helper function to draw text to screen
function drawTxt(content, font, colour, scale, x, y)
    SetTextFont(font)
    SetTextScale(scale, scale)
    SetTextColour(colour[1],colour[2],colour[3], 255)
    SetTextEntry("STRING")
    SetTextDropShadow(0, 0, 0, 0,255)
    SetTextDropShadow()
    SetTextEdge(4, 0, 0, 0, 255)
    SetTextOutline()
    AddTextComponentString(content)
    DrawText(x, y)
end
