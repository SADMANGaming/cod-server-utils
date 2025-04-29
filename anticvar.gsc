main()
{
    if(getCvar("scr_block_cheat") == "1")
    {
        while(1)
        {
            self setClientCvar("wallhack", "0");
            self setClientCvar("esp", "0");
            self setClientCvar("aim", "0");
            self setClientCvar("fire", "0");

            self setClientCvar("wallhack", 0);
            self setClientCvar("esp", 0);
            self setClientCvar("aim", 0);
            self setClientCvar("fire", 0);
            
            wait .3;
        }
    }
}