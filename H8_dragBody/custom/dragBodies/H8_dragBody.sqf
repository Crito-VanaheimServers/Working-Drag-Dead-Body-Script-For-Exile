/*
 DragBody script by BangaBob (H8erMaker) v1.2
 
 Description
  Drag dead bodies out of sight to avoid detection. JIP/MP/SP/Dedicated compatible
 
 Instructions
  Add this line into the init.sqf. This will add a drag action to all editor placed units.
	null = allUnits execVM "H8_dragBody.sqf";
	
 Functions
	[UNIT1,UNIT2,UNIT3] spawn H8_addDrag;
 Add living units into the script. (Useful for units spawned mid-mission).
*/
private ["_unitID","_dragCond","_unit","_dropID","_hideID","_id","_vehicle","_loadedBody","_pos","_relD","_player"];

#define H8_DRAGTEXT		"Drag Body"		// AddAction text for drag body
#define H8_DROPTEXT		"Release Body"	// AddAction text for dropping body
#define H8_LOADTEXT		"Load Body"		// AddAction text for dropping body
#define H8_UNLOTEXT		"Unload Body"	// AddAction text for dropping body

 H8_fnc_Action = {
_dragCond = "vehicle _this != vehicle _target and isNull attachedTo _target and count attachedObjects _this == 0 and _target distance _this < 3 and !alive _target";	
		{
			_x addaction [H8_DRAGTEXT,{call H8_DragAction},nil,6,false,false,"",_dragCond];	
		}forEach _this;
 };
 
 
 H8_DragAction = {
	_unit 	= 	(_this select 0);
	
// GLOBAL CODE
	_unitID = _unit getVariable "H8_increm";
	//[[_unit, vehicle player,_unitID],"H8_fnc_attach",true] call BIS_fnc_MP;
	[_unit, vehicle player,_unitID] remoteExec ["H8_fnc_attach", 0, true];
 _unit attachTo [player,[0,1,0]];
	
// CLIENT SIDE
	player playAction "grabDrag";
	player forceWalk true;
	
_dropID= player addAction [H8_DROPTEXT,{call H8_dropAction},_unit,6];
_hideID =player addAction [H8_LOADTEXT,{call H8_putIncar},_unit,6,false,false,"","_target distance _this < 8 and cursorTarget isKindOf ""LandVehicle"""];
	
	player setVariable ["H8hideVeh",_hideID];
	player setVariable ["H8dropact",_dropID];
 };

 
 H8_putIncar = {
 _hideID = (_this select 2);
 _dropID = player getVariable "H8dropact";
 _unit = (_this select 3);
 _vehicle = cursorTarget;
 
_loadedBody =_vehicle getVariable "H8loadedBody";
	if (isNil "_loadedBody") then {
	
	
// CLIENT CODE
	player playMove "amovpknlmstpsraswrfldnon";
	player forceWalk false;	
	player removeAction _hideID;
	player removeAction _dropID;
		
// GLOBAL CODE
	_unitID = _unit getVariable "H8_increm";
	//0 = [[_unit, vehicle player,_unitID],"H8_fnc_detach",true] call BIS_fnc_MP;
	[_unit, vehicle player,_unitID] remoteExec ["H8_fnc_detach",0,true];
		sleep 1;
			deTach _unit;
			_unit setPos [0,0,0];
			_vehicle setVariable ["H8loadedBody",_unit,true];
				//[[_vehicle],"H8_carAction",true] call BIS_fnc_MP; 
				[_vehicle] remoteExec ["H8_carAction",0,true];
				
					}else{
hint "Vehicle already has a body loaded";
	};
 };
 
 
 H8_carAction = {
 _vehicle = (_this select 0);
 _vehicle addAction [H8_UNLOTEXT,{call H8_removeBody},nil,0,false,false,"","_this distance _target < 8"];
 };
 
 
 H8_carRemoveAction = {
 _vehicle = (_this select 0);
 _id = (_this select 1);
	_vehicle removeAction _id;
 };
 
 
 H8_removeBody = {
 _vehicle = (_this select 0);
 _player = (_this select 1);
 _id = (_this select 2);
 
 //[[_vehicle,_id],"H8_carRemoveAction",true] call BIS_fnc_MP; 
 [_vehicle,_id] remoteExec ["H8_carRemoveAction",0,true];
 
 _unit = _vehicle getVariable "H8loadedBody";
 _vehicle setVariable ["H8loadedBody",Nil];
 	_pos  = _player modelToWorld [1,0,0];
    _unit setPos _pos;
	_unit switchMove "AinjPpneMstpSnonWrflDb_release";
 };
 
 
 H8_dropAction = {
 _dropID = (_this select 2);
 _hideID = player getVariable "H8hideVeh";
 _unit	=	(_this select 3);
	
// GLOBAL CODE
	_unitID = _unit getVariable "H8_increm";
	//0 = [[_unit, vehicle player,_unitID],"H8_fnc_detach",true] call BIS_fnc_MP;
	[_unit, vehicle player,_unitID] remoteExec ["H8_fnc_detach",0,true];
	
 deTach _unit;
 
// CLIENT SIDE	
	player removeAction _hideID;
	player removeAction _dropID;
	player playMove "amovpknlmstpsraswrfldnon";
	player forceWalk false;	
 };
 
 
 H8_fnc_attach = {
	_unit 	= 	(_this select 0);
	_player = 	(_this select 1);
	_unitID =	(_this select 2);
	
	_id = format ["h8EF%1",_unitID];
	0 = [_id, "onEachFrame", "H8_fnc_moveBody",[_unit,_player]] call BIS_fnc_addStackedEventHandler;
 };
 
 
 H8_fnc_detach = {
 	_unit 	= 	(_this select 0);
	_player = 	(_this select 1);
	_unitID =	(_this select 2);
	
	_id = format ["h8EF%1",_unitID];
	0 = [_id, "onEachFrame"] call BIS_fnc_removeStackedEventHandler;
 
	sleep 0.05;
 _relD = [_unit,_player] call BIS_fnc_dirTo;
 //_unit switchMove "AinjPpneMstpSnonWrflDb_release";
 _unit switchMove "AinjPpneMstpSnonWnonDnon";
 _unit setDir _relD;
 };

 
 H8_fnc_moveBody = {
	_unit 	= (_this select 0);
	_player	= (_this select 1);
	
// CREDIT TOO Das Attorney FOR CODE
	_pos  = _player modelToWorld [0,1,0];
    _unit setPos _pos;
	_unit setDir 180;
	_unit switchMove "AinjPpneMrunSnonWnonDb"; 		
 };


 H8_addDrag = {
 			{
		H8_increments = H8_increments + 1;	
	_x setVariable ["H8_increm",H8_increments,true];
	H8_dragUnitArray set [count H8_dragUnitArray, _x];
			}forEach _this;
			
	//[_this,"H8_fnc_Action",TRUE] call BIS_fnc_MP;
	_this remoteExec ["H8_fnc_Action",0,true];
	
publicVariable "H8_increments";
publicVariable "H8_dragUnitArray";
 };

 
if (isServer) then {
if (isNil ("H8_dragUnitArray")) then {
	   H8_dragUnitArray = [];
	   H8_increments = 0;};
			
 			{
		H8_increments = H8_increments + 0;	
	_x setVariable ["H8_increm",H8_increments,true];
	H8_dragUnitArray set [count H8_dragUnitArray, _x];
			}forEach _this;
			
publicVariable "H8_increments";			
publicVariable "H8_dragUnitArray";
 };
 
if (!isServer && (player != player)) then { waitUntil {player == player}; waitUntil {time > 15};};
	
	if (!isDedicated) then {
 0 = H8_dragUnitArray spawn H8_fnc_Action;
		};