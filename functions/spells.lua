do

	local _detalhes = 		_G._detalhes

	_detalhes.ClassSpellList = {

		--death knight
			[77535]	=	"DEATHKNIGHT", --Blood Shield (heal)
			[45470]	=	"DEATHKNIGHT", --Death Strike (heal)
			[53365]	=	"DEATHKNIGHT", --Unholy Strength (heal)
			[48707]	=	"DEATHKNIGHT", -- Anti-Magic Shell (heal)
			[48982]	=	"DEATHKNIGHT", --rune tap
			--> DK Frost
			[49020]	=	"DEATHKNIGHT", --obliterate
			[49143]	=	"DEATHKNIGHT", --frost strike
			[55095]	=	"DEATHKNIGHT", --frost fever
			[55078]	=	"DEATHKNIGHT", --blood plague
			[49184]	=	"DEATHKNIGHT", --howling blast
			--> DK Blood
			[49998]	=	"DEATHKNIGHT", --death strike
			--> DK Unholy
			[55090]	=	"DEATHKNIGHT",--scourge strike
			[47632]	=	"DEATHKNIGHT",--death coil
			
		--druid
			--> Druid Cat
			[1822] 	=	"DRUID", --rake
			[1079] 	=	"DRUID", --rip
			[5221] 	=	"DRUID", --shred
			[33876]	=	"DRUID", --mangle
			[33878]	=	"DRUID", --mangle (energy)
			[102545]	=	"DRUID", --ravage!
			[33878]	=	"DRUID", --mangle (energy gain)
			[17057]	=	"DRUID", --bear form (energy gain)
			[16959]	=	"DRUID", --primal fury (energy gain)
			[5217]	=	"DRUID", --tiger's fury (energy gain)
			[68285]	=	"DRUID", --leader of the pack (mana)
			--> Druid Balance
			[5176]	=	"DRUID", --wrath
			[93402]	=	"DRUID", --sunfire
			[2912]	=	"DRUID", --starfire
			[8921]	=	"DRUID", --moonfire
			[81070]	=	"DRUID", --eclipse
			--> Druid Resto
			[29166]	=	"DRUID", --innervate
			[774]	=	"DRUID", --rejuvenation
			[44203]	=	"DRUID", --tranquility
			[48438]	=	"DRUID", --wild growth
			[81269]	=	"DRUID", --shiftmend
			[102792]	=	"DRUID", --wind moshroom: bloom
			[5185]	=	"DRUID", --healing touch
			[8936]	=	"DRUID", --regrowth
			[33778]	=	"DRUID", --lifebloom
			[48503]	=	"DRUID", --living seed
			[50464]	=	"DRUID", --nourish

		--hunter
			[131900]	=	"HUNTER",--a murder of crows
			[118253]	=	"HUNTER",--serpent sting
			[77767]	=	"HUNTER",--cobra shot
			[3044]	=	"HUNTER",--arcane shot
			[53301]	=	"HUNTER",--explosive shot
			[120361]	=	"HUNTER",--barrage
			[53351]	=	"HUNTER",--kill shot
		
		--mage
			--> Mage Frost
			[116]	=	"MAGE",--frost bolt
			[30455]	=	"MAGE",--ice lance
			[84721]	=	"MAGE",--frozen orb
			[1449]	=	"MAGE",--arcane explosion
			[113092]	=	"MAGE",--frost bomb
			[115757]	=	"MAGE",--frost nova
			[44614]	=	"MAGE",--forstfire bolt
			[42208]	=	"MAGE",--blizzard
			[11426]	=	"MAGE",--Ice Barrier (heal)
			--> Mage Fire
			[11366]	=	"MAGE",--pyroblast
			[133]	=	"MAGE",--fireball
			[108853]	=	"MAGE",--infernoblast
			[2948]	=	"MAGE",--scorch
			--> Mage Arcane
			[30451]	=	"MAGE",--arcane blase
			[12051]	=	"MAGE",--evocation
		
		--monk
			--> Monk
			[107428]	=	"MONK", --rising sun kick
			[100784]	=	"MONK", --blackout kick
			[132467]	=	"MONK", --Chi wave	
			[107270]	=	"MONK", --spinning crane kick
			[100787]	=	"MONK", --tiger palm
			[123761]	=	"MONK", --mana tea
			--> Mistwave
			[119611]	=	"MONK", --renewing mist
			[115310]	=	"MONK", --revival
			[116670]	=	"MONK", --uplift
			[115175]	=	"MONK", --soothing mist
			[124041]	=	"MONK", --gift of the serpent
			[124040]	=	"MONK", -- shi torpedo
			[132120]	=	"MONK", -- enveloping mist
			[132463]	=	"MONK", -- shi wave
			[117895]	=	"MONK", --eminence (statue)
			--> drunk monk
			[115295]	=	"MONK", --guard
			[115072]	=	"MONK", --expel harm
			
		--paladin
			--> Paladin Retri
			[35395]	=	"PALADIN",--cruzade strike
			[879]	=	"PALADIN",--exorcism
			[85256]	=	"PALADIN",--templar's verdict
			[20167]	=	"PALADIN",--seal of insight (mana)
			--> Paladin Protection
			[31935]	=	"PALADIN",--avenger's shield
			[20271]	=	"PALADIN", --judgment
			[35395]	=	"PALADIN", --cruzader strike
			[81297]	=	"PALADIN", --consacration	
			[31803]	=	"PALADIN", --censure
			[65148]	=	"PALADIN", --Sacred Shield
			[20167]	=	"PALADIN", --Seal of Insight
			--> holy
			[86273]	=	"PALADIN", --illuminated healing
			[85222]	=	"PALADIN", --light of dawn
			[53652]	=	"PALADIN", --beacon of light
			[82327]	=	"PALADIN", --holy radiance
			[119952]	=	"PALADIN", --arcing light
			[25914]	=	"PALADIN", --holy shock
			[19750]	=	"PALADIN", --flash of light

		--priest
			[34650]	=	"PRIEST", --mana leech (pet)
			--> shadow priest
			[589]	=	"PRIEST", --shadow word: pain
			[34914]	=	"PRIEST", --vampiric touch
			[34919]	=	"PRIEST", --vampiric touch (mana)
			[15407]	=	"PRIEST", --mind flay
			[8092]	=	"PRIEST", --mind blast
			[15290]	=	"PRIEST",-- Vampiric Embrace
			[127626]	=	"PRIEST",--devouring plague (heal)
			[2944]	=	"PRIEST",--devouring plague (damage)
			--> disc priest
			[585]	=	"PRIEST", --smite
			[47666]	=	"PRIEST", --penance
			[14914]	=	"PRIEST", --holy fire
			[81751]	=	"PRIEST",  --atonement
			[47753]	=	"PRIEST",  --divine aegis
			--> holy priest
			[33110]	=	"PRIEST", --prayer of mending
			[77489]	=	"PRIEST", --mastery echo of light
			[596]	=	"PRIEST", --prayer of healing
			[34861]	=	"PRIEST", --circle of healing
			[139]	=	"PRIEST", --renew
			[120692]	=	"PRIEST", --halo
			[2060]	=	"PRIEST", --greater heal
			[110745]	=	"PRIEST", --divine star
			[2061]	=	"PRIEST", --flash heal
			[88686]	=	"PRIEST", --santuary
			[17]		=	"PRIEST", --power word: shield
			[64904]	=	"PRIEST", --hymn of hope
			--> talent
			[129250]	=	"PRIEST", --power word: solace
		
		--rogue
			[53]		= 	"ROGUE", --backstab
			[8680]	= 	"ROGUE", --wound pouson
			[2098]	= 	"ROGUE", --eviscerate
			[2818]	=	"ROGUE", --deadly poison
			[113780]	=	"ROGUE", --deadly poison
			[51723]	=	"ROGUE", --fan of knifes
			[111240]	=	"ROGUE", --dispatch
			[703]	=	"ROGUE", --garrote
			[1943]	=	"ROGUE", --rupture
			[114014]	=	"ROGUE", --shuriken toss
			[16511]	=	"ROGUE", --hemorrhage
			[89775]	=	"ROGUE", --hemorrhage
			[8676]	=	"ROGUE", --amcush
			[5374]	=	"ROGUE", --mutilate
			[32645]	=	"ROGUE", --envenom
			[1943]	=	"ROGUE", --rupture
			[73651]	=	"ROGUE", --Recuperate (heal)
			[35546]	=	"ROGUE", --combat potency (energy)
			[98440]	=	"ROGUE", --relentless strikes (energy)
			[51637]	=	"ROGUE", --venomous vim (energy)
			
		--shaman
			--> Shaman Elemental
			[88765]	=	"SHAMAN", --rolling thunder (mana)
			[51490]	=	"SHAMAN", --thunderstorm (mana)
			[82987]	=	"SHAMAN", --telluric currents glyph (mana)
			[101033]	=	"SHAMAN", --resurgence (mana)
			[51505]	=	"SHAMAN", --lava burst
			[8050]	=	"SHAMAN", --flame shock
			[117014]	=	"SHAMAN", --elemental blast
			[403]	=	"SHAMAN", --lightning bolt
			[45284]	=	"SHAMAN", --lightning bolt
			[421]	=	"SHAMAN", --chain lightining
			--> Shaman Melee
			[32175]	=	"SHAMAN", --stormstrike
			[25504]	=	"SHAMAN", --windfury
			[8042]	=	"SHAMAN", --earthshock
			[26364]	=	"SHAMAN", --lightning shield
			[117014]	=	"SHAMAN", --elemental blast
			[73683]	=	"SHAMAN", --unleash flame
			[51522]	=	"SHAMAN", --primal wisdom (mana)
			[63375]	=	"SHAMAN", --primal wisdom (mana)
			--> Shaman Resto
			[114942]	=	"SHAMAN", --healing tide
			[73921]	=	"SHAMAN", --healing rain
			[1064]	=	"SHAMAN", --chain heal
			[52042]	=	"SHAMAN", --healing stream totem
			[61295]	=	"SHAMAN", --riptide
			[51945]	=	"SHAMAN", --earthliving
			[114083]	=	"SHAMAN", --restorative mists
			[8004]	=	"SHAMAN", --healing surge
			
		--warlock
			[77799]	=	"WARLOCK", --fel flame
			[63106]	=	"WARLOCK", --siphon life
			[1454]	=	"WARLOCK", --life tap
			--> warlock affliction
			[103103]	=	"WARLOCK", --malefic grasp
			[980]	=	"WARLOCK", --agony
			[30108]	=	"WARLOCK", --unstable affliction
			[172]	=	"WARLOCK", --corruption	
			[48181]	=	"WARLOCK", --haunt	
			--> warlock destruction
			[29722]	=	"WARLOCK", --incenerate
			[348]	=	"WARLOCK", --Immolate
			[116858]	=	"WARLOCK", --Chaos Bolt
			[114654]	=	"WARLOCK", --incinerate
			[108686]	=	"WARLOCK", --immolate
			[108685]	=	"WARLOCK", --conflagrate
			[104233]	=	"WARLOCK", --rain of fire
			--> warlock demo
			[103964]	=	"WARLOCK", --touch os chaos
			[686]	=	"WARLOCK", --shadow bolt
			[114328]	=	"WARLOCK", --shadow bolt glyph
			[140719]	=	"WARLOCK", --hellfire
			[104027]	=	"WARLOCK", --soul fire
			[603]	=	"WARLOCK", --doom
			--> talents
			[108371]	=	"WARLOCK", --Harvest life
			

		--warrior
			[100130]	=	"WARRIOR", --wild strike
			[96103]	=	"WARRIOR", --raging blow
			[12294]	=	"WARRIOR", --mortal strike
			[1464]	=	"WARRIOR", --Slam
			[23922]	=	"WARRIOR", --shield slam
			[20243]	=	"WARRIOR", --devastate
			[11800]	=	"WARRIOR", --dragon roar
			[115767]	=	"WARRIOR", --deep wounds
			[109128]	=	"WARRIOR", --charge
			[11294]	=	"WARRIOR", --mortal strike
			[109128]	=	"WARRIOR", --charge
			[12880]	=	"WARRIOR", --enrage
			[29842]	=	"WARRIOR", --undribled wrath
	}
	
	_detalhes.CrowdControlSpells = {

		--death knight
			[96294]	= true, --chains of ice

		--druid
			--hibernate
			[2637]	= true, --hibernate
			[339]	= true, --entangling toots

		--hunter
			[3355]	= true, --freezing trap
			[24335]	= true, --wyvern sting
			[136634]	= true, --narrow escape
			[4167]	= true, --web (spider)
			[19503]	= true, --scatter shot
			
		--mage
			[118]	= true, --polymorph sheep
			[61305]	= true, --polymorph black cat
			[28272]	= true, --polymorph pig
			[61721]	= true, --polymorph rabbit
			[61780]	= true, --polymorph turkey
			[28271]	= true, --polymorph turtle
			[122]	= true, --frost nova
			[33395]	= true, --freeze
			[111340]	= true, --ice ward
			[82691]	= true, --ring of frost
		
		--monk
			[116706]	= true, --disable
		
		--paladin
			[105421]	= true, --blinding light
			[20066]	= true, --repentance
		--prist
			--shackle undead
			[8122]	= true, --psychic scream
			[9484]	= true, --shackle undead
			
		--rogue
			[2094]	= true, --blind
			[1776]	= true, --gouge
			[6770]	= true, --sap
			[408]	= true, --kidney shot
			[1833]	= true, --cheap shot
		
		--shaman
			[51514]	= true, --hex
			[64695]	= true, --earthgrab (earthgrab totem)
			[76780]	= true, --bind elemental
		
		--warlock
			[6358]	= true, --seduction (succubus)
			[115268]	= true, --mesmerize (shivarra)
			[118699]	= true, --fear
			[5484]	= true, --howl of terror
		
		--warrior
			[5246]	= true, --intimidating shout
			[107566]	= true, --staggering shout
	}

	_detalhes.AbsorbSpells = {

		--priest
			[47753]	=	true,  --Divine Aegis (discipline)
			[17]	=		true,  --Power Word: Shield (discipline)
			[114908]	=	true,  --Spirit Shell (discipline)
			[114214]	=	true,  --Angelic Bulwark (talent)
			
		--death knight
			[48707]	=	true, --Anti-Magic Shell
			[116888]	=	true, --Shroud of Purgatory (talent)
			[51052]	=	true, --Anti-Magic Zone (talent)
			[77535]	=	true, --Blood Shield
			
		--shaman
			[114893]	=	true, --Stone Bulwark (stone bulwark totem)

		--paladin
			[86273]	=	true, --Illuminated Healing (holy)
			[65148]	=	true, --Sacred Shield (talent)
		
		--monk
			[116849]	=	true, --Life Cocoon (mistweaver)
			[115295]	=	true, --Guard (brewmaster)
			[118604]	=	true, --Guard (brewmaster)
		
		--warlock
			[6229]	=	true, --Twilight Ward
			[108366]	=	true, --Soul Leech (talent)
			[108416]	=	true, --Sacrificial Pact (talent)
			[110913]	=	true, --Dark Bargain (talent)
			[7812]	=	true, --Voidwalker's Sacrifice

		--mage
			[11426]	=	true, --Ice Barrier (talent)
			[1463]	=	true, --Incanter's Ward (talent)
		
		--warrior
			[112048]	=	true, -- Shield Barrier (protection)
			
		--others
			[116631]	=	true, -- enchant "Enchant Weapon - Colossus"
			[140380]	=	true, -- trinket "Inscribed Bag of Hydra-Spawn"

	}
	
	_detalhes.DefensiveCooldownSpellsNoBuff = {
		
		--["DEATHKNIGHT"] = {},
		[48707] = {45, 5, 1}, -- Anti-Magic Shell
		[48743] = {120, 0, 1}, --Death Pact
		[51052] = {120, 3, 0}, --Anti-Magic Zone
		
		--["DRUID"] = {},
		[740] = {480, 8, 0}, --Tranquility
		[22842] = {0, 0, 1}, --Frenzied Regeneration
		
		--["HUNTER"] = {},
		
		--["MAGE"] = {},
		
		--["MONK"] = {},
		[115295] = {30, 30, 1}, -- Guard
		[116849] = {120, 12, 0}, -- Life Cocoon (a)
		[115310] = {180, 0, 0}, -- Revival
		[119582] = {60, 0, 0}, -- Purifying Brew
		[116844] = {45, 8, 0}, --Ring of Peace
		
		--["PALADIN"] = {},
		[633] = {600, 0, 0}, --Lay on Hands
		
		--["PRIEST"] = {},
		[62618] = {180, 10, 0}, --Power Word: Barrier
		[109964] = {60, 10, 0}, --Spirit Shell
		[64843] = {180, 8, 0}, --Divine Hymn
		[108968] = {300, 0, 0}, --Void Shift holy disc
		[142723] = {600, 0, 0}, --Void Shift shadow
		
		--["ROGUE"] = {},
		[76577] = {180, 0, 0}, --Smoke Bomb
		
		--["SHAMAN"] = {},
		[108270] = {60, 5, 1}, -- Stone Bulwark Totem
		
		--["WARLOCK"] = {108416, 6229},
		[108416] = {60, 20, 1}, -- Sacrificial Pact  1 = self
		[6229] = {30, 30, 1}, -- Twilight Ward  1 = self
		
		--["WARRIOR"] = {},
	}
	
	_detalhes.DefensiveCooldownSpells = {
	
		--> spellid = {cooldown, duration}
		
		-- Death Knigh 
		[55233] = {60, 10}, -- Vampiric Blood
		[49222] = {60, 300}, -- Bone Shield
		[48792] = {180, 12}, -- Icebound Fortitude
		[48743] = {120, 0}, -- Death Pact
		[49039] = {12, 10}, -- Lichborne
		["DEATHKNIGHT"] = {55233, 49222, 48707, 48792, 48743, 49039, 48743, 51052},

		-- Druid
		[62606] = {1.5, 6}, -- Savage Defense
		[106922] = {180, 20}, -- Might of Ursoc
		[102342] = {60, 12}, -- Ironbark
		[61336] = {180, 12}, -- Survival Instincts
		[22812] = {60, 12}, -- Barkskin
		["DRUID"] = {62606, 106922, 102342, 61336, 22812, 740, 22842},
		
		-- Hunter
		[19263] = {120, 5}, -- Deterrence
		["HUNTER"] = {19263},
		
		-- Mage
		[45438] = {300, 12}, -- Ice Block
		["MAGE"] = {45438},
		
		-- Monk
		[115203] = {180, 20}, -- Fortifying Brew
		[122470] = {90, 10}, -- Touch of Karma
		[115176] = {180, 8}, -- Zen Meditation
		[115213] = {180, 6}, -- Avert Harm
		[122278] = {90, 45}, -- Dampen Harm
		[122783] = {90, 6}, -- Diffuse Magic
		["MONK"] = {115295, 115203, 122470, 115176, 116849, 115213, 122278, 122783},
		
		-- Paladin
		[86659] = {180, 12}, -- Guardian of Ancient Kings
		[31850] = {180, 10}, -- Ardent Defender
		[498] = {60, 10}, -- Divine Protection
		[642] = {300, 8}, -- Divine Shield
		[6940] = {120, 12}, -- Hand of Sacrifice
		[1022] = {300, 10}, -- Hand of Protection
		[1038] = {120, 10}, -- Hand of Salvation
		["PALADIN"] = {86659, 31850, 498, 642, 6940, 1022, 1038},
		
		-- Priest
		[15286] = {180, 15}, -- Vampiric Embrace
		[47788] = {180, 10}, -- Guardian Spirit
		[47585] = {120, 6}, -- Dispersion
		[33206] = {180, 8}, -- Pain Suppression
		["PRIEST"] = {15286, 47788, 47585, 33206, 62618, 109964, 64843},
		
		-- Rogue
		[1966] = {1.5, 5}, -- Feint
		[31224] = {60, 5}, -- Cloak of Shadows
		[5277] = {180, 15}, -- Evasion
		["ROGUE"] = {1966, 31224, 5277},
		
		-- Shaman
		[30823] = {60, 15}, -- Shamanistic Rage
		[108271] = {120, 6}, -- Astral Shift
		["SHAMAN"] = {30823, 108271, 108270},
		
		-- Warlock
		[104773] = {180, 8}, -- Unending Resolve
		[108359] = {120, 12}, -- Dark Regeneration
		[110913] = {180, 8}, -- Dark Bargain
		["WARLOCK"] = {104773, 108359, 108416, 110913, 6229},
		
		-- Warrior
		[871] = {180, 12}, -- Shield Wall
		[12975] = {180, 20}, -- Last Stand
		[23920] = {25, 5}, -- Spell Reflection
		[114030] = {120, 12}, -- Vigilance
		[118038] = {120, 8}, -- Die by the Sword
		["WARRIOR"] = {871, 12975, 23920, 114030, 118038}
	}
	
	local Loc = LibStub ("AceLocale-3.0"):GetLocale ( "Details" )
	_detalhes.SpellOverwrite = {
		[124464] = {name = GetSpellInfo (124464) .. " (" .. Loc ["STRING_MASTERY"] .. ")"}, --> shadow word: pain mastery proc (priest)
		[124465] = {name = GetSpellInfo (124465) .. " (" .. Loc ["STRING_MASTERY"] .. ")"}, --> vampiric touch mastery proc (priest)
		[124468] = {name = GetSpellInfo (124468) .. " (" .. Loc ["STRING_MASTERY"] .. ")"} --> mind flay mastery proc (priest)
	}

end