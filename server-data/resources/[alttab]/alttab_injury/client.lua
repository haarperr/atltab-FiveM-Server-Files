Citizen.CreateThread(function()
    local hurt = false
    local crouched = false
    
    RequestAnimSet("move_ped_crouched")
    while (not HasAnimSetLoaded("move_ped_crouched")) do 
        Citizen.Wait(100)
    end 

    while true do
        local ped = GetPlayerPed(-1)
        local health = GetEntityHealth(ped)

        if (DoesEntityExist(ped) and not IsEntityDead(ped)) then 
            DisableControlAction(0, 36, true)
            if (not IsPauseMenuActive()) then 
                if (IsDisabledControlJustPressed(0, 36)) then 
                    RequestAnimSet("move_ped_crouched")
                    while (not HasAnimSetLoaded("move_ped_crouched")) do 
                        Citizen.Wait(100)
                    end 
                    if (crouched == true) then 
                        ResetPedMovementClipset(ped, 0)
                        crouched = false 
                    elseif (crouched == false) then
                        SetPedMovementClipset(ped, "move_ped_crouched", 0.25)
                        crouched = true 
                    end 
                end
            end 
        end

        -- if (health <= 150) and (health > 0) then
        --     hurt = true
        --     RequestAnimSet("move_m@injured")
        --     SetPedMovementClipset(ped, "move_m@injured", true)
        --     DisableControlAction(0, 21, true) -- disable sprint
        --     DisableControlAction(0, 22, true) -- disable jumping
        --     DisableControlAction(0, 36, true) -- disable crouch
        --     drawTxt("vous devez vous soigner !" , 7, {255, 96, 96} , 0.35, 0.165, 0.882 + 0.035)
        -- elseif (health > 150) then
        --     hurt = false
        --     if crouched == false then
        --         ResetPedMovementClipset(ped)
        --         ResetPedWeaponMovementClipset(ped)
        --         ResetPedStrafeClipset(ped)
        --     end
        -- elseif health <= 0 then
        --     drawTxt("vous êtes en coma", 7, {52, 73, 94} , 0.35, 0.165, 0.882 + 0.035)
        -- end
        Wait(1)
    end
end)

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

