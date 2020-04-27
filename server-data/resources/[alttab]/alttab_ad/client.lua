ESX = nil

Citizen.CreateThread(function()
  while ESX == nil do
    TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
    Citizen.Wait(0)
  end
end)

RegisterNetEvent('alttab_ad:showAd')
AddEventHandler('alttab_ad:showAd', function(source,player,title,subtitle,message)
    local playerID = GetPlayerFromServerId(player)
    local mugshot, mugshotStr = ESX.Game.GetPedMugshot(GetPlayerPed(playerID))
    ESX.ShowAdvancedNotification(title, subtitle, message, mugshotStr, 4)
    UnregisterPedheadshot(mugshot)
end)