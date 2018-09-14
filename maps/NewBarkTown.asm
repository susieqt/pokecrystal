	const_def 2 ; object constants
	const NEWBARKTOWN_TEACHER
	const NEWBARKTOWN_FISHER1
	const NEWBARKTOWN_FISHER2 ;1 and 2, for a testing fisher npc
	const NEWBARKTOWN_SILVER

NewBarkTown_MapScripts:
	db 2 ; scene scripts
	scene_script .DummyScene0 ; SCENE_DEFAULT
	scene_script .DummyScene1 ; SCENE_FINISHED

	db 1 ; callbacks
	callback MAPCALLBACK_NEWMAP, .FlyPoint

.DummyScene0:
	end

.DummyScene1:
	end

.FlyPoint:
	setflag ENGINE_FLYPOINT_NEW_BARK
	clearevent EVENT_FIRST_TIME_BANKING_WITH_MOM
	return

NewBarkTown_TeacherStopsYouScene1:
	playmusic MUSIC_MOM
	turnobject NEWBARKTOWN_TEACHER, LEFT
	opentext
	writetext Text_WaitPlayer
	waitbutton
	closetext
	turnobject PLAYER, RIGHT
	applymovement NEWBARKTOWN_TEACHER, Movement_TeacherRunsToYou1_NBT
	opentext
	writetext Text_WhatDoYouThinkYoureDoing
	waitbutton
	closetext
	follow NEWBARKTOWN_TEACHER, PLAYER
	applymovement NEWBARKTOWN_TEACHER, Movement_TeacherBringsYouBack1_NBT
	stopfollow
	opentext
	writetext Text_ItsDangerousToGoAlone
	waitbutton
	closetext
	special RestartMapMusic
	end

NewBarkTown_TeacherStopsYouScene2:
	playmusic MUSIC_MOM
	turnobject NEWBARKTOWN_TEACHER, LEFT
	opentext
	writetext Text_WaitPlayer
	waitbutton
	closetext
	turnobject PLAYER, RIGHT
	applymovement NEWBARKTOWN_TEACHER, Movement_TeacherRunsToYou2_NBT
	turnobject PLAYER, UP
	opentext
	writetext Text_WhatDoYouThinkYoureDoing
	waitbutton
	closetext
	follow NEWBARKTOWN_TEACHER, PLAYER
	applymovement NEWBARKTOWN_TEACHER, Movement_TeacherBringsYouBack2_NBT
	stopfollow
	opentext
	writetext Text_ItsDangerousToGoAlone
	waitbutton
	closetext
	special RestartMapMusic
	end

NewBarkTownTeacherScript:
	faceplayer
	opentext
	checkevent EVENT_TALKED_TO_MOM_AFTER_MYSTERY_EGG_QUEST
	iftrue .CallMom
	checkevent EVENT_GAVE_MYSTERY_EGG_TO_ELM
	iftrue .TellMomYoureLeaving
	checkevent EVENT_GOT_A_POKEMON_FROM_ELM
	iftrue .MonIsAdorable
	writetext Text_GearIsImpressive
	waitbutton
	closetext
	end

.MonIsAdorable:
	writetext Text_YourMonIsAdorable
	waitbutton
	closetext
	end

.TellMomYoureLeaving:
	writetext Text_TellMomIfLeaving
	waitbutton
	closetext
	end

.CallMom:
	writetext Text_CallMomOnGear
	waitbutton
	closetext
	end

NewBarkTownFisherScript:
	jumptextfaceplayer Text_ElmDiscoveredNewMon
	
NewBarkTownTestNPCScript: ;testing
	jumptextfaceplayer Text_nbtTestDialogue
	
;-----THESE ARE JUST REFERENCES FOR ME-----	
;AideScript_GivePotion:
;	opentext
;	writetext AideText_GiveYouPotion
;	buttonsound
;	verbosegiveitem POTION
;	writetext AideText_AlwaysBusy
;	waitbutton
;	closetext
;	setscene SCENE_ELMSLAB_NOTHING
;	end

NewBarkTownSilverScript:
	opentext
	writetext NewBarkTownRivalText1
	waitbutton
	closetext
	turnobject NEWBARKTOWN_SILVER, LEFT
	opentext
	writetext NewBarkTownRivalText2
	waitbutton
	closetext
	follow PLAYER, NEWBARKTOWN_SILVER
	applymovement PLAYER, Movement_SilverPushesYouAway_NBT
	stopfollow
	pause 5
	turnobject NEWBARKTOWN_SILVER, DOWN
	pause 5
	playsound SFX_TACKLE
	applymovement PLAYER, Movement_SilverShovesYouOut_NBT
	applymovement NEWBARKTOWN_SILVER, Movement_SilverReturnsToTheShadows_NBT
	end

NewBarkTownSign:
	jumptext NewBarkTownSignText

NewBarkTownPlayersHouseSign:
	jumptext NewBarkTownPlayersHouseSignText

NewBarkTownElmsLabSign:
	jumptext NewBarkTownElmsLabSignText

NewBarkTownElmsHouseSign:
	jumptext NewBarkTownElmsHouseSignText
	
NewBarkTownTestAreaSign:
	jumptext NewBarkTownTestAreaSignText

Movement_TeacherRunsToYou1_NBT:
	step LEFT
	step LEFT
	step LEFT
	step LEFT
	step_end

Movement_TeacherRunsToYou2_NBT:
	step LEFT
	step LEFT
	step LEFT
	step LEFT
	step LEFT
	turn_head DOWN
	step_end

Movement_TeacherBringsYouBack1_NBT:
	step RIGHT
	step RIGHT
	step RIGHT
	step RIGHT
	turn_head LEFT
	step_end

Movement_TeacherBringsYouBack2_NBT:
	step RIGHT
	step RIGHT
	step RIGHT
	step RIGHT
	step RIGHT
	turn_head LEFT
	step_end

Movement_SilverPushesYouAway_NBT:
	turn_head UP
	step DOWN
	step_end

Movement_SilverShovesYouOut_NBT:
	turn_head UP
	fix_facing
	jump_step DOWN
	remove_fixed_facing
	step_end

Movement_SilverReturnsToTheShadows_NBT:
	step RIGHT
	step_end

Text_GearIsImpressive:
	text "Wow, your #GEAR"
	line "is old!"

	para "[sip] back in my"
	line "day I used to"
	cont "play QUAKE"
	cont "on mine!"
	done

Text_WaitPlayer:
	text "Hey, wait up,"
	line "<PLAY_G>."
	done

Text_WhatDoYouThinkYoureDoing:
	text "[sip] Whatcha"
	line "doin?"
	done

Text_ItsDangerousToGoAlone:
	text "Are ya winnin',"
	line "son? [sip]"

	para "We're almost"
	line "done mowing up"
	cont "here, can ya"
	cont "wait a bit?"
	done

Text_YourMonIsAdorable:
	text "Jesus christ,"
	line "you're an ugly"
	cont "cunt."
	done

Text_TellMomIfLeaving:
	text "Hi, <PLAY_G>!"
	line "Finally leaving?"

	para "Please for the"
	line "love of god," ;todo?
	cont "don't come back."
	done

Text_CallMomOnGear:
	text "Call the matron"
	line "on your #GEAR to"

	para "let her know how" ;todo
	line "you're doing."
	done

Text_ElmDiscoveredNewMon:
	text "Yo, <PLAYER>!"

	para "I hear QUALUIGI"
	line "discovered some"
	cont "new BOOTLEGs."
	done
	
Text_nbtTestDialogue: ;for test NPC
	text "Man I hate"
	line "Millenials."
	cont "[sip]"
	done

NewBarkTownRivalText1:
	text "<……>"

	para "Where the hell"
	line "does he keep the"
	cont "money?"
	done

NewBarkTownRivalText2:
	text "Oh, hey bro!"
	
	para "How about you"
	line "go back to sleep?"
	done

NewBarkTownSignText:
	text "BOOMER TOWN"

	para "The Town With the"
	line "Wafting Smell of"
	cont "Freshly-Mowed" ;should this be on a new paragraph?
	cont "Grass"
	done

NewBarkTownPlayersHouseSignText:
	text "<PLAYER>'s Shed"
	done

NewBarkTownElmsLabSignText:
	text "QUALUIGI'S LAB"
	done

NewBarkTownElmsHouseSignText:
	text "QUALUIGI'S BIG"
	line "ASS TRUCK RENTAL"
	cont "AND STORAGE"
	done
	
NewBarkTownTestAreaSignText:
	text "Dev testing area"
	line "to the north if"
	
	para "Susie gets around"
	line "to putting it in."
	done

NewBarkTown_MapEvents:
	db 0, 0 ; filler

	db 4 ; warp events
	warp_event 16, 13, ELMS_LAB, 1
	warp_event  7,  5, PLAYERS_HOUSE_1F, 1
	warp_event  7, 15, PLAYERS_NEIGHBORS_HOUSE, 1
	warp_event  9,  9, ELMS_HOUSE, 1

	db 2 ; coord events
	coord_event  25,  8, SCENE_DEFAULT, NewBarkTown_TeacherStopsYouScene1
	coord_event  11,  2, SCENE_DEFAULT, NewBarkTown_TeacherStopsYouScene2

	db 4 ; bg events
	bg_event 12, 12, BGEVENT_READ, NewBarkTownSign
	bg_event  6,  6, BGEVENT_READ, NewBarkTownPlayersHouseSign
	bg_event 17, 15, BGEVENT_READ, NewBarkTownElmsLabSign
	bg_event  8, 10, BGEVENT_READ, NewBarkTownElmsHouseSign
	bg_event 23,  7, BGEVENT_READ, NewBarkTownTestAreaSign ;dev test area sign **CURRENTLY BROKEN**

	db 3 ; object events
	object_event  9,  0, SPRITE_FISHER, SPRITEMOVEDATA_SPINRANDOM_SLOW, 1, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, NewBarkTownTeacherScript, -1
	object_event 16,  17, SPRITE_FISHER, SPRITEMOVEDATA_WALK_UP_DOWN, 0, 1, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, NewBarkTownFisherScript, -1
	object_event 5,  11, SPRITE_FISHER, SPRITEMOVEDATA_STANDING_LEFT, 0, 1, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, NewBarkTownTestNPCScript, -1 
	object_event  13,  12, SPRITE_SILVER, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, NewBarkTownSilverScript, EVENT_RIVAL_NEW_BARK_TOWN