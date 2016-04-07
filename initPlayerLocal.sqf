disableRemoteSensors true;

//------------------------------ Headless Client
if !(isServer or hasInterface) then {
    if (profileName == "HCAOs") then {

        derp_HCAOsConnected = true;
        publicVariableServer "HCAOsConnected";
        format ["HCAOs connected: %1", derp_HCAOsConnected] remoteExec ["diag_log", 2];
    };
} else {//-------------------------------- Player stuff

    [] call derp_fnc_diary; // Diary

    ["InitializePlayer", [player]] call BIS_fnc_dynamicGroups; // Dynamic groups init

    [] execVM "scripts\misc\QS_icons.sqf";

    {
        _x addCuratorEditableObjects [[player], false];
    } forEach allCurators;
    //---------------- mission params
    if (("staminaEnabled" call BIS_fnc_getParamValue) == 0) then {
        player enableStamina false;
    };

    if (("paraJumpEnabled" call BIS_fnc_getParamValue) == 1) then {
        PARAM_paraJumpEnabled = true;
    } else {
        PARAM_paraJumpEnabled = false;
    };

    //---------------- class specific stuff
    if (player isKindOf "B_support_Mort_f") then {
    	enableEngineArtillery true;
    } else {
    	enableEngineArtillery false;
    };

    //---------------- EHs and addactions
    player addEventHandler ["Fired", {
        params ["_unit", "_weapon", "", "", "", "", "_projectile"];

        if (_unit distance2D (getMarkerPos "BASE") < 300) then {
            deleteVehicle _projectile;
            ["Don't goof at base", "Hold your horses soldier, don't throw, fire or place anything inside the base."] remoteExecCall ["derp_fnc_hintC", _unit];
        }}];

    if (PARAM_paraJumpEnabled) then {
        paraPoint addAction [
        "<t color='#FF6600'>Paradrop on AO</t>",
        {
            [player,
              2 * ("AOSize" call BIS_fnc_getParamValue)
            ] call derp_fnc_paradrop;
        },
        nil,
        0,
        true,
        true,
        "",
        "(!isNil 'missionInProgress') && {missionInProgress} && {!isNil 'derp_paraPos'}"
        ];
    };
};
