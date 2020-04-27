
--===============================================================================
--=== Stworzone przez Alcapone aka suprisex. Zakaz rozpowszechniania skryptu! ===
--===================== na potrzeby LS-Story.pl =================================
--===============================================================================


-- ESX

ESX = nil
local PlayerData                = {}

Citizen.CreateThread(function()
  while ESX == nil do
    TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
    Citizen.Wait(0)
	end
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
  PlayerData.job = job
end)


local radioMenu = false

function PrintChatMessage(text)
    TriggerEvent('chatMessage', "system", { 255, 0, 0 }, text)
end



function enableRadio(enable)

  SetNuiFocus(true, true)
  radioMenu = enable

  SendNUIMessage({

    type = "enableui",
    enable = enable

  })

end

--- sprawdza czy komenda /radio jest włączony

function hasRadio (cb)
  if (ESX == nil) then return cb(0) end
  ESX.TriggerServerCallback('ls-radio:getItemAmount', function(qtty)
    cb(qtty > 0)
  end, 'radio')
end
function ShowNoRadioWarning () 
  exports['mythic_notify']:SendAlert('inform', 'Vous n\'avez pas de Radio')
end
function ShowNotinRadioWarning () 
  exports['mythic_notify']:SendAlert('inform', 'Vous n\'êtes sur aucune Chaîne')
end

RegisterCommand('radio', function(source, args)
    hasRadio(function (hasRadio)
      if hasRadio == true then
        if Config.enableCmd then
          enableRadio(true)
        end
      else
        ShowNoRadioWarning()
      end
    end)
end, false)

-- dołączanie do radia

RegisterNUICallback('joinRadio', function(data, cb)
    local _source = source
    local PlayerData = ESX.GetPlayerData(_source)
    local playerName = GetPlayerName(PlayerId())
    local getPlayerRadioChannel = exports.tokovoip_script:getPlayerData(playerName, "radio:channel")

    if tonumber(data.channel) ~= tonumber(getPlayerRadioChannel) then
        if tonumber(data.channel) <= Config.RestrictedChannels then
          if(PlayerData.job.name == 'police' or PlayerData.job.name == 'ambulance' or PlayerData.job.name == 'state') then
            exports.tokovoip_script:removePlayerFromRadio(getPlayerRadioChannel)
            exports.tokovoip_script:setPlayerData(playerName, "radio:channel", tonumber(data.channel), true);
            exports.tokovoip_script:addPlayerToRadio(tonumber(data.channel))
            exports['mythic_notify']:SendAlert('success', Config.messages['joined_to_radio'] .. data.channel .. '.00 MHz </b>')
          elseif not (PlayerData.job.name == 'police' or PlayerData.job.name == 'ambulance' or PlayerData.job.name == 'state') then
            --- info że nie możesz dołączyć bo nie jesteś policjantem
            exports['mythic_notify']:SendAlert('error', Config.messages['restricted_channel_error'])
          end
        end
        if tonumber(data.channel) > Config.RestrictedChannels then
          exports.tokovoip_script:removePlayerFromRadio(getPlayerRadioChannel)
          exports.tokovoip_script:setPlayerData(playerName, "radio:channel", tonumber(data.channel), true);
          exports.tokovoip_script:addPlayerToRadio(tonumber(data.channel))
          exports['mythic_notify']:SendAlert('success', Config.messages['joined_to_radio'] .. data.channel .. '.00 MHz </b>')
        end
      else
        exports['mythic_notify']:SendAlert('error', Config.messages['you_on_radio'] .. data.channel .. '.00 MHz </b>')
      end
      --[[
    exports.tokovoip_script:removePlayerFromRadio(getPlayerRadioChannel)
    exports.tokovoip_script:setPlayerData(playerName, "radio:channel", tonumber(data.channel), true);
    exports.tokovoip_script:addPlayerToRadio(tonumber(data.channel))
    PrintChatMessage("radio: " .. data.channel)
    print('radiook')
      ]]--
    cb('ok')
end)

-- opuszczanie radia

RegisterNUICallback('leaveRadio', function(data, cb)
   local playerName = GetPlayerName(PlayerId())
   local getPlayerRadioChannel = exports.tokovoip_script:getPlayerData(playerName, "radio:channel")
    if getPlayerRadioChannel == "nil" then
      exports['mythic_notify']:SendAlert('inform', Config.messages['not_on_radio'])
        else
          exports.tokovoip_script:removePlayerFromRadio(getPlayerRadioChannel)
          exports.tokovoip_script:setPlayerData(playerName, "radio:channel", "nil", true)
          exports['mythic_notify']:SendAlert('success', Config.messages['you_leave'] .. getPlayerRadioChannel .. '.00 MHz </b>')
    end

   cb('ok')

end)

RegisterNUICallback('escape', function(data, cb)

    enableRadio(false)
    SetNuiFocus(false, false)


    cb('ok')
end)

-- net eventy

RegisterNetEvent('ls-radio:use')
AddEventHandler('ls-radio:use', function()
  enableRadio(true)
end)

RegisterNetEvent('ls-radio:onRadioDrop')
AddEventHandler('ls-radio:onRadioDrop', function(source)
  local playerName = GetPlayerName(source)
  local getPlayerRadioChannel = exports.tokovoip_script:getPlayerData(playerName, "radio:channel")


  if getPlayerRadioChannel ~= "nil" then

    exports.tokovoip_script:removePlayerFromRadio(getPlayerRadioChannel)
    exports.tokovoip_script:setPlayerData(playerName, "radio:channel", "nil", true)
    exports['mythic_notify']:SendAlert('inform', Config.messages['you_leave'] .. getPlayerRadioChannel .. '.00 MHz </b>')

end
end)

Citizen.CreateThread(function()
  while true do
    if radioMenu then
      DisableControlAction(0, 1, guiEnabled) -- LookLeftRight
      DisableControlAction(0, 2, guiEnabled) -- LookUpDown
      DisableControlAction(0, 142, guiEnabled) -- MeleeAttackAlternate
      DisableControlAction(0, 106, guiEnabled) -- VehicleMouseControlOverride
      if IsDisabledControlJustReleased(0, 142) then -- MeleeAttackAlternate
          SendNUIMessage({
              type = "click"
          })
      end
    end
    Citizen.Wait(0)

    if (IsControlJustPressed(0,246)) then
      local player = PlayerPedId()
      local playerName = GetPlayerName(PlayerId())
      local getPlayerRadioChannel = exports.tokovoip_script:getPlayerData(playerName, "radio:channel")
      hasRadio(function(hasRadio)
        if hasRadio == false then
          ShowNoRadioWarning()
        else
          if getPlayerRadioChannel == false or getPlayerRadioChannel == 'nil' then
            ShowNotinRadioWarning()
          end
        end
      end)
    end

    if (IsControlJustPressed(0,246)) or (IsControlJustReleased(0,246)) then
      hasRadio(function (hasRadio)
        if hasRadio == true then
          local player = PlayerPedId()
          local playerName = GetPlayerName(PlayerId())
          local getPlayerRadioChannel = exports.tokovoip_script:getPlayerData(playerName, "radio:channel")
          if getPlayerRadioChannel == false or getPlayerRadioChannel == 'nil' then
            -- no need to do anything
          else
            if ( DoesEntityExist( player ) and not IsEntityDead( player )) then 
              TriggerEvent('alttab_emotes:Animation', "cellphone@", "cellphone_call_listen_base", 49)
              TriggerEvent('alttab_emotes:AttachProp', 'prop_cs_hand_radio', 57005, 0.15, 0.025, -0.02, 70.0, 10.0, -258.0)
            end
          end
        end
      end)
    end
  end
end)