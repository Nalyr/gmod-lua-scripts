
local enums = {
"AlyxEMP.Charge",
"AlyxEMP.Discharge",
"AlyxEMP.Stop",
"BaseExplosionEffect.Sound",
"BaseGrenade.BounceSound",
"BaseGrenade.Explode",
"BaseGrenade.StopSounds",
"Bullets.DefaultNearmiss",
"Bullets.GunshipNearmiss",
"Bullets.StriderNearmiss",
"Func_Tank.BeginUse",
"FuncTank.Fire",
"FX_RicochetSound.Ricochet",
"GenericNPC.GunSound",
"Grenade.Blip",
"Grenade_Molotov.Detonate",
"GrenadeBeam.HitSound",
"GrenadeBottle.Detonate",
"GrenadeBugBait.Splat",
"GrenadeHomer.StopSounds",
"GrenadePathfollower.StopSounds",
"GrenadeScanner.StopSound",
"TripwireGrenade.ShootRope",
"WaterExplosionEffect.Sound",
"Weapon_357.OpenLoader",
"Weapon_357.Reload",
"Weapon_357.RemoveLoader",
"Weapon_357.ReplaceLoader",
"Weapon_357.Single",
"Weapon_357.Spin",
"Weapon_AR2.Double",
"Weapon_AR2.Empty",
"Weapon_AR2.NPC_Double",
"Weapon_AR2.NPC_Reload",
"Weapon_AR2.NPC_Single",
"Weapon_AR2.Reload",
"Weapon_AR2.Reload_Push",
"Weapon_AR2.Reload_Rotate",
"Weapon_AR2.Single",
"Weapon_AR2.Special1",
"Weapon_AR2.Special2",
"Weapon_Binoculars.Reload",
"Weapon_Binoculars.Special1",
"Weapon_Binoculars.Special2",
"Weapon_Brickbat.Special1",
"Weapon_Bugbait.Splat",
"Weapon_CombineGuard.Special1",
"Weapon_Crossbow.BoltElectrify",
"Weapon_Crossbow.BoltFly",
"Weapon_Crossbow.BoltHitBody",
"Weapon_Crossbow.BoltHitWorld",
"Weapon_Crossbow.BoltSkewer",
"Weapon_Crossbow.Reload",
"Weapon_Crossbow.Single",
"Weapon_Crowbar.Melee_Hit",
"Weapon_Crowbar.Melee_HitWorld",
"Weapon_Crowbar.Single",
"Weapon_Extinguisher.Double",
"Weapon_Extinguisher.Empty",
"Weapon_Extinguisher.NPC_Double",
"Weapon_Extinguisher.NPC_Reload",
"Weapon_Extinguisher.NPC_Single",
"Weapon_Extinguisher.Reload",
"Weapon_Extinguisher.Single",
"Weapon_Extinguisher.Special1",
"Weapon_FlareGun.Burn",
"Weapon_FlareGun.Reload",
"Weapon_FlareGun.Single",
"Weapon_functank.Single",
"Weapon_Gauss.ChargeLoop",
"Weapon_IRifle.Empty",
"Weapon_IRifle.Single",
"Weapon_MegaPhysCannon.Charge",
"Weapon_MegaPhysCannon.ChargeZap",
"Weapon_MegaPhysCannon.Drop",
"Weapon_MegaPhysCannon.DryFire",
"Weapon_MegaPhysCannon.HoldSound",
"Weapon_MegaPhysCannon.Launch",
"Weapon_MegaPhysCannon.Pickup",
"Weapon_Mortar.Impact",
"Weapon_Mortar.Incomming",
"Weapon_Mortar.Single",
"Weapon_PhysCannon.Charge",
"Weapon_PhysCannon.CloseClaws",
"Weapon_PhysCannon.Drop",
"Weapon_PhysCannon.DryFire",
"Weapon_PhysCannon.HoldSound",
"Weapon_PhysCannon.Launch",
"Weapon_PhysCannon.OpenClaws",
"Weapon_PhysCannon.Pickup",
"Weapon_PhysCannon.TooHeavy",
"Weapon_Physgun.HeavyObject",
"Weapon_Physgun.LightObject",
"Weapon_Physgun.LockedOn",
"Weapon_Physgun.Off",
"Weapon_Physgun.On",
"Weapon_Physgun.Scanning",
"Weapon_Physgun.Special1",
"Weapon_Pistol.Burst",
"Weapon_Pistol.Empty",
"Weapon_Pistol.NPC_Reload",
"Weapon_Pistol.NPC_Single",
"Weapon_Pistol.Reload",
"Weapon_Pistol.Single",
"Weapon_Pistol.Special1",
"Weapon_Pistol.Special2",
"Weapon_RPG.LaserOff",
"Weapon_RPG.LaserOn",
"Weapon_RPG.NPC_Single",
"Weapon_RPG.Single",
"Weapon_Shotgun.Double",
"Weapon_Shotgun.Empty",
"Weapon_Shotgun.NPC_Reload",
"Weapon_Shotgun.NPC_Single",
"Weapon_Shotgun.Reload",
"Weapon_Shotgun.Single",
"Weapon_Shotgun.Special1",
"Weapon_SMG1.Burst",
"Weapon_SMG1.Double",
"Weapon_SMG1.Empty",
"Weapon_SMG1.NPC_Reload",
"Weapon_SMG1.NPC_Single",
"Weapon_SMG1.Reload",
"Weapon_SMG1.Single",
"Weapon_SMG1.Special1",
"Weapon_SMG1.Special2",
"Weapon_SniperRifle.NPC_Reload",
"Weapon_SniperRifle.NPC_Single",
"Weapon_SniperRifle.Reload",
"Weapon_SniperRifle.Single",
"Weapon_SniperRifle.Special1",
"Weapon_SniperRifle.Special2",
"Weapon_StunStick.Activate",
"Weapon_StunStick.Deactivate",
"Weapon_StunStick.Melee_Hit",
"Weapon_StunStick.Melee_HitWorld",
"Weapon_StunStick.Melee_Miss",
"Weapon_StunStick.Swing",
"WeaponFrag.Roll",
"WeaponFrag.Throw",
};

local function PrintList()
	for i, enum in pairs( enums ) do
		local soundname = enum;
		enum = string.upper( enum );
		enum = string.gsub( enum, "WEAPON_", "" );
		enum = string.gsub( enum, "WEAPON", "" );
		enum = string.gsub( enum, "[.]", "_" );
		print( "SOUND_" .. enum .. "\t\t\t\t\t= Sound( \"" ..  soundname .. "\" );");
	end
end

PrintList()