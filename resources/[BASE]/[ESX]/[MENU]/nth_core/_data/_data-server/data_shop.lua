Jobs = {

    ["Weed"] = {
        jobRequired = false,
        jobName = "",
        location = { 
            [1] = { --recolte
                coords = vector3(2221.6, 5577.28, 52.84),
                zoneSize = 5,
                blip = {
                    showBlip = false,
                    blipName = "Chicken collect",
                    sprite = 475,
                    color = 8,
                    scale = 0.65,
                },
                marker = {
                    enable = false,
                    size  = { x = 5.0, y = 5.0, z = 5.0 },
                    color = { r = 255, g = 0, b = 0 },
                    type  = 27
                },
                draw3dtext = {
                    enable = false,
                    text = "Press~g~E ~w~for collect some chicken",
                },
                item = {
                    process = "pickup", --dont touch


                    itemName = "weed",
                    addCount = 1,
                },                
                animation = {
                    enable = true,
                    animationFunction = function(ped)
                        animDict = "mp_car_bomb"
                        animName = "car_bomb_mechanic"
                        Citizen.CreateThread(function() 
                            RequestAnimDict(animDict) 
                            while not HasAnimDictLoaded(animDict) do Citizen.Wait(10) end 
                            TaskPlayAnim(ped, animDict, animName, 8.0, -8, -1, 49, 0, 0, 0, 0)
                        end)
                    end,
                },
                progressbar = {
                    enable = true,
                    progText = "Recolte de la weed...", 
                    duration = 10000 
                }
            },
            [2] = { --process
                coords = vector3(3616.2, 5024.2, 10.35),
                zoneSize = 8,
                blip = {
                    showBlip = false,
                    blipName = "Traitement weed",
                    sprite = 475, 
                    color = 8,
                    scale = 0.65,
                },
                marker = {
                    enable = false,
                    size  = { x = 8.5, y = 8.5, z = 0.5 },
                    color = { r = 204, g = 204, b = 0 },
                    type  = 27
                },
                draw3dtext = {
                    enable = false,
                    text = "Press~g~E ~w~for process chicken",
                },
                item = {
                    process = "exchange", --dont touch
                    
                    addCount = 1,
                    itemName = "weed_pochon",
                    
                    removeCount = 2,
                    requiredItem = "weed",
                },
                animation = {
                    enable = true,
                    animationFunction = function(ped)
                        animDict = "mp_car_bomb"
                        animName = "car_bomb_mechanic"
                        Citizen.CreateThread(function()
                            RequestAnimDict(animDict) 
                            while not HasAnimDictLoaded(animDict) do Citizen.Wait(10) end
                            TaskPlayAnim(ped, animDict, animName, 8.0, -8, -1, 49, 0, 0, 0, 0)
                        end)
                    end,
                },
                progressbar = {
                    enable = true,
                    progText = "Traitement de la weed...",
                    duration = 10000
                }
            },

            [3] = { --sell
                coords = vector3(-1461.29, -640.9, 32.38),
                zoneSize = 4,
                blip = {
                    showBlip = false,
                    blipName = "Vente weed",
                    sprite = 475, 
                    color = 8,
                    scale = 0.65,
                },
                marker = {
                    enable = false,
                    size  = { x = 4.0, y = 4.0, z = 0.5 },
                    color = { r = 204, g = 204, b = 0 },
                    type  = 27
                },
                draw3dtext = {
                    enable = false,
                    text = "Press~g~E ~w~for sell packaged chickens",
                },
                item = {
                    process = "sell", --dont touch
                    moneyType = "black_money",-- money, bank, black_money

                    removeCount = 1,
                    requiredItem = "weed_pochon",
                    price = 100
                },
                animation = {
                    enable = true,
                    animationFunction = function(ped)
                        animDict = "mp_car_bomb"
                        animName = "car_bomb_mechanic"
                        Citizen.CreateThread(function()
                            RequestAnimDict(animDict) while not HasAnimDictLoaded(animDict) do Citizen.Wait(10) end
                            TaskPlayAnim(ped, animDict, animName, 8.0, -8, -1, 49, 0, 0, 0, 0)
                        end)
                    end,
                },
                progressbar = {
                    enable = true,
                    progText = "Vente de la weed...",
                    duration = 10000
                }
            }
        },
    },

    ["Vigne"] = {
        jobRequired = true,
        jobName = "vigne",
        location = { 
            [1] = { --collect
                coords = vector3(-1719.369,1953.49,126.77),
                zoneSize = 5.0,
                blip = {
                    showBlip = true,
                    blipName = "[1] Recolte de raisin",
                    sprite = 148,
                    color = 83,
                    scale = 0.2,
                },
                marker = {
                    enable = false,
                    size  = { x = 0.7, y = 0.7, z = 0.4 },
                    color = { r = 255, g = 0, b = 0 },
                    type  = 2
                },
                draw3dtext = {
                    enable = false,
                    text = "",
                },
                item = {
                    process = "pickup",


                    itemName = "raisin",
                    addCount = 2,
                },                
                animation = {
                    enable = true,
                    animationFunction = function(ped)
                        animDict = "mp_car_bomb"
                        animName = "car_bomb_mechanic"
                        Citizen.CreateThread(function() 
                            RequestAnimDict(animDict) 
                            while not HasAnimDictLoaded(animDict) do Citizen.Wait(10) end 
                            TaskPlayAnim(ped, animDict, animName, 8.0, -8, -1, 49, 0, 0, 0, 0)
                        end)
                    end,
                },
                progressbar = {
                    enable = true,
                    progText = "Ramasage du raisin...", 
                    duration = 2500 
                }
            },
            [2] = { --traitement 1
                coords = vector3(-1934.15, 2052.78, 140.81),
                zoneSize = 1.5,
                blip = {
                    showBlip = true,
                    blipName = "[2] Foulage du raisin",
                    sprite = 148,
                    color = 83,
                    scale = 0.2,
                },
                marker = {
                    enable = false,
                    size  = { x = 0.7, y = 0.7, z = 0.4 },
                    color = { r = 204, g = 204, b = 0 },
                    type  = 2
                },
                draw3dtext = {
                    enable = true,
                    text = "[2] Foulage du raisin",
                },
                item = {
                    process = "exchange",
                    
                    addCount = 1,
                    itemName = "raisin_foule",
                    
                    removeCount = 2,
                    requiredItem = "raisin",
                },
                animation = {
                    enable = true,
                    animationFunction = function(ped)
                        animDict = "mp_car_bomb"
                        animName = "car_bomb_mechanic"
                        Citizen.CreateThread(function()
                            RequestAnimDict(animDict) 
                            while not HasAnimDictLoaded(animDict) do Citizen.Wait(10) end
                            TaskPlayAnim(ped, animDict, animName, 8.0, -8, -1, 49, 0, 0, 0, 0)
                        end)
                    end,
                },
                progressbar = {
                    enable = true,
                    progText = "Foulage du raisin...",
                    duration = 5000
                }
            },
            [3] = { --traitement 2
                coords = vector3(-1933.12, 2055.59, 140.81),
                zoneSize = 1.5,
                blip = {
                    showBlip = true,
                    blipName = "[3] Égrappage du raisin",
                    sprite = 148,
                    color = 83,
                    scale = 0.2,
                },
                marker = {
                    enable = false,
                    size  = { x = 0.7, y = 0.7, z = 0.4 },
                    color = { r = 204, g = 204, b = 0 },
                    type  = 2
                },
                draw3dtext = {
                    enable = true,
                    text = "[3] Égrappage du raisin",
                },
                item = {
                    process = "exchange",
                    
                    addCount = 1,
                    itemName = "raisin_egrappe",
                    
                    removeCount = 2,
                    requiredItem = "raisin_foule",
                },
                animation = {
                    enable = true,
                    animationFunction = function(ped)
                        animDict = "mp_car_bomb"
                        animName = "car_bomb_mechanic"
                        Citizen.CreateThread(function()
                            RequestAnimDict(animDict) 
                            while not HasAnimDictLoaded(animDict) do Citizen.Wait(10) end
                            TaskPlayAnim(ped, animDict, animName, 8.0, -8, -1, 49, 0, 0, 0, 0)
                        end)
                    end,
                },
                progressbar = {
                    enable = true,
                    progText = "Égrappage du raisin...",
                    duration = 10000
                }
            },
            [4] = { --traitement 3
                coords = vector3(-1932.65, 2058.48, 140.81),
                zoneSize = 1.5,
                blip = {
                    showBlip = true,
                    blipName = "[4] Macération et fermentation du raisin",
                    sprite = 148,
                    color = 83,
                    scale = 0.2,
                },
                marker = {
                    enable = false,
                    size  = { x = 0.7, y = 0.7, z = 0.4 },
                    color = { r = 204, g = 204, b = 0 },
                    type  = 2
                },
                draw3dtext = {
                    enable = true,
                    text = "[4] Macération et fermentation",
                },
                item = {
                    process = "exchange",

                    addCount = 2,
                    itemName = "raisin_fermente",

                    removeCount = 2,
                    requiredItem = "raisin_egrappe",
                },
                animation = {
                    enable = true,
                    animationFunction = function(ped)
                        animDict = "mp_car_bomb"
                        animName = "car_bomb_mechanic"
                        Citizen.CreateThread(function()
                            RequestAnimDict(animDict) 
                            while not HasAnimDictLoaded(animDict) do Citizen.Wait(10) end
                            TaskPlayAnim(ped, animDict, animName, 8.0, -8, -1, 49, 0, 0, 0, 0)
                        end)
                    end,
                },
                progressbar = {
                    enable = true,
                    progText = "Macération et fermentation du raisin...",
                    duration = 10000
                }
            },
            [5] = { --traitement 4
                coords = vector3(-1869.18, 2055.68, 141),
                zoneSize = 1.7,
                blip = {
                    showBlip = true,
                    blipName = "[5] Écoulage et pressurage du raisin",
                    sprite = 148,
                    color = 83,
                    scale = 0.2,
                },
                marker = {
                    enable = false,
                    size  = { x = 0.7, y = 0.7, z = 0.4 },
                    color = { r = 204, g = 204, b = 0 },
                    type  = 2
                },
                draw3dtext = {
                    enable = true,
                    text = "[5] Écoulage et pressurage",
                },
                item = {
                    process = "exchange",

                    addCount = 2,
                    itemName = "raisin_presse",

                    removeCount = 2,
                    requiredItem = "raisin_fermente",
                },
                animation = {
                    enable = true,
                    animationFunction = function(ped)
                        animDict = "mp_car_bomb"
                        animName = "car_bomb_mechanic"
                        Citizen.CreateThread(function()
                            RequestAnimDict(animDict) 
                            while not HasAnimDictLoaded(animDict) do Citizen.Wait(10) end
                            TaskPlayAnim(ped, animDict, animName, 8.0, -8, -1, 49, 0, 0, 0, 0)
                        end)
                    end,
                },
                progressbar = {
                    enable = true,
                    progText = "Écoulage et pressurage du raisin...",
                    duration = 10000
                }
            },
            [6] = { --traitement 5
                coords = vector3(-1869.33, 2059.07, 141),
                zoneSize = 1.7,
                blip = {
                    showBlip = true,
                    blipName = "[5-1] Écoulage et pressurage a moitié du raisin",
                    sprite = 148,
                    color = 83,
                    scale = 0.2,
                },
                marker = {
                    enable = false,
                    size  = { x = 0.7, y = 0.7, z = 0.4 },
                    color = { r = 204, g = 204, b = 0 },
                    type  = 2
                },
                draw3dtext = {
                    enable = true,
                    text = "[5-1] Écoulage et pressurage a moitié",
                },
                item = {
                    process = "exchange",

                    addCount = 2,
                    itemName = "raisin_demi_presse",

                    removeCount = 2,
                    requiredItem = "raisin_egrappe",
                },
                animation = {
                    enable = true,
                    animationFunction = function(ped)
                        animDict = "mp_car_bomb"
                        animName = "car_bomb_mechanic"
                        Citizen.CreateThread(function()
                            RequestAnimDict(animDict) 
                            while not HasAnimDictLoaded(animDict) do Citizen.Wait(10) end
                            TaskPlayAnim(ped, animDict, animName, 8.0, -8, -1, 49, 0, 0, 0, 0)
                        end)
                    end,
                },
                progressbar = {
                    enable = true,
                    progText = "Écoulage et pressurage a moitié du raisin...",
                    duration = 10000
                }
            },







            [7] = { --Mise en bouteille 1
                coords = vector3(-1860.62, 2067.41, 141),
                zoneSize = 1.5,
                blip = {
                    showBlip = true,
                    blipName = "[6-0] Mise en bouteille (Vin rouge)",
                    sprite = 148,
                    color = 83,
                    scale = 0.2,
                },
                marker = {
                    enable = false,
                    size  = { x = 0.7, y = 0.7, z = 0.4 },
                    color = { r = 204, g = 204, b = 0 },
                    type  = 2
                },
                draw3dtext = {
                    enable = true,
                    text = "[6-0] Mise en bouteille (Vin rouge)",
                },
                item = {
                    process = "package",

                    addCount = 1,
                    itemName = "vin_rouge",

                    removeCount = 2,
                    requiredItem = "raisin_presse", 
                },
                animation = {
                    enable = true,
                    animationFunction = function(ped)
                        animDict = "mp_car_bomb"
                        animName = "car_bomb_mechanic"
                        Citizen.CreateThread(function()
                            RequestAnimDict(animDict) 
                            while not HasAnimDictLoaded(animDict) do Citizen.Wait(10) end
                            TaskPlayAnim(ped, animDict, animName, 8.0, -8, -1, 49, 0, 0, 0, 0)
                        end)
                    end,
                },
                progressbar = {
                    enable = true,
                    progText = "Mise en bouteille (Vin rouge)...",
                    duration = 5000
                }
            },

            [8] = { --Mise en bouteille 2
                coords = vector3(-1864.26, 2067.43, 141),
                zoneSize = 1.5,
                blip = {
                    showBlip = true,
                    blipName = "[6-1] Mise en bouteille (Vin blanc)",
                    sprite = 148,
                    color = 83,
                    scale = 0.2,
                },
                marker = {
                    enable = false,
                    size  = { x = 0.7, y = 0.7, z = 0.4 },
                    color = { r = 204, g = 204, b = 0 },
                    type  = 2
                },
                draw3dtext = {
                    enable = true,
                    text = "[6-1] Mise en bouteille (Vin blanc)",
                },
                item = {
                    process = "package",

                    addCount = 1,
                    itemName = "vin_blanc",

                    removeCount = 2,
                    requiredItem = "raisin_demi_presse", 
                },
                animation = {
                    enable = true,
                    animationFunction = function(ped)
                        animDict = "mp_car_bomb"
                        animName = "car_bomb_mechanic"
                        Citizen.CreateThread(function()
                            RequestAnimDict(animDict) 
                            while not HasAnimDictLoaded(animDict) do Citizen.Wait(10) end
                            TaskPlayAnim(ped, animDict, animName, 8.0, -8, -1, 49, 0, 0, 0, 0)
                        end)
                    end,
                },
                progressbar = {
                    enable = true,
                    progText = "Mise en bouteille (Vin blanc)...",
                    duration = 5000
                }
            },

            [9] = { --Mise en bouteille 2
                coords = vector3(-1867.65, 2066.96, 141),
                zoneSize = 1.5,
                blip = {
                    showBlip = true,
                    blipName = "[6-2] Mise en bouteille (Rosé)",
                    sprite = 148,
                    color = 83,
                    scale = 0.2,
                },
                marker = {
                    enable = false,
                    size  = { x = 0.7, y = 0.7, z = 0.4 },
                    color = { r = 204, g = 204, b = 0 },
                    type  = 2
                },
                draw3dtext = {
                    enable = true,
                    text = "[6-2] Mise en bouteille (Rosé)",
                },
                item = {
                    process = "package",

                    addCount = 1,
                    itemName = "rose",

                    removeCount = 2,
                    requiredItem = "raisin_demi_presse", 
                },
                animation = {
                    enable = true,
                    animationFunction = function(ped)
                        animDict = "mp_car_bomb"
                        animName = "car_bomb_mechanic"
                        Citizen.CreateThread(function()
                            RequestAnimDict(animDict) 
                            while not HasAnimDictLoaded(animDict) do Citizen.Wait(10) end
                            TaskPlayAnim(ped, animDict, animName, 8.0, -8, -1, 49, 0, 0, 0, 0)
                        end)
                    end,
                },
                progressbar = {
                    enable = true,
                    progText = "Mise en bouteille (Rosé)...",
                    duration = 5000
                }
            },

            [10] = {
                coords = vector3(-447.87, -2805.75, 6.3),
                zoneSize = 2.5,
                blip = {
                    showBlip = true,
                    blipName = "Vente de rosé",
                    sprite = 148,
                    color = 83,
                    scale = 0.2,
                },
                marker = {
                    enable = false,
                    size  = { x = 0.7, y = 0.7, z = 0.4 },
                    color = { r = 204, g = 204, b = 0 },
                    type  = 2
                },
                draw3dtext = {
                    enable = true,
                    text = "Vente de rosé",
                },
                item = {
                    process = "sell", --dont touch
                    moneyType = "money",-- money, bank, black_money

                    removeCount = 1,
                    requiredItem = "rose",
                    price = 85
                },
                animation = {
                    enable = true,
                    animationFunction = function(ped)
                        animDict = "mp_car_bomb"
                        animName = "car_bomb_mechanic"
                        Citizen.CreateThread(function()
                            RequestAnimDict(animDict) while not HasAnimDictLoaded(animDict) do Citizen.Wait(10) end
                            TaskPlayAnim(ped, animDict, animName, 8.0, -8, -1, 49, 0, 0, 0, 0)
                        end)
                    end,
                },
                progressbar = {
                    enable = true,
                    progText = "Vente de rosé...",
                    duration = 2500
                }
            },

            [11] = {
                coords = vector3(-457.1, -2814.85, 6.3),
                zoneSize = 2.5,
                blip = {
                    showBlip = true,
                    blipName = "Vente de vin blanc",
                    sprite = 148,
                    color = 83,
                    scale = 0.2,
                },
                marker = {
                    enable = false,
                    size  = { x = 0.7, y = 0.7, z = 0.4 },
                    color = { r = 204, g = 204, b = 0 },
                    type  = 2
                },
                draw3dtext = {
                    enable = true,
                    text = "Vente de vin blanc",
                },
                item = {
                    process = "sell", --dont touch
                    moneyType = "money",-- money, bank, black_money

                    removeCount = 1,
                    requiredItem = "vin_blanc",
                    price = 85
                },
                animation = {
                    enable = true,
                    animationFunction = function(ped)
                        animDict = "mp_car_bomb"
                        animName = "car_bomb_mechanic"
                        Citizen.CreateThread(function()
                            RequestAnimDict(animDict) while not HasAnimDictLoaded(animDict) do Citizen.Wait(10) end
                            TaskPlayAnim(ped, animDict, animName, 8.0, -8, -1, 49, 0, 0, 0, 0)
                        end)
                    end,
                },
                progressbar = {
                    enable = true,
                    progText = "Vente de vin blanc...",
                    duration = 2500
                }
            },

            [12] = {
                coords = vector3(-475.03, -2832.95, 6.3),
                zoneSize = 2.5,
                blip = {
                    showBlip = true,
                    blipName = "Vente de vin rouge",
                    sprite = 148,
                    color = 83,
                    scale = 0.2,
                },
                marker = {
                    enable = false,
                    size  = { x = 0.7, y = 0.7, z = 0.4 },
                    color = { r = 204, g = 204, b = 0 },
                    type  = 2
                },
                draw3dtext = {
                    enable = true,
                    text = "Vente de vin rouge",
                },
                item = {
                    process = "sell", --dont touch
                    moneyType = "money",-- money, bank, black_money

                    removeCount = 1,
                    requiredItem = "vin_rouge",
                    price = 100
                },
                animation = {
                    enable = true,
                    animationFunction = function(ped)
                        animDict = "mp_car_bomb"
                        animName = "car_bomb_mechanic"
                        Citizen.CreateThread(function()
                            RequestAnimDict(animDict) while not HasAnimDictLoaded(animDict) do Citizen.Wait(10) end
                            TaskPlayAnim(ped, animDict, animName, 8.0, -8, -1, 49, 0, 0, 0, 0)
                        end)
                    end,
                },
                progressbar = {
                    enable = true,
                    progText = "Vente de vin rouge...",
                    duration = 2500
                }
            }
        },
    },
}