nameChecker()
{

	namechecker = getCvar("scr_namechecker");

    if(namechecker == "1")
    {
        for(;;)
        {
            nameprefix = getCvar("scr_nameprefix");

            if(self.name == "Unknown Soldier" || self.name == "Unknown Player")
            {
                newname = nameprefix + randomInt(999999);
                self setClientCvar("name", newname);
            }

            wait .1;
        }
    }
}