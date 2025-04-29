precache()
{
    precacheShader("gfx/hud/headicon@axis");
    precacheShader("gfx/hud/headicon@allies");
    level.myscoretext = makeLocalizedString("YOUR SCORE:");
}

makeHudScores()
{
    baseX = 628;
    baseY = 75;
    stepY = 14;
    

/*
    // Create total allies
    hudTotalAllies = newHudElem();
    hudTotalAllies.x = baseX - 36;
    hudTotalAllies.y = baseY + stepY * 3;
    hudTotalAllies.alignX = "center";
    hudTotalAllies.alignY = "middle";
    hudTotalAllies.fontScale = 1;
    hudTotalAllies.color = (1, 1, 0);  // Yellow color
    hudTotalAllies.sort = 10;

    // Create total axis
    hudTotalAxis = newHudElem();
    hudTotalAxis.x = baseX - 36;
    hudTotalAxis.y = baseY + stepY * 2;
    hudTotalAxis.alignX = "center";
    hudTotalAxis.alignY = "middle";
    hudTotalAxis.fontScale = 1;
    hudTotalAxis.color = (1, 1, 0);  // Yellow color
    hudTotalAxis.sort = 10;

    thread CountPlayers(hudTotalAxis, hudTotalAllies);
*/

    // Create axis team score HUD
    hudScoreAxis = newHudElem();
    hudScoreAxis.x = baseX;
    hudScoreAxis.y = baseY + stepY * 2;
    hudScoreAxis.alignX = "center";
    hudScoreAxis.alignY = "middle";
    hudScoreAxis.fontScale = 1;
    hudScoreAxis.color = (1, 1, 0);  // Yellow color
    hudScoreAxis.sort = 10;


    // Axis team icon
    hudIconAxis = newHudElem();
    hudIconAxis.x = baseX - 18;  // Slightly offset for the icon
    hudIconAxis.y = baseY + stepY * 2;
    hudIconAxis.alignX = "center";
    hudIconAxis.alignY = "middle";
    hudIconAxis setShader("gfx/hud/headicon@axis", 12, 12);  // Axis icon
    hudIconAxis.sort = 5;

    // Create allies team score HUD
    hudScoreAllies = newHudElem();
    hudScoreAllies.x = baseX;
    hudScoreAllies.y = baseY + stepY * 3;
    hudScoreAllies.alignX = "center";
    hudScoreAllies.alignY = "middle";
    hudScoreAllies.fontScale = 1;
    hudScoreAllies.color = (1, 1, 0);  // Yellow color
    hudScoreAllies.sort = 10;

    // Allies team icon
    hudIconAllies = newHudElem();
    hudIconAllies.x = baseX - 18;
    hudIconAllies.y = baseY + stepY * 3;
    hudIconAllies.alignX = "center";
    hudIconAllies.alignY = "middle";
    hudIconAllies setShader("gfx/hud/headicon@allies", 12, 12);  // Allies icon
    hudIconAllies.sort = 5;

    thread updateHudScores(hudScoreAxis, hudScoreAllies);
}

updateHudScores(hudScoreAxis, hudScoreAllies)
{
    while(1)
    {
        scoreAxis = getTeamScore("axis");
        hudScoreAxis setValue(scoreAxis);

        scoreAllies = getTeamScore("allies");
        hudScoreAllies setValue(scoreAllies);

        wait 0.5;
    }
}

CountPlayers(hudTotalAxis, hudTotalAllies)
{

    while(1)
    {
        players = getEntArray("player", "classname");
        allies = 0;
        axis = 0;
        for(i = 0; i < players.size; i++)
        {
            if((isdefined(players[i].pers["team"])) && (players[i].pers["team"] == "allies"))
                allies++;
            else if((isdefined(players[i].pers["team"])) && (players[i].pers["team"] == "axis"))
                axis++;
        }
        
        hudTotalAxis setValue(axis);
        hudTotalAllies setValue(allies);

        wait 0.5;
    }
}