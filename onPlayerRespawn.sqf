if (("staminaEnabled" call BIS_fnc_getParamValue) == 0) then {
    player enableStamina false;
};

[[player], false] call derp_fnc_remoteAddCuratorEditableObjects;

if (!(player getVariable ["derp_revive_downed", false]) && {!isNil {player getVariable "derp_savedGear"}}) then {
	player setUnitLoadout [(player getVariable "derp_savedGear"), true];
};