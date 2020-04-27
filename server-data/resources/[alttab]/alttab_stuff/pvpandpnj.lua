DensityMultiplier = 0.01

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)

		for _, player in ipairs(GetActivePlayers()) do
			SetCanAttackFriendly(GetPlayerPed(player), true, true)
			NetworkSetFriendlyFireOption(true)
			-- EnableDispatchService(player, false)
		end

		DisablePlayerVehicleRewards(PlayerId())

		SetPlayerHealthRechargeMultiplier(PlayerId(), 0.0)
		
		SetVehicleDensityMultiplierThisFrame(DensityMultiplier)
		SetPedDensityMultiplierThisFrame(0.50)
		SetRandomVehicleDensityMultiplierThisFrame(DensityMultiplier)
		SetParkedVehicleDensityMultiplierThisFrame(DensityMultiplier)
		-- SetScenarioPedDensityMultiplierThisFrame(0.50, 0.50)

		RemoveAllPickupsOfType(GetHashKey('PICKUP_WEAPON_CARBINERIFLE'))
		RemoveAllPickupsOfType(GetHashKey('PICKUP_WEAPON_PISTOL'))
		RemoveAllPickupsOfType(GetHashKey('PICKUP_WEAPON_PUMPSHOTGUN'))

		local disableShuffle = true
		if IsPedInAnyVehicle(GetPlayerPed(-1), false) and disableShuffle then
			if GetPedInVehicleSeat(GetVehiclePedIsIn(GetPlayerPed(-1), false), 0) == GetPlayerPed(-1) then
				if GetIsTaskActive(GetPlayerPed(-1), 165) then
					SetPedIntoVehicle(GetPlayerPed(-1), GetVehiclePedIsIn(GetPlayerPed(-1), false), 0)
				end
			end
		end

		local playerPed = GetPlayerPed(-1)
		local pos = GetEntityCoords(playerPed)
		RemoveVehiclesFromGeneratorsInArea(pos['x'] - 500.0, pos['y'] - 500.0, pos['z'] - 500.0, pos['x'] + 500.0, pos['y'] + 500.0, pos['z'] + 500.0);
	end
end)


Citizen.CreateThread(function() 
	while true do
	  N_0xf4f2c0d4ee209e20() 
	  Wait(10000)
	end 
end)