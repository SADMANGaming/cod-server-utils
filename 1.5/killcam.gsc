killcam(attackerNum, delay)
{
    self endon("spawned");

	level.gametype = getCvar("g_gametype");

    if(level.gametype == "dm" || level.gametype == "tdm")
    {
        //previousorigin = self.origin;
        //previousangles = self.angles;
    }

    // killcam
/*
    if(attackerNum < 0)
        return;
*/
    if(attackerNum < 0)
    {
        attackerNum = self.entnum; // Set attackerNum to self to handle suicides
    }    

    self.sessionstate = "spectator";
    self.spectatorclient = attackerNum;
    self.archivetime = delay + 4;

    // wait till the next server frame to allow code a chance to update archivetime if it needs trimming
    wait 0.05;

    if(self.archivetime <= delay)
    {
        self.spectatorclient = -1;
        self.archivetime = 0;
        if(level.gametype == "dm" || level.gametype == "tdm")
        {
            self.sessionstate = "dead";

            if(level.gametype == "dm")
            {
                self thread maps\mp\gametypes\dm::respawn();
            }
            else if(level.gametype == "tdm")
            {
                self thread maps\mp\gametypes\tdm::respawn();
            }
        }

        return;
    }

    if(!isdefined(self.kc_topbar))
    {
        self.kc_topbar = newClientHudElem(self);
        self.kc_topbar.archived = false;
        self.kc_topbar.x = 0;
        self.kc_topbar.y = 0;
        self.kc_topbar.alpha = 0.5;
        self.kc_topbar setShader("black", 640, 112);
    }

    if(!isdefined(self.kc_bottombar))
    {
        self.kc_bottombar = newClientHudElem(self);
        self.kc_bottombar.archived = false;
        self.kc_bottombar.x = 0;
        self.kc_bottombar.y = 368;
        self.kc_bottombar.alpha = 0.5;
        self.kc_bottombar setShader("black", 640, 112);
    }

    if(!isdefined(self.kc_title))
    {
        self.kc_title = newClientHudElem(self);
        self.kc_title.archived = false;
        self.kc_title.x = 320;
        self.kc_title.y = 60;
        self.kc_title.alignX = "center";
        self.kc_title.alignY = "middle";
        self.kc_title.sort = 1; // force to draw after the bars
        self.kc_title.fontScale = 2.5;
    }
    self.kc_title setText(&"MPSCRIPT_KILLCAM");

    if(!isdefined(self.kc_skiptext))
    {
        self.kc_skiptext = newClientHudElem(self);
        self.kc_skiptext.archived = false;
        self.kc_skiptext.x = 320;
        self.kc_skiptext.y = self.kc_title.y + 30;
        self.kc_skiptext.alignX = "center";
        self.kc_skiptext.alignY = "middle";
        self.kc_skiptext.sort = 1; // force to draw after the bars
    }
    if(level.gametype == "dm" || level.gametype == "tdm" || level.gametype == "bel")
    {
        self.kc_skiptext setText(&"MPSCRIPT_PRESS_ACTIVATE_TO_RESPAWN");
    }
    else
    {
        self.kc_skiptext setText(&"MPSCRIPT_PRESS_ACTIVATE_TO_SKIP");
    }

    if(!isdefined(self.kc_timer))
    {
        self.kc_timer = newClientHudElem(self);
        self.kc_timer.archived = false;
        self.kc_timer.x = 320;
        self.kc_timer.y = 435;
        self.kc_timer.alignX = "center";
        self.kc_timer.alignY = "middle";
        self.kc_timer.fontScale = 2;
        self.kc_timer.sort = 1;
    }
    self.kc_timer setTenthsTimer(self.archivetime - delay);

    self thread spawnedKillcamCleanup();
    self thread waitSkipKillcamButton();
    self thread waitKillcamTime();
    self waittill("end_killcam");

    self removeKillcamElements();

    self.spectatorclient = -1;
    self.archivetime = 0;
    //if(level.gametype == "dm" || level.gametype == "tdm")
    //{
        self.sessionstate = "dead";
    //}

    if(level.gametype == "dm")
    {
        //self thread spawnSpectator(previousorigin + (0, 0, 60), previousangles);
        self thread maps\mp\gametypes\dm::respawn();
    }
    else if(level.gametype == "tdm")
    {
        //self thread spawnSpectator(previousorigin + (0, 0, 60), previousangles);
        self thread maps\mp\gametypes\tdm::respawn();
    }
}

waitKillcamTime()
{
    self endon("end_killcam");
    
    wait (self.archivetime - 0.05);
    self notify("end_killcam");
}

waitSkipKillcamButton()
{
    self endon("end_killcam");
    
    while(self useButtonPressed())
        wait .05;

    while(!(self useButtonPressed()))
        wait .05;
    
    self notify("end_killcam");	
}

removeKillcamElements()
{
    if(isdefined(self.kc_topbar))
        self.kc_topbar destroy();
    if(isdefined(self.kc_bottombar))
        self.kc_bottombar destroy();
    if(isdefined(self.kc_title))
        self.kc_title destroy();
    if(isdefined(self.kc_skiptext))
        self.kc_skiptext destroy();
    if(isdefined(self.kc_timer))
        self.kc_timer destroy();
}

spawnedKillcamCleanup()
{
    self endon("end_killcam");

    self waittill("spawned");
    self removeKillcamElements();
}







/*
killcam( attacker, delay )
{
	level endon( "intermission" );
	self endon( "spawned" );

	if ( isdefined( level.roundended ) && level.roundended )
		return;

	self.killcam = true;

	if ( !isPlayer( attacker ) )
		attacker = self;

	// Save starting (dead) position
	_origin = self.origin;
	_angles = self.angles;

	self.sessionstate = "spectator";
	self.spectatorclient = attacker getEntityNumber();
	self.archivetime = delay + 7;

	// Allow game to update archive in case it needs trimming
	wait( 0.05 );

	if ( self.archivetime <= delay )
	{
		// Not enough archived?
		self.spectatorclient = -1;
		self.archivetime = 0;
		self.sessionstate = "dead";
		self.killcam = undefined;
		level notify( "killcam_ended" );
		return;
	}

	// Draw top bar
	if ( !isdefined( self.kc_topbar ) )
	{
		self.kc_topbar = newClientHudElem( self );
		self.kc_topbar.archived = false;
		self.kc_topbar.x = 0;
		self.kc_topbar.y = 0;
		self.kc_topbar.alpha = 0.5;
		self.kc_topbar setShader( "black", 640, 112 );
	}

	// Draw bottom bar
	if ( !isdefined( self.kc_bottombar ) )
	{
		self.kc_bottombar = newClientHudElem( self );
		self.kc_bottombar.archived = false;
		self.kc_bottombar.x = 0;
		self.kc_bottombar.y = 368;
		self.kc_bottombar.alpha = 0.5;
		self.kc_bottombar setShader( "black", 640, 112 );
	}

	// Tell player what this is
	if ( !isdefined( self.kc_title ) )
	{
		self.kc_title = newClientHudElem( self );
		self.kc_title.archived = false;
		self.kc_title.x = 320;
		self.kc_title.y = 40;
		self.kc_title.alignX = "center";
		self.kc_title.alignY = "middle";
		self.kc_title.sort = 1; // force to draw after the bars
		self.kc_title.fontScale = 3.5;
	}
	self.kc_title setText( &"MPSCRIPT_KILLCAM" );

	// Tell player how to skip killcam
	if ( !isdefined( self.kc_skiptext ) )
	{
		self.kc_skiptext = newClientHudElem( self );
		self.kc_skiptext.archived = false;
		self.kc_skiptext.x = 320;
		self.kc_skiptext.y = 70;
		self.kc_skiptext.alignX = "center";
		self.kc_skiptext.alignY = "middle";
		self.kc_skiptext.sort = 1; // force to draw after the bars
	}
	self.kc_skiptext setText(&"MPSCRIPT_PRESS_ACTIVATE_TO_RESPAWN");

	// Place a countdown timer
	if ( !isdefined( self.kc_timer ) )
	{
		self.kc_timer = newClientHudElem( self );
		self.kc_timer.archived = false;
		self.kc_timer.x = 320;
		self.kc_timer.y = 428;
		self.kc_timer.alignX = "center";
		self.kc_timer.alignY = "middle";
		self.kc_timer.fontScale = 3.5;
		self.kc_timer.sort = 1;
	}

	if ( self.archivetime > delay )
	{
		self.kc_timer setTenthsTimer( self.archivetime - delay );

		// Setup ways to end killcam
		self thread spawnedKillcamCleanup();
		self thread waitSkipKillcamButton();
		self thread waitKillcamTime();

		// Wait for killcam end
		self waittill( "end_killcam" );
	}

	self removeKillcamElements();

	self.spectatorclient = -1;
	self.archivetime = 0;
	self.sessionstate = "dead";
	self.killcam = undefined;

	// Restore location ...
	wait( 0.05 );	// Server crashes without this!!!!
	self setOrigin( _origin );
	self.angles = _angles;


    // SHit heck moment xd
	self.kc_skiptext2 = newClientHudElem(self);
	self.kc_skiptext2.archived = false;
	self.kc_skiptext2.x = 320;
	self.kc_skiptext2.y = 70;
	self.kc_skiptext2.alignX = "center";
	self.kc_skiptext2.alignY = "middle";
	self.kc_skiptext2.sort = 1; // force to draw after the bars
	self.kc_skiptext2 setText(&"MPSCRIPT_PRESS_ACTIVATE_TO_RESPAWN");

	while(1){
		if(self useButtonPressed() && !isAlive(self))
		{
			switch(level.gametype)
			{
				case "tdm":
				self thread maps\mp\gametypes\tdm::respawn();
				break;

				case "dm":
				self thread maps\mp\gametypes\dm::respawn();
				break;
			}
		}
		wait .1;
	}
	
	level notify( "killcam_ended" );
	return;
}

waitKillcamTime()
{
	// End killcam after delay
	self endon( "end_killcam" );
	if ( self.archivetime > 0.05 )
		wait( self.archivetime - 0.05 );
	else
		wait( 0.05 );
	self notify( "end_killcam" );
	return;
}

waitSkipKillcamButton()
{
	self endon( "end_killcam" );
	while ( self useButtonPressed())
		wait 0.05;

	while (!( self useButtonPressed()))
		wait 0.05;

    self maps\mp\gametypes\tdm::spawnPlayer();
	self notify( "end_killcam" );
}

removeKillcamElements()
{
	if ( isdefined( self.kc_topbar ) )
		self.kc_topbar destroy();
	if ( isdefined( self.kc_bottombar ) )
		self.kc_bottombar destroy();
	if ( isdefined( self.kc_title ) )
		self.kc_title destroy();
	if ( isdefined( self.kc_skiptext ) )
		self.kc_skiptext destroy();
	if ( isdefined( self.kc_timer ) )
		self.kc_timer destroy();
	return;
}

spawnedKillcamCleanup()
{
	self endon( "end_killcam" );
	self waittill( "spawned" );
	self removeKillcamElements();
	return;
}
*/

///////////////////////////////////////////////////////////////////////////////////////////////////////

roundcam_level(timeWaitedBeforeRoundcam, winningteam, videoDurationBeforeKill)
{
    if (!isdefined(level.kc_topbar))
    {
        level.kc_topbar = newHudElem();
        level.kc_topbar.archived = false;
        level.kc_topbar.x = 0;
        level.kc_topbar.y = 0;
        level.kc_topbar.alpha = 0.5;
        level.kc_topbar setShader("black", 640, 112);
    }

    if (!isdefined(level.kc_bottombar))
    {
        level.kc_bottombar = newHudElem();
        level.kc_bottombar.archived = false;
        level.kc_bottombar.x = 0;
        level.kc_bottombar.y = 368;
        level.kc_bottombar.alpha = 0.5;
        level.kc_bottombar setShader("black", 640, 112);
    }

    if (!isdefined(level.kc_title))
    {
        level.kc_title = newHudElem();
        level.kc_title.archived = false;
        level.kc_title.x = 320;
        level.kc_title.y = 60;
        level.kc_title.alignX = "center";
        level.kc_title.alignY = "middle";
        level.kc_title.sort = 1; // force to draw after the bars
        level.kc_title.fontScale = 2.5;
    }

    if(winningteam == "allies")
        level.kc_title setText(&"MPSCRIPT_ALLIES_WIN");
    else if(winningteam == "axis")
        level.kc_title setText(&"MPSCRIPT_AXIS_WIN");
    else
        level.kc_title setText(&"MPSCRIPT_ROUNDCAM");
    
    if (!isdefined(level.kc_skiptext))
    {
        level.kc_skiptext = newHudElem();
        level.kc_skiptext.archived = false;
        level.kc_skiptext.x = 320;
        level.kc_skiptext.y = level.kc_title.y + 30;
        level.kc_skiptext.alignX = "center";
        level.kc_skiptext.alignY = "middle";
        level.kc_skiptext.sort = 1; // force to draw after the bars
    }
    if(game["alliedscore"] < level.scorelimit && game["axisscore"] < level.scorelimit)
        level.kc_skiptext setText(&"MPSCRIPT_STARTING_NEW_ROUND");

    if (!isdefined(level.kc_timer))
    {
        level.kc_timer = newHudElem();
        level.kc_timer.archived = false;
        level.kc_timer.x = 320;
        level.kc_timer.y = 435;
        level.kc_timer.alignX = "center";
        level.kc_timer.alignY = "middle";
        level.kc_timer.fontScale = 2;
        level.kc_timer.sort = 1;
    }
    level.kc_timer setTenthsTimer(videoDurationBeforeKill);

    level thread spawnedKillcamCleanup_rc();
    wait (timeWaitedBeforeRoundcam + videoDurationBeforeKill);
    level removeKillcamElements_rc();

    level notify("roundcam_ended");
}

roundcam_client(timeWaitedBeforeRoundcam, videoDurationBeforeKill)
{
	if(level.gametype == "sd")
	{
		maps\mp\gametypes\sd::spawnSpectator();
	}
//	else if(level.gametype == "re")
//	{
//		maps\mp\gametypes\re::spawnSpectator();
//	}

    if (level.gametype == "sd")
    {
        if(isdefined(level.bombcam))
            self thread maps\mp\gametypes\sd::spawnSpectator(level.bombcam.origin, level.bombcam.angles);
        else
            self.spectatorclient = level.playercam;
    }
    else if (level.gametype == "re")
    {
        if(isdefined(level.goalcam))
            self thread maps\mp\gametypes\sd::spawnSpectator(level.goalcam.origin, level.goalcam.angles);
        else
            self.spectatorclient = level.playercam;
    }

    self.archivetime = timeWaitedBeforeRoundcam + videoDurationBeforeKill;
    wait (self.archivetime);
    self.spectatorclient = -1;
    self.archivetime = 0;
}
removeKillcamElements_rc()
{
    if(isdefined(level.kc_topbar))
        level.kc_topbar destroy();
    if(isdefined(level.kc_bottombar))
        level.kc_bottombar destroy();
    if(isdefined(level.kc_title))
        level.kc_title destroy();
    if(isdefined(level.kc_skiptext))
        level.kc_skiptext destroy();
    if(isdefined(level.kc_timer))
        level.kc_timer destroy();
}
spawnedKillcamCleanup_rc()
{
    level waittill("roundcam_ended");
    level removeKillcamElements();
}
