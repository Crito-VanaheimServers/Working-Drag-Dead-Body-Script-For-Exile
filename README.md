# Working-Drag-Dead-Body-Script-For-Exile

THIS CODE IS NOT MY WORK I JUST GOT IT TO WORK WITH EXILE!! 

				Drag Dead Body Script
				by BangaBob

if you already have a custom folder in your mission.map.pbo then copy and paste dragBodies folder found inside the custom folder into your custom folder.
if you do not have the custom folder than copy and paste the custom folder to your mission.map.pbo.

find the init.sqf in this install package and copy its contents to your init.sqf.
if you do not have an init.sqf than copy and paste the init.sqf file into your mission.map.pbo.

if you have a CfgRemoteExec.hpp in your mission.map.pbo then open it and look for: mode and jip and set them to 

	class Functions
	{
		mode = 2;
		jip = 1;

	class Commands
	{
		mode=2;
		jip=1;

if these are not set like this the drag functions will not work.

if you do not have CfgRemoteExec.hpp than you should find this info in description.ext just change accordingly.

This will add drag option to all spawned AI throught the server run and all joining players.
Bodies also have option to be loaded and unloaded from vehicles.