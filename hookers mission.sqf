//Mission By: Fat Hooker (j0ker)//

if(isServer) then {
	 
	private 		["_baserunover","_mission","_directions","_position","_crate","_crate_type","_num"];

	_position		= [80] call find_position;
	
	_mission 		= [_position,"medium","Gas station robbery","MainHero",false] call mission_init;

	diag_log 		format["WAI: [Mission:[Hero] Robbery]: Starting at %1",_position];

	_crate_type 	= crates_large call BIS_fnc_selectrandom;
	_crate 			= createVehicle [_crate_type,[(_position select 0),(_position select 1),0],[],0,"CAN_COLLIDE"];

	[_crate,16,[8,crate_tools_sniper],[3,crate_items_high_value],[4,crate_backpacks_large]] call dynamic_crate;
	 
	_baserunover0 	= createVehicle ["land_fortified_nest_big",[(_position select 0) - 40, (_position select 1),-0.2],[], 0, "CAN_COLLIDE"];
	_baserunover1 	= createVehicle ["land_fortified_nest_big",[(_position select 0) + 40, (_position select 1),-0.2],[], 0, "CAN_COLLIDE"];
	_baserunover2 	= createVehicle ["land_fortified_nest_big",[(_position select 0), (_position select 1) - 40,-0.2],[], 0, "CAN_COLLIDE"];
	_baserunover3 	= createVehicle ["land_fortified_nest_big",[(_position select 0), (_position select 1) + 40,-0.2],[], 0, "CAN_COLLIDE"];
	_baserunover4 	= createVehicle ["Land_Ind_FuelStation_Build_EP1",[(_position select 0) - 10, (_position select 1),-0.2],[], 0, "CAN_COLLIDE"];
	
	_baserunover = [_baserunover0,_baserunover1,_baserunover2,_baserunover3,_baserunover4];
	
	_directions = [90,270,0,180,0,180,270,90];
	{ _x setDir (_directions select _forEachIndex) } forEach _baserunover;

	{ _x setVectorUp surfaceNormal position _x; } count _baserunover;

	_num = round (random 3) + 4;
	[[_position select 0, _position select 1, 0],_num,"medium",["random","at"],4,"random","bandit","random",["bandit",150],_mission] call spawn_group;
	[[_position select 0, _position select 1, 0],4,"medium","random",4,"random","bandit","random",["bandit",75],_mission] call spawn_group;
	[[_position select 0, _position select 1, 0],4,"easy","random",4,"random","bandit","random",["bandit",75],_mission] call spawn_group;	 

	_dir 			= floor(round(random 360));

	_vehclass 		= cargo_trucks 		call BIS_fnc_selectRandom;		
	_vehclass2 		= refuel_trucks 	call BIS_fnc_selectRandom;
	_vehclass3 		= military_unarmed 	call BIS_fnc_selectRandom;

	_vehicle		= [_vehclass,_position,false,_dir] 	call custom_publish;
	_vehicle2		= [_vehclass2,_position,false,_dir] call custom_publish;
	_vehicle3		= [_vehclass3,_position,false,_dir] call custom_publish;
	
	if(debug_mode) then {
		diag_log format["WAI: [Hero] Robbery spawned a %1",_vehclass];
		diag_log format["WAI: [Hero] Robbery spawned a %1",_vehclass3];
		diag_log format["WAI: [Hero] Robbery spawned a %1",_vehclass2];
	};
	
	_complete = [
		[_mission,_crate],		
		["crate"], 						
		[_vehicle,_vehicle2,_vehicle3],	
		"A gang of fat bitches has robbed a gas station, stop them now!",	
		"All the fat bitches have been cream pied!",															
		"The fat bitches got away with the loot, WTF man!"																
	] call mission_winorfail;

	if(_complete) then {
		[_crate,[2,crate_weapons_buildables],[4,crate_tools_buildable],[30,crate_items_buildables],4] call dynamic_crate;
	};

	diag_log format["WAI: [Mission:[Hero] Robbery]: Ended at %1",_position];
	
	h_missionrunning = false;
};