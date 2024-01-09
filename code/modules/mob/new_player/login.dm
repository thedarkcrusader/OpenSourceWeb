/var/obj/effect/lobby_image = new/obj/effect/lobby_image()
var/interquote = pick("How about that prick's face when he saw the gyatt?.",
"Allahu akbar.", "https://www.youtube.com/watch?v=dQw4w9WgXcQ","How do I stand up?","We need to find water.",
"See that mountain? You can climb it.","It is a full highest rating I can issue, TEN OUT OF TEN, and it easily earns the BADASS seal of approval.","Would you like to sign my petition?",
"Divine light severed, you are a flesh automaton animated by neurotrnasmitters.","You gormless tosser!",
"Look at you! Look at the nasty things that you have become! Look how small you are, how worthless you are! You are wretched, rotten little beasts! I made you!","Hold my beer.",
"Did you know that you have rights? Constitution says you do, and so do I.","How 'bout that prick's face when he saw the gat?")
var/brquote = pick("Odeio este lugar e faria qualquer coisa para sair daqui, que o grande senhor tenha misericórdia de nós.",
"Todos os porcos devem morrer.", "Não há anjos no céu; eles estão todos aqui em baixo.", "Construa suas asas ao descer.", "Sou um covarde, enfie sua faca em mim." ,
"A morte é apenas uma ameaça por causa da felicidade.", "Três podem guardar um segredo, se dois deles estiverem mortos.", "Carne consciente. Carne que ama. Carne dos sonhos.",
"Fiquem felizes com o que aconteceu, não tristes que isso acabe", "Este mundo é uma máquina! Uma Máquina para Porcos! Destina-se apenas ao abate de porcos!",
"Eu estou te implorando. Você me fez. Você é meu Criador, meu Pai. Você não pode me destruir!", "Eu tenho você agora, criatura. Eu vou destruir você.",
"Acabou. É hora de acabar com essa loucura.", "Aquele que faz de si mesmo um animal afasta-se da dor de ser humano.")
/obj/effect/lobby_image
	name = "Allah Combat"
	desc = "Allah Combat."
	icon = 'icons/misc/fullscreen.dmi'
	icon_state = "title"
	screen_loc = "WEST,SOUTH"
	plane = 300

/obj/effect/lobby_grain
	name = "Allah Combat"
	desc = "Allah Combat."
	icon = 'icons/misc/fullscreen.dmi'
	icon_state = "grain"
	screen_loc = "WEST,SOUTH"
	mouse_opacity = 0
	layer = MOB_LAYER+6
	plane = 300

/obj/effect/lobby_image/New()
	if(master_mode == "holywar")
		icon_state = "holywar"
	else
		icon_state = "title"
	overlays += /obj/effect/lobby_grain
	desc = vessel_name()

/mob/new_player/Login()
	..()
	if(ticker?.current_state != GAME_STATE_PLAYING)
		for(var/mob/new_player/N in mob_list)
			to_chat(N, "⠀<span class='passivebold'>[capitalize(usr.key)] is now at the local Mosque.</span>")
//	var/list/locinfo = client?.get_loc_info()
	update_Login_details()	//handles setting lastKnownIP and computer_id for use by the ban systems as well as checking for multikeying
	winset(src, null, "mainwindow.title='Allah Combat'")//Making it so window is named what it's named.
	if(join_motd)
		if(guardianlist.Find(ckey(src.client.key)))
			to_chat(src, "Welcome, <span class='graytextbold'>[capitalize(usr.ckey)]</span>! Your reliability level: <span class='guardianlobby'>Guardian</span>")
		else if(src.client in admins)
			to_chat(src, "Welcome, <span class='graytextbold'>[capitalize(usr.ckey)]</span>! Your reliability level: <span class='adminlobby'>[src.client.holder.rank]</span>")
		else if(comradelist.Find(ckey(src.client.key)))
			to_chat(src, "Welcome, <span class='graytextbold'>[capitalize(usr.ckey)]</span>! Your reliability level: <span class='comradelobby'>Comrade</span>")
		else if(villainlist.Find(ckey(src.client.key)))
			to_chat(src, "Welcome, <span class='graytextbold'>[capitalize(usr.ckey)]</span>! Your reliability level: <span class='villainlobby'>Villain</span>")
		else if(pigpluslist.Find(ckey(src.client.key)))
			to_chat(src, "Welcome, <span class='graytextbold'>[capitalize(usr.ckey)]</span>! Your reliability level: <span class='graytextbold'>Experienced Pig</span>")
		else
			to_chat(src, "Welcome, <span class='graytextbold'>[capitalize(usr.ckey)]</span>! Your reliability level: <span class='graytextbold'>Pig</span>")
		to_chat(src, "Press <a href='?src=\ref[src];action=f12'>F12</a> find your death!")
		to_chat(src, "Map of the week:</span> <span class='bname'><i>fucking golden river</i></span>")
		to_chat(src, "Country: <span class='bname'>Middle East</span>")
		to_chat(src, "<span class='lobby'>Allah Combat</span>   <span class='lobbyy'>Story #[story_id]</span>")
		to_chat(src, "<span class='bname'><b>Allah:</span></b> <i>\"[interquote]\"</i>")
	if(ticker && ticker.current_state == GAME_STATE_PLAYING && master_mode == "inspector")
		to_chat(src, "\n<div class='firstdivmood'><div class='moodbox'><span class='graytext'>You may join as the Inspector or his bodyguard.</span>\n<span class='feedback'><a href='?src=\ref[src];acao=joininspectree'>1. I want to.</a></span>\n<span class='feedback'><a href='?src=\ref[src];acao=nao'>2. I'll pass.</a></span></div></div>")


	if(!mind)
		mind = new /datum/mind(key)
		mind.active = 1
		mind.current = src

	if(length(newplayer_start))
		loc = pick(newplayer_start)
	else
		loc = locate(1,1,1)
	lastarea = loc

	//unlock_medal("First Timer", 0, "Welcome!", "easy")

	sight |= SEE_TURFS
	player_list |= src
	client.screen += lobby_image

/*
	var/list/watch_locations = list()
	for(var/obj/effect/landmark/landmark in landmarks_list)
		if(landmark.tag == "landmark*new_player")
			watch_locations += landmark.loc

	if(watch_locations.len>0)
		loc = pick(watch_locations)
*/
	new_player_panel()
	spawn(40)
		if(client)
			client.playtitlemusic()
