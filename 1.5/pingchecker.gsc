main()
{
    bot = self isBot();
    ping = self getPing();
    maxping = (getCvarInt("scr_pingcheck_ping"));
    
    if(getCvar("scr_pingcheck") == "1")
    {
        if(bot)
        return;


        if(ping > maxping)
        {
            self iPrintLnBold("^3Your ping is too high");
            self iPrintLnBold("^1Kicking ^3you in 10 seconds");
            wait 10;
            self dropclient("Too much ping. Please connect later!");
        }
    }
}