// ########## Welcome Messages Function
welcome()
{
    welcomemsg1 = getCvar("scr_welcomemsg1");
    welcomemsg2 = getCvar("scr_welcomemsg2");
    welcomemsg3 = getCvar("scr_welcomemsg3");

    pID = self getEntityNumber();

    greetedIDs = getCvar("tmp_welcomemessages");
    greetedArray = strTok(greetedIDs, ";"); // Split IDs into an array

    if(!(utils::isInArray(greetedArray, pID)) && getCvar("scr_welcome") == "1") {
        self iprintlnBold(welcomemsg1 + " " + self.name);
        wait 3;
        self iprintlnBold(welcomemsg2);
        wait 3;
        self iprintlnBold(welcomemsg3);

        newGreetedIDs = greetedIDs + ";" + pID;
        setCvar("tmp_welcomemessages", newGreetedIDs);
    }
}
