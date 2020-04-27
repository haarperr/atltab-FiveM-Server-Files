local playerCurrentlyAnimated = false
local playerCurrentlyHasProp = false
local playerCurrentlyHasWalkstyle = false
local surrendered = false
local firstAnim = true
local playerPropList = {}
local LastAD

Citizen.CreateThread( function()
	while true do
		Citizen.Wait(5)
		if (IsControlJustPressed(0,Config.StopAnimationKey)) then
			local player = PlayerPedId()
			if ( DoesEntityExist( player ) and not IsEntityDead( player ) ) then
				if IsEntityPlayingAnim(player, "random@mugging3", "handsup_standing_base", 3) or 
					IsEntityPlayingAnim(player, "anim@mp_player_intincarthumbs_upbodhi@ps@", "idle_a", 3)	then
					ClearPedSecondaryTask(player)
				else
					TriggerEvent('alttab_emotes:StopAnimations')
				end
			end
		end
	end
end)

RegisterNetEvent('alttab_emotes:KillProps')
AddEventHandler('alttab_emotes:KillProps', function()
	for _,v in pairs(playerPropList) do
		DeleteEntity(v)
	end

	playerCurrentlyHasProp = false
end)

RegisterNetEvent('alttab_emotes:AttachProp')
AddEventHandler('alttab_emotes:AttachProp', function(prop_one, boneone, x1, y1, z1, r1, r2, r3)
	local player = PlayerPedId()
	local x,y,z = table.unpack(GetEntityCoords(player))

	if not HasModelLoaded(prop_one) then
		loadPropDict(prop_one)
	end

	prop = CreateObject(GetHashKey(prop_one), x, y, z+0.2,  true,  true, true)
	AttachEntityToEntity(prop, player, GetPedBoneIndex(player, boneone), x1, y1, z1, r1, r2, r3, true, true, false, true, 1, true)
	SetModelAsNoLongerNeeded(prop_one)
	table.insert(playerPropList, prop)
	playerCurrentlyHasProp = true
end)

RegisterNetEvent('alttab_emotes:Animation')
AddEventHandler('alttab_emotes:Animation', function(ad, anim, body)
	local player = PlayerPedId()
	if playerCurrentlyAnimated then -- Cancel Old Animation

		loadAnimDict(ad)
		TaskPlayAnim( player, ad, "exit", 8.0, 1.0, -1, body, 0, 0, 0, 0 )
		Wait(750)
		ClearPedSecondaryTask(player)
		RemoveAnimDict(LastAD)
		RemoveAnimDict(ad)
		LastAD = ad
		playerCurrentlyAnimated = false
		TriggerEvent('alttab_emotes:KillProps')
		return
	end

	if firstAnim then
		LastAD = ad
		firstAnim = false
	end

	loadAnimDict(ad)
	TaskPlayAnim(player, ad, anim, 4.0, 1.0, -1, body, 0, 0, 0, 0 )  --- We actually play the animation here
	RemoveAnimDict(ad)
	playerCurrentlyAnimated = true

end)

RegisterNetEvent('alttab_emotes:StopAnimations')
AddEventHandler('alttab_emotes:StopAnimations', function()

	local player = PlayerPedId()
	if vehiclecheck() then
		if IsPedUsingAnyScenario(player) then
			--ClearPedSecondaryTask(player)
			ClearPedTasks(player)
		end

		if playerCurrentlyHasWalkstyle then
			ResetPedMovementClipset(player, 0.0)
			playerCurrentlyHasWalkstyle = false
		end

		if playerCurrentlyAnimated then
			if LastAD then
				RemoveAnimDict(LastAD)
			end

			if playerCurrentlyHasProp then
				TriggerEvent('alttab_emotes:KillProps')
				playerCurrentlyHasProp = false
			end

			if surrendered then
				surrendered = false
			end

			--ClearPedSecondaryTask(player)
			ClearPedTasks(player)
			playerCurrentlyAnimated = false
		end
	end
end)

RegisterNetEvent('alttab_emotes:Scenario')
AddEventHandler('alttab_emotes:Scenario', function(ad)
	local player = PlayerPedId()
	TaskStartScenarioInPlace(player, ad, 0, 1)   
end)

RegisterNetEvent('alttab_emotes:Walking')
AddEventHandler('alttab_emotes:Walking', function(ad)
	local player = PlayerPedId()
	ResetPedMovementClipset(player, 0.0)
	RequestWalking(ad)
	SetPedMovementClipset(player, ad, 0.25)
	RemoveAnimSet(ad)
end)

RegisterNetEvent('alttab_emotes:Surrender')  -- Too many waits to make it work properly within the config
AddEventHandler('alttab_emotes:Surrender', function()
	local player = PlayerPedId()
	local ad = "random@arrests"
	local ad2 = "random@arrests@busted"

	if ( DoesEntityExist( player ) and not IsEntityDead( player )) then 
		loadAnimDict( ad )
		loadAnimDict( ad2 )
		if ( IsEntityPlayingAnim( player, ad2, "idle_a", 3 ) ) then 
			TaskPlayAnim( player, ad2, "exit", 8.0, 1.0, -1, 2, 0, 0, 0, 0 )
			Wait (3000)
			TaskPlayAnim( player, ad, "kneeling_arrest_get_up", 8.0, 1.0, -1, 128, 0, 0, 0, 0 )
			RemoveAnimDict("random@arrests@busted")
			RemoveAnimDict("random@arrests" )
			surrendered = false
			LastAD = ad
			playerCurrentlyAnimated = false
		else

			TaskPlayAnim( player, "random@arrests", "idle_2_hands_up", 8.0, 1.0, -1, 2, 0, 0, 0, 0 )
			Wait (2500)
			TaskPlayAnim( player, "random@arrests", "kneeling_arrest_idle", 8.0, 1.0, -1, 2, 0, 0, 0, 0 )
			Wait (500)
			TaskPlayAnim( player, "random@arrests@busted", "enter", 8.0, 1.0, -1, 2, 0, 0, 0, 0 )
			Wait (500)
			TaskPlayAnim( player, "random@arrests@busted", "idle_a", 8.0, 1.0, -1, 9, 0, 0, 0, 0 )
			Wait(100)
			surrendered = true
			playerCurrentlyAnimated = true
			LastAD = ad2
			RemoveAnimDict("random@arrests" )
			RemoveAnimDict("random@arrests@busted")
		end     
	end
end)

AddEventHandler('onResourceStop', function(resource)
	if resource == GetCurrentResourceName() then
		TriggerEvent('alttab_emotes:KillProps')
		playerCurrentlyHasProp = false
	end
end)

RegisterCommand("e", function(source, args)

	local player = PlayerPedId()
	local pos = GetEntityCoords(player)
	local argh = tostring(args[1])

	if argh == 'h' then -- List Anims in Chat Command
		TriggerEvent('chat:addMessage', { args = { '^2[Animations]^0 Liste des animations sur notre ^5siteweb^0, catégorie ^5Annonces & Informations'} })
	elseif argh == 's' then -- Deletes Clients Props Command
		TriggerEvent('alttab_emotes:KillProps')
	elseif argh == 'f' then -- I'll figure out a better way to do animations with this much depth later.
		TriggerEvent('alttab_emotes:Surrender')
	elseif argh == 'sit' then -- I'll figure out a better way to do animations with this much depth later.
		TaskStartScenarioAtPosition(player, "PROP_HUMAN_SEAT_BENCH", pos.x + 0.5, pos.y, pos.z - 0.5, GetEntityHeading(player), 0, true, true)
	elseif argh == 'hu' then -- Handsup Animations
		-- local player = PlayerPedId()
		if ( DoesEntityExist( player ) and not IsEntityDead( player ) ) then
			if IsEntityPlayingAnim(player, "random@mugging3", "handsup_standing_base", 3) then
				ClearPedSecondaryTask(player)
			else
				loadAnimDict( "random@mugging3" )
				TaskPlayAnim(player, "random@mugging3", "handsup_standing_base", 2.0, 2.5, -1, 49, 0, 0, 0, 0 )
				RemoveAnimDict("random@mugging3")
			end
		end
	elseif argh == 'tu' then -- Thumbsup Animations
		-- local player = PlayerPedId()
		local handsup = false
		if ( DoesEntityExist( player ) and not IsEntityDead( player ) ) then
			if IsEntityPlayingAnim(player, "anim@mp_player_intincarthumbs_upbodhi@ps@", "idle_a", 3) then
				ClearPedSecondaryTask(player)
			else
				loadAnimDict( "anim@mp_player_intincarthumbs_upbodhi@ps@" )
				-- TaskPlayAnim(player, "anim@mp_player_intincarthumbs_upbodhi@ps@", "enter", 8.0, 8.0, -1, 49, 0, 0, 0, 0 )
				-- Citizen.Wait(800)
				TaskPlayAnim(player, "anim@mp_player_intincarthumbs_upbodhi@ps@", "idle_a", 8.0, 8.0, -1, 49, 0, 0, 0, 0 )
				RemoveAnimDict("anim@mp_player_intincarthumbs_upbodhi@ps@")
			end
		end
	else
		for i = 1, #Config.Anims, 1 do
			local name = Config.Anims[i].name
			if argh == name then				
				local prop_one = Config.Anims[i].data.prop
				local boneone = Config.Anims[i].data.boneone
				if ( DoesEntityExist( player ) and not IsEntityDead( player )) then 

					if Config.Anims[i].data.type == 'prop' then
						if playerCurrentlyHasProp then --- Delete Old Prop

							TriggerEvent('alttab_emotes:KillProps')
						end
						
						TriggerEvent('alttab_emotes:AttachProp', prop_one, boneone, Config.Anims[i].data.x, Config.Anims[i].data.y, Config.Anims[i].data.z, Config.Anims[i].data.xa, Config.Anims[i].data.yb, Config.Anims[i].data.zc)

					elseif Config.Anims[i].data.type == 'brief' then

						if name == 'brief2' then
							GiveWeaponToPed(player, 0x88C78EB7, 1, false, true)
						else
							GiveWeaponToPed(player, 0x01B79F17, 1, false, true)
						end
						return
					elseif Config.Anims[i].data.type == 'scenario' then
						local ad = Config.Anims[i].data.ad

						if vehiclecheck() then
							if IsPedActiveInScenario(player) then
								ClearPedTasks(player)
							else
								TriggerEvent('alttab_emotes:Scenario', ad)
							end 
						end

					elseif Config.Anims[i].data.type == 'walkstyle' then
						local ad = Config.Anims[i].data.ad
						if vehiclecheck() then
							TriggerEvent('alttab_emotes:Walking', ad)
							if not playerCurrentlyHasWalkstyle then
								playerCurrentlyHasWalkstyle = true
							end
						end
					else

						if vehiclecheck() then
							local ad = Config.Anims[i].data.ad
							local anim = Config.Anims[i].data.anim
							local body = Config.Anims[i].data.body
							
							TriggerEvent('alttab_emotes:Animation', ad, anim, body) -- Load/Start animation

							if prop_one ~= 0 then
								local prop_two = Config.Anims[i].data.proptwo
								local bonetwo = nil

								loadPropDict(prop_one)
								TriggerEvent('alttab_emotes:AttachProp', prop_one, boneone, Config.Anims[i].data.x, Config.Anims[i].data.y, Config.Anims[i].data.z, Config.Anims[i].data.xa, Config.Anims[i].data.yb, Config.Anims[i].data.zc)
								if prop_two ~= 0 then
									bonetwo = Config.Anims[i].data.bonetwo
									prop_two = Config.Anims[i].data.proptwo
									loadPropDict(prop_two)
									TriggerEvent('alttab_emotes:AttachProp', prop_two, bonetwo, Config.Anims[i].data.twox, Config.Anims[i].data.twoy, Config.Anims[i].data.twoz, Config.Anims[i].data.twoxa, Config.Anims[i].data.twoyb, Config.Anims[i].data.twozc)
								end
							end
						end
					end
				end
			end
		end
	end
end)

function loadAnimDict(dict)
	RequestAnimDict(dict)
	while not HasAnimDictLoaded(dict) do
		Citizen.Wait(500)
	end
end

function loadPropDict(model)
	RequestModel(GetHashKey(model))
	while not HasModelLoaded(GetHashKey(model)) do
		Citizen.Wait(500)
	end
end

function RequestWalking(ad)
	RequestAnimSet( ad )
	while ( not HasAnimSetLoaded( ad ) ) do 
		Citizen.Wait( 500 )
	end 
end

function vehiclecheck()
	local player = PlayerPedId()
	if IsPedInAnyVehicle(player, false) then
		return false
	end
	return true
end
