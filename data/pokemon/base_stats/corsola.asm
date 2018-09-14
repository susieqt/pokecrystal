	db CORSOLA ; 222

	db  80,  85,  60,  150, 90,  60
	;   hp  atk  def  spd  sat  sdf

	db ELECTRIC, NORMAL ; type
	db 60 ; catch rate
	db 113 ; base exp
	db NO_ITEM, NO_ITEM ; items
	db GENDER_F100 ; gender ratio
	db 100 ; unknown 1
	db 20 ; step cycles to hatch
	db 5 ; unknown 2
	INCBIN "gfx/pokemon/corsola/front.dimensions"
	db 0, 0, 0, 0 ; padding
	db GROWTH_FAST ; growth rate
	dn EGG_GROUND, EGG_HUMANSHAPE ; egg groups

	; tm/hm learnset
	tmhm HEADBUTT, CURSE, TOXIC, HIDDEN_POWER, SUNNY_DAY, SNORE, PROTECT, RAIN_DANCE, ENDURE, FRUSTRATION, IRON_TAIL, RETURN, SHADOW_BALL, MUD_SLAP, DOUBLE_TEAM, SWAGGER, SLEEP_TALK, SWIFT, DETECT, REST, ATTRACT, IRON_HEAD, CUT, SURF, STRENGTH, FLASH, ROCK_SMASH, ROLLOUT, DEFENSE_CURL, FIRE_PUNCH, ICE_PUNCH, THUNDERPUNCH, DIG, SWEET_SCENT, ZAP_CANNON, THUNDERBOLT, ROAR
	; end
