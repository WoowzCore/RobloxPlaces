local config = {
	
		--// Customizations
		StartupTime = 5;
		
		--// Group Only
		isGroupOnly = false;
		GroupID = 4194865;
		GroupRank = 1;
		
		--// Weapon Config
		BulletSpeed = 2500;
		CastDist = 10000;
		BulletSize = Vector3.new(0.2, 0.2, 12);
		FireRate = 1000;
		
		BulletDamage = 60;
		
		RocketFireRate = 200;
		BlastRadius = 10;
		
		--// Ammo
		RocketAmmo = math.huge;
		
		--// Speeds
		UpSpeed = 1.5;
		DownSpeed = 1.5;
		ForwardSpeed = 3;
		BackwardSpeed = 2;
		RightSpeed = 1.2;
		LeftSpeed = 1.2;
		
		--// Rotations
		FrontRotation = 5;
		BackRotation = 15;
		RightRotation = 15;
		LeftRotation = 15;
		
		--// Keybindings
		StartupKey = Enum.KeyCode.Y;
		UpKey = Enum.KeyCode.Space;
		DownKey = Enum.KeyCode.LeftControl;
		ForwardKey = Enum.KeyCode.W;
		BackwardKey = Enum.KeyCode.S;
		RightKey = Enum.KeyCode.D;
		LeftKey = Enum.KeyCode.A;
		MouseToggleKey = Enum.UserInputType.MouseButton1;
	
	
	}

return config
