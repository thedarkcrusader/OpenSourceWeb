//This file was auto-corrected by findeclaration.exe on 25.5.2012 20:42:32

/* Tools!
 * Note: Multitools are /obj/item/device
 *
 * Contains:
 * 		Wrench
 * 		Screwdriver
 * 		Wirecutters
 * 		Welding Tool
 * 		Crowbar
 */

/*
 * Wrench
 */
/obj/item/weapon/wrench
	name = "wrench"
	desc = "A wrench with common uses. Can be found in your hand."
	icon = 'icons/obj/items.dmi'
	icon_state = "wrench"
	flags = FPRINT | TABLEPASS| CONDUCT
	slot_flags = SLOT_BELT
	force = 7.0
	throwforce = 7.0
	w_class = 2.0
	m_amt = 150
	origin_tech = "materials=1;engineering=1"
	attack_verb = list("bashed", "battered", "bludgeoned", "whacked")


/*
 * Screwdriver
 */
/obj/item/weapon/screwdriver
	name = "screwdriver"
	desc = "You can be totally screwwy with this."
	icon = 'icons/obj/items.dmi'
	icon_state = "screwdriver"
	flags = FPRINT | TABLEPASS| CONDUCT
	slot_flags = SLOT_BELT
	force = 7.0
	w_class = 1.0
	throwforce = 5.0
	throw_speed = 3
	throw_range = 5
	sharp = 1
	g_amt = 0
	m_amt = 75
	attack_verb = list("slashed", "hit", "attacked")

	suicide_act(mob/user)
		viewers(user) << pick("\red <b>[user] is stabbing the [src.name] into \his temple! It looks like \he's trying to commit suicide.</b>", \
							"\red <b>[user] is stabbing the [src.name] into \his heart! It looks like \he's trying to commit suicide.</b>")
		return(BRUTELOSS)

/obj/item/weapon/screwdriver/New()
	switch(pick("red","blue","purple","brown","green","cyan","yellow"))
		if ("red")
			icon_state = "screwdriver2"
			item_state = "screwdriver"
		if ("blue")
			icon_state = "screwdriver"
			item_state = "screwdriver_blue"
		if ("purple")
			icon_state = "screwdriver3"
			item_state = "screwdriver_purple"
		if ("brown")
			icon_state = "screwdriver4"
			item_state = "screwdriver_brown"
		if ("green")
			icon_state = "screwdriver5"
			item_state = "screwdriver_green"
		if ("cyan")
			icon_state = "screwdriver6"
			item_state = "screwdriver_cyan"
		if ("yellow")
			icon_state = "screwdriver7"
			item_state = "screwdriver_yellow"

	if (prob(75))
		src.pixel_y = rand(0, 16)
	return

/obj/item/weapon/screwdriver/attack(mob/living/carbon/M as mob, mob/living/carbon/user as mob)
	if(!istype(M))	return ..()
	if(user.zone_sel.selecting == "eyes" || user.zone_sel.selecting == "head")
		if((CLUMSY in user.mutations) && prob(50))
			M = user
		return eyestab(M,user)
	else
		..()
		return

/*
 * Wirecutters
 */
/obj/item/weapon/wirecutters
	name = "wirecutters"
	desc = "This cuts wires."
	icon = 'icons/obj/items.dmi'
	icon_state = "cutters"
	flags = FPRINT | TABLEPASS| CONDUCT
	slot_flags = SLOT_BELT
	force = 8.0
	throw_speed = 2
	throw_range = 9
	w_class = 2.0
	m_amt = 80
	origin_tech = "materials=1;engineering=1"
	attack_verb = list("pinched", "nipped")

/obj/item/weapon/wirecutters/New()
	if(prob(50))
		icon_state = "cutters-y"
		item_state = "cutters_yellow"

/obj/item/weapon/wirecutters/attack(mob/living/carbon/C as mob, mob/user as mob)


	if(ishuman(C) && user.zone_sel.selecting == "mouth")
		var/mob/living/carbon/human/H = C
		var/datum/organ/external/mouth/O = locate() in H.organs
		if(!O || !O.get_teeth())
			to_chat(user, "<span class='combatbold'>[H]</span> <span class='combat'>doesn't have any teeth left!</span>")
			return
		if(!user.doing_something)
			user.doing_something = 1
			H.visible_message("<span class='hitbold'>[user]</span> <span class='hit'>tries to tear off</span> <span class='hitbold'>[H]'s</span> <span class='hit'>tooth with [src]!</span>",
								"<span class='combatbold'>[user] tries to tear off your tooth with [src]!</span>")
			if(do_after(user, 5))
				if(!O || !O.get_teeth()) return
				var/obj/item/stack/teeth/E = pick(O.teeth_list)
				if(!E || E.zero_amount()) return
				var/obj/item/stack/teeth/T = new E.type(H.loc, 1)
				E.use(1)
				T.add_blood(H)
				E.zero_amount() //Try to delete the teeth
				H.visible_message("<span class='hitbold'>[user]</span> <span class='hit'>tears off</span> <span class='hitbold'>[H]'s</span> <span class='hit'>tooth with [src]!</span>",
								"<span class='combatbold'>[user] tears off your tooth with [src]!</span>")
				H.apply_damage(rand(1, 3), BRUTE, O)
				H.custom_pain("[pick("<span class='hugepain'>OH [uppertext(H.god_text())] YOUR MOUTH HURTS SO BAD!</span>", "<span class='hugepain'OH [uppertext(H.god_text())] WHY!</span>", "<span class='hugepain'OH [uppertext(H.god_text())] YOUR MOUTH!</span>")]", 100)
				if(H.buckled && istype(H.buckled, /obj/structure/stool/bed/chair/comfy/torture))
					if(prob(20))
						H.client.ChromieWinorLoose(H.client, -1)
				playsound(H, "trauma", 40, 1, -1) //And out it goes.

				user.doing_something = 0
			else
				to_chat(user, "<span class='passive'>Your attempt to pull out a tooth fails...</span>")
				user.doing_something = 0
				return
		else
			to_chat(user, "<span class='notice'>You are already trying to pull out a tooth!</span>")
		return


	if((C.handcuffed) && (istype(C.handcuffed, /obj/item/weapon/handcuffs/cable)))
		usr.visible_message("\The [usr] cuts \the [C]'s restraints with \the [src]!",\
		"You cut \the [C]'s restraints with \the [src]!",\
		"You hear cable being cut.")
		C.handcuffed = null
		C.update_inv_handcuffed()
		return
	else
		..()

/*
 * Welding Tool
 */
/obj/item/weapon/weldingtool
	name = "welding tool"
	icon = 'icons/obj/items.dmi'
	icon_state = "welder"
	flags = FPRINT | TABLEPASS| CONDUCT
	slot_flags = SLOT_BELT

	//Amount of OUCH when it's thrown
	force = 5.0
	throwforce = 5.0
	throw_speed = 1
	throw_range = 5
	w_class = 2.0

	//Cost to make in the autolathe
	m_amt = 70
	g_amt = 30

	//R&D tech level
	origin_tech = "engineering=1"

	//Welding tool specific stuff
	var/welding = 0 	//Whether or not the welding tool is off(0), on(1) or currently welding(2)
	var/status = 1 		//Whether the welder is secured or unsecured (able to attach rods to it to make a flamethrower)
	var/max_fuel = 20 	//The max amount of fuel the welder can hold

/obj/item/weapon/weldingtool/New()
//	var/random_fuel = min(rand(10,20),max_fuel)
	var/datum/reagents/R = new/datum/reagents(max_fuel)
	reagents = R
	R.my_atom = src
	R.add_reagent("fuel", max_fuel)
	return


/obj/item/weapon/weldingtool/examine()
	set src in usr
	usr << text("\icon[] [] contains []/[] units of fuel!", src, src.name, get_fuel(),src.max_fuel )
	return


/obj/item/weapon/weldingtool/attackby(obj/item/W as obj, mob/user as mob)
	if(istype(W,/obj/item/weapon/screwdriver))
		if(welding)
			user << "\red Stop welding first!"
			return
		status = !status
		if(status)
			user << "\blue You resecure the welder."
		else
			user << "\blue The welder can now be attached and modified."
		src.add_fingerprint(user)
		return

	if((!status) && (istype(W,/obj/item/stack/rods)))
		var/obj/item/stack/rods/R = W
		R.use(1)
		var/obj/item/weapon/flamethrower/F = new/obj/item/weapon/flamethrower(user.loc)
		src.loc = F
		F.weldtool = src
		if (user.client)
			user.client.screen -= src
		if (user.r_hand == src)
			user.u_equip(src)
		else
			user.u_equip(src)
		src.master = F
		src.layer = initial(src.layer)
		user.u_equip(src)
		if (user.client)
			user.client.screen -= src
		src.loc = F
		src.add_fingerprint(user)
		return

	..()
	return


/obj/item/weapon/weldingtool/process()
	switch(welding)
		//If off
		if(0)
			if(src.icon_state != "welder") //Check that the sprite is correct, if it isnt, it means toggle() was not called
				src.force = 3
				src.damtype = "brute"
				src.icon_state = "welder"
				src.welding = 0
			processing_objects.Remove(src)
			return
		//Welders left on now use up fuel, but lets not have them run out quite that fast
		if(1)
			if(src.icon_state != "welder1") //Check that the sprite is correct, if it isnt, it means toggle() was not called
				src.force = 15
				src.damtype = "fire"
				src.icon_state = "welder1"
			if(prob(5))
				remove_fuel(1)

		//If you're actually actively welding, use fuel faster.
		//Is this actually used or set anywhere? - Nodrak
		if(2)
			if(prob(75))
				remove_fuel(1)


	//I'm not sure what this does. I assume it has to do with starting fires...
	//...but it doesnt check to see if the welder is on or not.
	var/turf/location = src.loc
	if(istype(location, /mob/))
		var/mob/M = location
		if(M.l_hand == src || M.r_hand == src)
			location = get_turf(M)
	if (istype(location, /turf))
		location.hotspot_expose(700, 5)


/obj/item/weapon/weldingtool/afterattack(obj/O as obj, mob/user as mob, proximity)
	if(!proximity) return
	if (istype(O, /obj/structure/reagent_dispensers/fueltank) && get_dist(src,O) <= 1 && !src.welding)
		O.reagents.trans_to(src, max_fuel)
		user << "\blue Welder refueled"
		playsound(src.loc, 'sound/effects/refill.ogg', 50, 1, -6)
		return
	else if (istype(O, /obj/structure/reagent_dispensers/fueltank) && get_dist(src,O) <= 1 && src.welding)
		message_admins("[key_name_admin(user)] triggered a fueltank explosion.")
		log_game("[key_name(user)] triggered a fueltank explosion.")
		user << "\red That was stupid of you."
		var/obj/structure/reagent_dispensers/fueltank/tank = O
		tank.explode()
		return
	if (src.welding)
		remove_fuel(1)
		var/turf/location = get_turf(user)
		if (istype(location, /turf))
			location.hotspot_expose(700, 50, 1)

		if(isliving(O))
			var/mob/living/L = O
			L.IgniteMob()

	return


/obj/item/weapon/weldingtool/attack_self(mob/user as mob)
	toggle()
	return

//Returns the amount of fuel in the welder
/obj/item/weapon/weldingtool/proc/get_fuel()
	return reagents.get_reagent_amount("fuel")


//Removes fuel from the welding tool. If a mob is passed, it will perform an eyecheck on the mob. This should probably be renamed to use()
/obj/item/weapon/weldingtool/proc/remove_fuel(var/amount = 1, var/mob/M = null)
	if(!welding || !check_fuel())
		return 0
	if(get_fuel() >= amount)
		reagents.remove_reagent("fuel", amount)
		check_fuel()
		if(M)
			eyecheck(M)
		return 1
	else
		if(M)
			M << "\blue You need more welding fuel to complete this task."
		return 0

//Returns whether or not the welding tool is currently on.
/obj/item/weapon/weldingtool/proc/isOn()
	return src.welding

//Sets the welding state of the welding tool. If you see W.welding = 1 anywhere, please change it to W.setWelding(1)
//so that the welding tool updates accordingly
/obj/item/weapon/weldingtool/proc/setWelding(var/temp_welding)
	//If we're turning it on
	if(temp_welding > 0)
		if (remove_fuel(1))
			usr << "\blue The [src] switches on."
			src.force = 15
			src.damtype = "fire"
			src.icon_state = "welder1"
			processing_objects.Add(src)
		else
			usr << "\blue Need more fuel!"
			src.welding = 0
			return
	//Otherwise
	else
		usr << "\blue The [src] switches off."
		src.force = 3
		src.damtype = "brute"
		src.icon_state = "welder"
		src.welding = 0

//Turns off the welder if there is no more fuel (does this really need to be its own proc?)
/obj/item/weapon/weldingtool/proc/check_fuel()
	if((get_fuel() <= 0) && welding)
		toggle(1)
		return 0
	return 1


//Toggles the welder off and on
/obj/item/weapon/weldingtool/proc/toggle(var/message = 0)
	if(!status)	return
	src.welding = !( src.welding )
	if (src.welding)
		if (remove_fuel(1))
			usr << "\blue You switch the [src] on."
			src.force = 15
			src.damtype = "fire"
			src.icon_state = "welder1"
			processing_objects.Add(src)
		else
			usr << "\blue Need more fuel!"
			src.welding = 0
			return
	else
		if(!message)
			usr << "\blue You switch the [src] off."
		else
			usr << "\blue The [src] shuts off!"
		src.force = 3
		src.damtype = "brute"
		src.icon_state = "welder"
		src.welding = 0

//Decides whether or not to damage a player's eyes based on what they're wearing as protection
//Note: This should probably be moved to mob
/obj/item/weapon/weldingtool/proc/eyecheck(mob/user as mob)
	if(!iscarbon(user))	return 1
	var/safety = user:eyecheck()
	if(istype(user, /mob/living/carbon/human))
		var/mob/living/carbon/human/H = user
		var/datum/organ/internal/eyes/E = H.internal_organs_by_name["eyes"]
		if(!E)
			return
		if(H.species.flags & IS_SYNTHETIC)
			return
		switch(safety)
			if(1)
				usr << "\red Your eyes sting a little."
				E.damage += rand(1, 2)
				if(E.damage > 12)
					user.eye_blurry += rand(3,6)
			if(0)
				usr << "\red Your eyes burn."
				E.damage += rand(2, 4)
				if(E.damage > 10)
					E.damage += rand(4,10)
			if(-1)
				usr << "\red Your thermals intensify the welder's glow. Your eyes itch and burn severely."
				user.eye_blurry += rand(12,20)
				E.damage += rand(12, 16)
		if(safety<2)

			if(E.damage > 10)
				user << "\red Your eyes are really starting to hurt. This can't be good for you!"

			if (E.damage >= E.min_broken_damage)
				user << "\red You go blind!"
				user.sdisabilities |= BLIND
			else if (E.damage >= E.min_bruised_damage)
				user << "\red You go blind!"
				user.eye_blind = 5
				user.eye_blurry = 5
				user.disabilities |= NEARSIGHTED
				spawn(100)
					user.disabilities &= ~NEARSIGHTED
	return


/obj/item/weapon/weldingtool/largetank
	name = "Industrial Welding Tool"
	max_fuel = 40
	m_amt = 70
	g_amt = 60
	origin_tech = "engineering=2"

/obj/item/weapon/weldingtool/hugetank
	name = "Upgraded Welding Tool"
	max_fuel = 80
	w_class = 3.0
	m_amt = 70
	g_amt = 120
	origin_tech = "engineering=3"

/obj/item/weapon/weldingtool/experimental
	name = "Experimental Welding Tool"
	max_fuel = 40
	w_class = 3.0
	m_amt = 70
	g_amt = 120
	origin_tech = "engineering=4;plasma=3"
	var/last_gen = 0



/obj/item/weapon/weldingtool/experimental/proc/fuel_gen()//Proc to make the experimental welder generate fuel, optimized as fuck -Sieve
	var/gen_amount = ((world.time-last_gen)/25)
	reagents += (gen_amount)
	if(reagents > max_fuel)
		reagents = max_fuel

/*
 * Crowbar
 */

/obj/item/weapon/crowbar
	name = "crowbar"
	desc = "Used to hit floors"
	icon = 'icons/obj/items.dmi'
	icon_state = "crowbar"
	flags = FPRINT | TABLEPASS| CONDUCT
	slot_flags = SLOT_BELT
	force = 5.0
	throwforce = 7.0
	item_state = "crowbar"
	w_class = 2.0
	m_amt = 50
	origin_tech = "engineering=1"
	attack_verb = list("attacked", "bashed", "battered", "bludgeoned", "whacked")
	hitsound= "crowbar_hit"
	swing_sound = "crowbar_swing"

/obj/item/weapon/crowbar/red
	icon = 'icons/obj/items.dmi'
	icon_state = "red_crowbar"
	item_state = "crowbar"

/obj/item/weapon/weldingtool/attack(mob/M as mob, mob/user as mob)
	if(hasorgans(M))
		var/datum/organ/external/S = M:organs_by_name[user.zone_sel.selecting]
		if (!S) return
		if(!(S.status & ORGAN_ROBOT) || user.a_intent != "help")
			return ..()

		if(istype(M,/mob/living/carbon/human))
			var/mob/living/carbon/human/H = M
			if(H.species.flags & IS_SYNTHETIC)
				if(M == user)
					user << "\red You can't repair damage to your own body - it's against OH&S."
					return

		if(S.brute_dam)
			S.heal_damage(15,0,0,1)
			if(user != M)
				user.visible_message("\red \The [user] patches some dents on \the [M]'s [S.display_name] with \the [src]",\
				"\red You patch some dents on \the [M]'s [S.display_name]",\
				"You hear a welder.")
			else
				user.visible_message("\red \The [user] patches some dents on their [S.display_name] with \the [src]",\
				"\red You patch some dents on your [S.display_name]",\
				"You hear a welder.")
		else
			user << "Nothing to fix!"
	else
		return ..()
