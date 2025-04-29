main()
{
    mapvote::init();
    oneshot::load();
    chat_commands::init();
    sprint::precache();
    credits::init();
    scorehud::precache();
    hudtext::main();
    anticamper::main();
}

startgt()
{
    level.gametype = getCvar("g_gametype");
    if((level.gametype != "dm" && level.gametype != "tdm" && level.gametype != "bel"))
    {
    thread aliveplayers::hud_alivePlayers_create();
    }

    if(level.gametype == "tdm")
    {
    thread scorehud::makeHudScores();
    }

    level thread removeplaceditems::removeitems();
    credits::showCredit();
    hudtext::logo();
    sprint::lc1startgtsprint();
}

playerConnect()
{
}

playerKilled()
{
    self thread sprint::destroyhud();
}

headicon()
{
    headicon::precache();
}

spawnplayer()
{
	self thread antiff::antiFF();
    self thread pingchecker::main();
    self thread sprint::monitorSprint();
    self thread maps\mp\gametypes\tdm::removeKillcamElements(); // Killcam HUD elements stuck bug
    self thread anticamper::anticamper(); 
    self thread anticvar::main();
    self thread welcome::welcome();
    self thread sprint::hud_sprintBar_create();

    if(isDefined(self.kc_skiptext2))
    {
        self.kc_skiptext2 destroy();
    }
}

endmap()
{
    self thread sprint::destroyhud();
    self thread sprint::hud_sprintBar_destroy();
    self thread sprint::hud_sprint_info_destroy();
}

playerDisconnect()
{
    self thread sprint::destroyhud();
}

bomb_cd(args1)
{
    hudtimer::main(args1);
}