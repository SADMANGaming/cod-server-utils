
isInArray(array, element)
{
    for(i = 0; i < array.size; i++) {
        if(array[i] == element)
            return true;
    }
    return false;
}

strtok(str)
{
    return strtok(str);
}

monotone(str)
{
    return monotone(str);
}

substr(str)
{
    return substr(str);
}

savePlayerWeapons()
{
    // for all living players store their weapons
    players = getEntArray("player", "classname");
    for (i = 0; i < players.size; i++)
    {
        player = players[i];
        if (isdefined(player.pers["team"]) && player.pers["team"] != "spectator" && player.sessionstate == "playing")
        {
            primary = player getWeaponSlotWeapon("primary");
            primaryb = player getWeaponSlotWeapon("primaryb");

            // If a menu selection was made
            if (isdefined(player.oldweapon))
            {
                // If a new weapon has since been picked up (this fails when a player picks up a weapon the same as his original)
                if (player.oldweapon != primary && player.oldweapon != primaryb && primary != "none")
                {
                    player.pers["weapon1"] = primary;
                    player.pers["weapon2"] = primaryb;
                    player.pers["spawnweapon"] = player getCurrentWeapon();
                } // If the player's menu chosen weapon is the same as what is in the primaryb slot, swap the slots
                else if (player.pers["weapon"] == primaryb)
                {
                    player.pers["weapon1"] = primaryb;
                    player.pers["weapon2"] = primary;
                    player.pers["spawnweapon"] = player.pers["weapon1"];
                } // Give them the weapon they chose from the menu
                else
                {
                    player.pers["weapon1"] = player.pers["weapon"];
                    player.pers["weapon2"] = primaryb;
                    player.pers["spawnweapon"] = player.pers["weapon1"];
                }
            } // No menu choice was ever made, so keep their weapons and spawn them with what they're holding, unless it's a pistol or grenade
            else
            {
                if(primary == "none")
                    player.pers["weapon1"] = player.pers["weapon"];
                else
                    player.pers["weapon1"] = primary;
                    
                player.pers["weapon2"] = primaryb;

                spawnweapon = player getCurrentWeapon();
                if(!maps\mp\gametypes\_teams::isPistolOrGrenade(spawnweapon))
                    player.pers["spawnweapon"] = spawnweapon;
                else
                    player.pers["spawnweapon"] = player.pers["weapon1"];
            }
        }
    }
}