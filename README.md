# Working-Drag-Dead-Body-Script-For-Exile

Since running this on my server I have found the biggest issue is it sometimes sends players to debug zone when revived by another player. Use at your own risk its not a perfect system.

THIS CODE IS NOT MY WORK I JUST GOT IT TO WORK WITH EXILE!! 

				Drag Dead Body Script
				by BangaBob

Unpack your Exile.Mission.pbo

copy the contents of config.cpp file provided in this installation package.

Open your config.cpp and find the following
	class Player 
	{
		targetType = 2;
		target = "Exile_Unit_Player";

		class Actions 
		{

Paste what we just copied under the bracket located under class Actions in your config.cpp

Copy the H8_dragBody.sqf provided in this installation into the root of your Exile.Mission.pbo

Repack the Exile.Mission.pbo and enjoy.

This only works on draging other players not AI.


After running this on live server and actually being able to use it on other players I have found some things that need worked on. I will try to work the issues out but im not the greatest at coding I just know enough to get small things done. So if anyone wants to takle the issues  than it would be awsome to see it shared. We have found that it needs some server side code that updates the dead players body position after being dragged. Also when one player drags another than any other players watching just see the player being drug like a rubberband on thier end. We also found that when reviving there has been a rare chance that revived player gets sent to debug zone. These are things that I was not able to test on my test server alone and did not run into them until put into the live server and started playing with it on other players. 
