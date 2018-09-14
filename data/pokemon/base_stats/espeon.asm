	db ESPEON ; 196

	db  60, 50, 110,  160,  65,  80
	;   hp  atk  def  spd  sat  sdf

	db ELECTRIC, PSYCHIC ; type
	db 45 ; catch rate
	db 197 ; base exp
	db NO_ITEM, NO_ITEM ; items
	db GENDER_F0 ; gender ratio
	db 100 ; unknown 1
	db 35 ; step cycles to hatch
	db 5 ; unknown 2
	INCBIN "gfx/pokemon/espeon/front.dimensions"
	db 0, 0, 0, 0 ; padding
	db GROWTH_MEDIUM_FAST ; growth rate
	dn EGG_GROUND, EGG_HUMANSHAPE ; egg groups

	; tm/hm learnset
	tmhm HEADBUTT, CURSE, TOXIC, HIDDEN_POWER, SUNNY_DAY, SNORE, PROTECT, RAIN_DANCE, ENDURE, FRUSTRATION, IRON_TAIL, RETURN, SHADOW_BALL, MUD_SLAP, DOUBLE_TEAM, SWAGGER, SLEEP_TALK, SWIFT, DETECT, REST, ATTRACT, IRON_HEAD, CUT, SURF, STRENGTH, FLASH, ROCK_SMASH, ROLLOUT, DEFENSE_CURL, FIRE_PUNCH, ICE_PUNCH, THUNDERPUNCH, DIG, PSYCH_UP, PSYCHIC_M, DREAM_EATER, NIGHTMARE
	; end
