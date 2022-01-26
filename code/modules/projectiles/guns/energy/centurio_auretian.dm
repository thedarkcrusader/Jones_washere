/obj/item/gun/energy/centurio
	name = "\"Centurio\" plasma pistol"
	desc = "A specialized firearm designed to fire lethal plasma rounds or a slow wave of ion particals."
	icon = 'icons/obj/guns/energy/toxgun.dmi'
	icon_state = "toxgun"
	w_class = ITEM_SIZE_NORMAL
	slot_flags = SLOT_BELT|SLOT_BACK|SLOT_HOLSTER
	twohanded = FALSE
	can_dual = TRUE
	sel_mode = 1
	origin_tech = list(TECH_COMBAT = 5, TECH_PLASMA = 4)
	matter = list(MATERIAL_STEEL = 20, MATERIAL_PLASMA = 5)
	price_tag = 1250
	damage_multiplier = 1
	init_firemodes = list(
		list(mode_name="melt", projectile_type=/obj/item/projectile/plasma/heavy, fire_sound='sound/weapons/lasercannonfire.ogg', fire_delay = 9, icon="destroy", projectile_color = "#006633"),
		list(mode_name="ion shot", projectile_type=/obj/item/projectile/ion, fire_sound='sound/effects/supermatter.ogg', fire_delay = 25, icon="stun", projectile_color = "#ff7f24"),
		)

/obj/item/gun/energy/plasma/auretian
	name = "\"Auretian\" energy pistol"
	desc = "\"Soteria\" brand energy pistol, for personal overprotection. It has the advantage of using laser and plasma firing methods, \
	with the former firing rapid weaker shots able to pass through glass or grilles and the latter firing slower but higher damage armor penetrating shots."
	icon = 'icons/obj/guns/energy/brigador.dmi'
	icon_state = "brigador"
	charge_meter = FALSE
	w_class = ITEM_SIZE_NORMAL
	slot_flags = SLOT_BELT|SLOT_BACK|SLOT_HOLSTER
	twohanded = FALSE
	origin_tech = list(TECH_COMBAT = 5, TECH_PLASMA = 6)
	can_dual = TRUE
	sel_mode = 1
	suitable_cell = /obj/item/cell/small
	charge_cost = 20
	damage_multiplier = 1
	matter = list(MATERIAL_PLASTEEL = 10, MATERIAL_PLASTIC = 8, MATERIAL_PLASMA = 2, MATERIAL_SILVER = 3, MATERIAL_URANIUM = 3)
	gun_tags = list(GUN_LASER, GUN_ENERGY)

	init_firemodes = list(
		list(mode_name="plasma", projectile_type=/obj/item/projectile/plasma/heavy, fire_sound='sound/weapons/Taser4.ogg', fire_delay=9, icon="destroy", projectile_color = "#00FFFF"),
		list(mode_name="laser", projectile_type=/obj/item/projectile/beam/midlaser, fire_sound='sound/weapons/Taser3.ogg', fire_delay=0.5, icon="kill", projectile_color = "#00AAFF"),
	)

/obj/item/gun/energy/plasma/auretian/update_icon()
	overlays.Cut()
	..()
	if(cell)
		overlays += image(icon, "cell_guild")