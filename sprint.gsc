precache()
{
    precacheShader("white");
}

main()
{
    level.hud_sprint_bar_maxWidth = 95;
    level.hud_sprint_bar_height = 10;
    level.hud_sprint_bar_x = 144;
    level.hud_sprint_bar_y = 461.5;
}

lc1startgtsprint()
{

    sprintMinTime = getCvarFloat("player_sprintMinTime");
    if(sprintMinTime != "")
        hud_sprint_info(sprintMinTime);
}

hud_sprintBar_create()
{
    if(isDefined(self.hud_sprint_bar))
        return;
    
    level endon("intermission");
    self endon("hud_sprintBar_destroy");
    
    self.hud_sprint_bar = newClientHudElem(self);
    self.hud_sprint_bar.sort = -1;
    self.hud_sprint_bar.x = level.hud_sprint_bar_x;
    self.hud_sprint_bar.y = level.hud_sprint_bar_y;
    self.hud_sprint_bar.color = (1, 1, 1);

    if(!getCvarInt("player_sprint"))
        return;
    sprintMaxTime = getCvarFloat("player_sprintTime");
    if(sprintMaxTime == "")
        return;
    sprintMaxTime *= 1000;
    
    for(;;)
    {
        remainingSprintTime = self getSprintRemaining();
        bar_width = (remainingSprintTime * level.hud_sprint_bar_maxWidth) / sprintMaxTime;
        if (isDefined(self.hud_sprint_bar))
        {
            if (bar_width < 1)
            {
                // Setting width to 0 makes width positive for a short time, so hiding.
                self.hud_sprint_bar.alpha = 0;
            }
            else
                self.hud_sprint_bar.alpha = 0.85;
            self.hud_sprint_bar setShader("white", (int)bar_width, level.hud_sprint_bar_height);
        }
        wait .05;
    }
}
hud_sprintBar_destroy()
{
    self notify("hud_sprintBar_destroy");
    if(isDefined(self.hud_sprint_bar))
        self.hud_sprint_bar destroy();
}
hud_sprint_info(minTime)
{
    if(!getCvarInt("player_sprint"))
        return;
        
    
    level.hud_sprint_bar_background = newHudElem();
    level.hud_sprint_bar_background.sort = -3;
    level.hud_sprint_bar_background.x = level.hud_sprint_bar_x;
    level.hud_sprint_bar_background.y = level.hud_sprint_bar_y;
    level.hud_sprint_bar_background.color = (0, 0, 0);
    level.hud_sprint_bar_background.alpha = 0.45;
    level.hud_sprint_bar_background setShader("white", level.hud_sprint_bar_maxWidth, level.hud_sprint_bar_height);
    
    sprintMaxTime = getCvarFloat("player_sprintTime");
    if(sprintMaxTime == "")
        return;
    sprintMaxTime *= 1000;
    minTime *= 1000;
    level.hud_sprint_bar_minTime = newHudElem();
    level.hud_sprint_bar_minTime.sort = -1;
    level.hud_sprint_bar_minTime.alpha = 0.85; // Didn't manage to make it disappear under hud_sprint_bar
    hud_sprint_bar_minTime_x = level.hud_sprint_bar_x + (int)((minTime / sprintMaxTime) * level.hud_sprint_bar_maxWidth);
    level.hud_sprint_bar_minTime.x = hud_sprint_bar_minTime_x;
    level.hud_sprint_bar_minTime.y = level.hud_sprint_bar_y;
    level.hud_sprint_bar_minTime.color = (1, 1, 1);
    level.hud_sprint_bar_minTime setShader("white", 2, level.hud_sprint_bar_height);
}
hud_sprint_info_destroy()
{
    if(isDefined(level.hud_sprint_bar_background))
        level.hud_sprint_bar_background destroy();
    if(isDefined(level.hud_sprint_bar_minTime))
        level.hud_sprint_bar_minTime destroy();
}
////