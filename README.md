# Working-Drag-Dead-Body-Script-For-Exile

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
