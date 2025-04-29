removeitems()
{
    if(getCvar("scr_remove_placed_items") == "1")
    {
        maps\mp\gametypes\_teams::deletePlacedEntity("mpweapon_m1carbine");
        maps\mp\gametypes\_teams::deletePlacedEntity("mpweapon_m1garand");
        maps\mp\gametypes\_teams::deletePlacedEntity("mpweapon_thompson");
        maps\mp\gametypes\_teams::deletePlacedEntity("mpweapon_bar");

        maps\mp\gametypes\_teams::deletePlacedEntity("mpweapon_springfield");
        maps\mp\gametypes\_teams::deletePlacedEntity("mpweapon_enfield");
        maps\mp\gametypes\_teams::deletePlacedEntity("mpweapon_sten");
        maps\mp\gametypes\_teams::deletePlacedEntity("mpweapon_bren");

        maps\mp\gametypes\_teams::deletePlacedEntity("mpweapon_mosinnagant");
        maps\mp\gametypes\_teams::deletePlacedEntity("mpweapon_ppsh");
        maps\mp\gametypes\_teams::deletePlacedEntity("mpweapon_mosinnagantsniper");

        maps\mp\gametypes\_teams::deletePlacedEntity("mpweapon_kar98k");
        maps\mp\gametypes\_teams::deletePlacedEntity("mpweapon_mp40");
        maps\mp\gametypes\_teams::deletePlacedEntity("mpweapon_mp44");
        maps\mp\gametypes\_teams::deletePlacedEntity("mpweapon_kar98ksniper");

        maps\mp\gametypes\_teams::deletePlacedEntity("mpweapon_fg42");
        maps\mp\gametypes\_teams::deletePlacedEntity("mpweapon_panzerfaust");
    }
}