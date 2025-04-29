init()
{
	level.codsu_version = "1.0";
	setcvar( "codsu_version", level.codsu_version, true );
	level.codsu_credit = &"^2CoD^5SU ^2V";
	iPrintLn("This server is powered by CoDSU.");
	showCredit();
}

showCredit()
{
	ver = newHudElem();
	ver.x = 1;
	ver.y = 474;
	ver.alignX = "left";
	ver.alignY = "middle";
	ver.sort = 99999;
	ver.fontScale = 0.6;
	ver.archived = true;
	ver.label = level.codsu_credit;
	ver setValue( level.codsu_version );
}