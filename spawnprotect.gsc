main()
{
	precacheString("^3SPAWN PROTECTION");
}

spawnProtection()
{
	if(getCvar("scr_spawnprotect") == "1")
	{
	self.spawnprotection = newClientHudElem(self);
	self.spawnprotection.alignX = "center";
	self.spawnprotection.alignY = "middle";
	self.spawnprotection.x = 320;
	self.spawnprotection.y = 90;
	self.spawnprotection.archived = false;
	self.spawnprotection.sort = 9998;
	self.spawnprotection.label = &"^3SPAWN PROTECTION";

	self.spawnprotected = true;
	for(msecs = 0; msecs <= 1; msecs += 0.25) {
		if(self attackButtonPressed())
			break;

		wait 0.25;
	}

	if(isDefined(self.spawnprotection))
		self.spawnprotection destroy();

	self.spawnprotected = false;
	}
}