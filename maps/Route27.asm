	const_def 2 ; object constants
	const ROUTE27_FISHER
	const ROUTE27_YOUNGSTER
	const ROUTE27_BUG_CATCHER
	const ROUTE27_COOLTRAINER_M
	const ROUTE27_FRUIT_TREE
	const ROUTE27_POKE_BALL1
	const ROUTE27_POKE_BALL2

Route27_MapScripts:
	db 0 ; scene scripts

	db 1 ; callbacks
	callback MAPCALLBACK_NEWMAP, .CheckMomCall

.CheckMomCall:
	checkevent EVENT_TALKED_TO_MOM_AFTER_MYSTERY_EGG_QUEST
	iffalse .DoMomCall
	return

.DoMomCall:
	specialphonecall SPECIALCALL_WORRIED
	return

TrainerBugCatcherWade1:
	trainer BUG_CATCHER, WADE1, EVENT_BEAT_BUG_CATCHER_WADE, BugCatcherWade1SeenText, BugCatcherWade1BeatenText, 0, .Script

.Script:
	writecode VAR_CALLERID, PHONE_BUG_CATCHER_WADE
	endifjustbattled
	opentext
	checkflag ENGINE_WADE
	iftrue .WadeRematch
	checkflag ENGINE_WADE_HAS_ITEM
	iftrue .WadeItem
	checkcellnum PHONE_BUG_CATCHER_WADE
	iftrue .AcceptedNumberSTD
	checkevent EVENT_WADE_ASKED_FOR_PHONE_NUMBER
	iftrue .AskAgain
	writetext BugCatcherWade1AfterText
	waitbutton
	setevent EVENT_WADE_ASKED_FOR_PHONE_NUMBER
	scall .AskPhoneNumberSTD
	jump .Continue

.AskAgain:
	scall .AskAgainSTD
.Continue:
	askforphonenumber PHONE_BUG_CATCHER_WADE
	ifequal PHONE_CONTACTS_FULL, .PhoneFullSTD
	ifequal PHONE_CONTACT_REFUSED, .DeclinedNumberSTD
	trainertotext BUG_CATCHER, WADE1, MEM_BUFFER_0
	scall .RegisterNumberSTD
	jump .AcceptedNumberSTD

.WadeRematch:
	scall .RematchSTD
	winlosstext BugCatcherWade1BeatenText, 0
	copybytetovar wWadeFightCount
	ifequal 4, .Fight4
	ifequal 3, .Fight3
	ifequal 2, .Fight2
	ifequal 1, .Fight1
	ifequal 0, .LoadFight0
.Fight4:
	checkevent EVENT_BEAT_ELITE_FOUR
	iftrue .LoadFight4
.Fight3:
	checkevent EVENT_CLEARED_RADIO_TOWER
	iftrue .LoadFight3
.Fight2:
	checkflag ENGINE_FLYPOINT_MAHOGANY
	iftrue .LoadFight2
.Fight1:
	checkflag ENGINE_FLYPOINT_GOLDENROD
	iftrue .LoadFight1
.LoadFight0:
	loadtrainer BUG_CATCHER, WADE1
	startbattle
	reloadmapafterbattle
	loadvar wWadeFightCount, 1
	clearflag ENGINE_WADE
	end

.LoadFight1:
	loadtrainer BUG_CATCHER, WADE2
	startbattle
	reloadmapafterbattle
	loadvar wWadeFightCount, 2
	clearflag ENGINE_WADE
	end

.LoadFight2:
	loadtrainer BUG_CATCHER, WADE3
	startbattle
	reloadmapafterbattle
	loadvar wWadeFightCount, 3
	clearflag ENGINE_WADE
	end

.LoadFight3:
	loadtrainer BUG_CATCHER, WADE4
	startbattle
	reloadmapafterbattle
	loadvar wWadeFightCount, 4
	clearflag ENGINE_WADE
	end

.LoadFight4:
	loadtrainer BUG_CATCHER, WADE5
	startbattle
	reloadmapafterbattle
	clearflag ENGINE_WADE
	end

.WadeItem:
	scall .ItemSTD
	checkevent EVENT_WADE_HAS_BERRY
	iftrue .Berry
	checkevent EVENT_WADE_HAS_PSNCUREBERRY
	iftrue .Psncureberry
	checkevent EVENT_WADE_HAS_PRZCUREBERRY
	iftrue .Przcureberry
	checkevent EVENT_WADE_HAS_BITTER_BERRY
	iftrue .BitterBerry
.Berry:
	verbosegiveitem BERRY
	iffalse .PackFull
	jump .Done
.Psncureberry:
	verbosegiveitem PSNCUREBERRY
	iffalse .PackFull
	jump .Done
.Przcureberry:
	verbosegiveitem PRZCUREBERRY
	iffalse .PackFull
	jump .Done
.BitterBerry:
	verbosegiveitem BITTER_BERRY
	iffalse .PackFull
.Done:
	clearflag ENGINE_WADE_HAS_ITEM
	jump .AcceptedNumberSTD
.PackFull:
	jump .PackFullSTD

.AskPhoneNumberSTD:
	jumpstd asknumber1m
	end

.AskAgainSTD:
	jumpstd asknumber2m
	end

.RegisterNumberSTD:
	jumpstd registerednumberm
	end

.AcceptedNumberSTD:
	jumpstd numberacceptedm
	end

.DeclinedNumberSTD:
	jumpstd numberdeclinedm
	end

.PhoneFullSTD:
	jumpstd phonefullm
	end

.RematchSTD:
	jumpstd rematchm
	end

.ItemSTD:
	jumpstd giftm
	end

.PackFullSTD:
	jumpstd packfullm
	end

ROUTE27MailRecipientScript:
	faceplayer
	opentext
	checkevent EVENT_GOT_TM50_NIGHTMARE
	iftrue .DescribeNightmare
	checkevent EVENT_GOT_KENYA
	iftrue .TryGiveKenya
	writetext Text_ROUTE27SleepyMan
	waitbutton
	closetext
	end

.TryGiveKenya:
	writetext Text_ROUTE27SleepyManGotMail
	buttonsound
	checkpokemail ReceivedSpearowMailText
	ifequal POKEMAIL_WRONG_MAIL, .WrongMail
	ifequal POKEMAIL_REFUSED, .Refused
	ifequal POKEMAIL_NO_MAIL, .NoMail
	ifequal POKEMAIL_LAST_MON, .LastMon
	; POKEMAIL_CORRECT
	writetext Text_ROUTE27HandOverMailMon
	buttonsound
	writetext Text_ROUTE27ReadingMail
	buttonsound
	setevent EVENT_GAVE_KENYA
	verbosegiveitem TM_NIGHTMARE
	iffalse .NoRoomForItems
	setevent EVENT_GOT_TM50_NIGHTMARE
.DescribeNightmare:
	writetext Text_ROUTE27DescribeNightmare
	waitbutton
.NoRoomForItems:
	closetext
	end

.WrongMail:
	writetext Text_ROUTE27WrongMail
	waitbutton
	closetext
	end

.NoMail:
	writetext Text_ROUTE27MissingMail
	waitbutton
	closetext
	end

.Refused:
	writetext Text_ROUTE27DeclinedToHandOverMail
	waitbutton
	closetext
	end

.LastMon:
	writetext Text_ROUTE27CantTakeLastMon
	waitbutton
	closetext
	end

ReceivedSpearowMailText:
	db   "DARK CAVE leads"
	next "to another road@"

ROUTE27YoungsterScript:
	jumptextfaceplayer ROUTE27YoungsterText

ROUTE27Sign:
	jumptext ROUTE27SignText

DarkCaveSign:
	jumptext DarkCaveSignText

ROUTE27CooltrainerMScript:
	jumptextfaceplayer ROUTE27CooltrainerMText

ROUTE27FruitTree:
	fruittree FRUITTREE_ROUTE_31

ROUTE27Potion:
	itemball POTION

ROUTE27PokeBall:
	itemball POKE_BALL

ROUTE27CooltrainerMText:
	text "DARK CAVE…"

	para "If #MON could"
	line "light it up, I'd"
	cont "explore it."
	done

BugCatcherWade1SeenText:
	text "I caught a bunch"
	line "of #MON. Let me"
	cont "battle with you!"
	done

BugCatcherWade1BeatenText:
	text "Awwwww…"
	done

BugCatcherWade1AfterText:
	text "You can catch"
	line "#MON even if"

	para "you have six with"
	line "you."

	para "If you catch one,"
	line "it'll go to your"
	cont "BOX automatically."
	done

Text_ROUTE27SleepyMan:
	text "… Hnuurg… Huh?"

	para "I walked too far"
	line "today looking for"
	cont "#MON."

	para "My feet hurt and"
	line "I'm sleepy…"

	para "If I were a wild"
	line "#MON, I'd be"
	cont "easy to catch…"

	para "…Zzzz…"
	done

Text_ROUTE27SleepyManGotMail:
	text "…Zzzz… Huh?"

	para "What's that? You"
	line "have MAIL for me?"
	done

Text_ROUTE27HandOverMailMon:
	text "<PLAYER> handed"
	line "over the #MON"
	cont "holding the MAIL."
	done

Text_ROUTE27ReadingMail:
	text "Let's see…"

	para "…DARK CAVE leads"
	line "to another road…"

	para "That's good to"
	line "know."

	para "Thanks for bring-"
	line "ing this to me."

	para "My friend's a good"
	line "guy, and you're"
	cont "swell too!"

	para "I'd like to do"
	line "something good in"
	cont "return too!"

	para "I know! I want you"
	line "to have this!"
	done

Text_ROUTE27DescribeNightmare:
	text "TM50 is NIGHTMARE."

	para "It's a wicked move"
	line "that steadily cuts"

	para "the HP of a sleep-"
	line "ing enemy."

	para "Ooooh…"
	line "That's scary…"

	para "I don't want to"
	line "have bad dreams."
	done

Text_ROUTE27WrongMail:
	text "This MAIL isn't"
	line "for me."
	done

Text_ROUTE27MissingMail:
	text "Why is this #-"
	line "MON so special?"

	para "It doesn't have"
	line "any MAIL."
	done

Text_ROUTE27DeclinedToHandOverMail:
	text "What? You don't"
	line "want anything?"
	done

Text_ROUTE27CantTakeLastMon:
	text "If I take that"
	line "#MON from you,"

	para "what are you going"
	line "to use in battle?"
	done

ROUTE27YoungsterText:
	text "I found a good"
	line "#MON in DARK"
	cont "CAVE."

	para "I'm going to raise"
	line "it to take on"
	cont "FALKNER."

	para "He's the leader of"
	line "VIOLET CITY's GYM."
	done

ROUTE27SignText:
	text "ROUTE 2"

	para "BOOMER CITY -"
	line "POINT CITY"
	done

DarkCaveSignText:
	text "DEMO END"
	done

Route27_MapEvents:
	db 0, 0 ; filler

	db 3 ; warp events
	warp_event 25,  0, ROUTE_31_VIOLET_GATE, 3
	warp_event 25,  1, ROUTE_31_VIOLET_GATE, 4
	warp_event 25,  2, DARK_CAVE_VIOLET_ENTRANCE, 1

	db 0 ; coord events

	db 2 ; bg events
	bg_event 21, 21, BGEVENT_READ, ROUTE27Sign
	bg_event 13,  3, BGEVENT_READ, DarkCaveSign

	db 7 ; object events
	object_event  3, 10, SPRITE_FISHER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, ROUTE27MailRecipientScript, -1
	object_event  3, 11, SPRITE_YOUNGSTER, SPRITEMOVEDATA_WANDER, 1, 1, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, ROUTE27YoungsterScript, -1
	object_event 21,  4, SPRITE_BUG_CATCHER, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, PAL_NPC_BROWN, OBJECTTYPE_TRAINER, 5, TrainerBugCatcherWade1, -1
	object_event  4, 11, SPRITE_COOLTRAINER_M, SPRITEMOVEDATA_WANDER, 1, 1, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, ROUTE27CooltrainerMScript, -1
	object_event 19,  9, SPRITE_FRUIT_TREE, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, ROUTE27FruitTree, -1
	object_event 10, 20, SPRITE_POKE_BALL, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_ITEMBALL, 0, ROUTE27Potion, EVENT_ROUTE_31_POTION
	object_event 23,  4, SPRITE_POKE_BALL, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_ITEMBALL, 0, ROUTE27PokeBall, EVENT_ROUTE_31_POKE_BALL
