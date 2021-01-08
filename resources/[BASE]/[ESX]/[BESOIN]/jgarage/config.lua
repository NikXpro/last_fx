Config = {}

Config.VehicleMenu = false -- enable this if you wan't a vehicle menu.
Config.VehicleMenuButton = 344 -- change this to the key you want to open the menu with. buttons: https://docs.fivem.net/game-references/controls/
Config.RangeCheck = 10.0 -- this is the change you will be able to control the vehicle.

Config.Garages = {
    ["A"] = {
        ["positions"] = {
            ["menu"] = {
                ["position"] = vector3(-88.111, -815.386, 36.068)
            },
            ["vehicle"] = {
                ["position"] = vector3(-84.113, -821.905, 36.208), 
                ["heading"] = 346.439758
            }   
        },
        ["camera"] = {  -- camera is not needed just if you want cool effects.
            ["x"] = -82.991, 
            ["y"] = -813.637, 
            ["z"] = 36.192, 
            ["rotationX"] = 0.0, 
            ["rotationY"] = 0.0, 
            ["rotationZ"] = -180.0 
        }
    },

    ["B"] = {
        ["positions"] = {
            ["menu"] = {
                ["position"] = vector3(273.67422485352, -344.15573120117, 44.919834136963)
            },
            ["vehicle"] = {
                ["position"] = vector3(272.50082397461, -337.40579223633, 44.919834136963), 
                ["heading"] = 160.0
            }
        },
        ["camera"] = { 
            ["x"] = 283.28225708008, 
            ["y"] = -333.24017333984, 
            ["z"] = 50.004745483398, 
            ["rotationX"] = -21.637795701623, 
            ["rotationY"] = 0.0, 
            ["rotationZ"] = 125.73228356242 
        }
    },

    ["C"] = {
        ["positions"] = {
            ["menu"] = {
                ["position"] = vector3(-1878.8, -312.32, 49.24)
            },
            ["vehicle"] = {
                ["position"] = vector3(-1879.72, -307.88, 49.24), 
                ["heading"] = 45.44
            }
        },
        ["camera"] = { 
            ["x"] = -1882.88, 
            ["y"] = -302.05, 
            ["z"] = 51.13, 
            ["rotationX"] = -30.496062710881, 
            ["rotationY"] = 0.0, 
            ["rotationZ"] = -155.110235854983 
        }
    }
}

Config.Labels = {
    ["menu"] = "~INPUT_CONTEXT~ Ouvrir le garage %s.",
    ["vehicle"] = "~INPUT_CONTEXT~ Remettre '%s' à votre garage."
}

Config.Trim = function(value)
	if value then
		return (string.gsub(value, "^%s*(.-)%s*$", "%1"))
	else
		return nil
	end
end

Config.AlignMenu = "left" -- this is where the menu is located [left, right, center, top-right, top-left etc.]