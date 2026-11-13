-- Shovel - Settings @ JDLENL 3/22/20
-- If you use this in your game, consider mentioning me in the description! I'd appreciate it.

return {
	ReachDistance = 32;						-- how far away the shovel can dig
	DigSize = 5;							-- radius of terrain ball dug out
	PlaceSize = 3;							-- radius of terrain ball placed
	AllowPlacement = true;					-- allow you to press E to fill terrain
	ConsumeSoil = true;						-- if you allow placement, keeps track of the soil you've dug to determine what you can place
	SoilMaterial = Enum.Material.Asphalt; 	-- the material of the soil to fill if you allow placement
	Cooldown = .5;							-- tool cooldown in seconds
	PlacementCooldown = .1;					-- soil placement cooldown in seconds
	SoilGained = 1;							-- amount of soil gained when you dig
	SoilUsed = 1;							-- amount of soil to consume to place
	GuiEnabled = true;						-- toggle whether to show a gui with how much soil you have
	AllowDamage = true;						-- can the shovel be used as a melee weapon?
	Damage = 9;								-- if so, how much damage it does per hit
	HitCooldown = 1;						-- damage cooldown in seconds
	
	-- you can ignore this one, unless you want to pre-load the shovel with soil
	Soil = 0;		-- keeps track of soil if you enable soil consumption
	
	-- this can automatically check if you have my Death Message system installed and display a custom death message
	DeathMessagesEnabled = game.ServerScriptService:FindFirstChild("DeathMessages") ~= nil;
	DeathMessageFlag = "ShoveledToDeath";
	
	-- CAUTION: this is only for specific games which have a Hunger value inside the Player. DON'T TURN ON IF YOU DON'T USE THAT.
	Hunger = false;
	DigHunger = 5;
	PlaceHunger = 4;
}