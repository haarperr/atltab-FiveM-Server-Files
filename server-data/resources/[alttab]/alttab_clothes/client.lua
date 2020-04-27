ESX  = nil

Citizen.CreateThread(function()
  while ESX == nil do
    TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
    Wait(0)
  end
end)

function SetUnsetAccessory(accessory)
	ESX.TriggerServerCallback('esx_accessories:get', function(hasAccessory, accessorySkin)
		local _accessory = string.lower(accessory)

		if hasAccessory then
			TriggerEvent('skinchanger:getSkin', function(skin)
				local mAccessory = -1
				local mColor = 0

				if _accessory == "mask" then
					mAccessory = 0
				end

				if skin[_accessory .. '_1'] == mAccessory then
					mAccessory = accessorySkin[_accessory .. '_1']
					mColor = accessorySkin[_accessory .. '_2']
				end

				local accessorySkin = {}
				accessorySkin[_accessory .. '_1'] = mAccessory
				accessorySkin[_accessory .. '_2'] = mColor
				TriggerEvent('alttab_emotes:Animation', "anim@mp_player_intupperface_palm", "idle_a", 49)
				Wait(600)
				TriggerEvent('alttab_emotes:StopAnimations')
				TriggerEvent('skinchanger:loadClothes', skin, accessorySkin)
			end)
		else
			ESX.ShowNotification('no' .. _accessory)
		end

	end, accessory)
end

RegisterCommand('c', function(source, args)
	local player = GetPlayerPed(-1)
	local argh = tostring(args[1])
	local clothesSkin

	if (argh == "all") then
		TriggerEvent('alttab_emotes:Animation', "veh@common@fp_helmet@", "put_on_helmet", 49)
		Wait(1500)
		TriggerEvent('alttab_emotes:StopAnimations')
		ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
			TriggerEvent('skinchanger:loadSkin', skin)
		end)
	end

	if (argh == "torso") then
		TriggerEvent('alttab_emotes:Animation', "veh@common@fp_helmet@", "take_off_helmet_stand", 49)
		Wait(600)
		TriggerEvent('alttab_emotes:StopAnimations')
		TriggerEvent('skinchanger:getSkin', function(skin)
			if skin.sex == 0 then
				clothesSkin = {
					['chain_1'] = 0, ['chain_2'] = 0,
					['tshirt_1'] = 15, ['tshirt_2'] = 0,
					['torso_1'] = 15, ['torso_2'] = 0,
					['arms'] = 15, ['arms_2'] = 0
				}
			else
				clothesSkin = {
					['chain_1'] = 78, ['chain_2'] = 0,
					['tshirt_1'] = 14, ['tshirt_2'] = 0,
					['torso_1'] = 15, ['torso_2'] = 11,
					['arms'] = 15, ['arms_2'] = 0
				}
			end
		TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
		end)
	-- elseif (argh == "gillet") then
	-- 	TriggerEvent('alttab_emotes:Animation', "veh@common@fp_helmet@", "take_off_helmet_stand", 49)
	-- 	Wait(600)
	-- 	TriggerEvent('alttab_emotes:StopAnimations')
	-- 	TriggerEvent('skinchanger:getSkin', function(skin)
	-- 		if skin.sex == 0 then
	-- 			clothesSkin = {
	-- 				['bproof_1'] = 0, ['bproof_2'] = 0,
	-- 			}
	-- 		else
	-- 			clothesSkin = {
	-- 				['bproof_1'] = 0, ['bproof_2'] = 0,
	-- 			}
	-- 		end
	-- 	TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
	-- 	end)
	elseif (argh == "pants") then
		TriggerEvent('alttab_emotes:Animation', "clothingtrousers", "try_trousers_neutral_c", 49)
		Wait(600)
		TriggerEvent('alttab_emotes:StopAnimations')
		TriggerEvent('skinchanger:getSkin', function(skin)
			if skin.sex == 0 then
				clothesSkin = {
					['pants_1'] = 61, ['pants_2'] = 1
				}
			else
				clothesSkin = {
					['pants_1'] = 15, ['pants_2'] = 11
				}
			end
		TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
		end)
	elseif (argh == "shoes") then
		TriggerEvent('alttab_emotes:Animation', "clothingshoes", "try_shoes_positive_a", 49)
		Wait(600)
		TriggerEvent('alttab_emotes:StopAnimations')
		TriggerEvent('skinchanger:getSkin', function(skin)
			if skin.sex == 0 then
				clothesSkin = {
					['shoes_1'] = 34, ['shoes_2'] = 0
				}
			else
				clothesSkin = {
					['shoes_1'] = 35, ['shoes_2'] = 0
				}
			end
		TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
		end)
	elseif (argh == "bag") then
		TriggerEvent('alttab_emotes:Animation', "veh@common@fp_helmet@", "take_off_helmet_stand", 49)
		Wait(600)
		TriggerEvent('alttab_emotes:StopAnimations')
		TriggerEvent('skinchanger:getSkin', function(skin)
			if skin.sex == 0 then
				clothesSkin = {
					['bags_1'] = 0, ['bags_2'] = 0
				}
			else
				clothesSkin = {
					['bags_1'] = 0, ['bags_2'] = 0
				}
			end
		TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
		end)
	end
end, false)




RegisterCommand('a', function(source, args)
	local player = GetPlayerPed(-1)
	local argh = tostring(args[1])

	if (argh == "mask") then
		SetUnsetAccessory('Mask')
	elseif (argh == "ears") then
		SetUnsetAccessory('Ears')
	elseif (argh == "helmet") then
		SetUnsetAccessory('Helmet')
	elseif (argh == "glasses") then
		SetUnsetAccessory('Glasses')
	elseif (argh == "gillet") then
	SetUnsetAccessory('bproof')
	end
end, false)