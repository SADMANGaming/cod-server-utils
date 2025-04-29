main()
{
    // ANTICAMP
    level.anticamptime = getCvarInt("scr_anticamptime");
    level.anticamp = getCvar("scr_anticamp");
    level.acrange = getCvarInt("scr_anticamp_range");
}

anticamper()
{
    while(isAlive(self))
    {
        if(level.anticamp == "1") // Check if its enabled or not
        {

            wait level.anticamptime;

            if(self sameangles())
            {
                self iprintlnbold("^3Better move it, soldier!");
            }

            wait level.acrange;

            if(self sameangles())
            {
                self suicide();
                self iprintlnbold("You are punished for camping");
                iprintln(self.name + " ^7Were ^1punished ^7for camping");
            }
        }
    }
}



sameangles()
{
    currentorigin = self.origin;

    wait level.anticamptime;
    neworigin = self.origin;

    if(currentorigin == neworigin)
    {
        return true;
    } else {
        return false;
    }
}
