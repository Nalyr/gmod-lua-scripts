// Herpes V3

// jewish bullshit hack noob hlh copypastens rip gd thread stealer 1992

// do something stupid
// 74.76.145.38:27015 -- amazing server full of amazing admins 

// fiki: http://steamcommunity.com/profiles/76561198024880684/ -- mini
// fiki: http://steamcommunity.com/profiles/76561198040607431/ -- asds


local ___h = nil;
if( _G['HERPES'] ) then
	___h = table.Copy( _G['HERPES'] );
end

// Some tables and copies
local HERPES 		= {};
HERPES['detours'] 	= {};
HERPES['metatbls']	= {};
HERPES['hooks']		= {};
HERPES['meta'] 		= {};
HERPES['setting']	= {};
HERPES['key']		= {};

local ___g = _G;

// do it all over again
//include( 'includes/init.lua' )

// useful function
local function FreeMetatable( tbl )
	___g["rawset"]( tbl, "__metatable", {} );
	local meta = ___g["debug"]["getmetatable"]( tbl );
	if( meta && ___g["type"]( meta ) != "table" ) then
		meta.__metatable = {};
	end
end

// Some detourz
function HERPES:Detour( old, new )
	HERPES['detours'][new] = old;
	return new;
end

local oldPrint = print;

local __lua = {};
local bModuleLoaded = false;

_G.require = HERPES:Detour( _G.require, function( binary )
	if( ( binary:lower() == "herpes" ) && !bModuleLoaded ) then
		local ac_lua = nil;
		local c_lua = nil;
		
		if( _lua ) then
			ac_lua = _lua;
		end
		
		HERPES.detours[_G.require]( binary );
		
		c_lua = _lua;
		
		_lua = nil;
		__lua = c_lua;
		
		if( ac_lua ) then
			_lua = ac_lua;
		end
		
		bModuleLoaded = true;
		return true;
	elseif( ( binary:lower() == "herpes" ) && bModuleLoaded ) then
		oldPrint( "Attempted to load gmcl_herpes.dll again..." );
		return false;
	end
	return HERPES.detours[_G.require]( binary );
end )

// local copies = larger phallus
local __i 		= include;
local __r 		= require;
local __t		= table;
local __s		= surface;
local __d		= debug;
local __tm 		= team;
local __f		= file;
local __ti		= timer;
local __str		= string;
local __dr		= draw;
local __in		= input;
local __m		= math;
local __u 		= util;
local __c		= cam;
local __re		= render;
local __v		= vgui;

// key binding and hook locking
local pTar = nil;
local __lock 	= false;
HERPES['__aim'] = false;
HERPES['__speed'] = false;
HERPES['__tar'] = nil;
HERPES['__menu'] = false;
HERPES['__ang'] = Angle( 0, 0, 0 );

// colors
local COLORS = {
	Red 	= Color( 255, 0, 0, 255 ),
	Green 	= Color( 0, 255, 0, 255 ),
	Blue 	= Color( 0, 0, 255, 255 ),
	Purple	= Color( 128, 0, 128, 255 ),
	White 	= Color( 255, 255, 255, 255 ),
	Black 	= Color( 0, 0, 0, 255 ),
};

__r( 'herpes' ); //0x02 0x06 0xA6 0xCEC2DAD9 0xCFD80000 (hashed)

local plInfo = {};
local tblEnts = {};
local tblFriends = {};
local ply = nil;

// copy globals again (???)
local copy, copyR, c = __t.Copy( ___g ), __t.Copy( _R ), {};

// Copy meta table shit
function HERPES:CopyMeta( meta )
	if( HERPES['meta'][meta] ) then return HERPES['meta'][meta] end
	HERPES['meta'][meta] = __t.Copy( _R[meta] );
	return HERPES['meta'][meta];
end

function HERPES:Execute()
	c.Player 	= HERPES:CopyMeta( "Player" );
	c.Entity 	= HERPES:CopyMeta( "Entity" );
	c.CUserCmd 	= HERPES:CopyMeta( "CUserCmd" );
	c.Angle 	= HERPES:CopyMeta( "Angle" );
	c.Vector 	= HERPES:CopyMeta( "Vector" );
end

// Spoofing _G/_R to go back to there default values
local function ____spoofG()
	// removed
end

// Spoofing debug table like a pr0
debug.getinfo = HERPES:Detour( debug.getinfo, function( func, ... )
	// Skip the callback from this file to the next which should be
	// where the file is really being called.
	local newFunc = ( type( func ) == "number" ) && func + 1 || func;
	
	local tbl = HERPES.detours[debug.getinfo]( HERPES.detours[func] || newFunc, ... );
	if( tbl != nil ) then
		tbl.func = HERPES.detours[func] || tbl.func;
	end
	return tbl;
end )

debug.getupvalue = HERPES:Detour( debug.getupvalue, function( func, ... )
	return HERPES.detours[debug.getupvalue]( HERPES.detours[func] || func, ... )
end )

// table.Empty is gay as penis?
table.Empty = HERPES:Detour( table.Empty, function( tbl )
	if( tbl == _G || tbl == _R ) then
		oldPrint( "Someone has attempted to empty _G or _R!" );
		return;
	end
	return HERPES.detours[table.Empty]( tbl )
end )

// Hooking
hook.Call = HERPES:Detour( hook.Call, function( name, gm, ... )
	local args = {...}
	for k, e in copy['pairs']( HERPES['hooks'] ) do
		if( ( __lock == false ) && k == name ) then
			if( args == nil ) then
				ret = e()
			else
				ret = e( ... )
			end
			if( ret != nil ) then return ret end
		end
	end
	return HERPES.detours[hook.Call]( name, gm, ... );
end )

file.Find = HERPES:Detour( file.Find, function( name )
	local ret = HERPES.detours[file.Find]( name );
	for k, v in pairs( ret ) do
		if( v:lower():find( "herpes" ) || v:lower():find( "!!!!!init.lua" ) ) then
			ret[ k ] = nil
		end
	end
	return ret;
end )

file.Exists = HERPES:Detour( file.Exists, function( name )
	if( name:lower():find( "herpes" ) || name:lower():find( "!!!!!init.lua" ) ) then
		return false;
	end
	return HERPES.detours[file.Exists]( name );
end )

function HERPES:AddHook( name, func )
	HERPES['hooks'][name] = func;
	return;
end

// Setting saving
local ___s = {}
function HERPES:Setting( name, value, min, max, help )
	HERPES['setting'][name] = { value, min, max, help };
end

// Quick friends adding/removing
local plQuickRef = {};
local function ReadID( pl )
	if( plQuickRef[pl] ) then return plQuickRef[pl] end
	local id = tostring( pl:SteamID() );
	id = __str.gsub( id, "STEAM_0:", "" );
	id = __str.gsub( id, ":", "" );
	plQuickRef[pl] = id;
	return id;
end

// File system oh god
local function CreateFile()
	local buildTxt = "";
	
	buildTxt = "[cvars]\n";
	for k, v in pairs( HERPES['setting'] ) do
		buildTxt = buildTxt .. __str.format( "%s=%i\n", k, v[1] );
	end
	
	buildTxt = buildTxt .. "[friends]\n";
	for k, v in pairs( tblFriends ) do
		if( k && IsValid( k ) ) then
			buildTxt = buildTxt .. __str.format( "%s=%s\n", k:Nick() || "NULL", ReadID( k ) );
		end
	end
	
	__f.Write( "saves.txt", buildTxt );
end

local function ReadFile()
	if( !__f.Exists( "saves.txt" ) ) then
		return;
	end
	
	local contents = __str.Explode( "\n", __f.Read( "saves.txt" ) );
	
	for k, v in pairs( contents ) do
		local cut = __str.Explode( "=", v );
		for k, v in pairs( HERPES['setting'] ) do
			if( HERPES['setting'][cut[1]] ) then
				HERPES['setting'][cut[1]][1] = tonumber( cut[2] );
			end
		end
		
		for e, q in pairs( player.GetAll() ) do
			if( q && ValidEntity( q ) ) then
				local id = ReadID( q );
				if( tostring( id ) == tostring( cut[2] ) ) then
					tblFriends[q] = true;
				end
			end
		end
	end
end

// friends system
local function AddFriend( id )
	for k, v in pairs( plQuickRef ) do
		if( tostring( v ) == tostring( id ) ) then
			tblFriends[k] = true;
			CreateFile();
			return k:Nick();
		end
	end
	return "Unknown"
end

local function RemoveFriend( id )
	for k, v in pairs( plQuickRef ) do
		if( tostring( v ) == tostring( id ) ) then
			tblFriends[k] = nil;
			CreateFile();
			return k:Nick();
		end
	end
	return "Unknown";
end

// KeyEvent
local __kp = {};
function HERPES:AssignKey( key, func )
	HERPES['key'][key] = func;
	return;
end

function HERPES.KeyEvent()
	for k, v in copy['pairs']( HERPES['key'] ) do
		if( __in.IsKeyDown( k ) ) then
			HERPES[v] = true;
		else
			HERPES[v] = false;
		end
	end
	HERPES.Console();
end

HERPES:AssignKey( KEY_INSERT, "__menu" );
HERPES:AssignKey( KEY_F, "__aim" );
HERPES:AssignKey( KEY_LALT, "__speed" );

HERPES:Execute();

// graydon legit config BEGIN
// name, value, min, max, desc
HERPES:Setting( "aim_autoshoot", 1, 0, 1, "Shoot when locked target" );
HERPES:Setting( "aim_autowall", 1, 0, 1, "Detect penetrable walls (madcow only)" );
HERPES:Setting( "aim_fov", 180, 0, 180, "Feild of view" );
HERPES:Setting( "aim_team", 1, 0, 1, "Aim at team members" );
HERPES:Setting( "aim_steam", 0, 0, 1, "Aim at steam friend" );
HERPES:Setting( "aim_npc", 0, 0, 1, "Aim at NPCs" );
HERPES:Setting( "aim_trigger", 0, 0, 1, "Shoot when crosshair over player" );
HERPES:Setting( "aim_calcview", 1, 0, 1, "Norecoil, silentaim..." );
HERPES:Setting( "aim_weaponchecks", 0, 0, 1, "Check for ammo, weapon state..." );
HERPES:Setting( "esp_enable", 1, 0, 1, "Turn ESP on" );
HERPES:Setting( "esp_fov", 0, 0, 1, "Draw FOV" );
HERPES:Setting( "esp_crosshair", 1, 0, 1, "Crosshair" );
HERPES:Setting( "esp_wallhack", 1, 0, 1, "Turn wallhack on" );
HERPES:Setting( "esp_xray", 0, 0, 1, "Make all props transparent" );
HERPES:Setting( "esp_barrel", 0, 0, 1, "Turn barrelhack on" );
HERPES:Setting( "esp_lights", 0, 0, 1, "Dynamic lights below players" );
HERPES:Setting( "misc_antiaim", 0, 0, 1, "Avoid other aimbots" );
HERPES:Setting( "misc_class", 0, 0, 1, "Show classname of view entity" );
HERPES:Setting( "misc_speedvalue", 5, 0, 10, "Speed hack speed" );

local bones = {}
bones["models/combine_scanner.mdl"] = "Scanner.Body"
bones["models/hunter.mdl"] = "MiniStrider.body_joint"
bones["models/combine_turrets/floor_turret.mdl"] = "Barrel"
bones["models/dog.mdl"] = "Dog_Model.Eye"
bones["models/vortigaunt.mdl"] = "ValveBiped.Head"
bones["models/antlion.mdl"] = "Antlion.Body_Bone"
bones["models/antlion_guard.mdl"] = "Antlion_Guard.Body"
bones["models/antlion_worker.mdl"] = "Antlion.Head_Bone"
bones["models/zombie/fast_torso.mdl"] = "ValveBiped.HC_BodyCube"
bones["models/zombie/fast.mdl"] = "ValveBiped.HC_BodyCube"
bones["models/headcrabclassic.mdl"] = "HeadcrabClassic.SpineControl"
bones["models/headcrabblack.mdl"] = "HCBlack.body"
bones["models/headcrab.mdl"] = "HCFast.body"
bones["models/zombie/poison.mdl"] = "ValveBiped.Headcrab_Cube1"
bones["models/zombie/classic.mdl"] = "ValveBiped.HC_Body_Bone"
bones["models/zombie/classic_torso.mdl"] = "ValveBiped.HC_Body_Bone"
bones["models/zombie/zombie_soldier.mdl"] = "ValveBiped.HC_Body_Bone"
bones["models/combine_strider.mdl"] = "Combine_Strider.Body_Bone"
bones["models/combine_dropship.mdl"] = "D_ship.Spine1"
bones["models/combine_helicopter.mdl"] = "Chopper.Body"
bones["models/gunship.mdl"] = "Gunship.Body"
bones["models/lamarr.mdl"] = "HeadcrabClassic.SpineControl"
bones["models/mortarsynth.mdl"] = "Root Bone"
bones["models/synth.mdl"] = "Bip02 Spine1"
bones["mmodels/vortigaunt_slave.mdl"] = "ValveBiped.Head"

local function GetPosType( e, pos )
	if( copy['type']( pos ) == "string" ) then
		return c.Entity['GetBonePosition']( e, c.Entity['LookupBone']( e, pos ) );
	elseif( copy['type']( pos ) == "Vector" ) then
		return c.Entity['LocalToWorld']( e, c.Entity['OBBCenter']( e ) + pos );
	end
	return ( c.Entity['LocalToWorld']( e, pos ) )
end

local eye_model_fix = {
	["models/player/phoenix.mdl"] 				= Vector( -3, 0, 4 ),
	["models/player/arctic.mdl"] 				= Vector( -3, 0, 1 ),
	["models/player/guerilla.mdl"] 				= Vector( -3, 0, 5 ),
	["models/player/classic.mdl"] 				= Vector( 6, 0, 0 ),
	["models/player/urban.mbl"]					= Vector( 0, -2, 3 ),
	["models/player/gasmask.mdl"]				= Vector( 0, -2, 3 ),
	["models/player/riot.mdl"]					= Vector( 0, -2, 3 ),
	["models/player/swat.mdl"]					= Vector( 0, -2, 3 ),
	["models/player/leet.mdl"]					= Vector( 0, -2, 3 ),
	["models/player/zombie_soldier.mdl"] 		= Vector( 0, -4, 0 ),
	["models/player/combine_super_soldier.mdl"]	= Vector( 0, -4, 1 ),
	["models/player/charple01.mdl"]				= Vector( 3, 2, 0 ),
	["models/breen.mdl"] 						= Vector( 0, -2, 0 ),
	["models/player/charple01.mdl"]				= Vector( 0, -3, 0 ),
	["models/player/gman_high.mdl"]				= Vector( 0, -3, 0 ),
	["models/player/dod_american.mdl"] 			= Vector( -2, 0, 0 ),
	["models/alyx.mdl"]							= Vector( 0, -2, 0 ),
	["models/humans/group03/male_03.mdl"] 		= Vector( 0, 3, 0 ),
	["models/humans/group01/male_03.mdl"] 		= Vector( -3, 0, 0 ),
};

local attachments = { 
	//"eyes",
	"head",
	"forward",
};

function HERPES:HeadPos( e )
	if( !ValidEntity( e ) ) then return Vector( 0, 0, 0 ) end;
	
	if( e:IsPlayer() ) then
		local pitch = e:EyeAngles().p;
		if( ( pitch > 89 && pitch <= 180  ) || pitch > 180 && pitch < 271 ) then
			return c.Entity['LocalToWorld']( e, c.Entity['OBBCenter']( e ) );
		end
	end
	
	for k, v in copy['pairs']( attachments ) do
		local att = c.Entity['GetAttachment']( e, c.Entity['LookupAttachment']( e, v ) );
		if( att ) then
			return att['Pos'];
		end
	end
	
	local model = c.Entity['GetModel']( e );
	if( bones[model] ) then
		return GetPosType( e, bones[model] );
	end
	
	return GetPosType( e, "ValveBiped.Bip01_Head1" );
end

// HUDPaint

// XRay Hack
local props = {
	"prop_physics",
	"prop_door_rotating",
	"func_breakable_surf",
	"func_door_rotating",
	"func_door",
};

local xrayents = {};

local function xray()
	if( copy['tonumber']( HERPES['setting']['esp_xray'][1] ) == 1 ) then
		for k, v in copy.pairs( props ) do
			local _ent = ents.FindByClass( v );
			if( _ent ) then
				for index, ent in copy.pairs( _ent ) do
					ent:SetColor( 255, 255, 255, 170 );
					xrayents[ent] = index;
				end
			end
		end
	else
		if( xrayents ) then
			for k, v in copy.pairs( xrayents ) do
				if( ValidEntity( k ) ) then
					k:SetColor( 255, 255, 255, 255 );
				end
				xrayents[k] = nil;
			end
		end
	end
end

// pastebin.com/cZCHYrKv I DID IT BEFORE HADES RELEASE SEE!!!
// also ignore my spelling errors im not the best germany
local skeleton = {
	{ "ValveBiped.Bip01_Head1", "ValveBiped.Bip01_Neck1" },
	{ "ValveBiped.Bip01_Neck1", "ValveBiped.Bip01_Spine4" },
	{ "ValveBiped.Bip01_Spine4", "ValveBiped.Bip01_Spine2" },
	{ "ValveBiped.Bip01_Spine2", "ValveBiped.Bip01_Spine1" },
	{ "ValveBiped.Bip01_Spine1", "ValveBiped.Bip01_Spine" },
	{ "ValveBiped.Bip01_Spine", "ValveBiped.Bip01_Pelvis" },
	{ "ValveBiped.Bip01_Spine2", "ValveBiped.Bip01_L_UpperArm" },
	{ "ValveBiped.Bip01_L_UpperArm", "ValveBiped.Bip01_L_Forearm" },
	{ "ValveBiped.Bip01_L_Forearm", "ValveBiped.Bip01_L_Hand" },
	{ "ValveBiped.Bip01_Spine2", "ValveBiped.Bip01_R_UpperArm" },
	{ "ValveBiped.Bip01_R_UpperArm", "ValveBiped.Bip01_R_Forearm" },
	{ "ValveBiped.Bip01_R_Forearm", "ValveBiped.Bip01_R_Hand" },
	{ "ValveBiped.Bip01_Pelvis", "ValveBiped.Bip01_L_Thigh" },
	{ "ValveBiped.Bip01_L_Thigh", "ValveBiped.Bip01_L_Calf" },
	{ "ValveBiped.Bip01_L_Calf", "ValveBiped.Bip01_L_Foot" },
	{ "ValveBiped.Bip01_L_Foot", "ValveBiped.Bip01_L_Toe0" },
	{ "ValveBiped.Bip01_Pelvis", "ValveBiped.Bip01_R_Thigh" },
	{ "ValveBiped.Bip01_R_Thigh", "ValveBiped.Bip01_R_Calf" },
	{ "ValveBiped.Bip01_R_Calf", "ValveBiped.Bip01_R_Foot" },
	{ "ValveBiped.Bip01_R_Foot", "ValveBiped.Bip01_R_Toe0" },
}

local function drawSkeleton( e )
	if ( c.Entity['IsPlayer']( e ) ) then return end
	
	for k, v in pairs( skeleton ) do
		local spos = c.Vector['ToScreen']( c.Entity['GetBonePosition']( e, c.Entity['LookupBone']( e, v[1] ) ) );
		local epos = c.Vector['ToScreen']( c.Entity['GetBonePosition']( e, c.Entity['LookupBone']( e, v[2] ) ) );
		
		__s.SetDrawColor( 255, 255, 255, 255 )
		__s.DrawLine( spos.x, spos.y, epos.x, epos.y )
	end
end

HERPES.laser = {};

function HERPES:CreateLaserObject( name )
	if( HERPES.laser[name:lower()] ) then return HERPES.laser[name:lower()] end
	
	local color = copy.Color( 0, 255, 0, 255 );
	local info = {
		["$basetexture"]	= "sprites/laser",
		["$additive"]		= 1,
		["$translucent"]	= 1,
		["$vertexcolor"]	= 1,
		["$color"]			= __str.format( "{%c %c %c}", color.r, color.g, color.b ),
	}
	
	local mat = copy.CreateMaterial( __str.format( "_%s_%s_%s", "HERPES", "laser", name:lower() ), "UnlitGeneric", info )
	HERPES.laser[name:lower()] = mat
	return mat
end

local function DrawGradient( x, y, w, h, color, off )
	w = w * 2;
	h = h * 2;
	
	for i = 1, ( w + off ) do
		local col = ( i / ( w + off ) );
		surface.SetDrawColor( 0, 0, 0, ( color.a * ( 1 - col ) ) );
		surface.DrawRect( x, y - 1, i, 3 );
		
		surface.SetDrawColor( 0, 0, 0, ( color.a * ( 1 - col ) ) );
		surface.DrawRect( x - i, y - 1, i, 3 );
	end
	for i = 1, ( h + off ) do
		local col = ( i / ( h + off ) );
		surface.SetDrawColor( 0, 0, 0, ( color.a * ( 1 - col ) ) );
		surface.DrawRect( x - 1, y, 3, i );
		
		surface.SetDrawColor( 0, 0, 0, ( color.a * ( 1 - col ) ) );
		surface.DrawRect( x - 1, y - i, 3, i );
	end
	
	for i = 1, w do
		local col = ( i / w );
		surface.SetDrawColor( color.r, color.g, color.b, ( color.a * ( 1 - col ) ) );
		surface.DrawLine( x, y, x + i, y );
		
		surface.SetDrawColor( color.r, color.g, color.b, ( color.a * ( 1 - col ) ) );
		surface.DrawLine( x, y, x - i, y );
	end
	for i = 1, h do
		local col = ( i / h );
		surface.SetDrawColor( color.r, color.g, color.b, ( color.a * ( 1 - col ) ) );
		surface.DrawLine( x, y, x, y + i );
		
		surface.SetDrawColor( color.r, color.g, color.b, ( color.a * ( 1 - col ) ) );
		surface.DrawLine( x, y, x, y - i );
	end
end

function HERPES:Crosshair()
	DrawGradient( ScrW() / 2, ScrH() / 2, 5, 5, Color( 255, 0, 0, 255 ), 2 )
end

local function FixTableOrder( k, v )
	local oK, oV = k, v;
	
	k = oV;
	v = oK;
	
	return k, v;
end

local passTime = 0;

function HERPES.HUDPaint()
	xray();
	
	if( copy['tonumber']( HERPES['setting']['esp_enable'][1] ) == 0 ) then
		return;
	end
	
	local x, y, color
	local mon, nom;
	local h, w;
	local bot, top;
	local pos, hitPos;
	local mat;
	
	for k, v in copy['pairs']( copy.tonumber( HERPES['setting']['aim_npc'][1] ) == 0 && copy['player']['GetAll']() || tblEnts ) do
		if( copy.tonumber( HERPES['setting']['aim_npc'][1] ) == 1 ) then
			k, v = FixTableOrder( k, v );
		end
		if( v && !ValidEntity( v ) || ( v == ply ||
			( v:IsPlayer() && !c.Player['Alive']( v ) ) ||
			c.Entity['GetMoveType']( v ) == MOVETYPE_NONE ) ) then
			continue;
		end
		
		if( passTime < 500 ) then
			ReadFile();
			passTime = 501;
		end
		
		// directly from s0beits base hook (connecting headpos to abs orgin isn't the best method for boxens esp) 
		nom = c.Entity['GetPos']( v );
		mon = nom + Vector( 0, 0, c.Entity['OBBMaxs']( v ).z );
		
		bot = c.Vector['ToScreen']( nom );
		top = c.Vector['ToScreen']( mon );
		
		if( bot['visible'] && top['visible'] ) then
			h = ( bot['y'] - top['y'] );
			w = h;
			
			local col = ( v:IsPlayer() && plInfo[v] && plInfo[v].IsEntVisible ) && COLORS.Blue || COLORS.Green;
			if( v:IsPlayer() && ( c.Player['GetFriendStatus']( v ) == "friend" || tblFriends[v] == true ) ) then
				col = COLORS.Purple;
			end
			if( v == pTar ) then
				col = COLORS.White;
			end
			col.a = 220;
			
			__s.SetDrawColor( col );
			
			__s.DrawOutlinedRect( ( top['x'] - ( w / 2 ) ), ( top['y'] ), w, ( bot.y - top.y ) );
			__s.DrawOutlinedRect( ( top['x'] - ( w / 2 ) ) - 1, ( top['y'] ) - 1, w + 2, ( bot.y - top.y ) + 2 );
			
			x 		= ( top['x'] );
			y 		= top['y'] - ( v:IsPlayer() && 24 || 12 );
			
			color 	= v:IsPlayer() && __tm.GetColor( c.Player['Team']( v ) ) || COLORS.Green;
			color.a = 255;
			
			__dr.SimpleText( v:IsPlayer() && c.Player['Nick']( v ) || c.Entity['GetClass']( v ), "DefaultSmallDropShadow", x, y, color, 1, 1 );
			
			if( !v:IsPlayer() ) then
				continue;
			end
			
			__dr.SimpleText( __str.format( "Hp:%i", c.Entity['Health']( v ) || 0 ), "DefaultSmallDropShadow", x, y + 12, color, 1, 1 );
		end
	end
	
	if( copy['tonumber']( HERPES['setting']['misc_class'][1] ) == 1 ) then
		local trc = ply:GetEyeTrace();
		if( trc && trc.Entity && ValidEntity( trc.Entity ) ) then
			local ent = trc.Entity;
			local pos = c.Vector['ToScreen']( c.Entity['LocalToWorld']( ent, c.Entity['OBBCenter']( ent ) ) );
			
			local str = c.Entity['GetClass']( ent );
			if( ent.Health && ( ent:Health() || 0 ) != 0 ) then
				local percent_hp = ent:Health();
				str = __str.format( "%s (%i)", str, percent_hp );
			end
			__dr.SimpleText( str, "TabLarge", pos.x, pos.y, COLORS.Green, 1, 1 );
		end
	end
	
	if( copy['tonumber']( HERPES['setting']['esp_fov'][1] ) == 1 && copy['tonumber']( HERPES['setting']['aim_fov'][1] ) < 35 ) then
		// thanks gmod wiki
		local mX, mY = ScrW() / 2, ScrH() / 2;
		local scale = copy['tonumber']( HERPES['setting']['aim_fov'][1] ) * 14.5
		local segmentdist = 360 / ( 2 * math.pi * math.max( scale, scale ) / 2 )
		
		__s.SetDrawColor( 255, 255, 255, 255 )
		for a = 0, 360 - segmentdist, segmentdist do
			__s.DrawLine( mX + math.cos( math.rad( a ) ) * scale, mY - math.sin( math.rad( a ) ) * scale, mX + math.cos( math.rad( a + segmentdist ) ) * scale, mY - math.sin( math.rad( a + segmentdist ) ) * scale )
		end
	end
	if( copy['tonumber']( HERPES['setting']['esp_crosshair'][1] ) == 1 ) then
		HERPES:Crosshair();
	end
	
	passTime = passTime + 1;
end
HERPES:AddHook( "PostRenderVGUI", HERPES.HUDPaint );

// XQZ
function HERPES.RenderScreenspaceEffects()
	if( copy['tonumber']( HERPES['setting']['esp_wallhack'][1] ) == 0 ) then
		return;
	end
	
	__c.Start3D( copy['EyePos'](), copy['EyeAngles']() )
	for k, v in copy['pairs']( copy['player']['GetAll']() ) do
		if( v && ( v == ply ||
			!c.Player['Alive']( v ) ||
			c.Entity['GetMoveType']( v ) == MOVETYPE_NONE ) ) then
			continue;
		end
		
		__c.IgnoreZ( true );
			__re.SuppressEngineLighting( false );
			c.Entity['DrawModel']( v );
		__c.IgnoreZ( false );
		__re.SuppressEngineLighting( false );
		
		if( copy['tonumber']( HERPES['setting']['esp_barrel'][1] ) == 1 ) then
			mat = HERPES:CreateLaserObject( "$$green" );
			pos, hitPos = HERPES:HeadPos( v ), c.Player['GetEyeTrace']( v ).HitPos;
			__re.SetMaterial( mat );
			__re.DrawBeam( pos, hitPos, 5, 0, 0, COLORS.Green );
		end
	end
	__c.End3D();
end
HERPES:AddHook( "RenderScreenspaceEffects", HERPES.RenderScreenspaceEffects );

// Nospread
HERPES.bullet = {}

local function WeaponVector( value, typ, vec )
	if ( !vec ) then return copy["tonumber"]( value ) end
	local s = ( copy["tonumber"]( value ) )
	if ( typ == true ) then
		s = ( copy["tonumber"]( -value ) )
	end
	return copy["Vector"]( s, s, s )
end

local CONE = {}

CONE.weapon = {}
CONE.weapon["weapon_pistol"]			= WeaponVector( 0.0100, true, true )	// HL2 Pistol
CONE.weapon["weapon_smg1"]				= WeaponVector( 0.04362, true, true )	// HL2 SMG1
CONE.weapon["weapon_ar2"]				= WeaponVector( 0.02618, true, true )	// HL2 AR2
CONE.weapon["weapon_shotgun"]			= WeaponVector( 0.08716, true, true )	// HL2 SHOTGUN
CONE.weapon["weapon_zs_zombie"]			= WeaponVector( 0.0, true, true )		// REGULAR ZOMBIE HAND
CONE.weapon["weapon_zs_fastzombie"]		= WeaponVector( 0.0, true, true )		// FAST ZOMBIE HAND

// noPE showed me this (before turbobot release)
_R.Entity.FireBullets = HERPES:Detour( _R.Entity.FireBullets, function( e, bullet )
	local w = c.Player["GetActiveWeapon"]( ply );
	HERPES.bullet[c.Entity["GetClass"]( w )] = bullet.Spread;
	return HERPES.detours[ _R.Entity.FireBullets ]( e, bullet );
end )

// data method (for gamemodes that use cones that change when jumping, walking...)
local DATA = {
	["gta_base"] = function( cone )
		local pl = copy['LocalPlayer']();
		local VELOCITY = c.Vector["Length"]( c.Entity["GetVelocity"]( pl ) );
		if( c.Player["KeyDown"]( pl, IN_SPEED ) && VELOCITY != 0 ) then
			return cone * 2.5;
		elseif( c.Player["KeyDown"]( pl, IN_FORWARD | IN_BACK | IN_MOVELEFT | IN_MOVERIGHT ) ) then
			if( c.Player["KeyDown"]( pl, IN_DUCK | IN_WALK ) ) then
				cone = math.Clamp( cone * 1.5, 0, 10 );
			end
			return cone * 2.0;
		elseif( c.Player["KeyDown"]( pl, IN_DUCK ) || ( c.Player["KeyDown"]( pl, IN_WALK ) && VELOCITY != 0 ) ) then
			return math.Clamp( cone / 1.2, 0, 10 );
		end
		return cone || 0;
	end,
	["sniper_base"] = function( cone )
		local pl = copy['LocalPlayer']();
		if( c.Player["KeyDown"]( pl, IN_FORWARD | IN_BACK | IN_MOVELEFT | IN_MOVERIGHT ) ) then
			return cone * 2.5
		elseif( c.Player["KeyDown"]( pl, IN_DUCK | IN_WALK ) ) then
			return math.Clamp( cone / 2.5, 0, 10 )
		end
		return cone || 0;
	end,
	["firearm_base"] = function( cone )
		local pl = copy['LocalPlayer']();
		if( c.Player["KeyDown"]( pl, IN_FORWARD | IN_BACK | IN_MOVELEFT | IN_MOVERIGHT ) ) then
			return cone * 1.5
		elseif( c.Player["KeyDown"]( pl, IN_DUCK | IN_WALK ) ) then
			return math.Clamp( cone / 2, 0, 10 )
		end
		return cone || 0;
	end,
	["as_swep_base"] = function( cone )
		local pl = copy['LocalPlayer']();
		local w = c.Player["GetActiveWeapon"]( pl );
		if( w ) then
			return cone / ( w:GetAccuracyModifier() );
		end
		return cone || 0;
	end,
}

function HERPES:PredictSpread( ucmd, angle )
	local w = c.Player["GetActiveWeapon"]( ply );
	if ( w && c.Entity["IsValid"]( w ) ) then
		local class = c.Entity["GetClass"]( w );
		if ( !CONE.weapon[class] ) then
			if ( HERPES.bullet[class] ) then
				local ang = c.Angle["Forward"]( angle ) || c.Vector["Forward"]( c.Vector["Angle"]( c.Player["GetAimVector"] ) );
				local conevec = Vector( 0, 0, 0 ) - HERPES.bullet[class] || Vector( 0, 0, 0 )
				return c.Vector["Angle"]( __lua.Nospread( ucmd, ang, conevec ) )
			end
		else
			local ang = c.Angle["Forward"]( angle ) || c.Vector["Forward"]( c.Vector["Angle"]( c.Player["GetAimVector"] ) );
			local conevec = CONE.weapon[class]
			
			local ret = c.Vector["Angle"]( __lua.Nospread( ucmd, ang, conevec ) );
			if( copy.tonumber( HERPES['setting']['misc_antiaim'][1] ) == 1 ) then
				return ret + c.Player['GetPunchAngle']( ply );
			else
				return ret - c.Player['GetPunchAngle']( ply );
			end
		end
	end
	return angle
end

// Aimbot

// Check if player is dead or alive
local function CheckLifeState( pl )
	if( pl:IsNPC() ) then
		
		local bCreated = false;
		if( !plInfo[pl] ) then
			plInfo[pl] = {};
			
			plInfo[pl].SpawnHealth 		= 0.0;
			plInfo[pl].IsEntVisible		= false;
			
			// Entity has just passed this table, so it was just spawned.
			bCreated = true;
		end
		
		plInfo[pl].IsEntVisible = ( HERPES:IsVisible( pl ) == 1 || HERPES:IsVisible( pl ) == 2 ) && true || false;
		
		if( bCreated ) then
			plInfo[pl].SpawnHealth = pl.Health && pl:Health() || 0;
		end
		
		return;
	end
	
	// Init varaibles if they didn't exist before
	if( !plInfo[pl] ) then
		plInfo[pl] = {};
		
		// Varaibles
		plInfo[pl].IsEntVisible			= false;
		plInfo[pl].IsAlive 				= false;
		plInfo[pl].DiedThisFrame 		= false;
		plInfo[pl].SpawnedThisFrame 	= false;
		plInfo[pl].IsSpawnProtected		= false;
		plInfo[pl].InPenitration		= false;
		
		plInfo[pl].SpawnHealth			= 0.0;
		
		plInfo[pl].LF = {}
		plInfo[pl].LF.IsAlive			= false;
	end
	
	// Restor these back to normal as they only are true for ONE frame
	plInfo[pl].DiedThisFrame 	= false;
	plInfo[pl].SpawnedThisFrame = false;
	plInfo[pl].InPenitration	= false;
	
	// Normal check
	plInfo[pl].IsAlive = c.Player['Alive']( pl );
	
	// Player is DEAD and was ALIVE last frame.
	if( ( plInfo[pl].IsAlive == false ) && ( plInfo[pl].LF.IsAlive == true ) ) then
		plInfo[pl].DiedThisFrame = true;
	end
	
	// Player is ALIVE and was DEAD last frame.
	if( ( plInfo[pl].IsAlive == true ) && ( plInfo[pl].LF.IsAlive == false ) ) then
		plInfo[pl].SpawnedThisFrame = true;
		plInfo[pl].SpawnHealth = pl:Health() || 100;
	end
	
	// Is the player visible?
	plInfo[pl].IsEntVisible = ( HERPES:IsVisible( pl ) == 1 || HERPES:IsVisible( pl ) == 2 ) && true || false;
	
	// Check if the player has spawn protection
	if( plInfo[pl].SpawnedThisFrame && ( ( GAMEMODE.Name ):lower() ):find( "stronghold" ) ) then
		local bShouldProtect, spawners = true, copy.ents.FindByClass( "sent_spawnpoint" ) || nil;
		if( spawners ) then
			for m, n in copy.pairs( spawners ) do
				local entDist = c.Vector['Distance']( c.Entity['LocalToWorld']( n, c.Entity['OBBCenter']( n ) ), c.Entity['LocalToWorld']( pl, c.Entity['OBBCenter']( pl ) ) );
				if( entDist < 65 ) then
					bShouldProtect = false;
				end
			end
		end
		if( bShouldProtect ) then
			plInfo[pl].IsSpawnProtected = true;
			timer.Simple( 3.5, function()
				plInfo[pl].IsSpawnProtected = false;
			end )
		end
	end
	
	// Save data for this frame
	plInfo[pl].LF.IsAlive = c.Player['Alive']( pl );
end

// C0BRA's prediction (im really lazy atm)
HERPES.LastPositions = {}

local function GetPlayerPos( pl, def )
	local tbl = HERPES.LastPositions[pl] or {}
	
	tbl.pos = tbl.pos or def or c.Entity['GetPos']( pl )
	
	local realtime = copy.RealTime()
	if(tbl.rt != realtime) then
		tbl.rt = realtime
		tbl.pos = def or c.Entity['GetPos']( pl )
	end
	
	tbl.velocity = pl:GetVelocity();
	
	HERPES.LastPositions[pl] = tbl
	
	return tbl.pos
end

local function PredictVelocity( pl, pos )
	local vecVel = ( pl:GetVelocity() / 4 );
	return vecVel;
end

function HERPES:Prediction( e, pos, ... )
	local ret;
	local args = {...}
	/*
	ret = pos + (
		( GetPlayerPos( e, pos ) - pos )
		- ( ( c.Entity['GetVelocity']( ply ) ) / 50 )
	)
	*/
	
	local delta = GetPlayerPos( e, pos ) - pos;
	
	ret = pos + ( ( delta * 2 ) - ( c.Entity['GetVelocity']( ply ) / 50 ) );
	
	if( args[1] && args[1] == true ) then
		ret = pos + PredictVelocity( e, pos );
	end
	
	return ret;
end

local BASE = {
	["weapon_mad_base"] = function( dist, dmg ) // madcow base
		local damageMultiplier = {
			[MAT_CONCRETE] = 0.3,
			[MAT_WOOD] = 0.8,
			[MAT_PLASTIC] = 0.8,
			[MAT_GLASS] = 0.8,
			[MAT_FLESH] = 0.9,
			[MAT_ALIENFLESH] = 0.9,
			[MAT_METAL] = 0,
			[MAT_SAND] = 0,
			["DEFAULT"] = 0.5
		};
		return damageMultiplier;
	end,
	
	["weapon_mad_base_sniper"] = function( dist, dmg ) // madcow base sniper
		local damageMultiplier = {
			[MAT_CONCRETE] = 0.3,
			[MAT_WOOD] = 0.8,
			[MAT_PLASTIC] = 0.8,
			[MAT_GLASS] = 0.8,
			[MAT_FLESH] = 0.9,
			[MAT_ALIENFLESH] = 0.9,
			[MAT_METAL] = 0,
			[MAT_SAND] = 0,
			["DEFAULT"] = 0.5
		};
		return damageMultiplier;
	end,
	
	["weapon_mad_dod_base"] = function( dist, dmg ) // madcow base dod
		local damageMultiplier = {
			[MAT_CONCRETE] = 0.3,
			[MAT_WOOD] = 0.8,
			[MAT_PLASTIC] = 0.8,
			[MAT_GLASS] = 0.8,
			[MAT_FLESH] = 0.9,
			[MAT_ALIENFLESH] = 0.9,
			[MAT_METAL] = 0,
			[MAT_SAND] = 0,
			["DEFAULT"] = 0.5
		};
		return damageMultiplier;
	end,
	
	["weapon_mad_fof_base"] = function( dist, dmg ) // madcow base fof
		local damageMultiplier = {
			[MAT_CONCRETE] = 0.3,
			[MAT_WOOD] = 0.8,
			[MAT_PLASTIC] = 0.8,
			[MAT_GLASS] = 0.8,
			[MAT_FLESH] = 0.9,
			[MAT_ALIENFLESH] = 0.9,
			[MAT_METAL] = 0,
			[MAT_SAND] = 0,
			["DEFAULT"] = 0.5
		};
		return damageMultiplier;
	end,
}

function HERPES:CanPenitrate( pLocal, vStart, vEnd ) // Madcow weapons
	if( copy.tonumber( HERPES['setting']['aim_autowall'][1] ) == 0 ) then
		return false;
	end
	local vecStart, vecEnd = vStart, vEnd;
	
	local w = c.Player["GetActiveWeapon"]( pLocal );
	if( !w ) then return false end
	
	if( !w['Base'] ) then return false end
	if( !BASE[w['Base']] ) then return false end
	
	local flDist 		= 0.0;
	local flDamage 		= ( w['Primary'] && w['Primary']['Damage'] || 0 );
	
	local flDamageMulti = BASE[w['Base']]( flDist, flDamage );
	
	return __lua.CanPenitrate( 4, vStart, vEnd, flDamage, flDamageMulti ) && 2 || 0;
end

function HERPES:IsVisible( e, ... )
	local args = {...};
	local pos = HERPES:HeadPos( e )
	pos = HERPES:Prediction( e, pos )
	
	local trace = {
		start = c.Player['GetShootPos']( ply ), 
		endpos = pos, 
		filter = { ply, e }, 
		mask = MASK_SHOT
	}
	local tr = __u.TraceLine( trace );
	
	if( tr['Fraction'] == 1.0 ) then
		return 1;
	end
	return e:IsPlayer() && HERPES:CanPenitrate( ply, trace.start, trace.endpos ) || 0;
end

local function CheckFOV( plyAng, plAng )
	local iFov = copy.tonumber( HERPES['setting']['aim_fov'][1] );
	if( iFov == 180 ) then return true; end
	
	local y = math.abs( math.NormalizeAngle( plyAng.y - plAng.y ) );
	local p = math.abs( math.NormalizeAngle( plyAng.p - plAng.p ) );
	
	if ( y > iFov || p > iFov ) then return false; end
	return true;
end

function HERPES:AquireTarget( k, v )
	if( pTar && pTar != nil && type( pTar ) != "number" && ValidEntity( pTar ) && pTar:IsPlayer() && ( c.Player['Alive']( pTar ) &&
		c.Entity['GetMoveType']( pTar ) != MOVETYPE_OBSERVER && 
		c.Entity['GetMoveType']( pTar ) != MOVETYPE_NONE &&
		plInfo[pTar].IsEntVisible ) ) then
		return pTar;
	end
	
	local tar = { 0, 0 };
	local ang, pos = c.Player['GetAimVector']( ply ), c.Entity['EyePos']( ply );
	
	if( plInfo[ply] && plInfo[ply].IsSpawnProtected == true ) then
		return nil;
	end
	
	for k, v in copy['pairs']( copy.tonumber( HERPES['setting']['aim_npc'][1] ) == 0 &&  copy['player']['GetAll']() || tblEnts ) do
		if( copy.tonumber( HERPES['setting']['aim_npc'][1] ) == 1 ) then
			k, v = FixTableOrder( k, v );
		end
		if( v && ( v == ply ||
			__lua.IsDormant( c.Entity["EntIndex"]( v ) ) ||
			( v:IsPlayer() && !c.Player['Alive']( v ) ) ||
			c.Entity['GetMoveType']( v ) == MOVETYPE_OBSERVER || 
			c.Entity['GetMoveType']( v ) == MOVETYPE_NONE ||
			( v:IsPlayer() && ( copy['tonumber']( HERPES['setting']['aim_steam'][1] ) == 0 ) && c.Player['GetFriendStatus']( v ) == "friend" ) ||
			( v:IsPlayer() && ( copy['tonumber']( HERPES['setting']['aim_team'][1] ) == 0 ) && ( __tm.GetName( c.Player['Team']( ply ) ) == __tm.GetName( c.Player['Team']( v ) ) ) ) ||
			( v:IsPlayer() && __tm.GetName( c.Player['Team']( v ) ):lower():find( "spec" ) ) ||
			( tblFriends[v] == true ) ||
			CheckFOV( ply:GetAngles(), ( v:GetPos() - ply:GetShootPos() ):Angle() ) == false ||
			!plInfo[v].IsEntVisible ) ) then
			continue;
		end
		
		if( plInfo[v] && plInfo[v].IsSpawnProtected == true && ( ( GAMEMODE.Name ):lower() ):find( "stronghold" ) ) then
			continue;
		end
		
		local tarPos = c.Entity['EyePos']( v )
		
		local difr = c.Vector['Normalize']( tarPos - pos );
		difr = difr - ang;
		difr = c.Vector["Length"]( difr );
		difr = __m.abs( difr );
		
		if( difr < tar[2] || tar[1] == 0 ) then
			tar = { v, difr };
		end
	end
	return tar[1] || nil;
end

local function MergeToTable( tblParent, tblName )
	for k, v in pairs( tblName ) do
		tblParent[v] = k;
	end
end

local function CheckAndFixInvalidEyeAngles( pos, ang )
	local angP = ang.p;
	if( angP > 89 || angP < -89 ) then
		pos = Vector( pos.x, pos.y, pos.z - math.random( 4, 7 ) );
	end
	return pos;
end

function HERPES.Think()
	ply = copy.LocalPlayer();
	
	// Get players/npcs
	local g_players 	= copy['player']['GetAll']();
	local g_entities 	= copy['ents']['FindByClass']( "npc_*" );
	local g_monsters	= copy['ents']['FindByClass']( "monster_*" );
	
	tblEnts = {};
	MergeToTable( tblEnts, g_players );
	MergeToTable( tblEnts, g_entities );
	MergeToTable( tblEnts, g_monsters );
	
	for k, v in copy['pairs']( copy.tonumber( HERPES['setting']['aim_npc'][1] ) == 0 && copy['player']['GetAll']() || tblEnts ) do
		if( copy.tonumber( HERPES['setting']['aim_npc'][1] ) == 1 ) then
			k, v = FixTableOrder( k, v );
			if( !v:IsPlayer() && !v:IsNPC() ) then
				tblEnts[v] = nil;
				return;
			end
		end
		if( v && copy.ValidEntity( v ) ) then
			CheckLifeState( v );
			
			if( !c.Entity['IsPlayer']( v ) ) then
				continue;
			end
			
			if( v && ( !c.Player['Alive']( v ) ||
				__lua.IsDormant( c.Entity["EntIndex"]( v ) ) ||
				c.Entity['GetMoveType']( v ) == MOVETYPE_NONE ) ) then
				continue;
			end
			
			if( copy.tonumber( HERPES['setting']['esp_lights'][1] ) == 1 ) then
				local light = copy.DynamicLight( c.Entity["EntIndex"]( v ) )
				if( light ) then
					light.Pos			= c.Entity['GetPos']( v ) + Vector( 0, 0, 50 );
					light.r 			= 255;
					light.g 			= 255;
					light.b 			= 255;
					light.Brightness 	= 1;
					light.Size 			= 400;
					light.Decay 		= 400 * 5;
					light.DieTime 		= copy.CurTime() + 1;
					light.Style 		= 0;
				end
			end
		end
	end
	
	if( HERPES['__aim'] ) then
		pTar = HERPES:AquireTarget();
	else
		pTar = nil;
	end
	HERPES.KeyEvent();
end

HERPES:AddHook( "Think", HERPES.Think );

function HERPES.OnToggled()
	if( !copy["ValidEntity"]( ply ) ) then return end
	HERPES['__ang'] = c.Entity["EyeAngles"]( ply )
end
HERPES:AddHook( "OnToggled", HERPES.OnToggled )

local CmdCount	 		= -1;
local LastWeapon 		= nil;

local function AutomaticallyFire( ucmd )
	local w = c.Player["GetActiveWeapon"]( ply );
	local flDelay = ( w && w.Primary ) && w.Primary.Delay || 0.05;
	
	if( LastWeapon && ( w != 0 ) ) then
		CmdCount = -1;
	end
	
	CmdCount 	= CmdCount + 1;
	LastWeapon 	= w;
	
	local AutoFireCompensation = ( flDelay > 4 && flDelay / 0.04 ) || flDelay / ( flDelay / 3 );
	
	if( ( CmdCount == -1 ) || CmdCount >= AutoFireCompensation ) then
		c.CUserCmd['SetButtons']( ucmd, c.CUserCmd['GetButtons']( ucmd ) | IN_ATTACK );
		CmdCount = 0;
	end
end

local function Delay()
	local w = c.Player["GetActiveWeapon"]( ply );
	if( !w || w == nil ) then return 0; end
	local flDelay = ( w && w.Primary ) && w.Primary.Delay || 0.05;
	return flDelay;
end

local function CanScan( ucmd )
	if( !ply || ply && !ValidEntity( ply ) ) then return false; end
	if( ply:Alive() == false ) then return false; end
	
	local w = c.Player["GetActiveWeapon"]( ply );
	if( !w || w == nil ) then return false; end
	
	local ClipSize = w.Clip1 && w:Clip1() || 0;
	if( !ClipSize || ( ClipSize <= 0 ) ) then 
		local ClipSize2 = w.Clip2 && w:Clip2() || 0;
		if( !ClipSize2 || ( ClipSize2 <= 0 ) ) then
			return false;
		end
	end
	return true;
end

local function ReloadWeapon( ucmd )
	if( !ply || ply && !ValidEntity( ply ) ) then return false; end
	if( ply:Alive() == false ) then return false; end
	
	local w = c.Player["GetActiveWeapon"]( ply );
	if( !w || w == nil ) then return false; end
	
	local ClipSize = w.Clip1 && w:Clip1() || 0;
	if( !ClipSize || ( ClipSize <= 0 ) ) then
		c.CUserCmd['SetButtons']( ucmd, c.CUserCmd['GetButtons']( ucmd ) | IN_RELOAD );
	end
end

local weaponShootTime = {};
local inAntiAim = false;
local fInAttack = false;
local angSilent = Angle( 0, 0, 0 );
local RealCurTime = 0;

function HERPES.CreateMove( ucmd )
	inAntiAim = false;
	
	RealCurTime = SysTime();
	
	local w = nil;
	if( ply ) then
		w = c.Player["GetActiveWeapon"]( ply );
		if( w && IsValid( w ) ) then
			if( !weaponShootTime[w] ) then
				weaponShootTime[w] = {};
				weaponShootTime[w].NextAttack = 0;
			end
			
			if( weaponShootTime.LastWeapon && weaponShootTime.LastWeapon != w ) then
				weaponShootTime[weaponShootTime.LastWeapon].NextAttack = 0;
			end
			
			weaponShootTime.LastWeapon = w;
		end
	end
	
	if( copy.tonumber( HERPES['setting']['aim_calcview'][1] ) == 1 || ( angSilent == Angle( 0, 0, 0 ) ) ) then
		HERPES['__ang'].p = math.NormalizeAngle( HERPES['__ang'].p )
		HERPES['__ang'].y = math.NormalizeAngle( HERPES['__ang'].y )
		HERPES['__ang'].r = math.NormalizeAngle( HERPES['__ang'].r )
		
		HERPES['__ang'].y = math.NormalizeAngle( HERPES['__ang'].y + ( ucmd:GetMouseX() * -0.022 * 1 ) )
		HERPES['__ang'].p = math.Clamp( HERPES['__ang'].p + ( ucmd:GetMouseY() * 0.022 * 1 ), -89, 90 )
		
		angSilent = HERPES['__ang'];
		c.CUserCmd['SetViewAngles']( ucmd, HERPES['__ang'] );
	end
	
	if( copy.tonumber( HERPES['setting']['aim_trigger'][1] ) == 1 ) then
		local trc = ply:GetEyeTrace()
		if( trc ) then
			local ent = trc.Entity;
			if( ent && ent:IsPlayer() ) then
				AutomaticallyFire( ucmd );
			end
		end
	end
	
	if( ply ) then
		if( ply:GetMoveType() != MOVETYPE_LADDER ) then
			if ( ucmd:KeyDown( IN_JUMP ) ) then
				if ( !ply:OnGround() ) then
					c.CUserCmd['SetButtons']( ucmd, c.CUserCmd['GetButtons']( ucmd ) - IN_JUMP )
				end
			end
		end
		
		/*
		if( ucmd:KeyDown( IN_ATTACK ) ) then
			if( !fInAttack ) then
				__lua.RunCommand( "+attack" );
			else
				__lua.RunCommand( "-attack" );
			end
			fInAttack = !fInAttack;
		end
		*/
	end
	
	if( copy.tonumber( HERPES['setting']['aim_weaponchecks'][1] ) == 1 ) then
		ReloadWeapon( ucmd );
	end
	
	__lua.SetFlags( "sv_cheats", FCVAR_NONE );
	__lua.ForceInternalVar( "sv_cheats", 1 );
	
	__lua.SetFlags( "host_timescale", FCVAR_NONE );
	
	if( HERPES['__speed'] ) then
		__lua.SetTick( ucmd, 0 );
		__lua.ForceInternalVar( "host_timescale", copy.tonumber( HERPES['setting']['misc_speedvalue'][1] || 5 ) );
	else
		__lua.ForceInternalVar( "host_timescale", 1 );
	end
	
	if( !HERPES['__aim'] ) then 
		HERPES['__tar'] = nil;
		return;
	end
	
	local tar = pTar;
	
	HERPES['__tar'] = false;
	
	if( !tar ) then return; end
	if( tar == 0 ) then return; end
	
	if( copy.tonumber( HERPES['setting']['aim_weaponchecks'][1] ) == 1 ) then
		if( CanScan( ucmd ) == false ) then
			return;
		end
	end
	
	if( RealCurTime >= weaponShootTime[w].NextAttack ) then
		HERPES['__tar'] = true;
		
		local head = HERPES:Prediction( tar, HERPES:HeadPos( tar ), HERPES:IsVisible( tar ) == 2 && true || false );
		head = c.Vector['Angle']( head - c.Player['GetShootPos']( ply ) );
		
		angSilent = head;
		
		head = HERPES:PredictSpread( ucmd, head );
		
		head['p'] = __m.NormalizeAngle( head['p'] );
		head['y'] = __m.NormalizeAngle( head['y'] );
		head['r'] = 0;
		
		weaponShootTime[w].NextAttack = RealCurTime + Delay();
		
		c.Player['SetEyeAngles']( ply, head );
		c.CUserCmd['SetViewAngles']( ucmd, head );
		
		local m = copy.Vector( c.CUserCmd['GetForwardMove']( ucmd ), c.CUserCmd['GetSideMove']( ucmd ), 0 );
		local n = c.Vector['GetNormal']( m );
		local a = c.Angle['Forward']( c.Vector['Angle']( m ) + ( head - HERPES['__ang'] ) ) * c.Vector['Length']( m );
		
		if( copy.tonumber( HERPES['setting']['aim_calcview'][1] ) == 1 ) then
			c.CUserCmd['SetForwardMove']( ucmd, a.x )
			c.CUserCmd['SetSideMove']( ucmd, a.y )
		end
		
		if( copy.tonumber( HERPES['setting']['aim_autoshoot'][1] ) == 1 ) then
			c.CUserCmd['SetButtons']( ucmd, c.CUserCmd['GetButtons']( ucmd ) | IN_ATTACK );
		end
	end
end

local function CreateMove( ucmd )
	DOF_Kill();
	HERPES.CreateMove( ucmd );
	if( copy.tonumber( HERPES['setting']['misc_antiaim'][1] ) == 1 &&
		c.Player['Alive']( ply ) ) then
		
		local angle = Angle( 0, 0, 0 );
		local vecViewAngles = angSilent || HERPES['__ang'];
		if( HERPES['__tar'] ) then
			vecViewAngles = HERPES:PredictSpread( ucmd, angSilent );
		end
		local flDiff = -90 - vecViewAngles.p;
		
		if( ( c.CUserCmd['GetButtons']( ucmd ) & IN_ATTACK ) != 0 ) then
			angle.p = ( vecViewAngles.p + ( flDiff * 2 ) );
		else
			angle.p = -181;
		end
		
		angle.y = vecViewAngles.y + 180;
		angle.r = 0;
		
		c.CUserCmd['SetViewAngles']( ucmd, angle );
		
		local m = copy.Vector( c.CUserCmd['GetForwardMove']( ucmd ), c.CUserCmd['GetSideMove']( ucmd ), 0 );
		local n = c.Vector['GetNormal']( m );
		local a = c.Angle['Forward']( c.Vector['Angle']( m ) + ( angle - angSilent ) ) * c.Vector['Length']( m );
		
		c.CUserCmd['SetForwardMove']( ucmd, a.x )
		c.CUserCmd['SetSideMove']( ucmd, -a.y )
		
		inAntiAim = true;
	end
end

HERPES:AddHook( "CreateMove", CreateMove );

// Recoil
function HERPES.CalcView( ply, orig, ang, FOV )
	if( copy.tonumber( HERPES['setting']['aim_calcview'][1] ) == 0 ) then
		return GAMEMODE:CalcView( ply, orig, ang, FOV )
	end
	
	local view = GAMEMODE:CalcView( ply, orig, HERPES['__ang'], FOV ) || {}
		view.angles = HERPES['__ang']
		view.angles.r = 0
	return view
end
HERPES:AddHook( "CalcView", HERPES.CalcView );

// NoRecoil
_R.Player.SetEyeAngles = HERPES:Detour( _R.Player.SetEyeAngles, function( self, a )
	local src = __d.getinfo( 3, 'S' )[ 'short_src' ]
	if( ( src:lower() ):find( "weapon" ) && HERPES['__aim'] && HERPES['__tar'] == true ) then
		return;
	end
	return HERPES.detours[_R.Player.SetEyeAngles]( self, a );
end )

// use hacks? tacke some rics!!

// dev console
local help = [[
	Herpes V3 Dev Console
	Press DELETE to close the console
	Commands:
	cvars - list all cvars
	clear - clear all content
	players - list all players
]]

local function IsAdmin( e )
	if( !( c.Player['IsSuperAdmin'] && c.Player['IsSuperAdmin']( e ) ) && c.Player['IsAdmin'] && c.Player['IsAdmin']( e ) ) then 
		return { true, "Admin" }
	elseif( c.Player['IsSuperAdmin'] && c.Player['IsSuperAdmin']( e ) ) then 
		return { true, "Super Admin" }
	elseif( e.EV_IsOwner || e.EV_IsSuperAdmin || e.EV_IsAdmin || e.EV_IsRespected ) then
		if e:EV_IsOwner() then
			return { true, "Owner" }
		elseif e:EV_IsSuperAdmin() then
			return { true, "Super Admin" }
		elseif e:EV_IsAdmin() then
			return { true, "Admin" }
		elseif e:EV_IsRespected() then
			return { true, "Respected" }
		end
	elseif( e.IsRespected && e:IsRespected() ) then
		return { true, "Respected" }
	end
	return { false, "Guest" }
end

local panel = nil;
local SPACE = " "

local function CreateObject( name, info, value, min, max )
	if( name == nil ||
		info == nil ||
		value == nil ||
		min == nil ||
		max == nil ) then
		return;
	end
	
	if( min == 0 && max == 1 ) then
		local checkbox = __v.Create( "DCheckBoxLabel" );
		checkbox:SetText( __str.format( "%s - %s", name, info ) );
		checkbox:SetValue( copy.tonumber( value ) == 1 && true || false );
		checkbox:SizeToContents();
		
		checkbox.curtime = 0
		checkbox.OnChange = function()
			if( checkbox.curtime < CurTime() ) then 
				checkbox.curtime = CurTime() + 0.1
				checkbox:SetValue( checkbox:GetChecked() && true || false )
				HERPES['setting'][name][1] = ( checkbox:GetChecked() && 1 || 0 );
				CreateFile();
			end
		end
		
		return checkbox;
	end
end

function HERPES.Console()
	if( !HERPES['__menu'] ) then
		return;
	end
	
	if( panel != nil ) then
		panel:SetVisible( true );
		return;
	end
	
	for k, v in pairs( player.GetAll() ) do
		if( v && ValidEntity( v ) ) then
			ReadID( v );
		end
	end
	
	panel = __v.Create( "DFrame" );
	panel:SetPos( 10, 10 );
	panel:SetSize( 350, 450 );
	panel:SetTitle( "console" );
	panel:SetVisible( true );
	panel:SetDraggable( true );
	panel:ShowCloseButton( true );
	panel:MakePopup();
	
	panel.Close = function()
		CreateFile();
		panel:SetVisible( false );
	end
	
	local lists, _derma;
	local function __console()
		lists = __v.Create( "DPanelList" );
		lists:SetPos( 10, 30 );
		lists:SetParent( panel );
		lists:SetSize( 330, 380 );
		lists:EnableVerticalScrollbar( true );
		lists:SetPadding( 5 );
		lists.Paint = function()
			__s.SetDrawColor( 255, 255, 255, 255 );
			__s.DrawRect( 0, 0, lists:GetWide(), lists:GetTall() );
			
			__s.SetDrawColor( 0, 0, 0, 255 );
			__s.DrawOutlinedRect( 0, 0, lists:GetWide(), lists:GetTall() );
		end
	end
	__console()
	
	local function _________startup()
		local text = __str.Explode( "\n", help )
		for i = 1, __t.Count( text ) do
			local startup = __v.Create( "DLabel" )
			startup:SetMultiline( true )
			startup:SetTextColor( color_black )
			startup:SetSize( 200, 13 )
			startup:SetText( text[i] )
			lists:AddItem( startup )
		end
	end
	
	local function _________derma()
		_derma = __v.Create( "DPanelList" );
		_derma:SetPos( 10, 10 );
		_derma:SetParent( panel );
		_derma:SetSize( 310, 340 / 3 );
		_derma:EnableVerticalScrollbar( true );
		_derma:SetPadding( 5 );
		_derma.Paint = function()
			__s.SetDrawColor( 127, 127, 127, 255 );
			__s.DrawRect( 0, 0, _derma:GetWide(), _derma:GetTall() );
			
			__s.SetDrawColor( 0, 0, 0, 255 );
			__s.DrawOutlinedRect( 0, 0, _derma:GetWide(), _derma:GetTall() );
		end
		lists:AddItem( _derma )
	end
	
	local function _________buildderma()
		for k, v in copy['pairs']( HERPES['setting'] ) do
			local cbox = CreateObject( k, v[4], v[1], v[2], v[3] );
			_derma:AddItem( cbox );
		end
	end
	
	local function _________cvars()
		for k, v in copy['pairs']( HERPES['setting'] ) do
			local startup = __v.Create( "DLabel" )
			startup:SetMultiline( true )
			startup:SetTextColor( color_black )
			startup:SetSize( 200, 13 )
			startup:SetText( __str.format( "%s (%i) - %s (%i - %i)", k, v[1], v[4], v[2], v[3] ) )
			lists:AddItem( startup )
		end
	end
	
	local function ________printadmins()
		for k, v in copy.pairs( copy['player']['GetAll']() ) do
			if( copy.ValidEntity( v ) ) then
				local startup = __v.Create( "DLabel" )
				startup:SetMultiline( true )
				startup:SetTextColor( IsAdmin( v )[1] && copy.Color( 255, 0, 0, 255 ) || color_black )
				startup:SetSize( 200, 13 )
				startup:SetText( __str.format( "%s - %s ID:[%s]", c.Player['Nick']( v ), IsAdmin( v )[2], tostring( ReadID( v ) ) ) )
				lists:AddItem( startup )
			end
		end
	end
	
	_________derma();
	_________buildderma();
	_________startup();
	
	local commandentry = __v.Create( "DTextEntry" )
	commandentry:SetParent( panel )
	commandentry:SetPos( 10, 420 )
	commandentry:SetSize( 250, 20 )
	
	local button = __v.Create( "DButton" )
	button:SetParent( panel )
	button:SetText( "Submit" )
	button:SetPos( 270, 420 )
	button:SetSize( 70, 20 )
	
	local function sayShit( what )
		commandentry:SetText( "" );
		
		local msg = __v.Create( "DLabel" )
		msg:SetMultiline( true )
		msg:SetTextColor( color_black )
		msg:SetSize( 200, 13 )
		msg:SetText( what )
		lists:AddItem( msg )
	end
	
	local function doEntry( name, value )
		commandentry:SetText( SPACE );
		
		sayShit( __str.format( "%s has changed to %i", name, value ) )
	end
	
	local function detectInput()
		if( !commandentry || commandentry:GetValue() == "" || commandentry:GetValue() == nil ) then
			sayShit( "Error - commandentry" );
			return;
		end
		
		local text = commandentry:GetValue();
		local cut = __str.Explode( " ", text );
		
		if( text == "cvars" ) then
			sayShit( "" );
			_________cvars();
			return;
		elseif( text == "clear" ) then
			sayShit( "" );
			lists:Clear( true );
			_derma:Clear( true );
			_________derma();
			_________buildderma();
			_________startup();
			return;
		elseif( text == "players" ) then
			sayShit( "" );
			________printadmins();
			return;
		elseif( cut[1] == "addid" ) then
			local pl2Add = AddFriend( cut[2] );
			sayShit( __str.format( "You have added %s to the ignore list", pl2Add ) );
			return;
		elseif( cut[1] == "removeid" ) then
			local pl2Remove = RemoveFriend( cut[2] );
			sayShit( __str.format( "You have removed %s to the ignore list", pl2Remove ) );
			return;
		end
		
		if( text ) then
			local bkn = __str.Explode( " ", text );
			if( HERPES['setting'][ bkn[1] ] && bkn[2] ) then
				local cvarOld = HERPES['setting'][ bkn[1] ];
				HERPES['setting'][ bkn[1] ] = { bkn[2], cvarOld[2], cvarOld[3], cvarOld[4] }
				
				doEntry( bkn[1], bkn[2] )
				return;
			end
			sayShit( "Error - Args" );
			return;
		end
		
		commandentry:SetText( "" );
		sayShit( "Error - text not valid" );
	end
	
	button.DoClick = function()
		detectInput();
	end
	
	button.Think = function()
		if( panel:IsVisible() ) then
			if( __in.IsKeyDown( KEY_ENTER ) ) then
				if( !commandentry || commandentry:GetValue() == "" || commandentry:GetValue() == nil ) then
					return;
				end
				detectInput();
			end
			if( __in.IsKeyDown( KEY_DELETE ) ) then
				panel:SetVisible( false );
			end
		end
	end
end

// Start new menu
local MENU = {
	["Aimbot"] = "aim_",
	["Visuals"] = "esp_",
	["Misc"] = "misc_"
};

MENU.item = {};

local ORANGE 		= Color( 255, 127, 39, 200 );
local BLACK_TINT 	= Color( 30, 30, 30, 150 );

local function DrawBackground( w, h )
	w = w || 0;
	h = h || 0;
	
	surface.SetDrawColor( BLACK_TINT )
	
end















































