main()
{
    level.weaponmenu = getCvar("scr_weapon_menu");

    if(level.weaponmenu == "all") // Weapon from Axis and Allies
    {
        game["menu_weapon_allies"] = "weapon_" + game["allies"] + game["axis"];
	    game["menu_weapon_axis"] = "weapon_" + game["allies"] + game["axis"];
    } else if(level.weaponmenu == "bolt") // Bolt weapons only
    {
        game["menu_weapon_allies"] = "weapon_bolt";
	    game["menu_weapon_axis"] = "weapon_bolt";
    } else if(level.weaponmenu == "normal") // Weapon Axis and allies
    {
        game["menu_weapon_allies"] = "weapon_" + game["allies"];
	    game["menu_weapon_axis"] = "weapon_" + game["axis"];
    }
}