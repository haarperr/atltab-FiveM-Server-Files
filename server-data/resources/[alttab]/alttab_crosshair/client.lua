Citizen.CreateThread( function()
    while true do 
		local p = GetPlayerPed(-1)
		if (DoesEntityExist(p) and not IsEntityDead(p)) then
			local weapon = GetSelectedPedWeapon(p)
			local sniperRifle = GetHashKey("WEAPON_SNIPERRIFLE")
			local marksmanRifle = GetHashKey("WEAPON_MARKSMANRIFLE")
			local marksmanRifle2 = GetHashKey("WEAPON_MARKSMANRIFLE_MK2")
			local heavySniper = GetHashKey("WEAPON_HEAVYSNIPER") 
			local heavySniper2 = GetHashKey("WEAPON_HEAVYSNIPER_MK2")
			
			if (weapon == sniperRifle or 
			weapon == marksmanRifle or 
			weapon == marksmanRifle2 or 
			weapon == heavySniper or 
			weapon == heavySniper2) then
				-- do nothing = do not remove recticles from snipers
			else
				HideHudComponentThisFrame(14) -- remove crosshair
			end
		end
   		Citizen.Wait(0)
    end 
end )