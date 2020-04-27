ESX = nil
local savedNotes = {
  
}

TriggerEvent('server:LoadsNote')
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

TriggerEvent('es:addCommand', 'note', function(source, args, user)
  local _source = source
  local xPlayer = ESX.GetPlayerFromId(_source)
  local item    = xPlayer.getInventoryItem('notepad').count
if item > 0 then
    TriggerClientEvent('alttab_simplenote:note', _source)
    TriggerClientEvent('alttab_simplenote:OpenNotepadGui', _source)
    TriggerEvent('server:LoadsNote')
else
     TriggerClientEvent('esx:showNotification', _source, 'Vous n\'avez pas de ~r~bloc-notes~s~.')
end
    
end, {help = "Prenez une feuille en main!"})


RegisterNetEvent("server:LoadsNote")
AddEventHandler("server:LoadsNote", function()
   TriggerClientEvent('alttab_simplenote:updateNotes', -1, savedNotes)
end)

RegisterNetEvent("server:newNote")
AddEventHandler("server:newNote", function(text, x, y, z)
      local import = {
        ["text"] = ""..text.."",
        ["x"] = x,
        ["y"] = y,
        ["z"] = z,
      }
      table.insert(savedNotes, import)
      TriggerEvent("server:LoadsNote")
end)

RegisterNetEvent("server:updateNote")
AddEventHandler("server:updateNote", function(noteID, text)
  savedNotes[noteID]["text"]=text
  TriggerEvent("server:LoadsNote")
end)

RegisterNetEvent("server:destroyNote")
AddEventHandler("server:destroyNote", function(noteID)
  table.remove(savedNotes, noteID)
  TriggerEvent("server:LoadsNote")
end)

