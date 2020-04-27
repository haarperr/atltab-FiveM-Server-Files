Config = {}

Config.SyncAnimations = {
	{
		name = 'synced',
		label = 'synced animation',
		items = {
			{label = 'bandit gansgter le plus proche', data = {lib = 'mp_ped_interaction', anim1 = 'hugs_guy_b', anim2 = 'hugs_guy_a', distans = 1.15, distans2 = 0.0, height = 0.0, spin = 180.0}},
			{label = 'Hug le joueur le plus proche', data = {lib = 'mp_ped_interaction', anim1 = 'kisses_guy_b', anim2 = 'kisses_guy_b', distans = 1.10, distans2 = -0.1, height = 0.0, spin = 180.0}},
			{label = 'Embrasser le joueur le plus proche', data = {lib = 'mp_ped_interaction', anim1 = 'kisses_guy_a', anim2 = 'kisses_guy_a', distans = 1.15, distans2 = 0.0, height = 0.0, spin = 180.0}},
			{label = 'Serrer la main au joueur le plus proche', data = {lib = 'mp_common', anim1 = 'givetake1_a', anim2 = 'givetake1_a', distans = 0.8, distans2 = 0.05, height = 0.0, spin = 180.0}},
			{label = 'Faire highfive avec le joueur le plus proche', data = {lib = 'mp_ped_interaction', anim1 = 'highfive_guy_a', anim2 = 'highfive_guy_b', distans = 1.2, distans2 = -0.3, height = 0.0, spin = 180.0}},
		}
	} 
}

Config.Animations = {

	{
		name  = 'festives',
		label = '🎉 Festives',
		items = {
			{label = "🚬 Fumer une cigarette", type = "scenario", data = {anim = "WORLD_HUMAN_SMOKING"}},
			{label = "🥁 Jouer de la musique", type = "scenario", data = {anim = "WORLD_HUMAN_MUSICIAN"}},
			{label = "🎧 DJ", type = "anim", data = {lib = "anim@mp_player_intcelebrationmale@dj", anim = "dj"}},
			{label = "🍺 Boire une biere", type = "scenario", data = {anim = "WORLD_HUMAN_DRINKING"}},
			{label = "🎇 Party", type = "scenario", data = {anim = "WORLD_HUMAN_PARTYING"}},
			{label = "🎸 Air Guitar", type = "anim", data = {lib = "anim@mp_player_intcelebrationmale@air_guitar", anim = "air_guitar"}},
			{label = "🤣 BUMP", type = "anim", data = {lib = "anim@mp_player_intcelebrationfemale@air_shagging", anim = "air_shagging"}},
			{label = "🎸 Rock'n'roll", type = "anim", data = {lib = "mp_player_int_upperrock", anim = "mp_player_int_rock"}},
			{label = "🤢 Rempli sur place", type = "anim", data = {lib = "amb@world_human_bum_standing@drunk@idle_a", anim = "idle_a"}},
		}
	},
	
	{
		name = 'dance',
		label = '🕺💃 Danser',
		items = {
		{label = "👯‍♂️ Danse 1", type = "anim", data = {lib = "misschinese2_crystalmazemcs1_cs", anim = "dance_loop_tao"}},		{label = "Danse 2", type = "anim", data = {lib = "special_ped@mountain_dancer@monologue_3@monologue_3a", anim = "mnt_dnc_buttwag"}},
		{label = "👯‍♂️ Danse 2", type = "anim", data = {lib = "special_ped@mountain_dancer@monologue_4@monologue_4a", anim = "mnt_dnc_verse"}},
		{label = "👯‍♂️ Danse 3", type = "anim", data = {lib = "special_ped@mountain_dancer@monologue_2@monologue_2a", anim = "mnt_dnc_angel"}},
		{label = "👯‍♂️ Danse 4", type = "anim", data = {lib = "special_ped@mountain_dancer@monologue_1@monologue_1a", anim = "mtn_dnc_if_you_want_to_get_to_heaven"}},
		{label = "👯‍♂️ Danse 5", type = "anim", data = {lib = "special_ped@mountain_dancer@base", anim = "base"}},
		{label = "💃 Danse courte 1", type = "anim", data = {lib = "move_clown@p_m_two_idles@", anim = "fidget_short_dance"}},
		{label = "💃️ Danse courte 2", type = "anim", data = {lib = "move_clown@p_m_zero_idles@", anim = "fidget_short_dance"}},
		{label = "🕺️ Freakout", type = "anim", data = {lib = "anim@mp_player_intcelebrationfemale@freakout", anim = "freakout"}},
		{label = "🕺 Jazz hands", type = "anim", data = {lib = "anim@mp_player_intcelebrationfemale@jazz_hands", anim = "jazz_hands"}},

		}
	},
	
	{
		name  = 'greetings',
		label = '👋🏼 Saluer',
		items = {
			{label = "✋🏼 Saluer", type = "anim", data = {lib = "gestures@m@standing@casual", anim = "gesture_hello"}},
			{label = "👋🏼 Serrer la main", type = "anim", data = {lib = "mp_common", anim = "givetake1_a"}},
			{label = "👋🏼 Serrer la main 2", type = "anim", data = {lib = "mp_ped_interaction", anim = "handshake_guy_a"}},
			{label = "👐🏼 Bandit", type = "anim", data = {lib = "mp_ped_interaction", anim = "hugs_guy_a"}},
			{label = "💪🏼 Salutation militaire", type = "anim", data = {lib = "mp_player_int_uppersalute", anim = "mp_player_int_salute"}},
		}
	},
	
		{
		name  = 'humors',
		label = '😂 Humors',
		items = {
			{label = "👏🏼 Applaudissant", type = "scenario", data = {anim = "WORLD_HUMAN_CHEERING"}},
			{label = "👍🏼 Bravo", type = "anim", data = {lib = "mp_action", anim = "thanks_male_06"}},
			{label = "✊🏼 Pression", type = "anim", data = {lib = "mp_ped_interaction", anim = "kisses_guy_a"}},
			{label = "🖕🏼🖕🏼 Fuck 2 doigts", type = "anim", data = {lib = "mp_player_int_upperfinger", anim = "mp_player_int_finger_01_enter"}},
			{label = "✊🏼 Flip Flap", type = "anim", data = {lib = "mp_player_int_upperwank", anim = "mp_player_int_wank_01"}},
		}
	},
	
	
	{
		name  = 'sports',
		label = '💪🏼 Sports',
		items = {
			{label = "🏋🏻‍ ♂️️Montrer ses muscles", type = "anim", data = {lib = "amb@world_human_muscle_flex@arms_at_side@base", anim = "base"}},
			{label = "💪🏽Barre de musculation", type = "anim", data = {lib = "amb@world_human_muscle_free_weights@male@barbell@base", anim = "base"}},
			{label = "💪🏼Faire des pompes", type = "anim", data = {lib = "amb@world_human_push_ups@male@base", anim = "base"}},
			{label = "💪🏼Faire des abdos", type = "anim", data = {lib = "amb@world_human_sit_ups@male@base", anim = "base"}},
			{label = "🌸Faire du yoga", type = "anim", data = {lib = "amb@world_human_yoga@male@base", anim = "base_a"}},
		}
	},
	
	{
		name  = 'work',
		label = '👨🏽‍🌾 Travaille',
		items = {
			{label = "🤷🏽‍♂️ Criminal: les mains derriere la tete", type = "anim", data = {lib = "random@arrests@busted", anim = "idle_c"}},
			{label = "🔎 La police enquete", type = "anim", data = {lib = "amb@code_human_police_investigate@idle_b", anim = "idle_f"}},
			{label = "📻 Police: parler a la radio", type = "anim", data = {lib = "random@arrests", anim = "generic_radio_chatter"}},
			{label = "🚦 Police: trafic", type = "scenario", data = {anim = "WORLD_HUMAN_CAR_PARK_ATTENDANT"}},
			{label = "👀 Police: jumelles", type = "scenario", data = {anim = "WORLD_HUMAN_BINOCULARS"}},
			{label = "🎍 Agriculture: recolte", type = "scenario", data = {anim = "world_human_gardener_plant"}},
			{label = "⚙️ Mecanicien: Reparer le moteur", type = "anim", data = {lib = "mini@repair", anim = "fixing_a_ped"}},
			{label = "💉 Medecins: observer", type = "scenario", data = {anim = "CODE_HUMAN_MEDIC_KNEEL"}},
			{label = "🗣 Taxi: parler au client", type = "anim", data = {lib = "oddjobs@taxi@driver", anim = "leanover_idle"}},
			{label = "📝 Taxi: donnez une facture", type = "anim", data = {lib = "oddjobs@taxi@cyi", anim = "std_hand_off_ps_passenger"}},
			{label = "💰 Alimentation: Donnez un change", type = "anim", data = {lib = "mp_am_hold_up", anim = "purchase_beerbox_shopkeeper"}},
			{label = "💰 Barman: gagner un coup", type = "anim", data = {lib = "mini@drinking", anim = "shots_barman_b"}},
			{label = "💰 Barman: gagner un coup", type = "scenario", data = {anim = "WORLD_HUMAN_PAPARAZZI"}},
			{label = "📝 Prendre des notes", type = "scenario", data = {anim = "WORLD_HUMAN_CLIPBOARD"}},
			{label = "🔨 Charpentier: marteau", type = "scenario", data = {anim = "WORLD_HUMAN_HAMMERING"}},
			{label = "💵 Luffare: mendier de l'argent", type = "scenario", data = {anim = "WORLD_HUMAN_BUM_FREEWAY"}},
			{label = "🤐 Statue", type = "scenario", data = {anim = "WORLD_HUMAN_HUMAN_STATUE"}},
			{label = "🕵🏽 Garde: videur", type = "anim", data = {lib = "mini@strip_club@idles@bouncer@base", anim = "base"}},
		}
	},

	{
		name  = 'misc',
		label = '⭐️ Divers',
		items = {
			{label = "☕️ Boire un cafe", type = "anim", data = {lib = "amb@world_human_aa_coffee@idle_a", anim = "idle_a"}},
			{label = "🙇🏽 S'asseoir", type = "anim", data = {lib = "anim@heists@prison_heistunfinished_biztarget_idle", anim = "target_idle"}},
			{label = "🙇🏽 Attendre", type = "scenario", data = {anim = "world_human_leaning"}},
			{label = "🙇🏽 Allongez-vous sur le dos", type = "scenario", data = {anim = "WORLD_HUMAN_SUNBATHE_BACK"}},
			{label = "🙇🏽 Allongez-vous sur le ventre", type = "scenario", data = {anim = "WORLD_HUMAN_SUNBATHE"}},
			{label = "💦 Laver les vitres", type = "scenario", data = {anim = "world_human_maid_clean"}},
			{label = "⛓ Grillage", type = "scenario", data = {anim = "PROP_HUMAN_BBQ"}},
			{label = "🤳🏽 Prendre un selfie", type = "scenario", data = {anim = "world_human_tourist_mobile"}},
			{label = "👂🏼 Ecoute une porte", type = "anim", data = {lib = "mini@safe_cracking", anim = "idle_base"}}, 
		}
	},
	
	{
		name = 'gestikulera',
		label = '🕹 Gestes',
		items = {
			{label = "jointoiement", type = "anim", data = {lib = "gestures@m@standing@casual", anim = "gesture_point"}},
			{label = "Viens ici", type = "anim", data = {lib = "gestures@m@standing@casual", anim = "gesture_come_here_soft"}}, 
			{label = "Viens", type = "anim", data = {lib = "gestures@m@standing@casual", anim = "gesture_bring_it_on"}},
			{label = "Pour moi", type = "anim", data = {lib = "gestures@m@standing@casual", anim = "gesture_me"}},
			{label = "Je savais que c'etait fou !", type = "anim", data = {lib = "anim@am_hold_up@male", anim = "shoplift_high"}},
			{label = "Facepalm", type = "anim", data = {lib = "anim@mp_player_intcelebrationmale@face_palm", anim = "face_palm"}},
			{label = "Se calmer ", type = "anim", data = {lib = "gestures@m@standing@casual", anim = "gesture_easy_now"}},
			{label = "Qu'ai-je fait?", type = "anim", data = {lib = "oddjobs@assassinate@multi@", anim = "react_big_variations_a"}},
			{label = "Avoir peur", type = "anim", data = {lib = "amb@code_human_cower_stand@male@react_cowering", anim = "base_right"}},
			{label = "Combat?", type = "anim", data = {lib = "anim@deathmatch_intros@unarmed", anim = "intro_male_unarmed_e"}},
			{label = "Ce n'est pas possible!", type = "anim", data = {lib = "gestures@m@standing@casual", anim = "gesture_damn"}},

		}
	},
	
	{
		name = 'casual',
		label = '😎 Lw9afi',
		items = {
		{label = "videur", type = "anim", data = {lib = "mini@strip_club@idles@bouncer@base", anim = "base"}},
		{label = "Bras croises", type = "anim", data = {lib = "mini@hookers_spvanilla", anim = "idle_reject_loop_c"}},
		{label = "Mains sur la ceinture", type = "anim", data = {lib = "amb@world_human_cop_idles@male@base", anim = "base"}},
		{label = "Pencher vers un mur", type = "anim", data = {lib = "amb@world_human_leaning@male@wall@back@legs_crossed@idle_a", anim = "idle_a"}},
		{label = "Pencher vers une balustrade", type = "scenario", data = {anim = "prop_human_bum_shopping_cart"}},

		}
	},
	
	{
		name  = 'attitudem',
		label = '🎭 Attitude',
		items = {
			{label = "Normal M", type = "attitude", data = {lib = "move_m@confident", anim = "move_m@confident"}},
			{label = "Normal F", type = "attitude", data = {lib = "move_f@heels@c", anim = "move_f@heels@c"}},
			{label = "Depressif", type = "attitude", data = {lib = "move_m@depressed@a", anim = "move_m@depressed@a"}},
			{label = "Depressif F", type = "attitude", data = {lib = "move_f@depressed@a", anim = "move_f@depressed@a"}},
			{label = "Business", type = "attitude", data = {lib = "move_m@business@a", anim = "move_m@business@a"}},
			{label = "Determine", type = "attitude", data = {lib = "move_m@brave@a", anim = "move_m@brave@a"}},
			{label = "Casual", type = "attitude", data = {lib = "move_m@casual@a", anim = "move_m@casual@a"}},
			{label = "Trop mange", type = "attitude", data = {lib = "move_m@fat@a", anim = "move_m@fat@a"}},
			{label = "Hipster", type = "attitude", data = {lib = "move_m@hipster@a", anim = "move_m@hipster@a"}},
			{label = "Blesse", type = "attitude", data = {lib = "move_m@injured", anim = "move_m@injured"}},
			{label = "Intimide", type = "attitude", data = {lib = "move_m@hurry@a", anim = "move_m@hurry@a"}},
			{label = "Hobo", type = "attitude", data = {lib = "move_m@hobo@a", anim = "move_m@hobo@a"}},
			{label = "Malheureux", type = "attitude", data = {lib = "move_m@sad@a", anim = "move_m@sad@a"}},
			{label = "Muscle", type = "attitude", data = {lib = "move_m@muscle@a", anim = "move_m@muscle@a"}},
			{label = "Choc", type = "attitude", data = {lib = "move_m@shocked@a", anim = "move_m@shocked@a"}},
			{label = "Sombre", type = "attitude", data = {lib = "move_m@shadyped@a", anim = "move_m@shadyped@a"}},
			{label = "Fatigue", type = "attitude", data = {lib = "move_m@buzzed", anim = "move_m@buzzed"}},
			{label = "Pressee", type = "attitude", data = {lib = "move_m@hurry_butch@a", anim = "move_m@hurry_butch@a"}},
			{label = "Fier", type = "attitude", data = {lib = "move_m@money", anim = "move_m@money"}},
			{label = "Petite course", type = "attitude", data = {lib = "move_m@quick", anim = "move_m@quick"}},
			{label = "Mangeuse d'homme", type = "attitude", data = {lib = "move_f@maneater", anim = "move_f@maneater"}},
			{label = "Impertinent", type = "attitude", data = {lib = "move_f@sassy", anim = "move_f@sassy"}},	
			{label = "Arrogante", type = "attitude", data = {lib = "move_f@arrogant@a", anim = "move_f@arrogant@a"}},
		}
	},
	
	{
		name  = 'porn',
		label = '👄 18+',
		items = {
			{label = "Homme se faire su*** en voiture", type = "anim", data = {lib = "oddjobs@towing", anim = "m_blow_job_loop"}},
			{label = "Femme faire une gaterie en voiture", type = "anim", data = {lib = "oddjobs@towing", anim = "f_blow_job_loop"}},
			{label = "Homme bais** en voiture", type = "anim", data = {lib = "mini@prostitutes@sexlow_veh", anim = "low_car_sex_loop_player"}},
			{label = "Femme bais** en voiture", type = "anim", data = {lib = "mini@prostitutes@sexlow_veh", anim = "low_car_sex_loop_female"}},
			{label = "Se gratter les couilles", type = "anim", data = {lib = "mp_player_int_uppergrab_crotch", anim = "mp_player_int_grab_crotch"}},
			{label = "Faire du charme", type = "anim", data = {lib = "mini@strip_club@idles@stripper", anim = "stripper_idle_02"}},
			{label = "Pose michto", type = "scenario", data = {anim = "WORLD_HUMAN_PROSTITUTE_HIGH_CLASS"}},
			{label = "Montrer sa poitrine", type = "anim", data = {lib = "mini@strip_club@backroom@", anim = "stripper_b_backroom_idle_b"}},
			{label = "Strip Tease 1", type = "anim", data = {lib = "mini@strip_club@lap_dance@ld_girl_a_song_a_p1", anim = "ld_girl_a_song_a_p1_f"}},
			{label = "Strip Tease 2", type = "anim", data = {lib = "mini@strip_club@private_dance@part2", anim = "priv_dance_p2"}},
			{label = "Stip Tease au sol", type = "anim", data = {lib = "mini@strip_club@private_dance@part3", anim = "priv_dance_p3"}},
		}
	}
}
