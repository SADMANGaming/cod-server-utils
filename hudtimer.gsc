main(countdowntime)
{
    self endon("bomb_defused");
    self endon("bomb_exploded");  // In case the bomb explodes before the countdown finishes

    bombTimerHud = newHudElem();
    bombTimerHud.x = 50;  // Position on the left
    bombTimerHud.y = 180;  // Vertically centered
    bombTimerHud.alignX = "left";
    bombTimerHud.alignY = "middle";
    bombTimerHud.fontScale = 2;
    bombTimerHud.color = (1, 0, 0);  // Red color for urgency

    bombTimerHud setValue(countdowntime);

    bombTimerHud setTimer(countdowntime);

    wait countdowntime;

    bombTimerHud destroy();
}
