debug(str, func)
{
    if(getCvar("scr_debug") == "1")
    {
        println("### LOADED FUNC: " + func + " ###");
        println("### DEBUGGER: " + str + " ###");
        println("### DEBUGGING END FOR: " + func + " ###");
    }
}

debugx(str, func)
{
    if(getCvar("scr_debug") == "1")
    {
        println("### " + func + " --- " + str + " ###");
    }
}