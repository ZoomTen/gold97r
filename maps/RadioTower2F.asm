	const_def 2 ; object constants
	const RADIOTOWER2F_JIGGLYPUFF
	const RADIOTOWER2F_BUENA
	const RADIOTOWER2F_RECEPTIONIST
	const RADIOTOWER2F_ROCKER
	const RADIOTOWER2F_GRUNTM24
	const RADIOTOWER2F_GRUNTM26
;	const RADIOTOWER2F_LILY

RadioTower2F_MapScripts:
	db 0 ; scene scripts

	db 0 ; callbacks

RadioTower2FUnusedDummyScene:
; unused
	end


RadioTowerJigglypuff:
	opentext
	writetext RadioTowerJigglypuffText
	cry JIGGLYPUFF
	waitbutton
	closetext
	end

Buena:
	faceplayer
	opentext
	checkflag ENGINE_ROCKETS_IN_RADIO_TOWER
	iftrue .MidRocketTakeover
	checkevent EVENT_MET_BUENA
	iffalse .Introduction
	checkflag ENGINE_BUENAS_PASSWORD_2
	iftrue .PlayedAlready
	checkcode VAR_HOUR
	ifless 18, .TooEarly
	checkflag ENGINE_BUENAS_PASSWORD
	iffalse .TuneIn
	checkitem BLUE_CARD
	iffalse .NoBlueCard
	checkcode VAR_BLUECARDBALANCE
	ifequal 30, .BlueCardCapped0
	playmusic MUSIC_BUENAS_PASSWORD
	writetext UnknownText_0x5de35
	special AskRememberPassword
	iffalse .ForgotPassword
	writetext UnknownText_0x5de84
	waitbutton
	closetext
	turnobject RADIOTOWER2F_BUENA, RIGHT
	checkcode VAR_FACING
	ifnotequal RIGHT, .DontNeedToMove
	applymovement PLAYER, MovementData_0x5d921
.DontNeedToMove:
	turnobject PLAYER, RIGHT
	opentext
	writetext UnknownText_0x5dedd
	waitbutton
	closetext
	turnobject RADIOTOWER2F_BUENA, DOWN
	refreshscreen
	special BuenasPassword
	closetext
	iffalse .WrongAnswer
	opentext
	writetext UnknownText_0x5dfc1
	waitbutton
	closetext
	checkcode VAR_BLUECARDBALANCE
	addvar 1
	writevarcode VAR_BLUECARDBALANCE
	waitsfx
	playsound SFX_TRANSACTION
	setflag ENGINE_BUENAS_PASSWORD_2
	pause 20
	turnobject RADIOTOWER2F_BUENA, RIGHT
	opentext
	writetext UnknownText_0x5e054
	waitbutton
	closetext
	special FadeOutMusic
	pause 20
	special RestartMapMusic
	checkcode VAR_BLUECARDBALANCE
	ifequal 30, .BlueCardCapped1
	end

.Introduction:
	writetext UnknownText_0x5dcf4
	buttonsound
	setevent EVENT_MET_BUENA
	verbosegiveitem BLUE_CARD
.TuneIn:
	writetext UnknownText_0x5de10
	waitbutton
	closetext
	checkcellnum PHONE_BUENA
	iftrue .Registered0
	checkevent EVENT_BUENA_OFFERED_HER_PHONE_NUMBER
	iftrue .OfferedNumberBefore
.Registered0:
	turnobject RADIOTOWER2F_BUENA, RIGHT
	end

.ForgotPassword:
	writetext UnknownText_0x5df29
	waitbutton
	closetext
	turnobject RADIOTOWER2F_BUENA, RIGHT
	special FadeOutMusic
	pause 20
	special RestartMapMusic
	end

.PlayedAlready:
	writetext UnknownText_0x5df6c
	waitbutton
	closetext
	checkcellnum PHONE_BUENA
	iftrue .Registered1
	checkevent EVENT_BUENA_OFFERED_HER_PHONE_NUMBER
	iftrue .OfferedNumberBefore
.Registered1:
	turnobject RADIOTOWER2F_BUENA, RIGHT
	pause 10
	end

.WrongAnswer:
	setflag ENGINE_BUENAS_PASSWORD_2
	opentext
	writetext UnknownText_0x5e01c
	waitbutton
	closetext
	turnobject RADIOTOWER2F_BUENA, RIGHT
	pause 20
	opentext
	writetext UnknownText_0x5e054
	waitbutton
	closetext
	turnobject RADIOTOWER2F_BUENA, RIGHT
	special FadeOutMusic
	pause 20
	special RestartMapMusic
	end

.MidRocketTakeover:
	writetext UnknownText_0x5e0c2
	waitbutton
	closetext
	end

.NoBlueCard:
	writetext UnknownText_0x5e192
	waitbutton
	closetext
	checkcellnum PHONE_BUENA
	iftrue .Registered2
	checkevent EVENT_BUENA_OFFERED_HER_PHONE_NUMBER_NO_BLUE_CARD
	iftrue .OfferedNumberBefore
.Registered2:
	turnobject RADIOTOWER2F_BUENA, RIGHT
	end

.BlueCardCapped0:
	writetext UnknownText_0x5e0f1
	waitbutton
	closetext
	checkcellnum PHONE_BUENA
	iftrue .Registered3
	checkevent EVENT_BUENA_OFFERED_HER_PHONE_NUMBER_NO_BLUE_CARD
	iftrue .OfferedNumberBefore
.Registered3:
	turnobject RADIOTOWER2F_BUENA, RIGHT
	end

.TooEarly:
	writetext UnknownText_0x5e131
	waitbutton
	closetext
	checkcellnum PHONE_BUENA
	iftrue .Registered4
	checkevent EVENT_BUENA_OFFERED_HER_PHONE_NUMBER
	iftrue .OfferedNumberBefore
.Registered4:
	end

.BlueCardCapped1:
	checkcellnum PHONE_BUENA
	iftrue .HasNumber
	pause 20
	turnobject RADIOTOWER2F_BUENA, DOWN
	pause 15
	turnobject PLAYER, UP
	pause 15
	checkevent EVENT_BUENA_OFFERED_HER_PHONE_NUMBER_NO_BLUE_CARD
	iftrue .OfferedNumberBefore
	showemote EMOTE_SHOCK, RADIOTOWER2F_BUENA, 15
	setevent EVENT_BUENA_OFFERED_HER_PHONE_NUMBER_NO_BLUE_CARD
	setevent EVENT_BUENA_OFFERED_HER_PHONE_NUMBER
	opentext
	writetext UnknownText_0x5e1ee
	jump .AskForNumber

.OfferedNumberBefore:
	opentext
	writetext UnknownText_0x5e2bf
.AskForNumber:
	askforphonenumber PHONE_BUENA
	ifequal PHONE_CONTACTS_FULL, .PhoneFull
	ifequal PHONE_CONTACT_REFUSED, .NumberDeclined
	writetext UnknownText_0x5e2f3
	playsound SFX_REGISTER_PHONE_NUMBER
	waitsfx
	buttonsound
	writetext UnknownText_0x5e310
	waitbutton
	closetext
	turnobject RADIOTOWER2F_BUENA, RIGHT
	addcellnum PHONE_BUENA
	end

.NumberDeclined:
	writetext UnknownText_0x5e33c
	waitbutton
	closetext
	turnobject RADIOTOWER2F_BUENA, RIGHT
	end

.PhoneFull:
	writetext UnknownText_0x5e35e
	waitbutton
	closetext
	turnobject RADIOTOWER2F_BUENA, RIGHT
.HasNumber:
	end

RadioTowerBuenaPrizeReceptionist:
	faceplayer
	opentext
	checkitem BLUE_CARD
	iffalse .NoCard
	writetext UnknownText_0x5e392
	buttonsound
	special BuenaPrize
	closetext
	end

.NoCard:
	writetext UnknownText_0x5e3d8
	buttonsound
	closetext
	end

RadioTower2FSalesSign:
	jumptext RadioTower2FSalesSignText

RadioTower2FOaksPKMNTalkSign:
	jumptext RadioTower2FOaksPKMNTalkSignText

RadioTower2FPokemonRadioSign:
	jumptext RadioTower2FPokemonRadioSignText
	
RadioTower2fRocker:
	faceplayer
	opentext
	checkflag ENGINE_ROCKETS_IN_RADIO_TOWER
	iftrue .MidRocketTakeover2fRocker
	writetext RadioTower2fRockerText
	waitbutton
	closetext
	end
.MidRocketTakeover2fRocker
	writetext RadioTower2fRockerTextTakeover
	waitbutton
	closetext
	end
	
TrainerGruntM24:
	trainer GRUNTF, GRUNTF_8, EVENT_BEAT_ROCKET_GRUNTM_24, GruntM24SeenText, GruntM24BeatenText, 0, .Script

.Script:
	endifjustbattled
	opentext
	writetext GruntM24AfterBattleText
	waitbutton
	closetext
	end
	
TrainerGruntM26:
	trainer GRUNTM, GRUNTM_26, EVENT_BEAT_ROCKET_GRUNTM_26, GruntM26SeenText, GruntM26BeatenText, 0, .Script

.Script:
	endifjustbattled
	opentext
	writetext GruntM26AfterBattleText
	waitbutton
	closetext
	end
	
;RadioTower2fLily:
;	faceplayer
;	opentext
;	checkflag ENGINE_ROCKETS_IN_RADIO_TOWER
;	iftrue .MidRocketTakeover2fLily
;	writetext RadioTower2fLilyText
;	waitbutton
;	closetext
;	end
;.MidRocketTakeover2fLily
;	writetext RadioTower2fLilyTextTakeover
;	waitbutton
;;	closetext
;	end
	
;RadioTower2fLilyText:
;	text "LILY: Be sure to"
;	line "tune in to hear me"
;	para "talk about all of"
;	line "my favorite people"
;	cont "and locations!"
;	done
;	
;RadioTower2fLilyTextTakeover:
;	text "LILY: TEAM ROCKET"
;	line "members are my"
;	cont "least favorite!"
;	done
	
GruntM24SeenText:
	text "TEAM ROCKET can"
	line "conduct operations"
	cont "in secret bases."
	para "But we also have"
	line "no problem barging"
	para "in and taking what"
	line "we need if it's"
	cont "necessary!"
	done
	
GruntM24BeatenText:
	text "And you had no"
	line "problem defeating"
	cont "me!"
	done
	
GruntM24AfterBattleText:
	text "Have you met our"
	line "leader?"
	para "I have a feeling"
	line "you two wouldn't"
	cont "get along."
	done

GruntM26SeenText:
	text "Why are we here?"
	para "Because you and"
	line "your friend"
	para "destroyed our"
	line "antenna!"
	para "Why build another"
	line "when we could just"
	cont "take this one!"
	done
	
GruntM26BeatenText:
	text "Yeowch!"
	done
	
GruntM26AfterBattleText:
	text "I blame you for"
	line "all the problems"
	cont "we've had!"
	done

	
RadioTower2fRockerTextTakeover:
	text "Every radio"
	line "station is talking"
	cont "about TEAM ROCKET!"
	done

RadioTower2fRockerText:
	text "Have you listened"
	line "to the #MON"
	cont "March?"
	para "It makes wild"
	line "#MON appear"
	cont "more frequently."
	done

MovementData_0x5d921:
;	slow_step DOWN
;	slow_step RIGHT
	step_end


RadioTowerJigglypuffText:
	text "JIGGLYPUFF:"
	line "Jiggly…"
	done

UnknownText_0x5dcf4:
	text "BUENA: Hi! I'm"
	line "BUENA!"

	para "Do you know about"
	line "a radio program"
	cont "called PASSWORD?"

	para "If you can tell me"
	line "the password from"

	para "the program, you"
	line "will earn points."

	para "Save up those"
	line "points and trade"

	para "them to that sweet"
	line "young lady over"

	para "there for some"
	line "choice prizes!"

	para "Here you go!"

	para "It's your very own"
	line "point card!"
	done

UnknownText_0x5de10:
	text "BUENA: Tune in to"
	line "my PASSWORD SHOW!"
	done

UnknownText_0x5de35:
	text "BUENA: Hi!"
	line "Did you tune in to"
	cont "my radio show?"

	para "Do you remember"
	line "today's password?"
	done

UnknownText_0x5de84:
	text "BUENA: Oh, wow!"
	line "Thank you!"

	para "What was your name"
	line "again?"

	para "…<PLAY_G>, OK!"

	para "Come on, <PLAY_G>."
	line "Join the show."
	done

UnknownText_0x5dedd:
	text "BUENA: Everyone"
	line "ready?"

	para "I want to hear you"
	line "shout out today's"

	para "password for"
	line "<PLAY_G>!"
	done

UnknownText_0x5df29:
	text "BUENA: Come back"
	line "after you listen"

	para "to my show, OK?"
	line "Catch ya later!"
	done

UnknownText_0x5df6c:
	text "BUENA: Sorry…"

	para "You get just one"
	line "chance each day."

	para "Come back tomorrow"
	line "for another try!"
	done

UnknownText_0x5dfc1:
	text "BUENA: YIPPEE!"
	line "That's right!"

	para "You did tune in!"
	line "I'm so happy!"

	para "You earned one"
	line "point! Congrats!"
	done

UnknownText_0x5e01c:
	text "BUENA: Aww…"
	line "That's not it…"

	para "Did you forget the"
	line "password?"
	done

UnknownText_0x5e054:
	text "BUENA: Yup! Our"
	line "contestant was"

	para "<PLAY_G>."
	line "Thanks for coming!"

	para "I hope all you"
	line "listeners will"

	para "come too!"
	line "I'll be waiting!"
	done

UnknownText_0x5e0c2:
	text "BUENA: Huh?"
	line "Today's password?"

	para "HELP, of course!"
	done

UnknownText_0x5e0f1:
	text "BUENA: Your BLUE"
	line "CARD's full."

	para "Trade it in for a"
	line "fabulous prize!"
	done

UnknownText_0x5e131:
	text "BUENA: Tune in to"
	line "PASSWORD every"

	para "night from six to"
	line "midnight!"

	para "Tune in, then drop"
	line "in for a visit!"
	done

UnknownText_0x5e192:
	text "BUENA: Oh? You"
	line "forgot to bring"
	cont "your BLUE CARD?"

	para "I can't give you"
	line "points if you"
	cont "don't have it."
	done

UnknownText_0x5e1ee:
	text "BUENA: Oh! Your"
	line "BLUE CARD reached"

	para "30 points today!"
	line "That's so wild!"

	para "Hmm… There isn't a"
	line "prize for hitting"
	cont "30 points, but…"

	para "You came by so"
	line "often, <PLAY_G>."

	para "I'll make you a"
	line "special deal!"

	para "How would you like"
	line "my phone number?"
	done

UnknownText_0x5e2bf:
	text "BUENA: <PLAY_G>,"
	line "do you want to"

	para "register my phone"
	line "number?"
	done

UnknownText_0x5e2f3:
	text "<PLAYER> registered"
	line "BUENA's number."
	done

UnknownText_0x5e310:
	text "BUENA: I look"
	line "forward to hearing"
	cont "from you!"
	done

UnknownText_0x5e33c:
	text "BUENA: Aww… It's a"
	line "special prize…"
	done

UnknownText_0x5e35e:
	text "BUENA: <PLAY_G>,"
	line "your phone list"

	para "has no room left"
	line "for me…"
	done

UnknownText_0x5e392:
	text "You can cash in"
	line "your saved points"

	para "for a lovely prize"
	line "of your choice!"
	done

UnknownText_0x5e3d8:
	text "You can't trade in"
	line "points without"
	cont "your BLUE CARD."

	para "Don't forget your"
	line "BLUE CARD!"
	done

RadioTower2FSalesSignText:
	text "2F STUDIO 1"
	done

RadioTower2FOaksPKMNTalkSignText:
	text "PROF.OAK'S #MON"
	line "TALK"

	para "The Hottest Show"
	line "on the Air!"
	done

RadioTower2FPokemonRadioSignText:
	text "Anywhere, Anytime"
	line "#MON Radio"
	done

RadioTower2F_MapEvents:
	db 0, 0 ; filler

	db 2 ; warp events
	warp_event  0,  0, RADIO_TOWER_3F, 1
	warp_event  7,  0, RADIO_TOWER_1F, 3

	db 0 ; coord events

	db 3 ; bg events
	bg_event  5,  0, BGEVENT_READ, RadioTower2FSalesSign
	bg_event  6, -1, BGEVENT_READ, RadioTower2FOaksPKMNTalkSign
	bg_event  3,  0, BGEVENT_READ, RadioTower2FPokemonRadioSign

	db 6 ; object events
;	object_event  0,  1, SPRITE_BLACK_BELT, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, RadioTower2FBlackBelt1Script, EVENT_RADIO_TOWER_BLACKBELT_BLOCKS_STAIRS
;	object_event  1,  1, SPRITE_BLACK_BELT, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, RadioTower2FBlackBelt2Script, EVENT_RADIO_TOWER_CIVILIANS_AFTER
	object_event  4,  1, SPRITE_JIGGLYPUFF, SPRITEMOVEDATA_POKEMON, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, RadioTowerJigglypuff, -1
	object_event  0,  5, SPRITE_LASS, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, Buena, -1
	object_event  4,  6, SPRITE_RECEPTIONIST, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, RadioTowerBuenaPrizeReceptionist, EVENT_GOLDENROD_CITY_CIVILIANS
	object_event  6,  5, SPRITE_ROCKER, SPRITEMOVEDATA_SPINRANDOM_SLOW, 1, 1, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, RadioTower2fRocker, -1
	object_event  2,  1, SPRITE_ROCKET_GIRL, SPRITEMOVEDATA_STANDING_DOWN, 1, 1, -1, -1, PAL_NPC_RED, OBJECTTYPE_TRAINER, 1, TrainerGruntM24, EVENT_RADIO_TOWER_ROCKET_TAKEOVER
	object_event  6,  1, SPRITE_ROCKET, SPRITEMOVEDATA_STANDING_DOWN, 1, 1, -1, -1, PAL_NPC_BROWN, OBJECTTYPE_TRAINER, 4, TrainerGruntM26, EVENT_RADIO_TOWER_ROCKET_TAKEOVER
;	object_event  6,  5, SPRITE_COOLTRAINER_F, SPRITEMOVEDATA_STANDING_RIGHT, 1, 1, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, RadioTower2fLily, -1
