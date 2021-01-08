fx_version 'cerulean'
games { 'gta5' };

name 'RageUI';
description 'RageUI, and a project specially created to replace the NativeUILua-Reloaded library. This library allows to create menus similar to the one of Grand Theft Auto online.'

client_scripts {
    "RMenu.lua",
    "menu/RageUI.lua",
    "menu/Menu.lua",
    "menu/MenuController.lua",

    "components/*.lua",

    "menu/elements/*.lua",

    "menu/items/*.lua",

    "menu/panels/*.lua",

    "menu/windows/*.lua",

}


usage [[
    exports['Blip_info']:ResetBlipInfo(blip),
    exports['Blip_info']:SetBlipInfo(blip, infoData),
    exports['Blip_info']:SetBlipInfoTitle(blip, title, rockstarVerified),
    exports['Blip_info']:SetBlipInfoImage(blip, dict, tex),
    exports['Blip_info']:SetBlipInfoEconomy(blip, rp, money),
    exports['Blip_info']:AddBlipInfoText(blip, leftText, rightText),
    exports['Blip_info']:AddBlipInfoName(blip, leftText, rightText),
    exports['Blip_info']:AddBlipInfoHeader(blip, leftText, rightText),
    exports['Blip_info']:AddBlipInfoIcon(blip, leftText, rightText, iconId, iconColor, checked)
]]

export 'ResetBlipInfo'
export 'SetBlipInfo'
export 'SetBlipInfoTitle'
export 'SetBlipInfoImage'
export 'SetBlipInfoEconomy'
export 'AddBlipInfoText'
export 'AddBlipInfoName'
export 'AddBlipInfoHeader'
export 'AddBlipInfoIcon'