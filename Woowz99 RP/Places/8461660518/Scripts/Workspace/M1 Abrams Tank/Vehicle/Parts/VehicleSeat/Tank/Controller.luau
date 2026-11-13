local RE = game:GetService('ReplicatedStorage')
local TFE = RE:WaitForChild('TankFireEvent')
if not TFE then print('No FireEvent, unable to function. HopperBin("Tank") > Controller') end

if not script.Parent.Parent.Parent:FindFirstChild("Turret") then
	repeat until script.Parent.Parent.Parent.ChildAdded:wait().Name == "Turret";
end

local Active = true

-- This finds the tank that we are controlling
parts = script.Parent.Parent.Parent.Turret.Value;
tankStats = parts.Stats;

-- Player's tank GUI
GUI = script.Parent.Parent.Parent.PlayerGui.TankGUI;
GUI.HP.Hitpoints.Text = parts.Parent:findFirstChild("Damage").Value

local Hull = parts.Parent:findFirstChild("Damage")

if Hull.Value<0 then
	GUI.HP.Hitpoints.Text = "DISABLED"
end

	
local MGDamage = math.random(20,25)


braking = false;
firingMg = false;
reloading = false;
currRound = tankStats.Round; -- Current loaded ammo (AP/HE)


myMouse = nil;

function updateAmmo()
	GUI.Ammo.Text = "Cannon Ammo = " .. tankStats[tankStats.Round.Value .. "Ammo"].Value;
	GUI.MG_Ammo.Text = tankStats.MGAmmo.Value;
	GUI.HP.Hitpoints.Text = parts.Parent:findFirstChild("Damage").Value
end


function Brakes()
	for i = 1, 5 do
	parts.Engine.BodyVelocity.Velocity = Vector3.new(0,0,0)
	print("Brakes activated")
	end
end

Loaded = false
-- Reload animation
function reload()
	if not reloading then
		reloading=true;
		updateAmmo()
		local reloadTime = tankStats.ReloadTime.Value;	


		local Timer = 0
	

		for i = 7, 1, -1 do
			wait(reloadTime/8);
			Timer = Timer + 1
			
			if Timer >= 2 and Loaded == false then
				GUI.ReloadSound:Play()
				Loaded = true
			end
		end
		wait(reloadTime/8);


		if Timer >= 7 then
		
		GUI.Loaded.Visible = true	
		
		
		
		Timer = 0
			reloading = false;
			
		end
		
		
	end
end

function fire()
	
	if reloading then return end;
	local APAmmo = tankStats.APAmmo;
	local HEAmmo = tankStats.HEAmmo;
	if currRound.Value == "AP" and APAmmo.Value <= 0 then return end
	if currRound.Value == "HE" and HEAmmo.Value <= 0 then return end
	GUI.Loaded.Visible = false
	
	TFE:FireServer('Fire',parts,currRound,APAmmo,HEAmmo,tankStats)
	
	reload(GUI);
	
end

-- When Clicked
function onButton1Down(mouse)
	--print("Down");
	--print(mouse.hit.p);
	fire();
	updateAmmo();
end

-- When mouse released
function onButton1Up(mouse)
	--print("Up");
end

-- When tool is selected
function onSelected(mouse)
	myMouse = mouse;
	mouse.Icon = "rbxassetid://412054506"; -- Change The ID - Eng
	mouse.Button1Down:connect(function() onButton1Down(mouse) end);
	mouse.Button1Up:connect(function() onButton1Up(mouse) end);
	mouse.KeyDown:connect(onKeyDown);
	mouse.KeyUp:connect(onKeyUp);

	updateAmmo();
	print("Tank Tool Equipped")
	
	wait()
	
	
	parts.Parent.Driver.Value = script.Parent.Parent.Parent.Name
	
	if Active == true then
		while Active do
		updateAmmo()
		
		wait()		
		end
	end
end

-- When tool deselected
function onDeselected(mouse)
	myMouse = nil
end

--rayPart					= Instance.new("Part")
--rayPart.Name			= "MG Ray"
--rayPart.Transparency	= .5
--rayPart.Anchored		= true
--rayPart.CanCollide		= false
--rayPart.TopSurface		= Enum.SurfaceType.Smooth
--rayPart.BottomSurface	= Enum.SurfaceType.Smooth
--rayPart.formFactor		= Enum.FormFactor.Custom
--rayPart.BrickColor		= BrickColor.new("Bright yellow")
--rayPart.Reflectance		= 0
--rayPart.Material = Enum.Material.SmoothPlastic

function fireCoax()
	local MGAmmo = tankStats.MGAmmo;
	if MGAmmo.Value <= 0 then
		return false;
	end;
	
	TFE:FireServer('FireMinigun',parts,tankStats,MGDamage,script.Parent)
	
	wait(1/350*60);
	
	return true;
end

-- When key pressed
function onKeyDown(key)
	if key == nil then return end
	key = key:lower()
			
	-- Coaxial Machine Gun Control
	if key == 'c' then
		if firingMg then return end
			
		firingMg = true;
			
		while firingMg do
			if not fireCoax() then
				firingMg = false;
			wait()
			end
			updateAmmo();
		end	
	end
	
	
	if key == 'f' then
		if tankStats.Round.Value == "AP" then
			tankStats.Round.Value = "HE";
		else
			tankStats.Round.Value = "AP";
		end
		updateAmmo();
	end
	
	-- Switch ammo type
	if key == 'e' then
		parts.Engine.BodyGyro.MaxTorque = Vector3.new(0,0,100)
		print("Flipping Vehicle")
		wait(5)
		parts.Engine.BodyGyro.MaxTorque = Vector3.new(0,0,0)
	end
	if key == 'q' then
		if braking then return end
			
		braking = true;
			
		while braking do
			if not Brakes() then
				braking = false;
			end
			updateAmmo();
		end	
	end
end

-- When key released
function onKeyUp(key)
	if key == nil then return end
	key = key:lower()
	
	-- Stop firing MG
	if key == 'c' then
		firingMg = false;
	end
end

script.Parent.Selected:connect(onSelected)
script.Parent.Deselected:connect(onDeselected)

-- Determine the gun elevation and tilt
function determineNewDirections(targetVector)
	local targElev = 0;
	local targRot = 0;
	
	local turretMain = 	parts.TurretRing2;
	
	-- Vector normal to the plane which is the turret ring
	local turretNormal = turretMain.CFrame.lookVector;
	
	local angleFromNormal = turretNormal:Dot(targetVector);
	
	-- Determine gun elevation
	targElev = math.pi/2 - math.acos(angleFromNormal);
	targRot= math.pi/2 - math.acos(angleFromNormal);	

	-- Projection of target vector onto the turret plane
	local targetProjection = (targetVector - (angleFromNormal*turretNormal)).unit;	

	local forwardVector = ( (turretMain.CFrame - turretMain.CFrame.p) -- Orientation only of brick
		* CFrame.new(0, -1, 0)).p; -- Translated down 1
	
	-- Determine angle between forward vector and the projected target vector
	targRot = math.acos(forwardVector:Dot(targetProjection));
	
	-- Determine the sign of the angle
	local vectorCross = forwardVector:Cross(targetProjection);
	
	-- If the cross product is opposite to the normal vector, make the angle negative
	if (vectorCross:Dot(turretNormal) < 0) then
		targRot = -targRot;
	end
	
	-- Put rotation and elevation into an array
	local rotations = {};
	rotations[1] = targElev;
	rotations[2] = targRot;
	
	return rotations;
end

function sign(input)
	if (input < 0) then
		return -1;
	else
		return 1;
	end
end

-- Using the desired target rotation and elevation, determine where the gun should point right now (smoothly turn)
function getSmoothRotation(rotations)
	
	local targElev = rotations[1];
	local targRot = rotations[2];	
	
	local maxGunDepression = tankStats.GunHandling.GunDepression.Value;	
	local maxTraverse = tankStats.GunHandling.GunTraverse.Value;	

	-- Restrict the height of travel of the gun
	if math.abs(targElev) > maxGunDepression then
		targElev = maxGunDepression*sign(targElev);
	end
	
	if math.abs(targRot) > maxTraverse then
		targRot = maxTraverse*sign(targRot);
	end
	

	-- Once target angles are set, slowly turn turret towards them
	-- Elevation
	local elevDiff = targElev - currentElev;
	if math.abs(elevDiff) < 0.01 then -- If they're close
		currentElev = targElev;
	else -- Move towards it
		currentElev = currentElev + 0.01*sign(elevDiff);
	end



	local rotDiff = targRot - currentRot;
	local turretSpeed = tankStats.GunHandling.TurretSpeed.Value;
	
	if math.abs(rotDiff) < turretSpeed then -- If they're close
		currentRot = targRot;
	else -- Move towards it
		currentRot = currentRot + turretSpeed*sign(rotDiff);
	end
	
	-- Put rotation and elevation into an array
	local rotations = {};
	rotations[1] = targElev;
	rotations[2] = targRot;
	
	return rotations;
end

-- Infinitely update the target position for the tank
currentElev = 0;
currentRot = 0;
while wait() do
	if (myMouse) then
		-- Position of mouse in world
		mousePoint = myMouse.Hit.p;
		
		-- Vector from tank to mouse point
		targetVector = (mousePoint - parts.GunBase.CFrame.p).unit;
		
		-- Determine where the gun should point
		targetRotations = determineNewDirections(targetVector);
		
		-- For each time we do all that math to determine the angle, we will smoothly rotate the gun towards it in 4 increments
		-- This means less lag (fewer calculations) but it's still smooth
		for i = 1, 4 do		
			newRotations = getSmoothRotation(targetRotations);
			TFE:FireServer('RotateTurret',parts,currentElev, currentRot)
			wait();
		end
	end
end
