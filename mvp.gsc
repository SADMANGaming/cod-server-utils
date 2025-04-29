mvp()
{
	topPlayer = undefined;
	score = 0;
	
	
	players = getEntArray("player", "classname");
	
	for(i = 0; i < players.size; i++) {
		if(players[i].score > score) {
			score = players[i].score;
			topPlayer = players[i];
		}
	}
	
	iprintlnbold("BEST PLAYER^3:^7 " + topPlayer.name + " ^7is having ^3" + score + " ^7kills.");
}