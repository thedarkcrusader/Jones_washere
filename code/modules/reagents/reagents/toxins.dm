/* Toxins, poisons, venoms */

/datum/reagent/toxin
	name = "toxin"
	id = "toxin"
	description = "A toxic chemical."
	taste_description = "bitterness"
	taste_mult = 1.2
	reagent_state = LIQUID
	color = "#CF3600"
	metabolism = REM * 0.05 // 0.01 by default. They last a while and slowly kill you.
	var/strength = 0.05 // How much damage it deals per unit
	reagent_type = "Toxin"
	scannable = 1

/datum/reagent/toxin/affect_blood(mob/living/carbon/M, alien, effect_multiplier)
	if(strength)
		var/multi = effect_multiplier
		if(issmall(M))  // Small bodymass, more effect from lower volume.
			multi *= 2
		M.adjustToxLoss(strength * multi)
	M.add_chemical_effect(CE_TOXIN, 1)

/datum/reagent/toxin/overdose(mob/living/carbon/M, alien)
	if(strength)
		M.adjustToxLoss(strength * issmall(M) ? 2 : 1)

/datum/reagent/toxin/plasticide
	name = "Plasticide"
	id = "plasticide"
	description = "Liquid plastic used in creation of plastic sheets."
	taste_description = "plastic"
	reagent_state = LIQUID
	color = "#CF3600"
	strength = 0.6

/datum/reagent/toxin/oil
	name = "Oil"
	id = "oil"
	description = "Crude oil, somehow connected to frequent invasions."
	taste_description = "money"
	reagent_state = LIQUID
	color = "#0C0C0C"

/datum/reagent/toxin/amatoxin
	name = "Amatoxin"
	id = "amatoxin"
	description = "A powerful poison derived from certain species of mushroom."
	taste_description = "mushroom"
	reagent_state = LIQUID
	color = "#792300"
	strength = 0.1
	nerve_system_accumulations = 60
	addiction_chance = 20
	heating_point = 523
	heating_products = list("toxin")

/datum/reagent/toxin/carpotoxin
	name = "Carpotoxin"
	id = "carpotoxin"
	description = "A deadly neurotoxin produced by the dreaded space carp."
	taste_description = "fish"
	reagent_state = LIQUID
	color = "#003333"
	strength = 0.1
	overdose = REAGENTS_OVERDOSE/3
	addiction_chance = 10
	nerve_system_accumulations = 5
	heating_point = 523
	heating_products = list("toxin")
	reagent_type = "Toxin/Stimulator"

/datum/reagent/toxin/carpotoxin/affect_blood(mob/living/carbon/M, alien, effect_multiplier)
	if(ishuman(M))
		var/mob/living/carbon/human/H = M
		var/obj/item/organ/internal/liver/L = H.random_organ_by_process(OP_LIVER)
		if(istype(L))
			L.take_damage(strength * effect_multiplier, 0)
	M.stats.addTempStat(STAT_VIG, STAT_LEVEL_BASIC, STIM_TIME, "carpotoxin")

/datum/reagent/toxin/carpotoxin/withdrawal_act(mob/living/carbon/M)
	M.stats.addTempStat(STAT_VIG, -STAT_LEVEL_BASIC, STIM_TIME, "carpotoxin_w")
	M.stats.addTempStat(STAT_ROB, -STAT_LEVEL_BASIC, STIM_TIME, "carpotoxin_w")
	M.stats.addTempStat(STAT_TGH, -STAT_LEVEL_BASIC, STIM_TIME, "carpotoxin_w")

/datum/reagent/toxin/carpotoxin/overdose(mob/living/carbon/M, alien)
	if(prob(80))
		M.adjustBrainLoss(2)
	if(strength)
		if(issmall(M))
			M.adjustToxLoss(strength)
		else
			M.adjustToxLoss(strength)

///datum/reagent/toxin/blattedin is defined in blattedin.dm

/datum/reagent/toxin/plasma
	name = "Plasma"
	id = "plasma"
	description = "Plasma in its liquid form."
	taste_mult = 1.5
	reagent_state = LIQUID
	color = "#9D14DB"
	strength = 0.3
	touch_met = 5

/datum/reagent/toxin/plasma/touch_mob(mob/living/L, var/amount)
	if(istype(L))
		L.adjust_fire_stacks(amount / 5)

/datum/reagent/toxin/plasma/affect_touch(mob/living/carbon/M, alien, effect_multiplier)
	M.take_organ_damage(0, effect_multiplier * 0.1) //being splashed directly with plasma causes minor chemical burns
	if(prob(50))
		M.pl_effects()

/datum/reagent/toxin/plasma/touch_turf(turf/simulated/T)
	if(!istype(T))
		return
	T.assume_gas("plasma", volume, T20C)
	remove_self(volume)
	return TRUE

/datum/reagent/toxin/cyanide //Fast and Lethal
	name = "Cyanide"
	id = "cyanide"
	description = "A highly toxic chemical that prevents cellular respiration."
	taste_mult = 0.6
	reagent_state = LIQUID
	color = "#CF3600"
	strength = 0.2
	metabolism = REM * 2

/datum/reagent/toxin/cyanide/affect_blood(mob/living/carbon/M, alien, effect_multiplier)
	..()
	M.adjustOxyLoss(2 * effect_multiplier)
	M.AdjustSleeping(1)

/datum/reagent/toxin/potassium_chloride
	name = "Potassium Chloride"
	id = "potassium_chloride"
	description = "A delicious salt that arrests the heart if injected there."
	taste_description = "salt"
	reagent_state = SOLID
	color = "#FFFFFF"
	strength = 0
	overdose = REAGENTS_OVERDOSE

/datum/reagent/toxin/potassium_chloride/overdose(mob/living/carbon/M, alien)
	..()
	if(ishuman(M))
		var/mob/living/carbon/human/H = M
		if(H.stat != 1)
			if(H.losebreath >= 10)
				H.losebreath = max(10, H.losebreath - 10)
			H.adjustOxyLoss(2)
			H.Weaken(10)
		M.add_chemical_effect(CE_NOPULSE, 1)


/datum/reagent/toxin/potassium_chlorophoride
	name = "Potassium Chlorophoride"
	id = "potassium_chlorophoride"
	description = "A specific chemical based on Potassium Chloride to arrest the heart for surgery."
	taste_description = "salt"
	reagent_state = SOLID
	color = "#FFFFFF"
	strength = 0.1
	overdose = 20

/datum/reagent/toxin/potassium_chlorophoride/affect_blood(mob/living/carbon/M, alien, effect_multiplier)
	..()
	if(ishuman(M))
		var/mob/living/carbon/human/H = M
		if(H.stat != 1)
			if(H.losebreath >= 10)
				H.losebreath = max(10, M.losebreath-10)
			H.adjustOxyLoss(2)
			H.Weaken(10)
		M.add_chemical_effect(CE_NOPULSE, 1)

/datum/reagent/toxin/zombiepowder
	name = "Zombie Powder"
	id = "zombiepowder"
	description = "A strong neurotoxin that puts the subject into a death-like state."
	taste_description = "death"
	reagent_state = SOLID
	color = "#669900"
	metabolism = REM
	strength = 0.04

/datum/reagent/toxin/zombiepowder/affect_blood(mob/living/carbon/M, alien, effect_multiplier)
	..()
	M.status_flags |= FAKEDEATH
	M.adjustOxyLoss(0.6 * effect_multiplier)
	M.Weaken(10)
	M.silent = max(M.silent, 10)
	M.tod = world.time
	M.add_chemical_effect(CE_NOPULSE, 1)

/datum/reagent/toxin/zombiepowder/Destroy()
	if(holder && holder.my_atom && ismob(holder.my_atom))
		var/mob/M = holder.my_atom
		M.status_flags &= ~FAKEDEATH
	. = ..()

/datum/reagent/toxin/fertilizer //Reagents used for plant fertilizers.
	name = "fertilizer"
	id = "fertilizer"
	description = "A chemical mix good for growing plants with."
	taste_description = "plant food"
	taste_mult = 0.5
	reagent_state = LIQUID
	strength = 0.01 // It's not THAT poisonous.
	color = "#664330"

/datum/reagent/toxin/fertilizer/eznutrient
	name = "EZ Nutrient"
	id = "eznutrient"

/datum/reagent/toxin/fertilizer/left4zed
	name = "Left-4-Zed"
	id = "left4zed"

/datum/reagent/toxin/fertilizer/robustharvest
	name = "Robust Harvest"
	id = "robustharvest"

/datum/reagent/toxin/plantbgone
	name = "Plant-B-Gone"
	id = "plantbgone"
	description = "A harmful toxic mixture to kill plant life."
	taste_mult = 1
	reagent_state = LIQUID
	color = "#49002E"
	strength = 0.04

/datum/reagent/toxin/plantbgone/touch_turf(turf/T)
	if(istype(T, /turf/simulated/wall))
		var/turf/simulated/wall/W = T
		if(locate(/obj/effect/overlay/wallrot) in W)
			for(var/obj/effect/overlay/wallrot/E in W)
				qdel(E)
			W.visible_message(SPAN_NOTICE("The fungi are completely dissolved by the solution!"))
	return TRUE

/datum/reagent/toxin/plantbgone/touch_obj(obj/O, var/volume)
	if(istype(O, /obj/effect/plant))
		qdel(O)
	if(istype(O, /obj/machinery/portable_atmospherics/hydroponics))
		var/obj/machinery/portable_atmospherics/hydroponics/T = O
		T.seed = null
		T.weedlevel = 0
		T.pestlevel = 0
		T.update_icon()
		return

/datum/reagent/acid/polyacid
	name = "Polytrinic acid"
	id = "pacid"
	description = "Polytrinic acid is an extremely corrosive chemical substance."
	taste_description = "acid"
	reagent_state = LIQUID
	color = "#8E18A9"
	power = 10
	meltdose = 4


/datum/reagent/toxin/lexorin
	name = "Lexorin"
	id = "lexorin"
	description = "Lexorin temporarily stops respiration. Causes tissue damage."
	taste_description = "acid"
	reagent_state = LIQUID
	color = "#C8A5DC"
	overdose = REAGENTS_OVERDOSE

/datum/reagent/toxin/lexorin/affect_blood(mob/living/carbon/M, alien, effect_multiplier)
	M.take_organ_damage(0.3 * effect_multiplier, 0)
	if(M.losebreath < 15)
		M.losebreath++

/datum/reagent/toxin/mutagen
	name = "Unstable mutagen"
	id = "mutagen"
	description = "Might cause unpredictable mutations."
	taste_description = "slime"
	taste_mult = 0.9
	reagent_state = LIQUID
	color = "#13BC5E"

/datum/reagent/toxin/mutagen/affect_touch(mob/living/carbon/M, alien, effect_multiplier)
	if(prob(33))
		affect_blood(M, alien, effect_multiplier)

/datum/reagent/toxin/mutagen/affect_ingest(mob/living/carbon/M, alien, effect_multiplier)
	if(prob(67))
		affect_blood(M, alien, effect_multiplier)

/datum/reagent/toxin/mutagen/affect_blood(mob/living/carbon/M, alien, effect_multiplier)
	if(ishuman(M))
		var/mob/living/carbon/human/H = M
		if(H.species.flags & NO_SCAN)
			return
	if(M.dna)
		if(prob(effect_multiplier * 0.01)) // Approx. one mutation per 10 injected/20 ingested/30 touching units
			randmuti(M)
			if(prob(98))
				randmutb(M)
			else
				randmutg(M)
			domutcheck(M, null)
			M.UpdateAppearance()
	M.apply_effect(1 * effect_multiplier, IRRADIATE, 0)

/datum/reagent/medicine/slimejelly
	name = "Slime Jelly"
	id = "slimejelly"
	description = "A gooey semi-liquid produced from one of the deadliest lifeforms in existence."
	taste_description = "slime"
	taste_mult = 1.3
	reagent_state = LIQUID
	color = "#801E28"

/datum/reagent/medicine/slimejelly/affect_blood(mob/living/carbon/M, alien, effect_multiplier)
	if(prob(10))
		to_chat(M, SPAN_DANGER("Your insides are burning!"))
		M.adjustToxLoss(rand(10, 30) * effect_multiplier)
	else if(prob(40))
		M.heal_organ_damage(2.5 * effect_multiplier, 0)

/datum/reagent/medicine/soporific
	name = "Soporific"
	id = "stoxin"
	description = "An effective hypnotic used to treat insomnia."
	taste_description = "bitterness"
	reagent_state = LIQUID
	color = "#009CA8"
	metabolism = REM * 5
	overdose = REAGENTS_OVERDOSE

/datum/reagent/medicine/soporific/affect_blood(mob/living/carbon/M, alien, effect_multiplier)
	var/effective_dose = dose
	if(issmall(M))
		effective_dose *= 2

	if(effective_dose < 1)
		if(effective_dose == metabolism * 2 || prob(5))
			M.emote("yawn")
	else if(effective_dose < 1.5)
		M.eye_blurry = max(M.eye_blurry, 10)
	else if(effective_dose < 5)
		if(prob(50))
			M.Weaken(2)
		M.drowsyness = max(M.drowsyness, 20)
	else
		M.sleeping = max(M.sleeping, 20)
		M.drowsyness = max(M.drowsyness, 60)
	M.add_chemical_effect(CE_PULSE, -1)

/datum/reagent/medicine/chloralhydrate
	name = "Chloral Hydrate"
	id = "chloralhydrate"
	description = "A powerful sedative."
	taste_description = "bitterness"
	reagent_state = SOLID
	color = "#000067"
	metabolism = REM * 5
	overdose = REAGENTS_OVERDOSE * 0.5

/datum/reagent/medicine/chloralhydrate/affect_blood(mob/living/carbon/M, alien, effect_multiplier)
	var/effective_dose = dose
	if(issmall(M))
		effective_dose *= 2

	if(effective_dose == metabolism)
		M.confused += 2
		M.drowsyness += 2
	else if(effective_dose < 2)
		M.Weaken(30)
		M.eye_blurry = max(M.eye_blurry, 10)
	else
		M.sleeping = max(M.sleeping, 30)

	if(effective_dose > 1)
		M.adjustToxLoss(effect_multiplier * 0.1)

/datum/reagent/medicine/chloralhydrate/beer2 //disguised as normal beer for use by emagged brobots
	name = "Beer"
	id = "beer2"
	description = "An alcoholic beverage made from malted grains, hops, yeast, and water. The fermentation appears to be incomplete." //If the players manage to analyze this, they deserve to know something is wrong.
	taste_description = "shitty piss water"
	reagent_state = LIQUID
	color = "#664300"

	glass_icon_state = "beerglass"
	glass_name = "beer"
	glass_desc = "A freezing pint of beer"
	glass_center_of_mass = list("x"=16, "y"=8)

/* Transformations */

/datum/reagent/toxin/slimetoxin
	name = "Mutation Toxin"
	id = "mutationtoxin"
	description = "A corruptive toxin produced by slimes."
	taste_description = "sludge"
	reagent_state = LIQUID
	color = "#13BC5E"

/datum/reagent/toxin/slimetoxin/affect_blood(mob/living/carbon/M, alien, effect_multiplier)
	if(ishuman(M))
		var/mob/living/carbon/human/H = M
		if(H.species.name != "Slime")
			to_chat(M, SPAN_DANGER("Your flesh rapidly mutates!"))
			H.set_species("Slime")

/datum/reagent/toxin/aslimetoxin
	name = "Advanced Mutation Toxin"
	id = "amutationtoxin"
	description = "An advanced corruptive toxin produced by slimes."
	taste_description = "sludge"
	reagent_state = LIQUID
	color = "#13BC5E"

/datum/reagent/toxin/aslimetoxin/affect_blood(mob/living/carbon/M, alien, effect_multiplier) // TODO: check if there's similar code anywhere else
	if(HAS_TRANSFORMATION_MOVEMENT_HANDLER(M))
		return
	to_chat(M, SPAN_DANGER("Your flesh rapidly mutates!"))
	ADD_TRANSFORMATION_MOVEMENT_HANDLER(M)
	M.canmove = 0
	M.icon = null
	M.cut_overlays()
	M.invisibility = 101
	for(var/obj/item/W in M)
		if(istype(W, /obj/item/implant)) //TODO: Carn. give implants a dropped() or something
			qdel(W)
			continue
		W.layer = initial(W.layer)
		W.loc = M.loc
		W.dropped(M)
	var/mob/living/carbon/slime/new_mob = new /mob/living/carbon/slime(M.loc)
	new_mob.a_intent = "hurt"
	new_mob.universal_speak = 1
	if(M.mind)
		M.mind.transfer_to(new_mob)
	else
		new_mob.key = M.key
	qdel(M)

/datum/reagent/other/xenomicrobes
	name = "Xenomicrobes"
	id = "xenomicrobes"
	description = "Microbes with an entirely alien cellular structure."
	taste_description = "sludge"
	reagent_state = LIQUID
	color = "#535E66"

/datum/reagent/toxin/pararein
	name = "Pararein"
	id = "pararein"
	description = "Venom used by spiders."
	taste_description = "sludge"
	reagent_state = LIQUID
	color = "#a37d9c"
	overdose = REAGENTS_OVERDOSE/3
	addiction_chance = 0.1
	nerve_system_accumulations = 5
	strength = 0.1
	heating_point = 523
	heating_products = list("toxin")

/datum/reagent/toxin/pararein/affect_blood(mob/living/carbon/M, alien, effect_multiplier)
	..()
	M.stats.addTempStat(STAT_ROB, -STAT_LEVEL_BASIC, STIM_TIME, "pararein")
	M.stats.addTempStat(STAT_VIG, -STAT_LEVEL_BASIC, STIM_TIME, "pararein")

/datum/reagent/toxin/diplopterum
	name = "Diplopterum"
	id = "diplopterum"
	description = "Can be found in tissues of the roaches."
	taste_description = "sludge"
	reagent_state = LIQUID
	color = "#c9bed2"
	overdose = 16
	strength = 0.1
	addiction_chance = 10
	nerve_system_accumulations = 5
	heating_point = 573
	heating_products = list("radium", "acetone", "hydrazine", "nutriment")
	reagent_type = "Toxin/Stimulator"

/datum/reagent/toxin/diplopterum/affect_blood(mob/living/carbon/M, alien, effect_multiplier)
	..()
	M.stats.addTempStat(STAT_MEC, STAT_LEVEL_BASIC, STIM_TIME, "diplopterum")
	if(M.species?.reagent_tag == IS_CHTMANT)
		M.adjustOxyLoss(-1.5 * effect_multiplier)
		M.add_chemical_effect(CE_OXYGENATED, 1)
		holder.remove_reagent("lexorin", 0.2 * effect_multiplier)
		M.adjustToxLoss(-0.1)
		return

/datum/reagent/toxin/diplopterum/withdrawal_act(mob/living/carbon/M)
	if(M.species?.reagent_tag == IS_CHTMANT)
		return
	M.stats.addTempStat(STAT_MEC, -STAT_LEVEL_BASIC, STIM_TIME, "diplopterum_w")
	M.stats.addTempStat(STAT_TGH, -STAT_LEVEL_BASIC, STIM_TIME, "diplopterum_w")

/datum/reagent/toxin/diplopterum/overdose(mob/living/carbon/M, alien)
	if(ishuman(M))
		var/mob/living/carbon/human/H = M
		var/obj/item/organ/internal/liver/L = H.random_organ_by_process(OP_LIVER)
		if(istype(L))
			L.take_damage(strength, 0)
	if(issmall(M))
		M.adjustToxLoss(strength * 2)
	else
		M.adjustToxLoss(strength)

/datum/reagent/toxin/seligitillin
	name = "Seligitillin"
	id = "seligitillin"
	description = "Promotes blood clotting. Harvested from Seuche roaches."
	taste_description = "plague"
	reagent_state = LIQUID
	color = "#6d33b4"
	overdose = 16
	addiction_chance = 10
	nerve_system_accumulations = 5
	heating_point = 573
	heating_products = list("radium", "ammonia", "sulfur", "nutriment")

/datum/reagent/toxin/seligitillin/affect_blood(mob/living/carbon/M, alien, effect_multiplier)
	var/mob/living/carbon/human/H = M
	for(var/obj/item/organ/external/E in H.organs)
		for(var/datum/wound/W in E.wounds)
			if(W.internal)
				W.heal_damage(1 * effect_multiplier)
	if(M.species?.reagent_tag == IS_CHTMANT)
		M.heal_organ_damage(0, 0.6 * effect_multiplier, 0, 3 * effect_multiplier)
		return

/datum/reagent/toxin/seligitillin/withdrawal_act(mob/living/carbon/M)
	if(M.species?.reagent_tag == IS_CHTMANT)
		return
	M.stats.addTempStat(STAT_TGH, -STAT_LEVEL_ADEPT, STIM_TIME, "seligitillin_w")

/datum/reagent/toxin/seligitillin/overdose(mob/living/carbon/M, alien)
	if(!ishuman(M))
		return
	var/mob/living/carbon/human/H = M
	var/obj/item/organ/internal/heart/S = H.random_organ_by_process(OP_HEART)
	if(istype(S))
		S.take_damage(2, 0)
	var/obj/item/organ/internal/liver/L = H.random_organ_by_process(OP_LIVER)
	if(istype(L))
		L.take_damage(3, 0)

/datum/reagent/toxin/starkellin
	name = "Starkellin"
	id = "starkellin"
	description = "Harvested from Panzer roaches."
	taste_description = "metal"
	reagent_state = LIQUID
	color = "#736bbe"
	overdose = 16
	addiction_chance = 15
	nerve_system_accumulations = 5
	heating_point = 573
	heating_products = list("radium", "aluminum", "tungsten", "nutriment")
	reagent_type = "Toxin/Stimulator"

/datum/reagent/toxin/starkellin/affect_blood(mob/living/carbon/M, alien, effect_multiplier)
	..()
	M.stats.addTempStat(STAT_TGH, STAT_LEVEL_BASIC, STIM_TIME, "starkellin")
	if(M.species?.reagent_tag == IS_CHTMANT)
		M.heal_organ_damage(0.6 * effect_multiplier, 0, 5 * effect_multiplier)
		M.add_chemical_effect(CE_BLOODCLOT, 0.15)
		M.adjustToxLoss(-0.1)
		return

/datum/reagent/toxin/starkellin/withdrawal_act(mob/living/carbon/M)
	if(M.species?.reagent_tag == IS_CHTMANT)
		return
	M.stats.addTempStat(STAT_ROB, -STAT_LEVEL_BASIC, STIM_TIME, "starkellin_w")
	M.stats.addTempStat(STAT_TGH, -STAT_LEVEL_BASIC, STIM_TIME, "starkellin_w")

/datum/reagent/toxin/gewaltine
	name = "Gewaltine"
	id = "gewaltine"
	description = "Harvested from Jager roaches."
	taste_description = "raw meat"
	reagent_state = LIQUID
	color = "#9452ba"
	overdose = 16
	addiction_chance = 20
	nerve_system_accumulations = 5
	strength = 0.2
	heating_point = 573
	heating_products = list("radium", "mercury", "sugar", "nutriment")
	reagent_type = "Toxin/Stimulator"

/datum/reagent/toxin/gewaltine/affect_blood(mob/living/carbon/M, alien, effect_multiplier)
	..()
	M.stats.addTempStat(STAT_ROB, STAT_LEVEL_BASIC, STIM_TIME, "gewaltine")
	M.stats.addTempStat(STAT_TGH, -STAT_LEVEL_BASIC, STIM_TIME, "gewaltine")
	if(M.species?.reagent_tag == IS_CHTMANT)
		M.drowsyness = max(0, M.drowsyness - 0.6 * effect_multiplier)
		M.adjust_hallucination(-0.9 * effect_multiplier)
		M.adjustToxLoss(-((0.4 + (M.getToxLoss() * 0.05)) * effect_multiplier))
		M.add_chemical_effect(CE_ANTITOX, 1)
		holder.remove_reagent("pararein", 0.4 * effect_multiplier)
		return

/datum/reagent/toxin/gewaltine/withdrawal_act(mob/living/carbon/M)
	if(M.species?.reagent_tag == IS_CHTMANT)
		return
	M.stats.addTempStat(STAT_ROB, -STAT_LEVEL_ADEPT, STIM_TIME, "gewaltine_w")
	M.stats.addTempStat(STAT_VIG, -STAT_LEVEL_BASIC, STIM_TIME, "gewaltine_w")

/datum/reagent/toxin/gewaltine/overdose(mob/living/carbon/M, alien)
	M.adjustCloneLoss(2)

/datum/reagent/toxin/fuhrerole
	name = "Fuhrerole"
	id = "fuhrerole"
	description = "Harvested from Fuhrer roaches."
	taste_description = "third reich"
	reagent_state = LIQUID
	color = "#a6b85b"
	overdose = 16
	addiction_chance = 30
	nerve_system_accumulations = 4
	heating_point = 573
	heating_products = list("radium", "mercury", "lithium", "nutriment")

/datum/reagent/toxin/fuhrerole/affect_blood(mob/living/carbon/M, alien, effect_multiplier)
	..()
	if(M.species?.reagent_tag == IS_CHTMANT)
		var/mob/living/carbon/human/H = M
		for(var/obj/item/organ/I in H.internal_organs)
			if((I.damage > 0) && !BP_IS_ROBOTIC(I)) //Chtmants are not meant to have robotic organs!
				I.heal_damage(((0.2 + I.damage * 0.05) * effect_multiplier), FALSE)
		return
	M.faction = "roach"

/datum/reagent/toxin/fuhrerole/on_mob_delete(mob/living/carbon/L)
	..()
	if(L.species?.reagent_tag == IS_CHTMANT)
		return
	L.faction = initial(L.faction)

/datum/reagent/toxin/fuhrerole/withdrawal_act(mob/living/carbon/M)
	if(M.species?.reagent_tag == IS_CHTMANT)
		return
	M.stats.addTempStat(STAT_ROB, -STAT_LEVEL_BASIC, STIM_TIME, "fuhrerole_w")
	M.stats.addTempStat(STAT_TGH, -STAT_LEVEL_BASIC, STIM_TIME, "fuhrerole_w")

/datum/reagent/toxin/fuhrerole/overdose(mob/living/carbon/M, alien)
	M.add_chemical_effect(CE_SPEECH_VOLUME, rand(3,4))
	M.adjustBrainLoss(0.5)

/datum/reagent/toxin/biomatter
	name = "Biomatter"
	id = "biomatter"
	description = "A goo of unknown to you origin. Its better to stay that way."
	taste_description = "vomit"
	reagent_state = LIQUID
	color = "#527f4f"
	strength = 0.3

/datum/reagent/toxin/biomatter/affect_blood(mob/living/carbon/M, alien, effect_multiplier)
	..()
	M.take_organ_damage(0, effect_multiplier * strength)

/datum/reagent/toxin/biomatter/affect_ingest(mob/living/carbon/M, alien, effect_multiplier)
	..()
	if(prob(10 - (5 * M.stats.getMult(STAT_TGH))))
		M.vomit()

/datum/reagent/toxin/biomatter/affect_touch(mob/living/carbon/M, alien, effect_multiplier)
	..()
	if(prob(5 - (4 * M.stats.getMult(STAT_TGH))))
		M.vomit()

/datum/reagent/toxin/biomatter/touch_turf(turf/T)
	if(volume >= 5)
		if(volume >= 45)
			spill_biomass(T, alldirs)
		else if(volume >= 25)
			spill_biomass(T, cardinal)
		else
			spill_biomass(T)
		remove_self(volume)
		return TRUE

/datum/reagent/toxin/xenotoxin
	name = "Xenomorph Toxin"
	id = "xenotoxin"
	description = "A highly toxic chemical that causes a complete neural weakening of the body in both mind and muscle."
	taste_description = "bitterness"
	reagent_state = LIQUID
	color = "#ffb3b7"
	nerve_system_accumulations = 5
	addiction_chance = 10
	scannable = 1
	metabolism = REM/4
	constant_metabolism = TRUE

/datum/reagent/toxin/xenotoxin/affect_blood(mob/living/carbon/M, alien, effect_multiplier)
	M.stats.addTempStat(STAT_MEC, -STAT_LEVEL_ADEPT * effect_multiplier, STIM_TIME, "xeno_toxin")
	M.stats.addTempStat(STAT_BIO, -STAT_LEVEL_ADEPT * effect_multiplier, STIM_TIME, "xeno_toxin")
	M.stats.addTempStat(STAT_COG, -STAT_LEVEL_ADEPT * effect_multiplier, STIM_TIME, "xeno_toxin")
	M.stats.addTempStat(STAT_VIG, -STAT_LEVEL_ADEPT * effect_multiplier, STIM_TIME, "xeno_toxin")
	M.stats.addTempStat(STAT_TGH, -STAT_LEVEL_ADEPT * effect_multiplier, STIM_TIME, "xeno_toxin")
	M.stats.addTempStat(STAT_ROB, -STAT_LEVEL_ADEPT * effect_multiplier, STIM_TIME, "xeno_toxin")

/datum/reagent/toxin/xenotoxin/withdrawal_act(mob/living/carbon/M)
	M.stats.addTempStat(STAT_MEC, -STAT_LEVEL_BASIC, STIM_TIME, "xeno_toxin_w")
	M.stats.addTempStat(STAT_BIO, -STAT_LEVEL_BASIC, STIM_TIME, "xeno_toxin_w")
	M.stats.addTempStat(STAT_COG, -STAT_LEVEL_BASIC, STIM_TIME, "xeno_toxin_w")
	M.stats.addTempStat(STAT_VIG, -STAT_LEVEL_BASIC, STIM_TIME, "xeno_toxin_w")
	M.stats.addTempStat(STAT_TGH, -STAT_LEVEL_BASIC, STIM_TIME, "xeno_toxin_w")
	M.stats.addTempStat(STAT_ROB, -STAT_LEVEL_BASIC, STIM_TIME, "xeno_toxin_w")
	if(prob(25 - (5 * M.stats.getMult(STAT_TGH))))
		M.shake_animation(8)

/datum/reagent/toxin/xenotoxin/overdose(mob/living/carbon/M, alien)
	M.adjustBrainLoss(2)
	M.slurring = max(M.slurring, 30)
	if(prob(5))
		M.vomit()

/datum/reagent/toxin/combat
	name = "Tetraricide"
	id = "chemweapon1"
	description = "A powerful chemical weapon, sometimes referred to as \"Sweet Death\". Only absolute psychopaths and REALLY desperate mercenaries utilize this chemical."
	taste_description = "sweetness"
	reagent_state = LIQUID
	strength = 0.8
	overdose = REAGENTS_OVERDOSE/2

/datum/reagent/toxin/combat/affect_blood(mob/living/carbon/M, alien, effect_multiplier)
	..()
	if(M.losebreath < 15)
		M.losebreath++
	M.apply_damages(0,0,0,1.5,0,20)				//Asphyxia and pain
	if(prob(5 - (4 * M.stats.getMult(STAT_TGH))))
		M.vomit()

/datum/reagent/toxin/combat/affect_ingest(mob/living/carbon/M, alien, effect_multiplier)
	..()
	if(M.losebreath < 15)
		M.losebreath++
	M.apply_damages(0,0,0,0.5,0,20)				//Asphyxia and pain
	if(prob(5 - (5 * M.stats.getMult(STAT_TGH))))
		M.vomit()

/datum/reagent/toxin/combat/affect_touch(mob/living/carbon/M, alien, effect_multiplier)
	..()
	if(M.losebreath < 15)
		M.losebreath++
	M.apply_damages(0,0,0,2.5,0,10)				//Asphyxia and pain
	if(prob(5 - (4 * M.stats.getMult(STAT_TGH))))
		M.vomit()

/datum/reagent/toxin/combat/overdose(mob/living/carbon/M, alien)
	..()
	M.adjustHalLoss(20)
	M.adjustOxyLoss(5)

/datum/reagent/toxin/combat/touch_mob(mob/living/L, amount)
	if(istype(L))
		L.adjustHalLoss(50)
		L.adjustToxLoss(20)

//Custom Chem Sir made me do to learn Chem Code
/datum/reagent/toxin/chlorobenzalmalononitrile
    name = "CS powder"
    id = "chlorobenzalmalononitrile"
    description = "A Nerve-Agent that works similar to Pepper Spray but higher in potency."
    taste_description = "the Sun's piss"
    taste_mult = 10
    reagent_state = LIQUID
    touch_met = 30
    overdose = REAGENTS_OVERDOSE
    color = "#545454"
    var/agony_dose = 0.5
    var/agony_amount = 4
    var/discomfort_message = "<span class='danger'>You feel like the world is turning fuzzy</span>"
/datum/reagent/toxin/chlorobenzalmalononitrile/affect_touch(mob/living/carbon/M, alien, effect_multiplier)
    var/eyes_covered = 0
    var/mouth_covered = 0
    var/no_pain = 0
    var/obj/item/eye_protection
    var/obj/item/face_protection

    var/list/protection
    if(ishuman(M))
        var/mob/living/carbon/human/H = M
        protection = list(H.head, H.glasses, H.wear_mask)
        if(H.species && (H.species.flags & NO_PAIN))
            no_pain = 1 //TODO: living-level can_feel_pain() proc
    else
        protection = list(M.wear_mask)

    for(var/obj/item/I in protection)
        if(I)
            if(I.body_parts_covered & EYES)
                eyes_covered = 1
                eye_protection = I.name
            if((I.body_parts_covered & FACE) && !(I.item_flags & FLEXIBLEMATERIAL))
                mouth_covered = 1
                face_protection = I.name

    var/message
    if(eyes_covered)
        if(!mouth_covered)
            message = SPAN_WARNING("Your [eye_protection] protects your eyes from the nerve gas agent!")
    else
        message = SPAN_WARNING("YOUR EYES ARE BURNING!!")
        if(mouth_covered)
            M.eye_blurry = max(M.eye_blurry, 15)
            M.make_dizzy(500)
        else
            M.eye_blurry = max(M.eye_blurry, 25)
            M.make_dizzy(1000)

    if(mouth_covered)
        if(!message)
            message = SPAN_WARNING("Your [face_protection] protects you from the nerve gas agent!")
    else if(!no_pain)
        message = SPAN_DANGER("Your face and throat feel like it's being roasted to death!")
        if(prob(25))
            M.custom_emote(2, "[pick("coughs!","coughs hysterically!","splutters!")]")
        M.apply_effect(30, AGONY, 0)
/datum/reagent/toxin/chlorobenzalmalononitrile/affect_ingest(mob/living/carbon/M, alien, effect_multiplier)
    if(ishuman(M))
        var/mob/living/carbon/human/H = M
        if(H.species && (H.species.flags & NO_PAIN))
            return
    if(dose < agony_dose)
        if(prob(5) || dose == metabolism) //dose == metabolism is a very hacky way of forcing the message the first time this procs
            to_chat(M, discomfort_message)
    if(dose == metabolism)
        to_chat(M, SPAN_DANGER("You feel the blood rushing through your veins like lava!"))
    else
        M.apply_effect(agony_amount, AGONY, 0)
        if(prob(5))
            M.visible_message("<span class='warning'>[M] [pick("dry heaves!","coughs!","splutters!")]</span>", SPAN_DANGER("You feel like your insides are melting!"))
    if(isslime(M))
        M.bodytemperature += rand(15, 30)
    holder.remove_reagent("tramadol", 5)
/datum/reagent/toxin/chlorobenzalmalononitrile/overdose(mob/living/carbon/M, alien, effect_multiplier)
    M.adjustOxyLoss(5 * effect_multiplier)
    M.take_organ_damage(5 * effect_multiplier, 0)
    if(M.losebreath < 15)
        M.losebreath++
