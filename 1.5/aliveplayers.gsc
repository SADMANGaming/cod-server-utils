hud_alivePlayers_create()
{
    level endon("intermission");
    
    hud_enemies_y = 8;
    hud_vs_y = hud_enemies_y + 18;
    hud_friends_y = hud_vs_y + 11;

    hud_enemies_color = (1, 0, 0);
    hud_friends_color = (0, 1, 0);

    hud_enemies_fontScale = 1.6;
    hud_friends_fontScale = 1.1;

    vs = &"VS";
    
    // Allies and Axis vs
    level.hud_alivePlayers_vs = [];
    level.hud_alivePlayers_vs[level.hud_alivePlayers_vs.size] = newTeamHudElem("allies");
    level.hud_alivePlayers_vs[level.hud_alivePlayers_vs.size] = newTeamHudElem("axis");
    for (i = 0; i < level.hud_alivePlayers_vs.size; i++)
    {
        level.hud_alivePlayers_vs[i].alignX = "center";
        level.hud_alivePlayers_vs[i].alignY = "middle";
        level.hud_alivePlayers_vs[i].x = 320;
        level.hud_alivePlayers_vs[i].y = hud_vs_y;
        level.hud_alivePlayers_vs[i].fontScale = 0.7;
        level.hud_alivePlayers_vs[i] setText(vs);
    }
    
    if (level.gametype != "dm")
    {
        // Spectator' vs
        level.hud_alivePlayers_spectator_vs = newTeamHudElem("spectator");
        level.hud_alivePlayers_spectator_vs.alignX = "center";
        level.hud_alivePlayers_spectator_vs.alignY = "middle";
        level.hud_alivePlayers_spectator_vs.x = 320;
        level.hud_alivePlayers_spectator_vs.y = 12;
        level.hud_alivePlayers_spectator_vs.fontScale = 0.8;
        level.hud_alivePlayers_spectator_vs setText(vs);

        // Spectator' allies
        level.hud_alivePlayers_spectator_allies = newTeamHudElem("spectator");
        level.hud_alivePlayers_spectator_allies.alignX = "left";
        level.hud_alivePlayers_spectator_allies.alignY = "middle";
        level.hud_alivePlayers_spectator_allies.x = level.hud_alivePlayers_spectator_vs.x - 80;
        level.hud_alivePlayers_spectator_allies.y = 12;
        level.hud_alivePlayers_spectator_allies.fontScale = 1.2;
        level.hud_alivePlayers_spectator_allies.label = &"Allies: ";

        // Spectator' axis
        level.hud_alivePlayers_spectator_axis = newTeamHudElem("spectator");
        level.hud_alivePlayers_spectator_axis.alignX = "right";
        level.hud_alivePlayers_spectator_axis.alignY = "middle";
        level.hud_alivePlayers_spectator_axis.x = level.hud_alivePlayers_spectator_vs.x + 80 - 6;
        level.hud_alivePlayers_spectator_axis.y = 12;
        level.hud_alivePlayers_spectator_axis.fontScale = 1.2;
        level.hud_alivePlayers_spectator_axis.label = &"Axis: ";
    }

    // Unable to retrieve hud team after creation, so do 1 by 1 for now
    
    // Allies' friends
    level.hud_alivePlayers_allies_allies = newTeamHudElem("allies");
    level.hud_alivePlayers_allies_allies.alignX = "center";
    level.hud_alivePlayers_allies_allies.alignY = "middle";
    level.hud_alivePlayers_allies_allies.x = 320;
    level.hud_alivePlayers_allies_allies.y = hud_friends_y;
    level.hud_alivePlayers_allies_allies.fontScale = hud_friends_fontScale;
    level.hud_alivePlayers_allies_allies.color = hud_friends_color;

    // Allies' enemies
    level.hud_alivePlayers_allies_axis = newTeamHudElem("allies");
    level.hud_alivePlayers_allies_axis.alignX = "center";
    level.hud_alivePlayers_allies_axis.alignY = "middle";
    level.hud_alivePlayers_allies_axis.x = 320;
    level.hud_alivePlayers_allies_axis.y = hud_enemies_y;
    level.hud_alivePlayers_allies_axis.fontScale = hud_enemies_fontScale;
    level.hud_alivePlayers_allies_axis.color = hud_enemies_color;

    // Axis' friends
    level.hud_alivePlayers_axis_axis = newTeamHudElem("axis");
    level.hud_alivePlayers_axis_axis.alignX = "center";
    level.hud_alivePlayers_axis_axis.alignY = "middle";
    level.hud_alivePlayers_axis_axis.x = 320;
    level.hud_alivePlayers_axis_axis.y = hud_friends_y;
    level.hud_alivePlayers_axis_axis.fontScale = hud_friends_fontScale;
    level.hud_alivePlayers_axis_axis.color = hud_friends_color;

    // Axis' enemies
    level.hud_alivePlayers_axis_allies = newTeamHudElem("axis");
    level.hud_alivePlayers_axis_allies.alignX = "center";
    level.hud_alivePlayers_axis_allies.alignY = "middle";
    level.hud_alivePlayers_axis_allies.x = 320;
    level.hud_alivePlayers_axis_allies.y = hud_enemies_y;
    level.hud_alivePlayers_axis_allies.fontScale = hud_enemies_fontScale;
    level.hud_alivePlayers_axis_allies.color = hud_enemies_color;

    for(;;)
    {
        aliveAllies = getTeamPlayersAlive("allies");
        aliveAxis = getTeamPlayersAlive("axis");
        
        level.hud_alivePlayers_allies_allies setValue(aliveAllies);
        level.hud_alivePlayers_allies_axis setValue(aliveAxis);

        level.hud_alivePlayers_axis_axis setValue(aliveAxis);
        level.hud_alivePlayers_axis_allies setValue(aliveAllies);

        if (level.gametype != "dm")
        {
            level.hud_alivePlayers_spectator_allies setValue(aliveAllies);
            level.hud_alivePlayers_spectator_axis setValue(aliveAxis);
        }

        wait .05;
    }
}
hud_alivePlayers_destroy()
{
    // Allies and Axis vs
    if(isDefined(level.hud_alivePlayers_vs))
        for(i = 0; i < level.hud_alivePlayers_vs.size; i++)
            if(isDefined(level.hud_alivePlayers_vs[i]))
                level.hud_alivePlayers_vs[i] destroy();

    // Spectator
    if(isDefined(level.hud_alivePlayers_spectator_vs))
        level.hud_alivePlayers_spectator_vs destroy();
    if(isDefined(level.hud_alivePlayers_spectator_allies))
        level.hud_alivePlayers_spectator_allies destroy();
    if(isDefined(level.hud_alivePlayers_spectator_axis))
        level.hud_alivePlayers_spectator_axis destroy();

    // Allies
    if(isDefined(level.hud_alivePlayers_allies_allies))
        level.hud_alivePlayers_allies_allies destroy();
    if(isDefined(level.hud_alivePlayers_allies_axis))
        level.hud_alivePlayers_allies_axis destroy();

    // Axis
    if(isDefined(level.hud_alivePlayers_axis_axis))
        level.hud_alivePlayers_axis_axis destroy();
    if(isDefined(level.hud_alivePlayers_axis_allies))
        level.hud_alivePlayers_axis_allies destroy();
}