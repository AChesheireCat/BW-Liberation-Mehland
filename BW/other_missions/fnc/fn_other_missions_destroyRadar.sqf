private _nearbyLocations = nearestLocations [[0,0,0], ["NameVillage", "Name", "NameCity", "NameCityCapital"], 10000];
private _randomLocation = getPos selectRandom _nearbyLocations;
private _find_pos = [_randomLocation, 500, 1000, 30, 0, 0.9, 0] call BIS_fnc_findSafePos;

_radar_1 = "rhs_prv13" createVehicle _find_pos;

//marker
private _Marker10 = createMarker ["Marker10", _radar_1 getPos [random 500, random 360]];
"Marker10" setMarkerShape "ELLIPSE";
"Marker10" setMarkerSize [500, 500];
"Marker10" setMarkerColor "ColorBlack";
"Marker10" setMarkerBrush "Cross";

["Task_10", true, ["Destroy the radar","Destroy the radar","respawn_west"], getMarkerPos _Marker10, "CREATED", 5, true, true, "meet", true] call BIS_fnc_setTask;

[
	getPos _radar_1,	// array of coordinates where the center of the building will be 

	EAST,	// the side of the enemy troops: EAST, WEST, independent

	["CPC_ME_O_KAM_soldier_Medic",
	"CPC_ME_O_KAM_soldier_AR",
	"CPC_ME_O_KAM_soldier_TL",
	"CPC_ME_O_KAM_soldier_AA",
	"CPC_ME_O_KAM_soldier_LAT"],

	["CPC_ME_O_KAM_uaz_spg9",
	"CPC_ME_O_KAM_uaz_dshkm"],

	["CPC_ME_O_KAM_BTR70",
	"CPC_ME_O_KAM_BRDM2",
	"CPC_ME_O_KAM_BMP1",
	"CPC_ME_O_KAM_T72B"],

	["CPC_ME_O_KAM_ZSU",
	"CPC_ME_O_KAM_ural_Zu23"],

	["CPC_ME_O_KAM_uh1h_gunship",
	"CPC_ME_O_KAM_Mi24D_Early"],

	["CPC_ME_O_KAM_DSHKM",
	"CPC_ME_O_KAM_Igla_AA_pod",
	"CPC_ME_O_KAM_ZU23",
	"CPC_ME_O_KAM_2b14_82mm"],

	200, // radius from the center for placement of static guns (meters)

	6, // number of static guns

	4,	// number of light vehicles on patrol in area

	1,	// number of heavy vehicles on patrol in area

	1,	// number of self-propelled AA vehicles on patrol in area 

	0,	// number of helicopters on patrol in area

	3,	// number of enemy squads on patrol in area

	3,	//	number of troops in enemy squads 

	30,	//  chance of enemy troop appearing in building/on roofs

	2000, // player activation radius

	200,	// enemy patrol radius

	200,	// radius of placement of enemy light vehicles (the more vehicles, the larger this should be)

	400,	// patrol radius of all vehicles and light tanks

	1000,	// patrol radius of helicopters

	false	// whether to delete the zone after activation if there are no players left in the activation zone

] execVM "BW\other_missions\fnc\fn_other_missions_spawnEnemyBot.sqf";

waitUntil{
	sleep 10;
	!alive _radar_1
};

["Task_10","SUCCEEDED"] call BIS_fnc_taskSetState;
deleteMarker _Marker10;
sleep 10;
["Task_03"] call BIS_fnc_deleteTask;
