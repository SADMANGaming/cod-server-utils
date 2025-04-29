antiFF()
{
    printLn("AntiFastFire Loaded");
	wait 1; // tmp to fix the spawn problem
	
	self endon("spawned"); // tmp to fix the spawn problem
	self endon("disconnect"); // tmp to fix the spawn problem

	/*
		kar98k_sniper 1350
		kar98k 1350
		mosin_nagant_sniper 1500
		mosin_nagant 1350
		springfield 1250 | 1300
		enfield 1450
	*/

    fastfire = 0;
	if(getCvar("scr_enableantiff") == "enable")
	    fastfire = 2;

    if(fastfire == 0)
        return;

    if(!isDefined(level.fastfireaction)) {
        level.fastfireaction = "suicide";
        if(getCvar("scr_ffreaction") != "" && getCvar("scr_ffreaction") != "suicide")
            level.fastfireaction = getCvar("scr_ffreaction");
    }
	
	wait 1;

	weaponTimes = []; // self getCurrentWeapon();
	weaponTimes["kar98k_sniper_mp"] = 1350;
	weaponTimes["kar98k_mp"] = 1350;
	weaponTimes["mosin_nagant_sniper_mp"] = 1500;
	weaponTimes["mosin_nagant_mp"] = 1350;
	weaponTimes["springfield_mp"] = 1300; // possibly 1250 or 1300(old)
	weaponTimes["enfield_mp"] = 1450;
	weaponTimes["default"] = 1300;
	
	if(!isDefined(self.pers["fastfire"]))
		self.pers["fastfire"] = 0;
	
	while(self.sessionstate == "playing") {
		wait(0.05);
		
		currentWeapon = self getCurrentWeapon();
		if(!isBoltWeapon(currentWeapon))
			continue;
		
		if(currentWeapon == self getWeaponSlotWeapon("primary"))
			weaponSlot = "primary";
		else if(currentWeapon == self getWeaponSlotWeapon("primaryb"))
			weaponSlot = "primaryb";
		else
			continue;
		
		weaponAmmo = self getWeaponSlotClipAmmo(weaponSlot);
		if(!isDefined(weaponAmmo)) continue;

		while(self getWeaponSlotClipAmmo(weaponSlot) == weaponAmmo && currentWeapon == self getCurrentWeapon())
			wait 0.05;
		
		if(self getWeaponSlotClipAmmo(weaponSlot) > weaponAmmo)
			continue;

		weaponAmmo = self getWeaponSlotClipAmmo(weaponSlot);
		if(!isDefined(weaponAmmo)) continue;
		
		if(currentWeapon == self getCurrentWeapon()) {
			weaponTime = weaponTimes["default"];
			if(isDefined(weaponTimes[currentWeapon]))
				weaponTime = weaponTimes[currentWeapon];
			
			startTime = getTime() + (weaponTime - 50);

			self.fastfire = true;
			while(startTime > getTime() && self.sessionstate == "playing") {
				if(currentWeapon != self getCurrentWeapon()) {
					currentWeapon = self getCurrentWeapon();
					if(!isBoltWeapon(currentWeapon))
						break;

					if(currentWeapon == self getWeaponSlotWeapon("primary"))
						weaponSlot = "primary";
					else if(currentWeapon == self getWeaponSlotWeapon("primaryb"))
						weaponSlot = "primaryb";
					else
						break;

					weaponAmmo = self getWeaponSlotClipAmmo(weaponSlot);
					if(!isDefined(weaponAmmo)) break;
				}
				
				if(self getWeaponSlotClipAmmo(weaponSlot) < weaponAmmo) { // TODO: code became messy here, recode sometime
					weaponTime = weaponTimes["default"];
					if(isDefined(weaponTimes[currentWeapon]))
						weaponTime = weaponTimes[currentWeapon];
					
					startTime = getTime() + (weaponTime - 50);

					if(fastfire != -1) {
						self.pers["fastfire"]++;
						if(self.pers["fastfire"] < fastfire)
							self iPrintLn("^3Warning! ^7Fast fire detected.");

						if(self.pers["fastfire"] >= fastfire) {
							iPrintLn(self.name + " ^7Was punished for fast fire.");
							self.pers["fastfire"] = 0;

							switch(level.fastfireaction) {
								case "suicide":
									self suicide();
								break;
								case "weapons":
									self disarm();
								break;
							}
							
							break;
						}
					} else 
						self iPrintLn("^3Warning! ^7Fast fire detected.");

					weaponAmmo = self getWeaponSlotClipAmmo(weaponSlot);
					if(!isDefined(weaponAmmo)) break;
				}
				
				wait(0.05);
			}

			self.fastfire = undefined;
		}
	}
}

disarm()
{
	if (self.sessionstate != "playing")
		return;	
	grenade = self getWeaponSlotWeapon("grenade");
	pistol = self getWeaponSlotWeapon("pistol");
	primary = self getWeaponSlotWeapon("primary");
	primaryb = self getWeaponSlotWeapon("primaryb");
			
	if ( !isdefined( grenade ) )
	   grenade = "none";
	if ( !isdefined( pistol ) )
	   pistol = "none";
	if ( !isdefined( primary ) )
	   primary = "none";
	if ( !isdefined( primaryb ) )
	   primary = "none";
			
	self dropItem( grenade );
	self dropItem( pistol );
	self dropItem( primary );
	self dropItem( primaryb );			
	return;	
}

isBoltWeapon(sWeapon)
{
	switch(sWeapon) {
		case "enfield_mp":
		//case "fg42_mp":
		//case "fg42_semi_mp":
		case "kar98k_mp":
		case "kar98k_sniper_mp":
		case "mosin_nagant_mp":
		case "mosin_nagant_sniper_mp":
		case "springfield_mp":
		return true;
	}

	return false;
}