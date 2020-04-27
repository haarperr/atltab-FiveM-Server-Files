-- Settings
local color = { r = 220, g = 220, b = 220, alpha = 255 } -- Color of the text 
local font = 0 -- Font of the text
local time = 5000 -- Duration of the display of the text : 1000ms = 1sec
local background = {
    enable = true,
    color = { r = 0, g = 0, b = 0, alpha = 200 },
}

-- Don't touch
local nbrDisplaying = 1

RegisterCommand('me', function(source, args)
    
    local text = '' -- edit here if you want to change the language : EN: the person / FR: la personne
    for i = 1,#args do
        text = text .. ' ' .. args[i]
    end
    TriggerServerEvent('alttab_me:shareDisplay', text)
end)

RegisterNetEvent('alttab_me:triggerDisplay')
AddEventHandler('alttab_me:triggerDisplay', function(text, source)
    local offset = -0.20 + (nbrDisplaying*0.14)
    Display(GetPlayerFromServerId(source), text, offset)
end)

function Display(mePlayer, text, offset)
    local displaying = true

    Citizen.CreateThread(function()
        Wait(time)
        displaying = false
    end)
    Citizen.CreateThread(function()
        nbrDisplaying = nbrDisplaying + 1
        print(nbrDisplaying)
        while displaying do
            Wait(0)
            local coordsMe = GetEntityCoords(GetPlayerPed(mePlayer), false)
            local coords = GetEntityCoords(PlayerPedId(), false)
            local dist = Vdist2(coordsMe, coords)
            if dist < 2500 then
                if HasEntityClearLosToEntity(PlayerPedId(), GetPlayerPed(mePlayer), 17 ) then
                    DrawText3D(coordsMe['x'], coordsMe['y'], coordsMe['z']+offset, text)
                end
            end
        end
        nbrDisplaying = nbrDisplaying - 1
    end)
end

function DrawText3D(x,y,z, text)
    local onScreen,_x,_y = World3dToScreen2d(x,y,z)
    local px,py,pz = table.unpack(GetGameplayCamCoord())
    local dist = GetDistanceBetweenCoords(px,py,pz, x,y,z, 1)
 
    local scale = ((1/dist)*2)*(1/GetGameplayCamFov())*100

    if onScreen then

        -- Formalize the text
        SetTextColour(color.r, color.g, color.b, color.alpha)
        SetTextScale(0.0*scale, 0.25*scale)
        SetTextFont(font)
        SetTextProportional(1)
        SetTextCentre(true)

        -- Calculate width and height
        BeginTextCommandWidth("STRING")
        AddTextComponentString(text)
        local height = GetTextScaleHeight(0.55*scale, font)
        local width = EndTextCommandGetWidth(font)

        -- Diplay the text
        SetTextEntry("STRING")
        AddTextComponentString(text)
        EndTextCommandDisplayText(_x, _y)

        if background.enable then
            DrawRect(_x+scale/800, _y+scale/100, width + 0.01, height, background.color.r, background.color.g, background.color.b , background.color.alpha)
        end
    end
end
