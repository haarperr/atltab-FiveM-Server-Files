ESX          = nil
local IsDead = false
local IsAnimated = false
local IsAlreadyDrunk = false
local DrunkLevel     = -1

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

AddEventHandler('esx_basicneeds:resetStatus', function()
	TriggerEvent('esx_status:set', 'hunger', 500000)
	TriggerEvent('esx_status:set', 'thirst', 500000)
end)

RegisterNetEvent('esx_basicneeds:healPlayer')
AddEventHandler('esx_basicneeds:healPlayer', function()
	-- restore hunger & thirst
	TriggerEvent('esx_status:set', 'hunger', 1000000)
	TriggerEvent('esx_status:set', 'thirst', 1000000)

	-- restore hp
	local playerPed = PlayerPedId()
	SetEntityHealth(playerPed, GetEntityMaxHealth(playerPed))
end)

AddEventHandler('esx:onPlayerDeath', function()
	IsDead = true
end)

AddEventHandler('playerSpawned', function(spawn)
	if IsDead then
		TriggerEvent('esx_basicneeds:resetStatus')
	end

	IsDead = false
end)

AddEventHandler('esx_status:loaded', function(status)

	TriggerEvent('esx_status:registerStatus', 'hunger', 1000000, '#FFFF00', function(status) -- #CFAD0F -- Amarelo
		return true
	end, function(status)
		status.remove(100)
	end)

	TriggerEvent('esx_status:registerStatus', 'thirst', 1000000, '#0099FF', function(status) -- #0C98F1 -- Azul
		return true
	end, function(status)
		status.remove(75)
	end)

	Citizen.CreateThread(function()
		while true do
			Citizen.Wait(1000)

			local playerPed  = PlayerPedId()
			local prevHealth = GetEntityHealth(playerPed)
			local health     = prevHealth

			TriggerEvent('esx_status:getStatus', 'hunger', function(status)
				if status.val == 0 then
					if prevHealth <= 150 then
						health = health - 5
					else
						health = health - 1
					end
				end
			end)

			TriggerEvent('esx_status:getStatus', 'thirst', function(status)
				if status.val == 0 then
					if prevHealth <= 150 then
						health = health - 5
					else
						health = health - 1
					end
				end
			end)

			if health ~= prevHealth then
				SetEntityHealth(playerPed, health)
			end
		end
	end)
end)

AddEventHandler('esx_basicneeds:isEating', function(cb)
	cb(IsAnimated)
end)

RegisterNetEvent('esx_basicneeds:onEat')
AddEventHandler('esx_basicneeds:onEat', function(prop_name)
	prop_name = prop_name or 'prop_sandwich_01'
	TriggerEvent('alttab_emotes:Animation', "mp_player_inteat@burger", "mp_player_int_eat_burger_fp", 49)
	TriggerEvent('alttab_emotes:AttachProp', prop_name, 18905, 0.12, 0.028, 0.03, -240.0, -180.0, 0.0)
	exports['progressBars']:startUI(5000, "Pain..")
	Citizen.Wait(5000)
	TriggerEvent('alttab_emotes:StopAnimations')
end)

RegisterNetEvent('esx_basicneeds:onEatChocolate')
AddEventHandler('esx_basicneeds:onEatChocolate', function(prop_name)

	prop_name = prop_name or 'prop_choc_ego'
	TriggerEvent('alttab_emotes:Animation', "mp_player_inteat@burger", "mp_player_int_eat_burger_fp", 49)
	TriggerEvent('alttab_emotes:AttachProp', prop_name, 18905, 0.12, 0.035, 0.009, -30.0, -240.0, -120.0)
	exports['progressBars']:startUI(5000, "Chocolat..")
	Citizen.Wait(5000)
	TriggerEvent('alttab_emotes:StopAnimations')
end)

RegisterNetEvent('esx_basicneeds:onEatCupCake')
AddEventHandler('esx_basicneeds:onEatCupCake', function(prop_name)


	prop_name = prop_name or 'ng_proc_food_ornge1a'
	TriggerEvent('alttab_emotes:Animation', "mp_player_inteat@burger", "mp_player_int_eat_burger_fp", 49)
	TriggerEvent('alttab_emotes:AttachProp', prop_name, 18905, 0.12, 0.045, 0.06, 45.0, 175.0, 0.0)
	exports['progressBars']:startUI(5000, "Gâteau..")
	Citizen.Wait(5000)
	TriggerEvent('alttab_emotes:StopAnimations')
end)

RegisterNetEvent('esx_basicneeds:onEatChips')
AddEventHandler('esx_basicneeds:onEatChips', function(prop_name)

	prop_name = prop_name or 'v_ret_ml_chips4'
	TriggerEvent('alttab_emotes:Animation', "mp_player_inteat@burger", "mp_player_int_eat_burger_fp", 49)
	TriggerEvent('alttab_emotes:AttachProp', prop_name, 18905, 0.12, 0.028, 0.001, 10.0, 175.0, 0.0)
	exports['progressBars']:startUI(5000, "Chips..")
	Citizen.Wait(5000)
	TriggerEvent('alttab_emotes:StopAnimations')
end)

RegisterNetEvent('esx_basicneeds:onEatSandwich')
AddEventHandler('esx_basicneeds:onEatSandwich', function(prop_name)
		prop_name = prop_name or 'prop_cs_burger_01'
		TriggerEvent('alttab_emotes:Animation', "mp_player_inteat@burger", "mp_player_int_eat_burger_fp", 49)
		TriggerEvent('alttab_emotes:AttachProp', prop_name, 18905, 0.11, 0.045, 0.02, 10.0, 175.0, 0.0)
		exports['progressBars']:startUI(10000, "Sandwich..")
		Citizen.Wait(10000)
		TriggerEvent('alttab_emotes:StopAnimations')
end)

RegisterNetEvent('esx_basicneeds:onDrink')
AddEventHandler('esx_basicneeds:onDrink', function(prop_name)
	prop_name = prop_name or 'prop_ld_flow_bottle'
	TriggerEvent('alttab_emotes:Animation', "mp_player_intdrink", "loop_bottle", 49)
	TriggerEvent('alttab_emotes:AttachProp', prop_name, 18905, 0.12, -0.02, 0.03, 260.0, 0.0, -20.0)
		exports['progressBars']:startUI(10000, "Eau..")
		Citizen.Wait(10000)
		TriggerEvent('alttab_emotes:StopAnimations')
end)

RegisterNetEvent('esx_basicneeds:onDrinkCocaCola')
AddEventHandler('esx_basicneeds:onDrinkCocaCola', function(prop_name)
	prop_name = prop_name or 'prop_ecola_can'
	TriggerEvent('alttab_emotes:Animation', "mp_player_intdrink", "loop_bottle", 49)
	TriggerEvent('alttab_emotes:AttachProp', prop_name, 18905, 0.12, 0.008, 0.03, 240.0, 0.0, 0.0)
		exports['progressBars']:startUI(5000, "Coca Cola..")
		Citizen.Wait(5000)
		TriggerEvent('alttab_emotes:StopAnimations')
end)

RegisterNetEvent('esx_basicneeds:onDrinkIceTea')
AddEventHandler('esx_basicneeds:onDrinkIceTea', function(prop_name)
		prop_name = prop_name or 'prop_orang_can_01'
		TriggerEvent('alttab_emotes:Animation', "mp_player_intdrink", "loop_bottle", 49)
		TriggerEvent('alttab_emotes:AttachProp', prop_name, 18905, 0.12, 0.008, 0.03, 240.0, 0.0, 0.0)
			exports['progressBars']:startUI(5000, "Coca Cola..")
			Citizen.Wait(5000)
			TriggerEvent('alttab_emotes:StopAnimations')
end)

RegisterNetEvent('esx_basicneeds:onDrinkCoffe')
AddEventHandler('esx_basicneeds:onDrinkCoffe', function(prop_name)
	prop_name = prop_name or 'prop_fib_coffee'
	TriggerEvent('alttab_emotes:Animation', "amb@world_human_aa_coffee@idle_a", "idle_a", 49)
	TriggerEvent('alttab_emotes:AttachProp', prop_name, 57005, 0.12, 0.01, -0.025, -75.0, 0.0, 0.0)
end)

RegisterNetEvent('esx_basicneeds:onDrinkRedBull')
AddEventHandler('esx_basicneeds:onDrinkRedBull', function(prop_name)
	local player = PlayerId()
	prop_name = prop_name or 'prop_ecola_can'
	TriggerEvent('alttab_emotes:Animation', "mp_player_intdrink", "loop_bottle", 49)
	TriggerEvent('alttab_emotes:AttachProp', prop_name, 18905, 0.12, 0.008, 0.03, 240.0, 0.0, 0.0)
	exports['progressBars']:startUI(5000, "RedBull..")
	Citizen.Wait(5000)
	TriggerEvent('alttab_emotes:StopAnimations')
	RestorePlayerStamina(player, 1.0)
	SetRunSprintMultiplierForPlayer(player, 1.25)
	Citizen.Wait(30000)
	SetRunSprintMultiplierForPlayer(player, 1.0)
end)

-- Bar drinks
RegisterNetEvent('esx_basicneeds:onDrinkBeer')
AddEventHandler('esx_basicneeds:onDrinkBeer', function(prop_name)
		prop_name = prop_name or 'prop_amb_beer_bottle'
		TriggerEvent('alttab_emotes:Animation', "amb@world_human_drinking@beer@male@idle_a", "idle_a", 49)
		TriggerEvent('alttab_emotes:AttachProp', prop_name, 57005, 0.13, 0.0, -0.045, -75.0, 0.0, 0.0)
end)

RegisterNetEvent('esx_basicneeds:onDrinkWine')
AddEventHandler('esx_basicneeds:onDrinkWine', function(prop_name)
	prop_name = prop_name or 'prop_wine_bot_01'
	TriggerEvent('alttab_emotes:Animation', "amb@world_human_drinking@beer@male@idle_a", "idle_a", 49)
	TriggerEvent('alttab_emotes:AttachProp', prop_name, 57005, 0.13, -0.20, -0.1, -75.0, 0.0, 0.0)
end)

RegisterNetEvent('esx_basicneeds:onDrinkVodka')
AddEventHandler('esx_basicneeds:onDrinkVodka', function(prop_name)
		prop_name = prop_name or 'prop_vodka_bottle'
		TriggerEvent('alttab_emotes:Animation', "amb@world_human_drinking@beer@male@idle_a", "idle_a", 49)
		TriggerEvent('alttab_emotes:AttachProp', prop_name, 57005, 0.13, -0.22, -0.11, -75.0, 0.0, 0.0)
end)

RegisterNetEvent('esx_basicneeds:onDrinkWhisky')
AddEventHandler('esx_basicneeds:onDrinkWhisky', function(prop_name)
		prop_name = prop_name or 'prop_cs_whiskey_bottle'
		TriggerEvent('alttab_emotes:Animation', "amb@world_human_drinking@beer@male@idle_a", "idle_a", 49)
		TriggerEvent('alttab_emotes:AttachProp', prop_name, 57005, 0.13, 0.02, -0.05, -75.0, 0.0, 0.0)
end)

RegisterNetEvent('esx_basicneeds:onDrinkTequila')
AddEventHandler('esx_basicneeds:onDrinkTequila', function(prop_name)
		prop_name = prop_name or 'prop_tequila_bottle'
		TriggerEvent('alttab_emotes:Animation', "amb@world_human_drinking@beer@male@idle_a", "idle_a", 49)
		TriggerEvent('alttab_emotes:AttachProp', prop_name, 57005, 0.13, -0.17, -0.12, -75.0, 0.0, 0.0)
end)

RegisterNetEvent('esx_basicneeds:onDrinkMilk')
AddEventHandler('esx_basicneeds:onDrinkMilk', function(prop_name)
		prop_name = prop_name or 'prop_fib_coffee'
		TriggerEvent('alttab_emotes:Animation', "mp_player_intdrink", "loop_bottle", 49)
		TriggerEvent('alttab_emotes:AttachProp', prop_name, 18905, 0.12, 0.008, 0.03, 240.0, 0.0, 0.0)
		exports['progressBars']:startUI(5000, "Laît..")
		Citizen.Wait(5000)
		TriggerEvent('alttab_emotes:StopAnimations')
end)

RegisterNetEvent('esx_basicneeds:onDrinkChampagne')
AddEventHandler('esx_basicneeds:onDrinkChampagne', function(prop_name)
		prop_name = prop_name or 'prop_wine_white'
		TriggerEvent('alttab_emotes:Animation', "amb@world_human_drinking@beer@male@idle_a", "idle_a", 49)
		TriggerEvent('alttab_emotes:AttachProp', prop_name, 57005, 0.13, -0.17, -0.12, -75.0, 0.0, 0.0)
end)

-- Cigarett 
RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
  PlayerData = xPlayer
end)

RegisterNetEvent('esx_cigarett:startSmoke')
AddEventHandler('esx_cigarett:startSmoke', function(source)
	SmokeAnimation()
end)

RegisterNetEvent('esx_cigarett:startMakingJoint')
AddEventHandler('esx_cigarett:startMakingJoint', function()
	exports['progressBars']:startUI(5000, "Joint..")
end)

RegisterNetEvent('esx_cigarett:startSmokeWeed')
AddEventHandler('esx_cigarett:startSmokeWeed', function(source)
	SmokeWeedAnimation()
end)


function SmokeAnimation()
	local playerPed = GetPlayerPed(-1)
	
	Citizen.CreateThread(function()
		TaskStartScenarioInPlace(playerPed, "WORLD_HUMAN_SMOKING", 0, true)               
	end)
end

function SmokeWeedAnimation()
	local playerPed = GetPlayerPed(-1)
	
	Citizen.CreateThread(function()
		TaskStartScenarioInPlace(playerPed, "WORLD_HUMAN_SMOKING_POT", 0, true)               
	end)
end

-- Optionalneeds
function Drunk(level, start)
  
  Citizen.CreateThread(function()
     local playerPed = GetPlayerPed(-1)
     if start then
      DoScreenFadeOut(800)
      Wait(1000)
    end
     if level == 0 then
       RequestAnimSet("move_m@drunk@slightlydrunk")
      
      while not HasAnimSetLoaded("move_m@drunk@slightlydrunk") do
        Citizen.Wait(0)
      end
       SetPedMovementClipset(playerPed, "move_m@drunk@slightlydrunk", true)
     elseif level == 1 then
       RequestAnimSet("move_m@drunk@moderatedrunk")
      
      while not HasAnimSetLoaded("move_m@drunk@moderatedrunk") do
        Citizen.Wait(0)
      end
       SetPedMovementClipset(playerPed, "move_m@drunk@moderatedrunk", true)
     elseif level == 2 then
       RequestAnimSet("move_m@drunk@verydrunk")
      
      while not HasAnimSetLoaded("move_m@drunk@verydrunk") do
        Citizen.Wait(0)
      end
       SetPedMovementClipset(playerPed, "move_m@drunk@verydrunk", true)
     end
     SetTimecycleModifier("spectator5")
    SetPedMotionBlur(playerPed, true)
    SetPedIsDrunk(playerPed, true)
     if start then
      DoScreenFadeIn(800)
    end
   end)
 end
 function Reality()
   Citizen.CreateThread(function()
     local playerPed = GetPlayerPed(-1)
     DoScreenFadeOut(800)
    Wait(1000)
     ClearTimecycleModifier()
    ResetScenarioTypesEnabled()
    ResetPedMovementClipset(playerPed, 0)
    SetPedIsDrunk(playerPed, false)
    SetPedMotionBlur(playerPed, false)
     DoScreenFadeIn(800)
   end)
 end
 AddEventHandler('esx_status:loaded', function(status)
   TriggerEvent('esx_status:registerStatus', 'drunk', 0, '#FFC0CB', --roxo
    function(status)
      if status.val > 0 then
        return true
      else
        return false
      end
    end,
    function(status)
      status.remove(1500)
    end
  )
 	Citizen.CreateThread(function()
 		while true do
 			Wait(1000)
 			TriggerEvent('esx_status:getStatus', 'drunk', function(status)
				
				if status.val > 0 then
					
          local start = true
           if IsAlreadyDrunk then
            start = false
          end
           local level = 0
           if status.val <= 250000 then
            level = 0
          elseif status.val <= 500000 then
            level = 1
          else
            level = 2
          end
           if level ~= DrunkLevel then
            Drunk(level, start)
          end
           IsAlreadyDrunk = true
          DrunkLevel     = level
				end
 				if status.val == 0 then
          
          if IsAlreadyDrunk then
            Reality()
          end
           IsAlreadyDrunk = false
          DrunkLevel     = -1
 				end
 			end)
 		end
 	end)
 end)
 RegisterNetEvent('esx_optionalneeds:onDrink')
AddEventHandler('esx_optionalneeds:onDrink', function()
  
  local playerPed = GetPlayerPed(-1)
  
  TaskStartScenarioInPlace(playerPed, "WORLD_HUMAN_DRINKING", 0, 1)
  Citizen.Wait(1000)
  ClearPedTasksImmediately(playerPed)
 end) 
