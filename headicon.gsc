precache()
{
    if(game["allies"] == "american")
    {
        game["headicon_allies"] = "gfx/hud/headicon@american.tga";
		precacheHeadIcon(game["headicon_allies"]);
    } else if(game["allies"] == "russian")
    {
        game["headicon_allies"] = "gfx/hud/headicon@russian.tga";
		precacheHeadIcon(game["headicon_allies"]);
    } else if(game["allies"] == "british")
    {
        game["headicon_allies"] = "gfx/hud/headicon@british.tga";
		precacheHeadIcon(game["headicon_allies"]);
    }

    game["headicon_axis"] = "gfx/hud/headicon@german.tga";
	precacheHeadIcon(game["headicon_axis"]); 
}