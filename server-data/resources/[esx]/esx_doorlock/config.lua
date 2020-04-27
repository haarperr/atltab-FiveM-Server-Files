Config = {}
Config.Locale = 'fr'

Config.DoorList = {

	--
	-- Mission Row First Floor
	--

	-- Entrance Doors
	{
		textCoords = vector3(434.7, -982.0, 31.5),
		authorizedJobs = { 'police' },
		locked = false,
		distance = 2.5,
		doors = {
			{
				objName = 'v_ilev_ph_door01',
				objYaw = -90.0,
				objCoords = vector3(434.7, -980.6, 30.8)
			},

			{
				objName = 'v_ilev_ph_door002',
				objYaw = -90.0,
				objCoords = vector3(434.7, -983.2, 30.8)
			}
		}
	},

	-- To locker room & roof
	{
		objName = 'v_ilev_ph_gendoor004',
		objYaw = 90.0,
		objCoords  = vector3(449.6, -986.4, 30.6),
		textCoords = vector3(450.1, -986.3, 31.7),
		authorizedJobs = { 'police' },
		locked = true
	},

	-- Rooftop
	{
		objName = 'v_ilev_gtdoor02',
		objYaw = 90.0,
		objCoords  = vector3(464.3, -984.6, 43.8),
		textCoords = vector3(464.3, -984.0, 44.8),
		authorizedJobs = { 'police' },
		locked = true
	},

	-- Hallway to roof
	{
		objName = 'v_ilev_arm_secdoor',
		objYaw = 90.0,
		objCoords  = vector3(461.2, -985.3, 30.8),
		textCoords = vector3(461.5, -986.0, 31.5),
		authorizedJobs = { 'police' },
		locked = true
	},

	-- Armory
	{
		objName = 'v_ilev_arm_secdoor',
		objYaw = -90.0,
		objCoords  = vector3(452.6, -982.7, 30.6),
		textCoords = vector3(453.0, -982.6, 31.7),
		authorizedJobs = { 'police' },
		locked = true
	},

	-- Captain Office
	{
		objName = 'v_ilev_ph_gendoor002',
		objYaw = -180.0,
		objCoords  = vector3(447.2, -980.6, 30.6),
		textCoords = vector3(447.2, -980.0, 31.7),
		authorizedJobs = { 'police' },
		locked = true
	},

	-- To downstairs (double doors)
	{
		textCoords = vector3(444.6, -989.4, 31.7),
		authorizedJobs = { 'police' },
		locked = true,
		distance = 4,
		doors = {
			{
				objName = 'v_ilev_ph_gendoor005',
				objYaw = 180.0,
				objCoords = vector3(443.9, -989.0, 30.6)
			},

			{
				objName = 'v_ilev_ph_gendoor005',
				objYaw = 0.0,
				objCoords = vector3(445.3, -988.7, 30.6)
			}
		}
	},

	--
	-- Mission Row Cells
	--

	-- Main Cells
	{
		objName = 'v_ilev_ph_cellgate',
		objYaw = 0.0,
		objCoords  = vector3(463.8, -992.6, 24.9),
		textCoords = vector3(463.3, -992.6, 25.1),
		authorizedJobs = { 'police' },
		locked = true
	},

	-- Cell 1
	{
		objName = 'v_ilev_ph_cellgate',
		objYaw = -90.0,
		objCoords  = vector3(462.3, -993.6, 24.9),
		textCoords = vector3(461.8, -993.3, 25.0),
		authorizedJobs = { 'police' },
		locked = true
	},

	-- Cell 2
	{
		objName = 'v_ilev_ph_cellgate',
		objYaw = 90.0,
		objCoords  = vector3(462.3, -998.1, 24.9),
		textCoords = vector3(461.8, -998.8, 25.0),
		authorizedJobs = { 'police' },
		locked = true
	},

	-- Cell 3
	{
		objName = 'v_ilev_ph_cellgate',
		objYaw = 90.0,
		objCoords  = vector3(462.7, -1001.9, 24.9),
		textCoords = vector3(461.8, -1002.4, 25.0),
		authorizedJobs = { 'police' },
		locked = true
	},

	-- To Back
	{
		objName = 'v_ilev_gtdoor',
		objYaw = 0.0,
		objCoords  = vector3(463.4, -1003.5, 25.0),
		textCoords = vector3(464.0, -1003.5, 25.5),
		authorizedJobs = { 'police' },
		locked = true
	},

	--
	-- Mission Row Back
	--

	-- Back (double doors)
	{
		textCoords = vector3(468.6, -1014.4, 27.1),
		authorizedJobs = { 'police' },
		locked = true,
		distance = 4,
		doors = {
			{
				objName = 'v_ilev_rc_door2',
				objYaw = 0.0,
				objCoords  = vector3(467.3, -1014.4, 26.5)
			},

			{
				objName = 'v_ilev_rc_door2',
				objYaw = 180.0,
				objCoords  = vector3(469.9, -1014.4, 26.5)
			}
		}
	},

	-- Back Gate
	{
		objName = 'hei_prop_station_gate',
		objYaw = 90.0,
		objCoords  = vector3(488.8, -1017.2, 27.1),
		textCoords = vector3(488.8, -1020.2, 30.0),
		authorizedJobs = { 'police' },
		locked = true,
		distance = 14,
		size = 2
	},

	--
	-- Sandy Shores
	--

	-- Entrance
	{
		objName = 'v_ilev_shrfdoor',
		objYaw = 30.0,
		objCoords  = vector3(1855.1, 3683.5, 34.2),
		textCoords = vector3(1855.1, 3683.5, 35.0),
		authorizedJobs = { 'police' },
		locked = false
	},

	--
	-- Paleto Bay
	--

	-- Entrance (double doors)
	{
		textCoords = vector3(-443.5, 6016.3, 32.0),
		authorizedJobs = { 'police' },
		locked = false,
		distance = 2.5,
		doors = {
			{
				objName = 'v_ilev_shrf2door',
				objYaw = -45.0,
				objCoords  = vector3(-443.1, 6015.6, 31.7),
			},

			{
				objName = 'v_ilev_shrf2door',
				objYaw = 135.0,
				objCoords  = vector3(-443.9, 6016.6, 31.7)
			}
		}
	},

	--
	-- Bolingbroke Penitentiary
	--

	-- Entrance (Two big gates)
	{
		objName = 'prop_gate_prison_01',
		objCoords  = vector3(1844.9, 2604.8, 44.6),
		textCoords = vector3(1844.9, 2608.5, 48.0),
		authorizedJobs = { 'police' },
		locked = true,
		distance = 12,
		size = 2
	},

	{
		objName = 'prop_gate_prison_01',
		objCoords  = vector3(1818.5, 2604.8, 44.6),
		textCoords = vector3(1818.5, 2608.4, 48.0),
		authorizedJobs = { 'police' },
		locked = true,
		distance = 12,
		size = 2
	},

	--paletoJAD

	{
		objName = 'v_ilev_bk_door2',
		objCoords  = vector3(-442.33, 6011.42, 31.72),
		textCoords = vector3(-441.85, 6011.91, 31.72),
		authorizedJobs = { 'police' },
		locked = true,
		distance = 3,
		size = 0.5
	},

	{
		objName = 'v_ilev_bk_door2',
		objCoords  = vector3(-441.14, 6012.19, 31.72),
		textCoords = vector3(-441.85, 6011.91, 31.72),
		authorizedJobs = { 'police' },
		locked = true,
		distance = 3,
		size = 0.5
	},

	{
		objName = 'V_ILev_RC_Door2',
		objCoords  = vector3(-450.36, 6016.19, 31.72),
		textCoords = vector3(-450.36, 6016.19, 31.72),
		authorizedJobs = { 'police' },
		locked = true,
		distance = 3,
		size = 0.5
	},

	{
		objName = 'V_ILev_SS_Door8',
		objCoords  = vector3(-448.28, 6007.19, 31.72),
		textCoords = vector3(-448.68, 6007.7, 31.72),
		authorizedJobs = { 'police' },
		locked = true,
		distance = 3,
		size = 0.5
	},

	{
		objName = 'V_ILev_SS_Door7',
		objCoords  = vector3(-449.07, 6008.08, 31.72),
		textCoords = vector3(-448.68, 6007.7, 31.72),
		authorizedJobs = { 'police' },
		locked = true,
		distance = 3,
		size = 0.5
	},

		{
		objName = 'v_ilev_gc_door01',
		objCoords  = vector3(-446.65, 6001.81, 31.72),
		textCoords = vector3(-446.65, 6001.81, 31.72),
		authorizedJobs = { 'police' },
		locked = true,
		distance = 3,
		size = 0.5
	},

		{
		objName = 'v_ilev_gc_door01',
		objCoords  = vector3(-451.54, 6006.62, 31.72),
		textCoords = vector3(-451.54, 6006.62, 31.72),
		authorizedJobs = { 'police' },
		locked = true,
		distance = 3,
		size = 0.5
	},

		{
		objName = 'V_ILev_CD_EntryDoor',
		objCoords  = vector3(-453.8, 6011.66, 31.72),
		textCoords = vector3(-453.8, 6011.66, 31.72),
		authorizedJobs = { 'police' },
		locked = true,
		distance = 3,
		size = 0.5
	},

			{
		objName = 'V_ILev_CF_OfficeDoor',
		objCoords  = vector3(-441.63, 6004.45, 31.72),
		textCoords = vector3(-441.63, 6004.45, 31.72),
		authorizedJobs = { 'police' },
		locked = true,
		distance = 3,
		size = 0.5
	},

			{
		objName = 'V_ILev_CF_OfficeDoor',
		objCoords  = vector3(-438.35, 6007.78, 31.72),
		textCoords = vector3(-438.35, 6007.78, 31.72),
		authorizedJobs = { 'police' },
		locked = true,
		distance = 3,
		size = 0.5
	},

				{
		objName = 'v_ilev_fingate',
		objCoords  = vector3(-436.84, 5992.2, 31.72),
		textCoords = vector3(-436.84, 5992.2, 31.72),
		authorizedJobs = { 'police' },
		locked = true,
		distance = 3,
		size = 0.5
	},

					{
		objName = 'v_ilev_ph_cellgate',
		objCoords  = vector3(-432.75, 5992.69, 31.72),
		textCoords = vector3(-432.75, 5992.69, 31.72),
		authorizedJobs = { 'police' },
		locked = true,
		distance = 3,
		size = 0.5
	},

						{
		objName = 'v_ilev_ph_cellgate',
		objCoords  = vector3(-428.55, 5997.14, 31.72),
		textCoords = vector3(-428.55, 5997.14, 31.72),
		authorizedJobs = { 'police' },
		locked = true,
		distance = 3,
		size = 0.5
	},

						{
		objName = 'v_ilev_ph_cellgate',
		objCoords  = vector3(-431.54, 6000.24, 31.72),
		textCoords = vector3(-431.54, 6000.24, 31.72),
		authorizedJobs = { 'police' },
		locked = true,
		distance = 3,
		size = 0.5
	},

		--(bahamas)

	{
		objName = 'v_ilev_ph_gendoor006',
		objCoords  = vector3(-1387.0,-586.6,30.4),
		textCoords = vector3(-1388.03,-587.41,30.4),
		authorizedJobs = { 'bahamas' },
		locked = true,
		distance = 4,
		size = 1
	},
	{
		objName = 'v_ilev_ph_gendoor006',
		objCoords  = vector3(-1389.2,-588.0,30.4),
		textCoords = vector3(-1388.03,-587.41,30.4),
		authorizedJobs = { 'bahamas' },
		locked = true,
		distance = 4,
		size = 1
	},
	-- unicorn

	{
		objName = 'prop_strip_door_01',
		objCoords  = vector3(128.7,-1298.6,28.0),
		textCoords = vector3(128.7,-1298.6,30.0),
		authorizedJobs = {'unicorn'},
		locked = true,
		distance = 4,
		size = 1
	},

	{
		objName = 'v_ilev_door_orangesolid',
		objCoords  = vector3(113.9,-1297.4,28.0),
		textCoords = vector3(113.7,-1296.4,30.0),
		authorizedJobs = { 'unicorn' },
		locked = true,
		distance = 4,
		size = 1
	},
	{
		objName = 'prop_magenta_door',
		objCoords  = vector3(96.0,-1284.8,28.0),
		textCoords = vector3(95.0,-1284.8,30.0),
		authorizedJobs = {'unicorn'},
		locked = true,
		distance = 4,
		size = 1
	},
		{
		objName = 'v_ilev_roc_door2',
		objCoords  = vector3(99.08,-1293.701,29.41),
		textCoords = vector3(99.61,-1293.701,30.00),
		authorizedJobs = {'unicorn'},
		locked = true,
		distance = 4,
		size = 1
	},
	--car dealer
	{
		objName = 'v_ilev_csr_door_l',
		objCoords  = vector3(-39.13,-1108.2,26.7),
		textCoords = vector3(-38.17,-1108.30,26.7),
		authorizedJobs = {'cardealer'},
		locked = true,
		distance = 4,
		size = 1
	},
	{
		objName = 'v_ilev_csr_door_r',
		objCoords  = vector3(-37.33,-1108.87,26.7),
		textCoords = vector3(-38.17,-1108.30,26.7),
		authorizedJobs = {'cardealer'},
		locked = true,
		distance = 4,
		size = 1
	},
	{
		objName = 'v_15_garg_delta_doordown',
		objCoords  = vector3(-29.32,-1086.63,26.9),
		textCoords = vector3(-29.32,-1086.63,26.9),
		authorizedJobs = {'cardealer'},
		locked = true,
		distance = 4,
		size = 1
	},
	{
		objName = 'v_ilev_csr_door_l',
		objCoords  = vector3(-59.89,-1092.9,26.8),
		textCoords = vector3(-60.31,-1093.84,26.7),
		authorizedJobs = {'cardealer'},
		locked = true,
		distance = 4,
		size = 1
	},
	{
		objName = 'v_ilev_csr_door_r',
		objCoords  = vector3(-60.54,-1094.74,26.7),
		textCoords = vector3(-60.31,-1093.84,26.7),
		authorizedJobs = {'cardealer'},
		locked = true,
		distance = 4,
		size = 1
	},

	--immobilier
	{
		objName = 'ex_prop_exec_office_door01',
		objCoords  = vector3(-139.936,-626.120,168.820),
		textCoords = vector3(-60.31,-1093.84,26.7),
		authorizedJobs = {'realestateagent'},
		locked = true,
		distance = 4,
		size = 1
	},
	{
		objName = 'ex_prop_exec_office_door01',
		objCoords  = vector3(-139.52,-626.180,168.820),
		textCoords = vector3(-139.936,-626.120,168.820),
		authorizedJobs = {'realestateagent'},
		locked = true,
		distance = 4,
		size = 1
	},

-- 9ser

	{
		objName = 'apa_Prop_apa_BankDoor_New',
		objCoords  = vector3( -1412.15,  672.89,  193.06),
		textCoords = vector3( -1412.15,  672.89,  193.06),
		authorizedJobs = {'state'},
		locked = true,
		distance = 4,
		size = 0.5
	},
	{
		objName = 'apa_Prop_apa_BankDoor_New',
		objCoords  = vector3( -1411.02,  672.73,  193.04),
		textCoords = vector3( -1411.02, 672.73,  193.04),
		authorizedJobs = {'state'},
		locked = true,
		distance = 4,
		size = 0.5
	},
	{
		objName = 'apa_p_mp_door_Apart_door_black',
		objCoords  = vector3( -1412.46,  641.49,  198.09),
		textCoords = vector3( -1412.46,  641.49,  198.09),
		authorizedJobs = {'state'},
		locked = true,
		distance = 4,
		size = 0.5
	},
   	{
		objName = 'apa_p_mp_yacht_door_02',
		objCoords  = vector3( -1416.85,  635.44,  198.12),
		textCoords = vector3(-1416.85,  635.44,  198.12),
		authorizedJobs = {'state'},
		locked = true,
		distance = 4,
		size = 0.5
	},
    {
		objName = 'apa_p_mp_yacht_door_02',
		objCoords  = vector3( -1415.62,  635.30,  198.11),
		textCoords = vector3( -1415.62,  635.30,  198.11),
		authorizedJobs = {'state'},
		locked = true,
		distance = 4,
		size = 0.5
	},
    		{
		objName = 'apa_p_mp_yacht_door_02',
		objCoords  = vector3( -1398.28, 663.39,  198.07),
		textCoords = vector3( -1398.28, 663.39,  198.07),
		authorizedJobs = {'state'},
		locked = true,
		distance = 4,
		size = 0.5
	},
	   		{
		objName = 'apa_p_mp_yacht_door_02',
		objCoords  = vector3( -1398.11, 664.67,  198.07),
		textCoords = vector3( -1398.11, 664.67,  198.07),
		authorizedJobs = {'state'},
		locked = true,
		distance = 4,
		size = 0.5
	},
	{
		objName = 'apa_p_mp_yacht_door_02',
		objCoords  = vector3( -1426.53,  668.13,  198.09),
		textCoords = vector3( -1426.53,  668.13,  198.09),
		authorizedJobs = {'state'},
		locked = true,
		distance = 4,
		size = 0.5
	},
	{
		objName = 'apa_p_mp_yacht_door_02',
		objCoords  = vector3( -1426.70,  666.93,  198.09),
		textCoords = vector3( -1426.70,  666.93,  198.09),
		authorizedJobs = {'state'},
		locked = true,
		distance = 4,
		size = 0.5
	},
    {
		objName = 'prop_ld_garaged_01',
		objCoords  = vector3( -1411.38,  674.05, 188.99),
		textCoords = vector3(-1411.38,  674.05, 188.99),
		authorizedJobs = {'state'},
		locked = true,
		distance = 8,
		size = 1.5
	},

	{
		objName = 'Prop_Gate_TEP_01_L',
		objCoords  = vector3(-1405.19000000, 693.44000000, 187.79000000),
		textCoords = vector3(-1408.503, 693.635, 187.79000000),
		authorizedJobs = {'state'},
		locked = true,
		distance = 20,
		size = 1.5
	},

	{
		objName = 'prop_gate_tep_01_r',
		objCoords  = vector3(-1412.96000000, 694.39000000,187.79000000),
		textCoords = vector3(-1409.789, 694.075,187.79000000),
		authorizedJobs = {'state'},
		locked = true,
		distance = 20,
		size = 1.5
	},
	{
		objName = 'prop_ld_vault_door',
		objCoords  = vector3(-1408.861, 628.747, 197.1164),
		textCoords = vector3(-1408.861, 628.747, 197.1164),
		authorizedJobs = {'state'},
		locked = true,
		distance = 5,
		size = 1.5
	},
	{
		objName = 'v_ilev_mm_doorm_l',
		objCoords  = vector3(-816.475, 179.645, 72.1530),
		textCoords = vector3(-816.0656, 178.4660, 72.1531),
		authorizedJobs = {'state'},
		locked = true,
		distance = 5,
		size = 1.5
	},
	{
		objName = 'v_ilev_mm_doorm_r',
		objCoords  = vector3(-815.627, 177.669, 72.1531),
		textCoords = vector3(-816.0656, 178.4660, 72.1531),
		authorizedJobs = {'state'},
		locked = true,
		distance = 5,
		size = 1.5
	},
	{
		objName = 'prop_bh1_48_backdoor_l',
		objCoords  = vector3(-794.466, 182.1192, 72.834),
		textCoords = vector3(-794.244, 181.3225, 72.834),
		authorizedJobs = {'state'},
		locked = true,
		distance = 5,
		size = 1.5
	},
	{
		objName = 'prop_bh1_48_backdoor_r',
		objCoords  = vector3(-794.466, 182.1192, 72.834),
		textCoords = vector3(-794.244, 181.3225, 72.834),
		authorizedJobs = {'state'},
		locked = true,
		distance = 5,
		size = 1.5
	},
	{
		objName = 'prop_bh1_48_backdoor_r',
		objCoords  = vector3(-795.650, 178.1234, 72.8347),
		textCoords = vector3(-795.650, 178.1234, 72.8347),
		authorizedJobs = {'state'},
		locked = true,
		distance = 2,
		size = 1
	},
	{
		objName = 'prop_bh1_48_backdoor_l',
		objCoords  = vector3(-795.650, 178.1234, 72.8347),
		textCoords = vector3(-795.650, 178.1234, 72.8347),
		authorizedJobs = {'state'},
		locked = true,
		distance = 1,
		size = 1
	},
	{
		objName = 'v_ilev_mm_door',
		objCoords  = vector3(-806.417, 185.099, 72.1477),
		textCoords = vector3(-806.417, 185.099, 72.1477),
		authorizedJobs = {'state'},
		locked = true,
		distance = 1,
		size = 1
	},
	{
		objName = 'v_ilev_mm_doorw',
		objCoords  = vector3(-809.737, 177.214, 76.7407),
		textCoords = vector3(-809.737, 177.214, 76.7407),
		authorizedJobs = {'state'},
		locked = true,
		distance = 1,
		size = 1
	},
	{
		objName = 'prop_lrggate_02_ld',
		objCoords  = vector3(-843.619, 155.414, 66.859),
		textCoords = vector3(-848.496, 161.998,66.3619),
		authorizedJobs = {'state'},
		locked = true,
		distance = 20,
		size = 2
	},
	{
		objName = 'prop_ld_garaged_01',
		objCoords  = vector3(-816.680, 186.105, 72.425),
		textCoords = vector3(-816.680, 186.105, 72.425),
		authorizedJobs = {'state'},
		locked = true,
		distance = 5,
		size = 2
	},
	{
		objName = 'prop_bh1_48_gate_1',
		objCoords  = vector3(-849.440, 178.500, 69.805),
		textCoords = vector3(-849.440, 178.500, 69.805),
		authorizedJobs = {'state'},
		locked = true,
		distance = 2,
		size = 1
	},

		--madrazo ranch

		{
		objName = 'v_ilev_ra_door4l',
		objCoords  = vector3(1395.920, 1142.904, 114.700),
		textCoords = vector3(1395.94, 1141.77, 114.65),
		authorizedJobs = {'gang_2'},
		locked = true,
		distance = 2,
		size = 0.5
	},

	{
		objName = 'v_ilev_ra_door4r',
		objCoords  = vector3(1395.919, 1140.704, 114.700),
		textCoords = vector3(1395.94, 1141.77, 114.65),
		authorizedJobs = {'gang_2'},
		locked = true,
		distance = 2,
		size = 0.5
	},

	--
	-- Addons
	--

	--[[
	-- Entrance Gate (Mission Row mod) https://www.gta5-mods.com/maps/mission-row-pd-ymap-fivem-v1
	{
		objName = 'prop_gate_airport_01',
		objCoords  = vector3(420.1, -1017.3, 28.0),
		textCoords = vector3(420.1, -1021.0, 32.0),
		authorizedJobs = { 'police' },
		locked = true,
		distance = 14,
		size = 2
	}
	--]]
}