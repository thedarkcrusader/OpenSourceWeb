var/church_name = null
/proc/church_name()
	if (church_name)
		return church_name

	var/name = ""

	name += pick("Holy", "United", "First", "Second", "Last")

	if (prob(20))
		name += " Space"

	name += " " + pick("Church", "Cathedral", "Body", "Worshippers", "Movement", "Witnesses")
	name += " of [religion_name()]"

	return name

var/command_name = null
/proc/command_name()
	if (command_name)
		return command_name

	var/name = "Central Command"

	command_name = name
	return name

/proc/change_command_name(var/name)

	command_name = name

	return name

var/religion_name = null
/proc/religion_name()
	if (religion_name)
		return religion_name

	var/name = ""

	name += pick("bee", "science", "edu", "captain", "assistant", "monkey", "alien", "space", "unit", "sprocket", "gadget", "bomb", "revolution", "beyond", "station", "goon", "robot", "ivor", "hobnob")
	name += pick("ism", "ia", "ology", "istism", "ites", "ick", "ian", "ity")

	return capitalize(name)

/proc/vessel_name()
	var/name = ""

	//Rare: Pre-Prefix

	// Prefix

	name = "Allah Combat: "
	name += pick("Gabagool", "Sopranos", "Download the", "Pirate the","Torrent the","Install the","Woody Got","Arabic", "Five Nights At", "Sus", "The Elder", "Deus", "Nokia","Coding","Combat","Morrowind","Vampire: The","Prick's","Consuming","Mr.","Chuck","Feed","Seed","Fake","Real","Allah") // I genuinely didn't add Chuck, Feed, or Seed
	name += " "
	name += pick("Gyatt","Wood","Imposter","Scrolls","Ex","Hardcore Pornography","Terrorist","Phone","Masquerade","Purpletext","Hijab","Frags","Gacha Game","TV Show","Cartoon","Morgz","Daemon","News","Allah","Chuck","Feed","Seed","Ice Cream Man","McNuggets","Combat") // I did add it here though.

	world.name = name

	return name

/proc/world_name(var/name)

	vessel_name = name

	if (config && config.server_name)
		world.name = "[config.server_name]: [name]"
	else
		world.name = name

	return name