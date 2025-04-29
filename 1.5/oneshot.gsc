load()
{
    precacheShader("gfx/hud/hud@fire_ready.tga");
    precacheString(&"-");
}

_finishPlayerDamage(eInflictor, eAttacker, iDamage, iDFlags, sMeansOfDeath, sWeapon, vPoint, vDir, sHitLoc, spawnprotected)
{
		if(isDefined(self.spawnprotected) && self.spawnprotected)
			return;


	// Don't do knockback if the damage direction was not specified
	if (!isdefined(vDir))
		iDFlags |= level.iDFLAGS_NO_KNOCKBACK;

	// Make sure at least one point of damage is done
	if (iDamage < 1)
		iDamage = 1;

    if( isDefined( self ) && getcvar("scr_oneshot") == "1") {
        if(isDefined(eAttacker) && sMeansOfDeath != "MOD_FALL" && isBoltWeapon(sWeapon))
           iDamage = iDamage * 100;
    }

    if( isDefined(self) && getCvar("scr_damagemarker") == "1")
    {
      if(isPlayer(eAttacker) && eAttacker != self)
            eAttacker thread _showDamagemarker(iDamage);
    }

    if( isDefined( self ) && getcvar("scr_hitmark") == "1") {
        if(isPlayer(eAttacker) && eAttacker != self)
            eAttacker thread showHit();
	        return (self finishPlayerDamage(eInflictor, eAttacker, iDamage, iDFlags, sMeansOfDeath, sWeapon, vPoint, vDir, sHitLoc));
    }

}

showHit() // Taken from AWE
{
  self endon("spawned");
	self endon("disconnect");
	
	if(isDefined(self.hitBlip))
		self.hitBlip destroy();

	self.hitBlip = newClientHudElem(self);
	self.hitBlip.alignX = "center";
	self.hitBlip.alignY = "middle";
	self.hitBlip.x = 320;
	self.hitBlip.y = 240;
	self.hitBlip.alpha = 0.5;
	self.hitBlip setShader("gfx/hud/hud@fire_ready.tga", 32, 32);
	self.hitBlip.color = (1, 0.7, 0);
	self.hitBlip scaleOverTime(0.15, 64, 64);

	wait 0.30;

	if(isDefined(self.hitBlip))
		self.hitBlip destroy();
}

_showDamagemarker(iDamage)
{
	self endon("spawned");
	self endon("disconnect");
	
	if(!isDefined(self.damageBlip))
		self.damageBlip = [];
	
	if(!isDefined(self.damageBlipSize))
		self.damageBlipSize = 0;

	if(self.damageBlipSize > 2)
		self.damageBlipSize = 0;

	if(isDefined(self.damageBlip[self.damageBlipSize]))
		self.damageBlip[self.damageBlipSize] destroy();
	
	time = getTime(); // dirty hack to fix blip problem XD
	self.damageBlip[self.damageBlipSize] = newClientHudElem(self);
	self.damageBlip[self.damageBlipSize].blipId = time; // dirty hack to fix blip problem XD
	self.damageBlip[self.damageBlipSize].alignX = "center";
	self.damageBlip[self.damageBlipSize].alignY = "middle";
	self.damageBlip[self.damageBlipSize].x = 335;
	self.damageBlip[self.damageBlipSize].y = 225;
	self.damageBlip[self.damageBlipSize].alpha = 1;
	self.damageBlip[self.damageBlipSize].color = (1, 0.7, 0);
	self.damageBlip[self.damageBlipSize].label = &"-";
	self.damageBlip[self.damageBlipSize] setValue(iDamage);
	self.damageBlip[self.damageBlipSize] moveOverTime(0.35);
	
	rand = randomInt(10);
	
	self.damageBlip[self.damageBlipSize].x = self.damageBlip[self.damageBlipSize].x + (20 - rand);
	self.damageBlip[self.damageBlipSize].y = self.damageBlip[self.damageBlipSize].y - (20 + rand);
	
	damageBlipSize = self.damageBlipSize; // fix stuck marker
	self.damageBlipSize++;
	
	wait 0.35;
	
	if(isDefined(self.damageBlip[damageBlipSize]) && self.damageBlip[damageBlipSize].blipId == time)
		self.damageBlip[damageBlipSize] destroy();

}

isBoltWeapon(sWeapon)
{
    oneshot_pistol = getCvar("scr_oneshot_pistol") == "1";
  switch(sWeapon) {
    case "enfield_mp":
    case "fg42_mp":
    case "fg42_semi_mp":
    case "kar98k_mp":
    case "kar98k_sniper_mp":
    case "mosin_nagant_mp":
    case "mosin_nagant_sniper_mp":
    case "springfield_mp":
    case "enfieldscoped_mp":
    case "knife_mp":
    return true;
    case "colt_mp":
    case "luger_mp":
    if(oneshot_pistol)
    {
        return true;
    }
    break;
  }
  
  return false;
}