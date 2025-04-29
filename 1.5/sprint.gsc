precache()
{
    precacheShader("gfx/hud/hud@health_back.dds");
    precacheShader("gfx/hud/hud@health_bar.dds");

    level.sprintSpeed = getCvarInt("scr_sprint_speed");          // Sprint speed
    level.walkSpeed = getCvarInt("scr_sprint_walk");            // Normal walking speed
    level.sprintDuration = getCvarInt("scr_sprint_duration"); ;         // Total sprint duration in seconds
    level.maxSprintEnergy = level.sprintDuration; // Maximum sprint energy
    level.sprintRegenRate = getCvarInt("scr_sprint_regenrate"); ;        // Sprint regeneration rate per second
}

sprint_start()
{
    if(getCvar("scr_sprint") == "1"){
    
    self endon("disconnect");

    // Create HUD background element
    self.sprintHudBg = newClientHudElem(self);
    self.sprintHudBg.x = 630;
    self.sprintHudBg.y = 454;
    self.sprintHudBg.alignX = "right";
    self.sprintHudBg.alignY = "middle";
//    self.sprintHudBg.color = (0, 0, 0.5);  // Darker background
    self.sprintHudBg setShader("gfx/hud/hud@health_back.dds", 128 + 2, 6);

    // Create sprint HUD bar element
    self.sprintHud = newClientHudElem(self);
    self.sprintHud.x = 629;
    self.sprintHud.y = 455;
    self.sprintHud.alignX = "right";
    self.sprintHud.alignY = "middle";
    self.sprintHud.color = (0, 0, 1);  // Bright blue color for sprint bar
    self.sprintHud setShader("gfx/hud/hud@health_bar.dds", 128, 3);

    self.sprintEnergy = level.maxSprintEnergy;
    self.isSprinting = false;
    self thread sprintRegen();

    debug::debug("Sprint Loaded - HUD", "sprint::sprint_start");
    }
}

monitorSprint()
{
    if(getCvar("scr_sprint") == "1"){
    self endon("disconnect");
    self thread sprint_start();

    while(1)
    {
        if(self useButtonPressed() && self.sprintEnergy > 0 && !self backButtonPressed() && self getStance() == "stand" && !self sameangles())
        {
            self setSpeed(level.sprintSpeed);
            self.isSprinting = true;
        }
        else
        {
            self setSpeed(level.walkSpeed);
            self.isSprinting = false;
        }

        if(self.isSprinting && self.sprintEnergy > 0)
        {
            self.sprintEnergy -= 0.05;
            if(self.sprintEnergy < 0)
                self.sprintEnergy = 0;
        }

        // Update HUD width based on sprint energy
        if(isDefined(self.sprintHud))
        {
            self.sprintHud setShader("gfx/hud/hud@health_bar.dds", (self.sprintEnergy / level.maxSprintEnergy) * 128, 3);
        }
        wait 0.05;
    }
  }
}

sprintRegen()
{
    self endon("disconnect");
    while(1)
    {
        if(!self.isSprinting && self.sprintEnergy < level.maxSprintEnergy)
        {
            self.sprintEnergy += level.sprintRegenRate * 0.05;
            if(self.sprintEnergy > level.maxSprintEnergy)
                self.sprintEnergy = level.maxSprintEnergy;
        }
        wait .5;
    }
}

sameangles()
{
    currentorigin = self.origin;

    wait .3;
    neworigin = self.origin;

    if(currentorigin == neworigin)
    {
        return true;
    } else {
        return false;
    }
}

destroyhud()
{
    if(isDefined(self.sprintHud))
    {
        self.sprintHud destroy();
    }
    
    if(isDefined(self.sprintHudBg))
    {
        self.sprintHudBg destroy();
    }
}



lc1startgtsprint()
{
    level.hud_sprint_bar_maxWidth = 95;
    level.hud_sprint_bar_height = 10;
    level.hud_sprint_bar_x = 144;
    level.hud_sprint_bar_y = 461.5;
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



