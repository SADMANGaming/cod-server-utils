/*precache()
{
    precacheShader("");
}
*/
statshud(level)
{
    self.StatsHud = newClientHudElem(self);
    self.StatsHud.x = 272;
    self.StatsHud.y = 58;
    self.StatsHud.alignX = "left";
    self.StatsHud.alignY = "middle";
    self.StatsHud.fontScale = 2;

    switch(level)
    {
        case "first":
	    self.StatsHud setShader( "gfx/hud/stats/first.dds", 30, 30 );
        break;

        case "normal":
	    self.StatsHud setShader( "gfx/hud/stats/normal.dds", 30, 30 );
        break;

        case "double":
	    self.StatsHud setShader( "gfx/hud/stats/double.dds", 30, 30 );
        break;

        case "unstop":
    	self.StatsHud setShader( "gfx/hud/stats/unstop.dds", 30, 30 );
        break;

        case "nuke":
    	self.StatsHud setShader( "gfx/hud/stats/nuke.dds", 30, 30 );
        break;
    }
}

destroystats()
{
    if(isDefined(self.StatsHud))
        self.StatsHud destroy();
}
