_v=_this select 0;
_int = _this select 1;
_t=_this select 2;
_pos=getpos _v;
// Particle effects
_smoke = "#particlesource" createVehicleLocal _pos;
_smoke attachto [_v,[0,0,0],"destructionEffect1"];
_smoke setParticleParams [["\ca\Data\ParticleEffects\Universal\Universal",16,7,48],
			"", "Billboard", 1, 15, [0, 0, 0], [0, 0, 0], 1, 1.275, 1, 0, [8,14],
			[[0.1,0.1,0.1,1],[0.1,0.1,0.1,0]], [0.5], 0.1, 0.1, "", "", _v];
//_smoke setParticleCircle [2,[0,0,0]];
_smoke setParticleRandom [4, [2, 2, 2], [0, 0, 0], 0, 0, [0, 0, 0, 0], 0, 0];
_smoke setDropInterval 0.02;

_fire = "#particlesource" createVehicleLocal _pos;
_fire attachto [_v,[0,0,0],"destructionEffect2"];
/*_fire setParticleParams [["\ca\Data\ParticleEffects\Universal\Universal",16,2,32], "", "Billboard", 1, 1, [0, 1, 0], [0, 0, 0], 1, 1.275, 1, 0, [10,15],
          [[1,1,1,-1],[1,1,1,0]], [0.5], 0.01, 0.01, "", "", _v,360]; */
_fire setParticleParams [["\ca\Data\ParticleEffects\Universal\Universal",16,2,80],
		"", "Billboard", 1, 2, [0, 1, 0], [0, 0, 0], 1, 1.275, 1, 0, [7,13],
                [[1,1,1,-1],[1,1,1,0]], [0.5], 0.01, 0.01, "", "", _v,360];
_fire setParticleRandom [0.5, [0.5, 0.5, 0.5], [0, 0, 0], 0, 0, [0, 0, 0, 0], 0, 0];
_fire setDropInterval 0.01;
/*
_shards = "#particlesource" createVehicleLocal _pos;
//_shards attachto [_v,[0,0,0],"destructionEffect1"];
_shards setParticleParams [["\CA\Data\ParticleEffects\Shard\shard",1,0,1], "", "SpaceObject", 1, 60, [0, 0, 0], [0, 0, 0], 0, 1.275, 1, 0, [1,1],
                       [[1,1,1,1]], [0.5], 0, 0, "", "", _v];
		       _shards setParticleRandom [30, [1, 1, 0], [0, 0, 0], 0, 0, [0, 0, 0, 0], 0, 0];
_shards setParticleCircle [2,[0.001,0.001,-0.001]];
_shards setDropInterval 0.05;
*/
_dirt = "#particlesource" createVehicleLocal _pos;
_dirt attachto [_v,[0,0,0],"destructionEffect1"];
_dirt setParticleParams [["\ca\Data\ParticleEffects\Universal\Universal",16,12,9,0], "", "Billboard", 1, 5, [0, 0, 0], [0, 0, 5], 0, 5, 1, 0, [10,20],
	  [[0.1,0.1,0.1,1],[0.1,0.1,0.1,0.7],[0.1,0.1,0.1,0]], [1000], 0, 0, "", "", _v,360];
	  _dirt setParticleRandom [0, [1, 1, 1], [1, 1, 2.5], 0, 0, [0, 0, 0, 0.5], 0, 0];
_dirt setDropInterval 0.05;

	//creating ground craters
	_i=0;
	while {(speed _v) > 0.1} do
	{
		_pos=getpos _v;
		_xv=velocity _v select 0;
		_yv=velocity _v select 1;
		_dir = abs(_xv atan2 _yv);

		_speed = (speed _v);
		_velz=velocity _v select 2;

		if (_velz>1) then {_v setvelocity [_xv/1.3,_yv/1.3,0]}
		else {_v setvelocity [_xv/1.2,_yv/1.2,velocity _v select 2]};

		_tv=abs(_xv)+abs(_yv)+abs(_zv);
		if (_tv>2) then {_dr=1/_tv} else {_dr=1};
		_smoke setDropInterval _dr*1.5;
		_fire setDropInterval _dr*1.5;
		_dirt setDropInterval _dr;
		_shards setDropInterval _dr;

		sleep (0.25 - (_speed / 1000));
		_i = _i + 1;
	};
deleteVehicle _smoke;
deleteVehicle _fire;
deleteVehicle _shards;
deleteVehicle _dirt;

_v setvelocity [0,0,-0.1];
if (local _v) then
{
	_v setVehicleInit format ["[this, %1, %2,false,true]spawn BIS_Effects_Burn",_int, _t];
	processInitCommands; //ClearvehicleInit done at end of burn script
	[_v,_int,false] spawn BIS_Effects_Secondaries;
};
sleep 0.5;
_v setvelocity [0,0,-0.01];
