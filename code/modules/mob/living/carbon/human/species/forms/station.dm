/datum/species_form/human
	name = FORM_HUMAN
//	name_plural = "Humans"
	base = 'icons/mob/human_races/r_human_white.dmi'
	deform = 'icons/mob/human_races/r_def_human_white.dmi'
	appearance_flags = HAS_HAIR_COLOR | HAS_LIPS | HAS_UNDERWEAR | HAS_EYE_COLOR | HAS_SKIN_COLOR
	playable = TRUE

	//No changes.

/*#define FORM_HUMAN				"Human"
#define FORM_CANINE				"Canine"
#define FORM_SHARK				"Shark"
#define FORM_LIZARD				"Lizard"
#define FORM_VULPINE				"Vulpine"
#define FORM_FENNEC				"Fennec"
#define FORM_NARAMAD				"Naramad"
#define FORM_SLIME				"Slime"
#define FORM_AVIAN				"Avian"
#define FORM_SPIDER				"Arachnoid"
#define FORM_MARQUA				"Mar'Qua"*/

/*/datum/species_form/template
	name
	base
	deform
	face
	damage_overlays
	damage_mask
	blood_mask*/

/datum/species_form/stationxeno
	playable = FALSE
	name = FORM_STATIONXENO
	base = 'icons/mob/human_races/xenos/r_xenos_drone.dmi'
	deform =  'icons/mob/human_races/xenos/r_xenos_drone.dmi'
	variantof = FORM_STATIONXENO
	appearance_flags = HAS_EYE_COLOR | HAS_UNDERWEAR
	playable = FALSE

/datum/species_form/stationxeno/hunter
	name = FORM_STATIONXENO_HUNTER
	base = 'icons/mob/human_races/xenos/r_xenos_hunter.dmi'
	deform = 'icons/mob/human_races/xenos/r_xenos_hunter.dmi'

/datum/species_form/stationxeno/queen
	name = FORM_STATIONXENO_QUEEN
	base = 'icons/mob/human_races/xenos/r_xenos_queen.dmi'
	deform = 'icons/mob/human_races/xenos/r_xenos_queen.dmi'

/datum/species_form/stationxeno/sentinel
	name = FORM_STATIONXENO_SENTI
	base = 'icons/mob/human_races/xenos/r_xenos_sentinel.dmi'
	deform = 'icons/mob/human_races/xenos/r_xenos_sentinel.dmi'

/datum/species_form/soteria_synthetic
	playable = FALSE
	name = FORM_SOTSYNTH
	blood_color = "#191919"
	base = 'icons/mob/human_races/r_human_white.dmi'
	deform = 'icons/mob/human_races/r_def_human_white.dmi'
	appearance_flags = HAS_UNDERWEAR
	death_sound = 'sound/machines/shutdown.ogg'
	death_message = "falls over crashing to the ground as their electronic eyes fade off."
	knockout_message = "has been knocked offline!"
	halloss_message = "falls down with a loud clash and seems to be unresponsive."
	halloss_message_self = "Your systems are rebooting after an overload."

/datum/species_form/artificer_guild_synthetic
	playable = FALSE
	name = FORM_AGSYNTH
	blood_color = "#191919"
	base = 'icons/mob/human_races/r_human_white.dmi'
	deform = 'icons/mob/human_races/r_def_human_white.dmi'
	appearance_flags = HAS_UNDERWEAR
	death_sound = 'sound/machines/shutdown.ogg'
	death_message = "falls over crashing to the ground as their electronic eyes fade off."
	knockout_message = "has been knocked offline!"
	halloss_message = "falls down with a loud clash and seems to be unresponsive."
	halloss_message_self = "Your systems are rebooting after an overload."

/datum/species_form/blackshield_synthetic
	playable = FALSE
	name = FORM_BSSYNTH
	blood_color = "#191919"
	base = 'icons/mob/human_races/r_human_white.dmi'
	deform = 'icons/mob/human_races/r_def_human_white.dmi'
	appearance_flags = HAS_UNDERWEAR
	death_sound = 'sound/machines/shutdown.ogg'
	death_message = "falls over crashing to the ground as their electronic eyes fade off."
	knockout_message = "has been knocked offline!"
	halloss_message = "falls down with a loud clash and seems to be unresponsive."
	halloss_message_self = "Your systems are rebooting after an overload."

/datum/species_form/church_synthetic
	playable = FALSE
	name = FORM_CHURCHSYNTH
	blood_color = "#191919"
	base = 'icons/mob/human_races/r_human_white.dmi'
	deform = 'icons/mob/human_races/r_def_human_white.dmi'
	appearance_flags = HAS_UNDERWEAR
	death_sound = 'sound/machines/shutdown.ogg'
	death_message = "falls over crashing to the ground as their electronic eyes fade off."
	knockout_message = "has been knocked offline!"
	halloss_message = "falls down with a loud clash and seems to be unresponsive."
	halloss_message_self = "Your systems are rebooting after an overload."

/datum/species_form/nashef_synthetic
	playable = FALSE
	name = FORM_NASHEF
	blood_color = "#191919"
	base = 'icons/mob/human_races/r_human_white.dmi'
	deform = 'icons/mob/human_races/r_def_human_white.dmi'
	appearance_flags = HAS_UNDERWEAR
	death_sound = 'sound/machines/shutdown.ogg'
	death_message = "falls over crashing to the ground as their electronic eyes fade off."
	knockout_message = "has been knocked offline!"
	halloss_message = "falls down with a loud clash and seems to be unresponsive."
	halloss_message_self = "Your systems are rebooting after an overload."

/datum/species_form/full_body_prosthetic
	playable = FALSE
	name = FORM_FBP
	blood_color = "#191919"
	colorable = TRUE
	base = 'icons/mob/human_races/r_human_white.dmi'
	deform = 'icons/mob/human_races/r_def_human_white.dmi'
	appearance_flags = HAS_HAIR_COLOR | HAS_EYE_COLOR | HAS_SKIN_COLOR | HAS_UNDERWEAR | HAS_SKIN_TONE
	death_sound = 'sound/machines/shutdown.ogg'
	death_message = "falls over crashing to the ground as their electronic eyes fade off."
	knockout_message = "has been knocked offline!"
	halloss_message = "falls down with a loud clash and seems to be unresponsive."
	halloss_message_self = "Your systems are rebooting after an overload."

