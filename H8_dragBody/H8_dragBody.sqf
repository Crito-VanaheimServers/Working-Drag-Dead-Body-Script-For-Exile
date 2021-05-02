/*
 DragBody script by BangaBob (H8erMaker) v1.1
 
 Description
  Drag dead bodies out of sight to avoid detection. JIP/MP/SP/Dedicated compatible
 
 Instructions
  Add this line into the init.sqf. This will add a drag action to all editor placed units.
	null = allUnits execVM "H8_dragBody.sqf";
	
 Functions
	[UNIT1,UNIT2,UNIT3] spawn H8_addDrag;
 Add living units into the script. (Useful for units spawned mid-mission).
*/

//#define H8_DRAGTEXT		"Drag Body"		// AddAction text for drag body
#define H8_DROPTEXT		"Release Body"	// AddAction text for dropping body


 //H8_addDrag = {
 //			{
//	_x setVariable ["H8_dragged",false,true];
//	H8_dragUnitArray set [count H8_dragUnitArray, _x];
//			}forEach _this;
//			
//	[_this,"H8_fnc_Action",TRUE] call BIS_fnc_MP;
//	publicVariable "H8_dragUnitArray";
 //};
 
 
// H8_fnc_Action = {
//	_dragCond = "!alive _target and _this != _target and !(_this getVariable ""H8_drag"") and _target distance _this < 3 and !(_target getVariable ""H8_dragged"")";
//		{
//	_x addaction [H8_DRAGTEXT,{call H8_DragAction},nil,6,false,false,"",_dragCond];	
//		}forEach _this;
// };
 
 
 H8_DragAction = {
	_unit 	= 	(_this select 0);
	player playAction "grabDrag";
	player forceWalk true;
	
// SET VARIABLES
 _unit	setVariable ["H8_dragged",true,true];
 player	setVariable ["H8_drag", true];

 sendServer = [_unit,vehicle player,0]; publicVariableServer "sendServer";
 
 player addAction [H8_DROPTEXT,{call H8_dropAction},_unit,6];
	_unit attachTo [player,[0,1,0]];
 0 = ["localID", "onEachFrame", "H8_fnc_moveBody",[_unit,vehicle player]] call BIS_fnc_addStackedEventHandler; 
 };


 H8_dropAction = {
	_id = (_this select 2);
	
	player removeAction _id;
	
	_unit	=	(_this select 3);
	player playMove "amovpknlmstpsraswrfldnon";
	player forceWalk false;	
	
// SET VARIABLES
 _unit	setVariable ["H8_dragged",false,true];
 player	setVariable ["H8_drag",false];	

 sendServer = [_unit,vehicle player,1];publicVariableServer "sendServer";
 
	deTach _unit;
	_unit switchMove "AinjPpneMstpSnonWrflDb_release"; 
 0 = ["localID", "onEachFrame"] call BIS_fnc_removeStackedEventHandler;
 };


 H8_fnc_moveBody = {
	_unit 	= 	(_this select 0);
	_dragger= 	(_this select 1);
	
// CREDIT TOO Das Attorney FOR CODE
	_pos 	= 	_dragger modelToWorld [0,1,0]; // PLACE BODY IN-FRONT OF PLAYER
    _unit setPos _pos; 
	_unit setDir 180;
	
		if (!isDedicated) then{
	_unit switchMove "AinjPpneMrunSnonWnonDb"; 
			}else{
		_dir = [_unit,_dragger] call BIS_fnc_relativeDirTo;
		_unit setDir (_dir + 180);				
		};
 };

if (isServer) then {
// SERVER SIDE
if (isNil ("H8_dragUnitArray")) then {
	   H8_dragUnitArray = [];};
			
 			{
	_x setVariable ["H8_dragged",false,true];
	H8_dragUnitArray set [count H8_dragUnitArray, _x];
			}forEach _this;
			
		publicVariable "H8_dragUnitArray";
		
 "sendServer" addPublicVariableEventHandler {
		_sentData 	=	(_this select 1);
	_unit 	= 	(_sentData select 0);
	_player	=	(_sentData select 1);
	_type 	= 	(_sentData select 2);
	
	_id = format ["serverID%1",_unit];
 		if (_type == 0) then {
	0 = [_id, "onEachFrame", "H8_fnc_moveBody",[_unit,_player]] call BIS_fnc_addStackedEventHandler; 
				};
				
		if (_type == 1) then {
	0 = [_id, "onEachFrame"] call BIS_fnc_removeStackedEventHandler;
				};
		};
 };
 
if (!isServer && (player != player)) then { waitUntil {player == player}; waitUntil {time > 15};};
	
if (!isDedicated) then {
 player setVariable ["H8_drag",false];

 // ADD ALL ACTIONS ONTO EXISTING UNITS	
 0 = H8_dragUnitArray spawn H8_fnc_Action;
 };