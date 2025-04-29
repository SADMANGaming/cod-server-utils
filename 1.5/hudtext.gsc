main()
{	
    level.hudtext1 = getCvar("scr_hud_text1");
    level.hudtext2 = getCvar("scr_hud_text2");
    level.hudtext3 = getCvar("scr_hud_text3");

    if (!isDefined(level.hudtext1)) level.hudtext1 = "This server is powered by CODSU";
    if (!isDefined(level.hudtext2)) level.hudtext2 = "Visit our website: ^2cod1.rf.gd^7";
    if (!isDefined(level.hudtext3)) level.hudtext3 = "Download CODSU: cod1.rf.gd/codsu";

    level.madehudstr1 = makelocalizedstring(level.hudtext1);
    level.madehudstr2 = makelocalizedstring(level.hudtext2);
    level.madehudstr3 = makelocalizedstring(level.hudtext3);

    preCacheString(level.madehudstr1);
    preCacheString(level.madehudstr2);
    preCacheString(level.madehudstr3);
}

logo()
{
    level.logo = newHudElem();
    level.logo.x = 15;
    level.logo.y = 15;
    level.logo.alignx = "left";
    level.logo.aligny = "middle";
    level.logo.fontscale = 0.9;
    level.logo.archived = true;

    while (1)
    {
        if (isDefined(level.madehudstr1)) {
            level.logo.alpha = 1;
            level.logo setText(level.madehudstr1);
            wait 8;
            level.logo.alpha = 0;
            wait 2;
        }

        if (isDefined(level.madehudstr2)) {
            level.logo.alpha = 1;
            level.logo setText(level.madehudstr2);
            wait 8;
            level.logo.alpha = 0;
            wait 2;
        }

        if (isDefined(level.madehudstr3)) {
            level.logo.alpha = 1;
            level.logo setText(level.madehudstr3);
            wait 8;
            level.logo.alpha = 0;
            wait 2;
        }
    }
}
