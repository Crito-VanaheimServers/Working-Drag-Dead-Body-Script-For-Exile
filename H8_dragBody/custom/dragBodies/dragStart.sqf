while {true} do
{
	private _loopTime = time;
{
	_check = _x getVariable ["H8_increm",0];

			if (_check == 0) then
				{
					[_x] spawn H8_addDrag;
				};
}forEach allUnits;
	waitUntil {time - _loopTime >= 10};
};

