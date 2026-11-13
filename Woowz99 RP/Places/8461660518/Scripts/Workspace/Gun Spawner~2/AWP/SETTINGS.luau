local Settings = { --These are the settings, change them however you like
	
	
	gunType = { --[[These are the 5 gun types you can have. Set whichever ones you want to true. (NOTE: Semi and Auto can't both be
		true, and Burst and Auto can't both be true)]]
		Semi = true; --Set this true if you want the gun to be semi-automatic. (Pistols, Snipers, etc)
		Auto = false; --Set this true if you want the gun to be fully automatic. (Assault Rifles, Submachine guns, machine guns, etc)
		Burst = false; --Set this true if you want the gun to be burst fire. (Battle rifles, assault rifles, etc)
		Shot = false; --Set this true if you want the gun to be a shotgun. (NOTE: Shot and auto can both be true)
		Explosive = false; --Set this true if you want the projectiles to be explosive. (Rocket launchers, grenade launchers, etc)
	};
	
	selectFire = false; --This is whether or not select fire is enabled
	selectFireSettings = {
		Animation = true; --This is whether or not there will be an animation for when you switch fire modes
		GUI = true; --This is whether or not a gui appears showing the fire being selected
		Modes = { --This the list of modes you can switch between
			Safety = true; --This mode doesn't allow any form of firing
			Semi = true; --This mode allows semi-automatic firing
			Burst = true; --This mode allows burst fire. The burst will be based on the burstSettings below
			Auto = true; --This mode allows fully automatic fire
		};
		animSpeed = 0.5; --This is how long it takes to switch fire if GUI or Animation is true. If neither are true, then switching will be instant
	};
	
	
	burstSettings = {
		fireRateBurst = true; --[[If this is true, then the burst time and wait will be adjusted so the bullet firing speed is the fire rate. If this
			is false, then the burst time and burst wait will be the values below]]
		Amount = 3; --This is how many bullets will be fired in one burst (if Burst is true)
		Time = 0.2; --This is how long it takes for a burst to complete
		Wait = 0.1; --This is how much time you have to wait before you can fire another burst
	};
	
	
	shotAmount = 5; --This is how many bullets will be fired in one shot (if Shot is true)
	
	
	explosionSettings = {
		Radius = 20; --This is the radius of the explosion when the bullet hits a target. (If Explosive is true)
		Pressure = 5e5; --This is the pressure of the explosion when the bullet hits the target
		Type = Enum.ExplosionType.NoCraters; --This is the type of explosion
		--[[
		(0 or "NoCraters" or Enum.ExplosionType.NoCraters) means that the explosion will not damage terrain
		(1 or "Craters" or Enum.ExplosionType.Craters) means that the explosion will leave craters in terrain
		(2 or "CratersAndDebris" or Enum.ExplosionType.CratersAndDebris) means that the explosion will leave craters and debris in terrain
		--]]
		soundId = "rbxassetid://138499093"; --This is what the sound of the explosion will be
		soundPitch = 1; --This is what the pitch of the explosion sound will be
		soundVolume = 1; --This is what the volume of the explosion sound will be
		rayCastExplosions = false; --[[This is whether or not explosions will have raycasting. If this is true, humanoids behind walls
		won't be damaged. If this is false, any humanoid within the radius will be damaged. (NOTE: RangeBasedDamage has to be true in
		order for explosions to have raycasting)]]
		rangeBasedDamage = true; --[[This is whether or not will depend on how far the object is from the center of the explosion. If this
		is true, the farther a humanoid is from the blast center, the less damage it'll take. If this is false, any object within
		the explosion's radius will have its joints broken]]
	};
	
	
	playerArms = true; --This is whether or not the fake arms will look like the Player's arms
	fakeArmSettings = {
		Transparency = 0; --This is the transparency of the fake arms
		armSize = Vector3.new(0.6, 2, 0.6); --This is the size of the fake player arms if playerArms is true
		characterMeshes = false; --This is whether or not the fake player arms will have the arm meshes if playerArms is true
		realBodyColor = true; --This is whether or not the color of the fake arm will be the color of the player's real arms
		Color = BrickColor.new("Pastel brown"); --This is what the color of the fake arms will be if realBodyColor is false
	};
	
	
	unAimedC1 = { --This table contains the CFrames of welds when the gun is not aimed
		leftArm = CFrame.new(-0.7, 1.6, -0.8) * CFrame.Angles(math.rad(-10), 0, math.rad(-30));
		rightArm = CFrame.new(0.4, 0.25, -0.3) * CFrame.Angles(0, 0, math.rad(25));
		Grip = CFrame.Angles(0, math.rad(25), 0);
	};
	aimedC1 = { --This table contains the CFrames of welds when the gun is aimed
		leftArm = CFrame.new(-0.1, 1, -0.3) * CFrame.Angles(math.rad(-10), 0, 0) * CFrame.Angles(0, 0, math.rad(-40));
		rightArm = CFrame.new(0.5, 0.3, 0.1) * CFrame.Angles(0, 0, math.rad(45));
	};
	runningC1 = { --This table contains the CFrames of welds when you're running
		leftArm = CFrame.new(-0.65, 0.85, -1) * CFrame.Angles(math.rad(1), math.rad(-8.5), math.rad(16));
		rightArm = CFrame.new(0.16, 1, -0.14) * CFrame.Angles(math.rad(15), math.rad(2), math.rad(50));
		Grip = CFrame.Angles(0, math.rad(-5), 0);
	};
	
	
	equipAnimation = true; --This is whether or not an equipping animation will play when you equip the gun
	equipSettings = {
		Time = 0.25; --This is how long it takes for the equip animation to play
		leftArmC1 = CFrame.new(0.2, 1.2, 0) * CFrame.Angles(math.rad(105), math.rad(-30), math.rad(90)); --This is the left arm C1 when you equip the gun
		rightArmC1 = CFrame.new(-0.5, 0.75, 0) * CFrame.Angles(math.rad(45), 0, math.rad(75)); --This is the right arm C1 when you equip the gun
		GripC1 = CFrame.new(); --This is the C1 of the grip when you equip the gun
	};
	
	
	stopAnimsOnFall = true; --This is whether or not the movement animation will stop when you're falling
	fallAnimation = true; --This is whether or not there will be animation for falling and landing
	fallSettings = {
		maxDist = 35; --This is the cut off fall distance for the landing animation. If you fall any farther it'll be treated as if you fell this distance
		landMultiplier = 1; --This is how far the arms go down and rotate when you land. The larger the number the bigger the effect of the animation
		fallMultiplier = 1; --This is how far the arms go up and rotate when you fall. The larger the number the bigger the effect of the animation
		aimEffect = 0.25; --[[This is how many times of an effect the falling and landing animation has when you're aimed. The smaller the number the lesser
		the effect]]
	};
	
	
	gunMomentum = true; --This is whether or not there will be a gun swaying animation for when you move your mouse around
	momentumSettings = {
		maxInput = 18; --This is the maximum mouse delta that will be used as input for the sway
		Speed = 20; --This is the speed of the gun momentum
		Damper = 0.5; --[[This is the dampening effect of the gun momentum. NOTE: This number must be between 0 and 1, 0 being forever swaying and 1 being
		instant dampening]]
		Amplitude = { --These are the amplitudes of the gun momentum
			unAimed = 5;
			Aimed = 1;
		}
	};
	
	
	cockingAnim = true; --This is whether or not a cocking animation will play between every shot (for shotguns and bolt action guns)
	movementAnims = true; --This is whether or not the player will have movement animations
	
	
	canADS = true; --This is whether or not the gun can ADS
	aimSettings = {
		Anim = true; --This is whether or not there is an animation for aiming down the sights
		Speed = 0.4; --This is how long the gun will take to fully aim down the sights
		FOV = 10; --This is the FOV that the Camera will have when the gun is fully aimed down
		holdToADS = true; --This is whether or not you have to hold the right mouse or the ADS key to ADS
		headTilt = math.rad(25); --This is what angle the head tilts at when you ADS
	};
	
	
	sensitivitySettings = {
		Default = 1; --This is what the sensitivity of the mouse will be when the gun is not aimed. 1 is the default
		Aim = 0.05; --[[This is what the sensitivity of the mouse will be when the gun is aimed. The smaller the MaxZoom,
		the smaller the sensitivity should be (i.e. Scoped guns should have a sensitivity of around 0.2 or less]]
		
		scrollToChange = true; --This is whether or not scrolling the mouse changes the aim sensitivity
		Min = 0.05; --This is the lowest the sensitivity can be
		Max = 1; --This is the highest the sensitivity can be
		Increment = 0.05; --This is what the increment for the sensitivity is when you scroll
	};
	
	
	guiScope = true; --This is whether or not your Scope will be a gui instead of a normal sight
	scopeSettings = {
		Frequency = { --This is the how fast the camera sway is. The larger the number the faster the camera moves
			Idling = 0.2; --This is the frequency when you're idling
			Walking = 0.5; --This is the frequency when you're walking
		};
		Amplitude = { --This is the how wide the camera sway is. The larger the number the wider the sway
			Idling = 0.75; --This is the amplitude when you're idling
			Walking = 0.75; --This is the amplitude when you're walking
		};
		steadyTime = 8; --This is how long you can hold your breath to steady the scope
		breathTime = 5; --This is how long it takes to fully retake your breath
		camSwayOnBreath = 2.5; --This is what the cam sway multiplier will be when you start your retake your breath
		unSteadyOnFire = true; --This is whether or not the camera will become unsteady when you fire the gun
	};
	
	
	roundsPerMin = 41; --This is how many bullets per minute the gun will fire
	
	
	bulletSettings = {
		instantHit = true; --[[This is whether or not the bullet will hit a target instantly. If it is false, the bullet will travel at a
			specific speed till it hits a target]]
		Range = 1800; --This is how far the bullet will travel in studs before it is no longer effective
		Velocity = 853; --This is how fast the bullet will travel in studs per second
		Acceleration = 196.2; --This is the bullet's acceleration downward (196.2 is normal roblox gravity)
		Color = BrickColor.new("Bright red"); --This is the color of the bullet
		Transparency = 0; --This is the transparency of the bullet
		Size = Vector3.new(0.1, 0.1, 5); --This is how big the bullet will look
	};
	
	
	damageSettings = {
		--[[The start and end damages are basically a representation of this: http://goo.gl/SiWaTj, which is a basically a graph showing the starting damage
		value for the gun at a distance percent from 0 to 100 and the ending damage value for the gun at a distance percent from 0 to 100. Before the bullet
		hits the starting distance percent, the damage is the starting damage. Once it goes past the starting distance percent, it steadily drops til it hits
		the ending damage. After the ending damage percent, it'll stay that damage.]]
		Start = {
			Damage = 100; --The starting damage
			Dist = 0.5; --[[A value between 0 and 1 which represents the distance percent. So if the bullet range is 1000 studs and this value is 0.5, then
			the damage will be the starting damage until the bullet travels 0.5*1000 studs or 500 studs]]
		};
		End = {
			Damage = 59; --The ending damage
			Dist = 0.5; --A value between 0 and 1 which represents the distance percent for the ending damage
		};
		Multipliers = { --[[These are the damage multipliers. There's a spread of +0.1. That means that if the multiplier is 1, the actual
			multiplier will range from 1 - 1.1]]
			Chest = 1.1; --This is what the damage will be multiplied by if the bullet hits the chest
			Head = 2; --This is what the damage will be multiplied by if the bullet hits the head or a hat
			Limbs = 1.1; --This is what the damage will be multiplied by if the bullet hits a limb (Arms or legs)
		};
	};
	
	
	AllowFriendlyFire = false; --This is whether or not you can damage teammates
	CanDamageNPCs = true; --This is whether or not you can damage NPC's (Zombies, fake players, anything with a humanoid)
	
	
	CanKnife = true; --This is whether or not you can knife
	AutoKnife = false; --This is whether or not the gun will automatically knife if an enemy is within a specific distance
	AutoKnifeDist = 4; --This is how many studs away an enemy has to be for the gun to auto knife
	KnifeMeshId = "http://www.roblox.com/asset/?id=121944778"; --This is the Mesh of the knife
	KnifeTextureId = "http://www.roblox.com/asset/?id=121944805"; --This is the Texture of the knife
	KnifeCooldown = 0.5; --This is how long you have to wait before you can knife again
	KnifeAnim = 1; --This is the type of knife animation
	--[[
		Type 1: An animation that swings a knife from the left of the body to the right of the body
		Type 2: An animation that stabs the knife forward from the center of the body
	--]]
	
	
	Throwables = true; --This is whether or not you have grenades
	TrajectoryAssist = true; --This is whether or not the script will show you the flight path of the grenade before you throw it
	DetonationTime = 2; --[[This is how long the grenade will wait to detonate (If DetonateOnHit is false, this is how long the
		grenade will wait after the pin is pulled. If true, this is how long the grenade will wait after it hits something]]
	TimerStartOnHit = false; --This is whether or not the timer will start when the grenade hits something
	GrenadeSize = Vector3.new(0.8, 0.8, 0.8); --This is the size of the grenade (Doesn't apply to throwing knives)
	
	
	LethalGrenadeColor = BrickColor.new("Bright green"); --This is the color of the lethal grenade
	GrenadeBlastRadius = 20; --This is the blast radius of the explosion (Doesn't apply to non-explosive grenades)
	GrenadeBlastPressure = 6e5; --This is what the blast pressure of the explosion (Doesn't apply to non-explosive grenades)
	GrenadeExplosionType = Enum.ExplosionType.NoCraters; --This is the type of explosion (Doesn't apply to non-explosive grenades)
	--[[
	(0 or "NoCraters" or Enum.ExplosionType.NoCraters) means that the explosion will not damage terrain
	(1 or "Craters" or Enum.ExplosionType.Craters) means that the explosion will leave craters in terrain
	(2 or "CratersAndDebris" or Enum.ExplosionType.CratersAndDebris) means that the explosion will leave craters and debris in terrain
	--]]
	LethalAnimationTime = 1.5; --This is how long the throwing animation for the lethal will take
	LethalGrenadeDamage = 150; --This is max damage that the grenade will do
	LethalGrenadeThrowVelocity = 200; --This is the speed at which the lethal grenade is thrown
	GrenadeRayCastExplosions = true; --[[This is whether or not grenade explosions will have raycasting. If this is true, humanoids
		behind walls won't be damaged. If this is false, any humanoid within the radius will be damaged. (NOTE: GrenadeRangeBasedDamage
		has to be true in order for explosions to have raycasting)]]
	GrenadeRangeBasedDamage = true; --[[This is whether or not will depend on how far the object is from the center of the explosion.
		If this is true, the farther a humanoid is from the blast center, the less damage it'll take. If this is false, any object
		within the explosion's radius will have its joints broken]]
	LethalGrenadeType = 1; --This is the lethal grenade type
	--[[
		Type 1: Frag grenade [An explosive grenade]
		Type 2: Sticky [An explosive grenade that sticks to a surface]
		Type 3: Throwing Knife [A throwable knife]
		Type 4: Molotov [A grenade that explodes in flames on impact]
	--]]
	
	TacticalGrenadeColor = BrickColor.new("Brick yellow"); --This is the color of the lethal grenade
	TacticalAnimationTime = 1.5; --This how long the throwing animation for the tactical will take
	TacticalGrenadeThrowVelocity = 200; --This is the speed at which the tactical grenade is thrown
	GrenadeEffectRadius = 70; --[[This is the radius of the effect of the grenade. If the Grenade is a smoke, this is the radius of
		the smoke]]
	GrenadeEffectTime = 10; --[[This is the how long the grenade effect will last. If the grenade is a smoke, this is how long the
		smoke will linger]]
	TacticalGrenadeType = 1; --This is the tactical grenade type
	--[[
		Type 1: Smoke grenade [A grenade that creates a cloud of smoke]
		Type 2: Flashbang [A grenade that temporarily blinds and deafens players]
	--]]
	
	
	GrenadeTrail = true; --This is whether or not the grenade will have a trail
	GrenadeTrailColor = BrickColor.new("Black"); --This is the color of the grenade trail
	GrenadeTrailTransparency = 0.6; --This is the transparency of the trail
	GrenadeTrailThickness = 0.3; --This is the thickness of the trail
	GrenadeTrailVisibleTime = 0.2; --This is how long the trail will be visible for
	GrenadeTrailDisappearTime = 0.2; --This is how long it will take for the trail to disappear
	
	
	bulletTrail = false; --This is whether or not there will be a trail behind the bullet
	trailSettings = {
		Color = BrickColor.new("White"); --This is the color of the bullet trail
		Transparency = 0.6; --This is the transparency of the trail
		Thickness = 0.2; --This is the thickness of the trail
		visibleTime = 0; --This is how long the trail will be visible for
		disappearTime = 0.5; --This is how long it will take for the trail to disappear
	};
	
	
	bulletHoles = true; --This is whether or not bullet holes will appear where you shot
	holeSettings = {
		Texture = "http://www.roblox.com/asset/?id=64291961"; --This is the texture of the bullet hole
		Size = 0.5; --This is how big the bullet hole will be in studs
		visibleTime = 3; --This is how long the bullet hole will be visible for
		disappearTime = 1; --This is how long it will take for the bullet hole to disappear
	};
	
	
	bulletSparks = true; --This is whether or not sparks will fly when a bullet hits a surface
	sparkSettings = {
		Color = Color3.new(1, 1, 127 / 255); --This is the color of the sparks
		Size = 0.075; --This is the size of the sparks
		Texture = "http://www.roblox.com/asset/?id=3419963"; --This is the texture of the sparks
		Lifetime = 0.2; --This is the lifetime of each spark in seconds +-0.05 seconds
		Rate = 150; --This is the number of sparks that fly
		Speed = 45; --This is the speed at which the sparks fly +-5 studs/sec
		Spread = 45; --This is the angle in degrees at which the sparks spread out (0 means single line, 180 means all around)
		Materials = { --This is the list of the materials which cause bullet sparks. You can add or remove materials from this list
			Enum.Material.Plastic;
			Enum.Material.Slate;
			Enum.Material.Concrete;
			Enum.Material.CorrodedMetal;
			Enum.Material.DiamondPlate;
			Enum.Material.Foil;
			Enum.Material.Marble;
			Enum.Material.Granite;
			Enum.Material.Brick;
			Enum.Material.Pebble;
			Enum.Material.SmoothPlastic;
			Enum.Material.Metal;
			Enum.Material.Cobblestone;
		};
	};
	
	
	bulletSmoke = true; --This is whether or not smoke particles will fly when a bullet hits a surface
	smokeSettings = {
		objColor = true; --This is whether or not the smoke color will be the color of the object the bullet hit
		Color = Color3.new(0.5, 0.5, 0.5); --This is what the color of the smoke will be if objColor is false
		Size = {
			Start = 0.25; --This is what the starting size of the smoke will be
			End = 0.5; --This is what the ending size of the smoke will be
		};
		Texture = "http://www.roblox.com/asset/?id=244514423"; --This is what the texture of the smoke will be
		startTransparency = 0; --This is what the transparency of the particle starts at. It gradually goes to 1
		Lifetime = 0.2; --This is the lifetime of each smoke particle +-0.05 seconds
		Rate = 100; --This is the number of smoke particles that fly
		Speed = 35; --This is the speed at which the smoke particles fly +-5 studs/sec
		Spread = 15; --This is the angle in degrees at which the smoke particles spread out (0 means single line, 180 means all around)
	};
	
	
	bloodEffect = true; --This is whether or not blood particles will appear from the bullet exit position when a humanoid is shot
	bloodSettings = {
		Color = Color3.new(1, 0, 0); --This is what the color of the blood will be
		Size = 0.1; --This is what the size of the blood will be with an +-0.1
		Texture = "http://www.roblox.com/asset/?id=3419963"; --This is what the texture of the blood will be
		startTransparency = 0.125; --This is what the starting transparency of the blood will be +-0.125
		Lifetime = 0.1; --This is what the lifetime of each blood particle +-0.05 seconds
		Rate = 200; --This is the number of blood particles that appear
		Speed = 50; --This is the speed at which the blood particles fly
		Spread = 15; --This is the angle in degrees at which the blood particles spread out (0 means single line, 180 means all around)
	};
	
	
	bulletShockwave = true; --This is whether or not a shockwave will appear where you shot. (A sphere that appears when the bullet hits)
	shockwaveSettings = {
		Radius = 0.3; --This is the radius of the shockwave. (If the gun type is explosion, this radius will be the blast radius)
		Color = BrickColor.new("Light stone grey"); --This is the color of the shockwave
		Duration = 0.2; --This is how long the shockwave will take to disappear
	};
	
	
	penetrationSettings = {
		Dist = 5; --This is the maximum amount of studs a bullet can penetrate into a wall (that isn't ignored)
		transparencyThreshold = 1; --This is what the transparency of a wall has to be greater than or equal to in order to be ignored
		ignoreNonCanCollide = true; --This is whether or not the script should ignore non-cancollide parts
		ignoreCustom = {}; --This is a table of objects that will be ignored by the script. The object and it's descendants will be ignored
	};
	
	
	recoilSettings = {
		firstShotMultiplier = 1; --This is what the recoil multiplier for the first shot will be. The rest of the shots will be normal recoil
		aimedMultiplier = 0.5; --When you're aimed, this is what the recoil will be multiplied by
		camMultiplier = 2.5; --This is what the gun up recoil will be multiplied by to get you the cam recoil
		springSpeed = 15; --This is the what the speed of the gun's recoil spring will be. The lower it is the slower the gun sways around
		springDamper = 0.5; --This is a number between 0 and 1 that determines how quickly the spring will be dampened.
		Recoil = {
			Side = { --This is the side to side gun and camera recoil
				Left = -0.1;
				Right = 0.3;
			};
			Up = { --This is the up and down gun and camera recoil
				Min = 1.9;
				Max = 2;
			};
			Back = { --[[This is the kick back gun recoil. NOTE: The numbers below are the amount the gun moves back, so the gun will move back
				a value/2 amount of studs. So if the min is 0.25 and the max is 0.3, the gun will move back anywhere between 0.025 and 0.03 studs]]
				Min = 0.4;
				Max = 0.45;
			};
			Tilt = { --[[This is tilt camera recoil. NOTE: The numbers below are the amount of deca-degrees the camera tilts, so if the left is -1
				and the right is 1 then the gun will tilt anywhere between -10 degress and 10 degrees]]
				Left = -0.5;
				Right = 0.5;
			};
		}
	};
	
	
	spreadSettings = {
		Increase = 0.3; --This is what is added to the spread of the bullet every time you fire
		Decrease = 15; --This is what the spread of the bullet decreases by per second
		
		--[[This spread values are how many degrees offset the bullets will travel from the center, so a spread of 1 would mean that the bullet's
		max spread in any direction is 1 degree from the center. The idling category is when you're not moving, and the moving category is when
		you're moving]]
		Aimed = {
			Stand = {
				Idling = 0;
				Moving = 0;
			};
			Crouch = {
				Idling = 0;
				Moving = 0;
			};
			Prone = {
				Idling = 0;
				Moving = 0;
			};
		};
		unAimed = {
			Stand = {
				Idling = 1.5;
				Moving = 3.5;
			};
			Crouch = {
				Idling = 2.5;
				Moving = 4;
			};
			Prone = {
				Idling = 1.5;
				Moving = 4;
			};
		};
	};
	
	
	reloadSettings = {
		Anim = true; --This is whether or not there is an animation for reloading
		Times = {
			Loaded = 2.036; --This is how long it takes to reload the gun if a bullet is already chambered
			Empty = 2.036; --This is how long it takes to reload the gun if a bullet isn't chambered
		};
		autoReload = true; --This is whether or not the gun will reload automatically when the ammo reaches 0
		magIsBullet = false; --This is whether or not the mag is the bullet itself. This is useful for guns with only 1 bullet per clip
		reloadWhileRunning = true; --This is whether or not you can reload while running
	};
	
	
	sprintTime = 15; --This is the maximum time you can sprint
	staminaCoolTime = 4; --This is how long it takes for your stamina to fully recharge
	canFireWhileRunning = false; --This is whether or not you can shoot while sprinting
	
	
	dolphinDive = true; --This is whether or not you can dolphin dive (Run and crouch at the same time to dive)
	diveSettings = {
		rechargeTime = 1; --This is how long you have to wait till you can dive or run again after you've dived
		Force = 750; --This is the multiplier for the dolphin dive force. The higher it is the farther you'll dive
		Angle = math.rad(30); --This is the angle in radians from the ground that you dive at
	};
	
	
	canChangeStance = true; --This is whether or not you can change stance. That means whether or not you can crouch or go prone
	stanceSettings = {
		Anim = true; --This is whether or not there is an animation for changing stance
		Speed = 0.3; --This is how quickly you change stance
		Stances = {
			Crouch = true; --This is whether or not you can crouch
			Prone = true; --This is whether or not you can go prone
		};
		standOnDeselect = true; --This is whether or not you stand up when you deselect the tool
		crawlAnimation = true; --This is whether or not you crawl while moving when you're prone
	};
	
	
	walkSpeeds = {
		Base = 14; --This is the base walkspeed
		Sprinting = 25; --This is the walkspeed when you're sprinting
		Aimed = 7; --[[This is the base walkspeed when the gun is aimed down. If you crouch or go prone, the speed will change
		based on the Aimed walkspeed to Base walkspeed ratio]]
		Crouched = 6; --This is the walkspeed when you're crouched
		Prone = 3; --This is the walkspeed when you're prone
	};
	
	
	--NOTE: For extra keys, go here: http://wiki.roblox.com/index.php?title=Taking_keyboard_input
	Keys = {
		lowerStance = "c"; --This is the key you press to lower your stance (Stand > Crouch > Prone)
		raiseStance = "x"; --This is the key you press to raise your stance (Prone > Crouch > Stand)
		selectFire = "e"; --This is the key you press to switch fire modes
		Reload = "r"; --This is the key you press to reload
		Sprint = string.char(48); --This is the key you press to sprint
		Knife = "f"; --This is the key you press to knife
		lethalGrenade = "g"; --This is the key you press to throw the lethal grenade
		tacticalGrenade = "t"; --This is the key you press to throw the tactical grenade
		ADS = "q"; --This is the key you press to ADS. If you want ADS to just be right mouse, then make this key ""
		scopeSteady = string.char(48); --This is the key you press to steady the scope
	};
	
	
}

return Settings