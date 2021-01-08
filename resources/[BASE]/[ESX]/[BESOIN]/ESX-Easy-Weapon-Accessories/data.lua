data = {}

data.weapons = {
    [GetHashKey('WEAPON_PISTOL')] = { 
        suppressor = GetHashKey('COMPONENT_AT_PI_SUPP_02'), --silencieux
        compensator = nil,
        flashlight = GetHashKey('COMPONENT_AT_PI_FLSH'), --lampe
        grip = nil, --poignet
        scope_rail = nil, --pistolet lunette
        scope_sights = nil, --holographique lunette
        scope_macro = nil, --Petite lunette
        scope_small = nil, --Moyenne lunette
        scope_medium = nil, --Grande lunette
        clip_large = GetHashKey('COMPONENT_PISTOL_CLIP_02'), --chargeur grande capacité
        clip_tracer = nil, --balle tracente
        clip_incendiary = nil, --balle incendiaire
        clip_hollowpoint = nil, --balle a téte creuse
        clip_armorpiercing = nil, --balle perforante
        clip_fmj = nil, --balle blindé
        barrel_heavy = nil, --Canon lourd
    },

    [GetHashKey('WEAPON_COMBATPISTOL')] = { 
        suppressor = GetHashKey('COMPONENT_AT_PI_SUPP'), --silencieux
        compensator = nil,
        flashlight = GetHashKey('COMPONENT_AT_PI_FLSH'), --lampe
        grip = nil, --poignet
        scope_rail = nil, --pistolet lunette
        scope_sights = nil, --holographique lunette
        scope_macro = nil, --Petite lunette
        scope_small = nil, --Moyenne lunette
        scope_medium = nil, --Grande lunette
        clip_large = GetHashKey('COMPONENT_COMBATPISTOL_CLIP_02'), --chargeur grande capacité
        clip_tracer = nil, --balle tracente
        clip_incendiary = nil, --balle incendiaire
        clip_hollowpoint = nil, --balle a téte creuse
        clip_armorpiercing = nil, --balle perforante
        clip_fmj = nil, --balle blindé
        barrel_heavy = nil, --Canon lourd
    },

    [GetHashKey('WEAPON_APPISTOL')] = { 
        suppressor = GetHashKey('COMPONENT_AT_PI_SUPP'), --silencieux
        compensator = nil,
        flashlight = GetHashKey('COMPONENT_AT_PI_FLSH'), --lampe
        grip = nil, --poignet
        scope_rail = nil, --pistolet lunette
        scope_sights = nil, --holographique lunette
        scope_macro = nil, --Petite lunette
        scope_small = nil, --Moyenne lunette
        scope_medium = nil, --Grande lunette
        clip_large = GetHashKey('COMPONENT_APPISTOL_CLIP_02'), --chargeur grande capacité
        clip_tracer = nil, --balle tracente
        clip_incendiary = nil, --balle incendiaire
        clip_hollowpoint = nil, --balle a téte creuse
        clip_armorpiercing = nil, --balle perforante
        clip_fmj = nil, --balle blindé
        barrel_heavy = nil, --Canon lourd
    },

    [GetHashKey('WEAPON_PISTOL50')] = { 
        suppressor = GetHashKey('COMPONENT_AT_AR_SUPP_02'), --silencieux
        compensator = nil,
        flashlight = GetHashKey('COMPONENT_AT_PI_FLSH'), --lampe
        grip = nil, --poignet
        scope_rail = nil, --pistolet lunette
        scope_sights = nil, --holographique lunette
        scope_macro = nil, --Petite lunette
        scope_small = nil, --Moyenne lunette
        scope_medium = nil, --Grande lunette
        clip_large = GetHashKey('COMPONENT_PISTOL50_CLIP_02'), --chargeur grande capacité
        clip_tracer = nil, --balle tracente
        clip_incendiary = nil, --balle incendiaire
        clip_hollowpoint = nil, --balle a téte creuse
        clip_armorpiercing = nil, --balle perforante
        clip_fmj = nil, --balle blindé
        barrel_heavy = nil, --Canon lourd
    },

    [GetHashKey('WEAPON_SNSPISTOL')] = { 
        suppressor = nil, --silencieux
        compensator = nil,
        flashlight = nil, --lampe
        grip = nil, --poignet
        scope_rail = nil, --pistolet lunette
        scope_sights = nil, --holographique lunette
        scope_macro = nil, --Petite lunette
        scope_small = nil, --Moyenne lunette
        scope_medium = nil, --Grande lunette
        clip_large = GetHashKey('COMPONENT_SNSPISTOL_CLIP_02'), --chargeur grande capacité
        clip_tracer = nil, --balle tracente
        clip_incendiary = nil, --balle incendiaire
        clip_hollowpoint = nil, --balle a téte creuse
        clip_armorpiercing = nil, --balle perforante
        clip_fmj = nil, --balle blindé
        barrel_heavy = nil, --Canon lourd
    },

    [GetHashKey('WEAPON_HEAVYPISTOL')] = { 
        suppressor = GetHashKey('COMPONENT_AT_PI_SUPP'), --silencieux
        compensator = nil,
        flashlight = GetHashKey('COMPONENT_AT_PI_FLSH'), --lampe
        grip = nil, --poignet
        scope_rail = nil, --pistolet lunette
        scope_sights = nil, --holographique lunette
        scope_macro = nil, --Petite lunette
        scope_small = nil, --Moyenne lunette
        scope_medium = nil, --Grande lunette
        clip_large = GetHashKey('COMPONENT_HEAVYPISTOL_CLIP_02'), --chargeur grande capacité
        clip_tracer = nil, --balle tracente
        clip_incendiary = nil, --balle incendiaire
        clip_armorpiercing = nil, --balle perforante
        clip_fmj = nil, --balle blindé
        barrel_heavy = nil, --Canon lourd
    },

    [GetHashKey('WEAPON_REVOLVER_MK2')] = { 
        suppressor = GetHashKey('COMPONENT_AT_PI_SUPP'), --silencieux
        compensator = GetHashKey('COMPONENT_AT_PI_COMP_03'),
        flashlight = GetHashKey('COMPONENT_AT_PI_FLSH'), --lampe
        grip = nil, --poignet
        scope_rail = nil, --pistolet lunette
        scope_sights = GetHashKey('COMPONENT_AT_SIGHTS'), --holographique lunette
        scope_macro = GetHashKey('COMPONENT_AT_SCOPE_MACRO_MK2'), --Petite lunette
        scope_small = nil, --Moyenne lunette
        scope_medium = nil, --Grande lunette
        clip_large = nil, --chargeur grande capacité
        clip_tracer = GetHashKey('COMPONENT_REVOLVER_MK2_CLIP_TRACER'), --balle tracente
        clip_incendiary = GetHashKey('COMPONENT_REVOLVER_MK2_CLIP_INCENDIARY'), --balle incendiaire
        clip_hollowpoint = GetHashKey('COMPONENT_REVOLVER_MK2_CLIP_HOLLOWPOINT'), --balle a téte creuse
        clip_armorpiercing = nil, --balle perforante
        clip_fmj = GetHashKey('COMPONENT_REVOLVER_MK2_CLIP_FMJ'), --balle blindé
        barrel_heavy = nil, --Canon lourd
    },

    [GetHashKey('WEAPON_SNSPISTOL_MK2')] = { 
        suppressor = GetHashKey('COMPONENT_AT_PI_SUPP_02'), --silencieux
        compensator = GetHashKey('COMPONENT_AT_PI_COMP_02'),
        flashlight = GetHashKey('COMPONENT_AT_PI_FLSH_03'), --lampe
        grip = nil, --poignet
        scope_rail = GetHashKey('COMPONENT_AT_PI_RAIL_02'), --pistolet lunette
        scope_sights = nil, --holographique lunette
        scope_macro = nil, --Petite lunette
        scope_small = nil, --Moyenne lunette
        scope_medium = nil, --Grande lunette
        clip_large = GetHashKey('COMPONENT_SNSPISTOL_MK2_CLIP_02'), --chargeur grande capacité
        clip_tracer = GetHashKey('COMPONENT_SNSPISTOL_MK2_CLIP_TRACER'), --balle tracente
        clip_incendiary = GetHashKey('COMPONENT_SNSPISTOL_MK2_CLIP_INCENDIARY'), --balle incendiaire
        clip_hollowpoint = GetHashKey('COMPONENT_SNSPISTOL_MK2_CLIP_HOLLOWPOINT'), --balle a téte creuse
        clip_armorpiercing = nil, --balle perforante
        clip_fmj = GetHashKey('COMPONENT_SNSPISTOL_MK2_CLIP_FMJ'), --balle blindé
        barrel_heavy = nil, --Canon lourd
    },

    [GetHashKey('WEAPON_PISTOL_MK2')] = { 
        suppressor = GetHashKey('COMPONENT_AT_PI_SUPP_02'), --silencieux
        compensator = GetHashKey('COMPONENT_AT_PI_COMP'),
        flashlight = GetHashKey('COMPONENT_AT_PI_FLSH_02'), --lampe
        grip = nil, --poignet
        scope_rail = GetHashKey('COMPONENT_AT_PI_RAIL'), --pistolet lunette
        scope_sights = nil, --holographique lunette
        scope_macro = nil, --Petite lunette
        scope_small = nil, --Moyenne lunette
        scope_medium = nil, --Grande lunette
        clip_large = GetHashKey('COMPONENT_PISTOL_MK2_CLIP_02'), --chargeur grande capacité
        clip_tracer = GetHashKey('COMPONENT_PISTOL_MK2_CLIP_TRACER'), --balle tracente
        clip_incendiary = GetHashKey('COMPONENT_PISTOL_MK2_CLIP_INCENDIARY'), --balle incendiaire
        clip_hollowpoint = GetHashKey('COMPONENT_PISTOL_MK2_CLIP_HOLLOWPOINT'), --balle a téte creuse
        clip_armorpiercing = nil, --balle perforante
        clip_fmj = GetHashKey('COMPONENT_PISTOL_MK2_CLIP_FMJ'), --balle blindé
        barrel_heavy = nil, --Canon lourd
    },

    [GetHashKey('WEAPON_VINTAGEPISTOL')] = { 
        suppressor = GetHashKey('COMPONENT_AT_PI_SUPP'), --silencieux
        compensator = nil,
        flashlight = nil, --lampe
        grip = nil, --poignet
        scope_rail = nil, --pistolet lunette
        scope_sights = nil, --holographique lunette
        scope_macro = nil, --Petite lunette
        scope_small = nil, --Moyenne lunette
        scope_medium = nil, --Grande lunette
        clip_large = GetHashKey('COMPONENT_VINTAGEPISTOL_CLIP_02'), --chargeur grande capacité
        clip_tracer = nil, --balle tracente
        clip_incendiary = nil, --balle incendiaire
        clip_hollowpoint = nil, --balle a téte creuse
        clip_armorpiercing = nil, --balle perforante
        clip_fmj = nil, --balle blindé
        barrel_heavy = nil, --Canon lourd
    },

    [GetHashKey('WEAPON_MICROSMG')] = { 
        suppressor = GetHashKey('COMPONENT_AT_AR_SUPP_02'), --silencieux
        compensator = nil,
        flashlight = GetHashKey('COMPONENT_AT_PI_FLSH'), --lampe
        grip = nil, --poignet
        scope_rail = nil, --pistolet lunette
        scope_sights = nil, --holographique lunette
        scope_macro = GetHashKey('COMPONENT_AT_SCOPE_MACRO'), --Petite lunette
        scope_small = nil, --Moyenne lunette
        scope_medium = nil, --Grande lunette
        clip_large = GetHashKey('COMPONENT_MICROSMG_CLIP_02'), --chargeur grande capacité
        clip_tracer = nil, --balle tracente
        clip_incendiary = nil, --balle incendiaire
        clip_hollowpoint = nil, --balle a téte creuse
        clip_armorpiercing = nil, --balle perforante
        clip_fmj = nil, --balle blindé
        barrel_heavy = nil, --Canon lourd
    },
}