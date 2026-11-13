local Settings = {
	
	
	gunType = {
		Semi = false;
		Auto = true;
		Burst = false;
		Shot = false;
		Explosive = false;
	};
	
	selectFire = false;
	selectFireSettings = {
		Animation = true;
		GUI = false;
		Modes = {
			Safety = true;
			Semi = false;
			Burst = true;
			Auto = true;
		};
		animSpeed = 0.5;
	};
	
	
	burstSettings = {
		fireRateBurst = true;
		Amount = 3;
		Time = 0.2;
		Wait = 0.1;
	};
	
	
	shotAmount = 5;
	
	
	explosionSettings = {
		Radius = 20;
		Pressure = 5e5;
		Type = Enum.ExplosionType.NoCraters;
		
		soundId = "rbxassetid://138499093";
		soundPitch = 1;
		soundVolume = 1;
		rayCastExplosions = false;
		rangeBasedDamage = true;
	};
	
	
	playerArms = true;
	fakeArmSettings = {
		Transparency = 0;
		armSize = Vector3.new(0.6, 2, 0.6);
		characterMeshes = false;
		realBodyColor = true;
		Color = BrickColor.new("Pastel brown");
	};
	
	
	unAimedC1 = {
		leftArm = CFrame.new(-.5, 1.3, -1.7) * CFrame.Angles(math.rad(-30), -.5, math.rad(-30));
		rightArm = CFrame.new(0.4, 0.25, -0.3) * CFrame.Angles(0, 0, math.rad(25));
		Grip = CFrame.Angles(0, math.rad(25), 0);
	};
	aimedC1 = {
		leftArm = CFrame.new(-.1, 1.3, -1) * CFrame.Angles(math.rad(-30), -.5, 0) * CFrame.Angles(0, 0, math.rad(-40));
		rightArm = CFrame.new(0.5, 0.3, 0.1) * CFrame.Angles(0, 0, math.rad(45));
	};
	runningC1 = {
		leftArm = CFrame.new(-0.8, .9, -1) * CFrame.Angles(math.rad(1), math.rad(-8.5), math.rad(16));
		rightArm = CFrame.new(0.16, 1, -0.14) * CFrame.Angles(math.rad(15), math.rad(2), math.rad(50));
		Grip = CFrame.Angles(0, math.rad(-5), 0);
	};
	
	
	equipAnimation = true;
	equipSettings = {
		Time = 0.25;
		leftArmC1 = CFrame.new(0.2, 1.2, 0) * CFrame.Angles(math.rad(105), math.rad(-30), math.rad(90));
		rightArmC1 = CFrame.new(-0.5, 0.75, 0) * CFrame.Angles(math.rad(45), 0, math.rad(75)); 
		GripC1 = CFrame.new();
	};
	
	
	stopAnimsOnFall = true;
	fallAnimation = true;
	fallSettings = {
		maxDist = 35;
		landMultiplier = 1;
		fallMultiplier = 1;
		aimEffect = 0.25;
	};
	
	
	gunMomentum = true;
	momentumSettings = {
		maxInput = 18;
		Speed = 20;
		Damper = 0.5;
		Amplitude = {
			unAimed = 5;
			Aimed = 1;
		}
	};
	
	
	cockingAnim = false;
	movementAnims = true;
	
	
	canADS = true;
	aimSettings = {
		Anim = true;
		Speed = 0.3;
		FOV = 37;
		holdToADS = true;
		headTilt = math.rad(25);
	};
	
	
	sensitivitySettings = {
		Default = 1;
		Aim = 0.3;
		
		scrollToChange = true;
		Min = 0.05;
		Max = 1;
		Increment = 0.05;
	};
	
	
	guiScope = false;
	scopeSettings = {
		Frequency = {
			Idling = 0.7;
			Walking = 2;
		};
		Amplitude = {
			Idling = 0.75;
			Walking = 0.75;
		};
		steadyTime = 8;
		breathTime = 5;
		camSwayOnBreath = 2.5;
		unSteadyOnFire = true;
	};
	
	
	roundsPerMin = 1000;
	
	
	bulletSettings = {
		instantHit = true;
		Range = 900;
		Velocity = 540;
		Acceleration = 196.2;
		Color = BrickColor.new("Bright red");
		Transparency = 0;
		Size = Vector3.new(0.1, 0.1, 5);
	};
	
	
	damageSettings = {
		Start = {
			Damage = 30;
			Dist = 0.08;
		};
		End = {
			Damage = 23;
			Dist = 0.5;
		};
		Multipliers = {
			Chest = 1;
			Head = 1.1;
			Limbs = 1;
		};
	};
	
	
	AllowFriendlyFire = false;
	CanDamageNPCs = true;
	
	bulletTrail = false;
	trailSettings = {
		Color = BrickColor.new("White");
		Transparency = 0;
		Thickness = 0;
		visibleTime = 0;
		disappearTime = 0;
	};
	
	
	bulletHoles = true;
	holeSettings = {
		Texture = "http://www.roblox.com/asset/?id=64291961";
		Size = 0.5;
		visibleTime = 3;
		disappearTime = 1;
	};
	
	
	bulletSparks = true;
	customSparks = false;
	sparkSettings = {
		Color = {
			Start = Color3.new(1, 158 / 255, 24 / 255);
			End = Color3.new(212 / 255, 242 / 255, 8 / 255);
		};
		Size = 0.25;
		Texture = "http://www.roblox.com/asset/?id=311395391";
		Lifetime = 0.2;
		Rate = 75;
		Speed = 25;
		Spread = 45;
		Materials = {
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
	
	
	bulletSmoke = false;
	smokeSettings = {
		objColor = false;
		Color = Color3.new(0.5, 0.5, 0.5);
		Size = {
			Start = 0.25;
			End = 0.5;
		};
		Texture = "http://www.roblox.com/asset/?id=244514423";
		startTransparency = 0;
		Lifetime = 0.2;
		Rate = 100;
		Speed = 35;
		Spread = 15;
	};
	
	
	bloodEffect = true;
	bloodSettings = {
		Color = Color3.new(1, 0, 0);
		Size = 0.1;
		Texture = "http://www.roblox.com/asset/?id=3419963";
		startTransparency = 0.125;
		Lifetime = 0.1;
		Rate = 200;
		Speed = 50;
		Spread = 15;
	};
	
	
	bulletShockwave = false;
	shockwaveSettings = {
		Radius = 0.3;
		Color = BrickColor.new("Light stone grey");
		Duration = 0.2;
	};
	
	
	penetrationSettings = {
		Dist = 0;
		transparencyThreshold = 1;
		ignoreNonCanCollide = true;
		ignoreCustom = {};
	};
	
	
	recoilSettings = {
		firstShotMultiplier = 2.4;
		aimedMultiplier = 0.5;
		camMultiplier = 2;
		springSpeed = 15;
		springDamper = 0.5;
		Recoil = {
			Side = {
				Left = -0.17;
				Right = 0.28;
			};
			Up = {
				Min = 0.26;
				Max = 0.28;
			};
			Back = {
				Min = 0.3;
				Max = 0.35;
			};
			Tilt = {
				Left = -0.5;
				Right = 0.5;
			};
		}
	};
	
	
	spreadSettings = {
		Increase = 0.1;
		Decrease = 15; 
		
		Aimed = {
			Stand = {
				Idling = 0.2;
				Moving = 0.4;
			};
			Crouch = {
				Idling = 0.15;
				Moving = 0.3;
			};
			Prone = {
				Idling = 0.1;
				Moving = 0.3;
			};
		};
		unAimed = {
			Stand = {
				Idling = 2;
				Moving = 2.5;
			};
			Crouch = {
				Idling = 1.5;
				Moving = 2;
			};
			Prone = {
				Idling = 1;
				Moving = 2;
			};
		};
	};
	
	
	reloadSettings = {
		Anim = true;
		Times = {
			Loaded = 2.03;
			Empty = 2.4;
		};
		autoReload = true;
		magIsBullet = false;
		reloadWhileRunning = true;
	};
	
	
	sprintTime = 15;
	staminaCoolTime = 4;
	canFireWhileRunning = false;
	
	
	dolphinDive = true;
	diveSettings = {
		rechargeTime = 1;
		Force = 350;
		Angle = math.rad(30);
	};
	
	
	canChangeStance = true;
	stanceSettings = {
		Anim = true;
		Speed = 0.3;
		Stances = {
			Crouch = true;
			Prone = true;
		};
		standOnDeselect = true;
		crawlAnimation = true; 
	};
	
	
	walkSpeeds = {
		Base = 16;
		Sprinting = 25;
		Aimed = 10;
		Crouched = 7;
		Prone = 4;
	};
	
	
	--NOTE: For extra keys, go here: http://wiki.roblox.com/index.php?title=Taking_keyboard_input
	Keys = {
		lowerStance = "c";
		raiseStance = "x";
		selectFire = "f";
		Reload = "r";
		Sprint = string.char(48);
		ADS = "q";
		scopeSteady = string.char(48);
	};
	
	
}

return Settings