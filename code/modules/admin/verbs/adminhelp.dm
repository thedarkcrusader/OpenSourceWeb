

//This is a list of words which are ignored by the parser when comparing message contents for names. MUST BE IN LOWER CASE!
//var/list/adminhelp_ignored_words = list("unknown","the","a","an","of","monkey","alien","as")

/client/verb/adminhelp()
	set category = "Admin"
	set name = "Adminhelp"
	usr << 'sound/voice/torture/male_torture_scream1.ogg' // honest reaction
	to_chat(src, "<font color='[normal_ooc_colour]'><b>OOC: [src.key]: I forgot to pray to </font><font color='red'><span class='highlighttext'>ALLAH!</span></font></b>")