local Plyr = script:WaitForChild("Plyr")

local Gun = script.Parent
local Handle = Gun:WaitForChild("Handle")

local V3 = Vector3.new
local CF, CFANG = CFrame.new, CFrame.Angles

local RAD = math.rad

local numLerp = function(A, B, Alpha)
	return A + (B - A) * Alpha
end

local inList = function(Element, List)
	for _, v in pairs(List) do
		if v == Element then
			return true
		end
	end
	return false
end

local getObject = function(Model, Class, Name)
	for _, v in pairs(Model:GetChildren()) do
		if v:IsA(Class) and v.Name == Name then
			return v
		end
	end
	return nil
end

----------------------------------------------------------------------
--------------------[ IGNORE MODEL HANDLING ]-------------------------
----------------------------------------------------------------------

wait(math.random(0, 20) / 40) --This is to prevent more than one ignoreModel from being created

if _G.ignoreCode then --If the ignoreCode already exists, then the script creates the ignoreModel
	--[[
		The purpose of this is so that every gun in a game that uses this gun kit will share one ignoreModel. That way,
		bullet trails, bullet holes, and other fake arms will be ignored by the gun which makes the bullets more likely to
		hit a character part
	--]]
	if (not game.Workspace:FindFirstChild("ignoreModel_".._G.ignoreCode)) then
		local ignoreModel = Instance.new("Model")
		ignoreModel.Name = "ignoreModel_".._G.ignoreCode
		ignoreModel.Parent = game.Workspace
		
		local grenadeFolder = Instance.new("Model")
		grenadeFolder.Name = "grenadeFolder"
		grenadeFolder.Parent = ignoreModel
	
		spawn(function()
			while true do
				ignoreModel.Parent = game.Workspace
				grenadeFolder.Parent = ignoreModel
				wait(1 / 20)
			end
		end)
	end
	
	script.Parent:WaitForChild("clientMain"):WaitForChild("ignoreCode").Value = _G.ignoreCode
else
	--[[
		If there isn't already an ignoreCode, then this creates one. The purpose of it being random is so that if there is
		an ignoreModel for something else in the game, the script won't end up placing the ignored objects in that ignoreModel
	--]]
	_G.ignoreCode = math.random(1, 1e4)
	
	if (not game.Workspace:FindFirstChild("ignoreModel_".._G.ignoreCode)) then
		local ignoreModel = Instance.new("Model")
		ignoreModel.Name = "ignoreModel_".._G.ignoreCode
		ignoreModel.Parent = game.Workspace
		
		local grenadeFolder = Instance.new("Model")
		grenadeFolder.Name = "grenadeFolder"
		grenadeFolder.Parent = ignoreModel
	
		spawn(function()
			while true do
				ignoreModel.Parent = game.Workspace
				grenadeFolder.Parent = ignoreModel
				wait(1 / 20)
			end
		end)
	end
	
	script.Parent:WaitForChild("clientMain"):WaitForChild("ignoreCode").Value = _G.ignoreCode
end

spawn(function()
	--[[
		This function deletes any Player Folders that were left in the ignoreModel because the player left the game without
		deselecting the Gun first
	--]]
	repeat wait() until _G.ignoreCode
	local ignoreModel = game.Workspace:WaitForChild("ignoreModel_".._G.ignoreCode)
	while true do
		for _, gunIgnore in pairs(ignoreModel:GetChildren()) do
			if gunIgnore.Name ~= "grenadeFolder" then
				if (not game.Players:FindFirstChild(gunIgnore.Name:sub(11))) then
					gunIgnore:Destroy()
				end
			end
		end
		wait(1 / 20)
	end
end)

----------------------------------------------------------------------
--------------------[ RESET CAMERA ]----------------------------------
----------------------------------------------------------------------

Gun.ChildRemoved:connect(function(Child)
	if Child == Handle and Plyr.Value then
		local ignoreCode = Gun:WaitForChild("clientMain"):WaitForChild("ignoreCode").Value
		local resetCam = script:WaitForChild("resetCam")
		resetCam:WaitForChild("ignoreCode").Value = ignoreCode
		resetCam.Parent = Plyr.Value.PlayerGui
	end
end)

----------------------------------------------------------------------
--------------------[ GET WELD CFRAMES ]------------------------------
----------------------------------------------------------------------

for _, v in pairs(Gun:GetChildren()) do
	if v:IsA("BasePart") and v ~= Handle then
		if v:FindFirstChild("mainWeld") then v.mainWeld:Destroy() end
		if (not v:FindFirstChild("weldCF")) then
			local weldCF = Instance.new("CFrameValue")
			weldCF.Name = "weldCF"
			weldCF.Value = Handle.CFrame:toObjectSpace(v.CFrame)
			weldCF.Parent = v
		end
		if string.sub(v.Name, 1, 3) == "Mag" then
			if (not v:FindFirstChild("magTrans")) then
				local magTrans = Instance.new("NumberValue")
				magTrans.Name = "magTrans"
				magTrans.Value = v.Transparency
				magTrans.Parent = v
			end
		end
		v.Anchored = true
		v.CanCollide = false
	end
end
Handle.Anchored = false
Handle.CanCollide = true

----------------------------------------------------------------------
--------------------[ GUNSETUP HANDLING ]-----------------------------
----------------------------------------------------------------------

local gunSetup = script:WaitForChild("gunSetup")
function gunSetup.OnServerInvoke(Player, Vars)
	
	--------------------[ CREATING IGNORE MODELS ]--------------------------------
	
	local gunIgnore = Instance.new("Model")
	gunIgnore.Name = "gunIgnore_"..Player.Name
	gunIgnore.Parent = Vars.ignoreModel
	
	--------------------[ MODIFYING THE PLAYER ]----------------------------------
		
	Vars.Humanoid.AutoRotate = false
	
	Vars.Shoulders.Right.Part1 = nil
	Vars.Shoulders.Left.Part1 = nil
	
	local playerFolder = Instance.new("Model")
	playerFolder.Name = "playerFolder"
	playerFolder.Parent = gunIgnore
	
	local headBase = Instance.new("Part")
	headBase.Transparency = 1
	headBase.Name = "headBase"
	headBase.CanCollide = false
	headBase.FormFactor = Enum.FormFactor.Custom
	headBase.Size = V3(0.2, 0.2, 0.2)
	headBase.BottomSurface = Enum.SurfaceType.Smooth
	headBase.TopSurface = Enum.SurfaceType.Smooth
	headBase.Parent = playerFolder
		
	local headWeld = Instance.new("Weld")
	headWeld.Part0 = Vars.Torso
	headWeld.Part1 = headBase
	headWeld.C0 = CF(0, 1.5, 0)
	headWeld.Parent = Vars.Torso
	
	local headWeld2 = Instance.new("Weld")
	headWeld2.Part0 = headBase
	headWeld2.Part1 = Vars.Head
	headWeld2.Parent = headBase
		
	local animBase = Instance.new("Part")
	animBase.Transparency = 1
	animBase.Name = "animBase"
	animBase.CanCollide = false
	animBase.FormFactor = Enum.FormFactor.Custom
	animBase.Size = V3(0.2, 0.2, 0.2)
	animBase.BottomSurface = Enum.SurfaceType.Smooth
	animBase.TopSurface = Enum.SurfaceType.Smooth
	animBase.Parent = playerFolder
	
	local animWeld = Instance.new("Weld")
	animWeld.Part0 = animBase
	animWeld.Part1 = headBase
	animWeld.Parent = animBase
	
	local armBase = Instance.new("Part")
	armBase.Transparency = 1
	armBase.Name = "ArmBase"
	armBase.CanCollide = false
	armBase.FormFactor = Enum.FormFactor.Custom
	armBase.Size = V3(0.2, 0.2, 0.2)
	armBase.BottomSurface = Enum.SurfaceType.Smooth
	armBase.TopSurface = Enum.SurfaceType.Smooth
	armBase.Parent = playerFolder
	
	local ABWeld = Instance.new("Weld")
	ABWeld.Part0 = armBase
	ABWeld.Part1 = animBase
	ABWeld.Parent = armBase
		
	local LArmBase = Instance.new("Part")
	LArmBase.Transparency = 1
	LArmBase.Name = "LArmBase"
	LArmBase.CanCollide = false
	LArmBase.FormFactor = Enum.FormFactor.Custom
	LArmBase.Size = V3(0.2, 0.2, 0.2)
	LArmBase.BottomSurface = Enum.SurfaceType.Smooth
	LArmBase.TopSurface = Enum.SurfaceType.Smooth
	LArmBase.Parent = playerFolder
	
	local RArmBase = Instance.new("Part")
	RArmBase.Transparency = 1
	RArmBase.Name = "RArmBase"
	RArmBase.CanCollide = false
	RArmBase.FormFactor = Enum.FormFactor.Custom
	RArmBase.Size = V3(0.2, 0.2, 0.2)
	RArmBase.BottomSurface = Enum.SurfaceType.Smooth
	RArmBase.TopSurface = Enum.SurfaceType.Smooth
	RArmBase.Parent = playerFolder
	
	local LWeld = Instance.new("Weld")
	LWeld.Name = "LWeld"
	LWeld.Part0 = armBase
	LWeld.Part1 = LArmBase
	LWeld.C0 = Vars.armC0[1]
	LWeld.C1 = Vars.leftArmC1
	LWeld.Parent = armBase
	
	local RWeld = Instance.new("Weld")
	RWeld.Name = "RWeld"
	RWeld.Part0 = armBase
	RWeld.Part1 = RArmBase
	RWeld.C0 = Vars.armC0[2]
	RWeld.C1 = Vars.rightArmC1
	RWeld.Parent = armBase
	
	local LWeld2 = Instance.new("Weld")
	LWeld2.Name = "LWeld"
	LWeld2.Part0 = LArmBase
	LWeld2.Part1 = Vars.LArm
	LWeld2.Parent = LArmBase
	
	local RWeld2 = Instance.new("Weld")
	RWeld2.Name = "RWeld"
	RWeld2.Part0 = RArmBase
	RWeld2.Part1 = Vars.RArm
	RWeld2.Parent = RArmBase
	
	local LLegWeld = Instance.new("Weld")
	LLegWeld.Name = "LLegWeld"
	LLegWeld.Part0 = Vars.Torso
	LLegWeld.Part1 = nil
	LLegWeld.C0 = CF(-0.5, -2, 0)
	LLegWeld.Parent = Vars.Torso
	
	local RLegWeld = Instance.new("Weld")
	RLegWeld.Name = "RLegWeld"
	RLegWeld.Part0 = Vars.Torso
	RLegWeld.Part1 = nil
	RLegWeld.C0 = CF(0.5, -2, 0)
	RLegWeld.Parent = Vars.Torso
	
	for _, Tab in pairs(Vars.gunParts) do
		Tab.Obj.Anchored = false
		local Weld = Instance.new("Weld")
		Weld.Name = "mainWeld"
		Weld.Part0 = Vars.Handle
		Weld.Part1 = Tab.Obj
		Weld.C0 = Tab.Obj.weldCF.Value
		Weld.Parent = Vars.Handle
		Tab.Weld = Weld
	end
	
	return gunIgnore, playerFolder, headWeld, headWeld2, animWeld, ABWeld, LWeld, RWeld, LWeld2, RWeld2, LLegWeld, RLegWeld, Vars.gunParts
end

----------------------------------------------------------------------
--------------------[ TWEENJOINT HANDLING ]---------------------------
----------------------------------------------------------------------

local createTweenIndicator = script:WaitForChild("createTweenIndicator")
function createTweenIndicator.OnServerInvoke(_, Joint, newCode)
	local tweenIndicator = nil
	if (not Joint:findFirstChild("tweenCode")) then --If the joint isn't being tweened, then
		tweenIndicator = Instance.new("IntValue")
		tweenIndicator.Name = "tweenCode"
		tweenIndicator.Value = newCode
		tweenIndicator.Parent = Joint
	else
		tweenIndicator = Joint.tweenCode
		tweenIndicator.Value = newCode --If the joint is already being tweened, this will change the code, and the tween loop will stop
	end
	return tweenIndicator
end

local lerpCF = script:WaitForChild("lerpCF")
function lerpCF.OnServerInvoke(_, Joint, Prop, startCF, endCF, Alpha)
	spawn(function()
		Joint[Prop] = startCF:lerp(endCF, Alpha)
	end)
end

local deleteTweenIndicator = script:WaitForChild("deleteTweenIndicator")
function deleteTweenIndicator.OnServerInvoke(_, tweenIndicator, newCode)
	if tweenIndicator.Value == newCode then --If this tween functions was the last one called on a joint then it will remove the code
		tweenIndicator:Destroy()
	end
end

----------------------------------------------------------------------
--------------------[ BULLET IMPACT HANDLING ]------------------------
----------------------------------------------------------------------

local createBulletImpact = script:WaitForChild("createBulletImpact")
createBulletImpact.OnServerEvent:connect(function(_, H, P, N, D, humanoidFound, gunIgnore, S)
	local surfaceCF = CF(P, P + N)
	----------------------------------------------------------------------------------
	--Creating the bullet hole--------------------------------------------------------
	----------------------------------------------------------------------------------
	if S.bulletHoles and (not humanoidFound) then
		local Hole = Instance.new("Part")
		Hole.Transparency = 1
		Hole.Anchored = true
		Hole.CanCollide = false
		Hole.FormFactor = "Custom"
		Hole.Size = V3(1, 1, 0.2)
		Hole.TopSurface = 0
		Hole.BottomSurface = 0
		local Mesh = Instance.new("BlockMesh")
		Mesh.Offset = V3(0, 0, -0.05)
		Mesh.Scale = V3(S.holeSettings.Size, S.holeSettings.Size, 0)
		Mesh.Parent = Hole
		local Decal = Instance.new("Decal")
		Decal.Face = Enum.NormalId.Front
		Decal.Texture = S.holeSettings.Texture
		Decal.Parent = Hole
		Hole.Parent = gunIgnore
		Hole.CFrame = surfaceCF
		if (not H.Anchored) then
			local Weld = Instance.new("Weld", Hole)
			Weld.Part0 = H
			Weld.Part1 = Hole
			Weld.C0 = H.CFrame:toObjectSpace(surfaceCF)
			Hole.Anchored = false
		end
		delay(S.holeSettings.visibleTime, function()
			if S.holeSettings.disappearTime > 0 then
				local t0 = tick()
				while true do
					local Alpha = math.min((tick() - t0) / S.holeSettings.disappearTime, 1)
					Decal.Transparency = numLerp(0, 1, Alpha)
					if Alpha == 1 then break end
					wait()
				end
				Hole:Destroy()
			else
				Hole:Destroy()
			end
		end)
	end
	----------------------------------------------------------------------------------
	--Creating the spark effect-------------------------------------------------------
	----------------------------------------------------------------------------------
	if S.bulletSparks and (not humanoidFound) and inList(H.Material, S.sparkSettings.Materials) then
		local Sparks = Instance.new("Part")
		Sparks.Transparency = 1
		Sparks.Anchored = true
		Sparks.CanCollide = false
		Sparks.FormFactor = "Custom"
		Sparks.Size = V3(1, 1, 1)
		Sparks.TopSurface = 0
		Sparks.BottomSurface = 0
		
		local Particles = nil
		if S.customSparks then
			Particles = getObject(game.ServerStorage, "ParticleEmitter", "bulletSpark"):Clone()
		else
			Particles = Instance.new("ParticleEmitter")
			Particles.Color = ColorSequence.new(S.sparkSettings.Color.Start, S.sparkSettings.Color.End)
			Particles.LightEmission = 1
			Particles.Size = NumberSequence.new(
				{
					NumberSequenceKeypoint.new(0, S.sparkSettings.Size, 0.25);
					NumberSequenceKeypoint.new(1, 0);
				}
			)
			Particles.Texture = S.sparkSettings.Texture
			Particles.Transparency = NumberSequence.new(0)
			Particles.Acceleration = V3(0, -196.2, 0)
			Particles.EmissionDirection = Enum.NormalId.Front
			Particles.Lifetime = NumberRange.new(S.sparkSettings.Lifetime - 0.05, S.sparkSettings.Lifetime + 0.05)
			Particles.Rate = S.sparkSettings.Rate
			Particles.Rotation = NumberRange.new(0, 360)
			Particles.Speed = NumberRange.new(S.sparkSettings.Speed - 5, S.sparkSettings.Speed + 5)
			Particles.VelocitySpread = S.sparkSettings.Spread
		end
		Particles.Parent = Sparks
		
		Sparks.Parent = gunIgnore
		Sparks.CFrame = surfaceCF
		if (not H.Anchored) then
			local Weld = Instance.new("Weld", Sparks)
			Weld.Part0 = H
			Weld.Part1 = Sparks
			Weld.C0 = H.CFrame:toObjectSpace(surfaceCF)
			Sparks.Anchored = false
		end
		delay(0.1, function()
			Particles.Enabled = false
			wait(Particles.Lifetime.Max)
			Sparks:Destroy()
		end)
	end
	----------------------------------------------------------------------------------
	--Creating the smoke effect-------------------------------------------------------
	----------------------------------------------------------------------------------
	if S.bulletSmoke and (not humanoidFound) then
		local Smoke = Instance.new("Part")
		Smoke.Transparency = 1
		Smoke.Anchored = true
		Smoke.CanCollide = false
		Smoke.FormFactor = "Custom"
		Smoke.Size = V3(1, 1, 1)
		Smoke.TopSurface = 0
		Smoke.BottomSurface = 0
		
		local Particles = Instance.new("ParticleEmitter")
		Particles.Color = ColorSequence.new(S.smokeSettings.objColor and H.Color or S.smokeSettings.Color)
		Particles.LightEmission = 0
		Particles.Size = NumberSequence.new(
			{
				NumberSequenceKeypoint.new(0, S.smokeSettings.Size.Start);
				NumberSequenceKeypoint.new(1, S.smokeSettings.Size.End);
			}
		)
		Particles.Texture = S.smokeSettings.Texture
		Particles.Transparency = NumberSequence.new(
			{
				NumberSequenceKeypoint.new(0, S.smokeSettings.startTransparency);
				NumberSequenceKeypoint.new(0.5, 0.75 * S.smokeSettings.startTransparency + 0.25);
				NumberSequenceKeypoint.new(1, 1);
			}
		)
		Particles.Acceleration = V3(0, -196.2, 0)
		Particles.EmissionDirection = Enum.NormalId.Front
		Particles.Lifetime = NumberRange.new(S.smokeSettings.Lifetime - 0.05, S.smokeSettings.Lifetime + 0.05)
		Particles.Rate = S.smokeSettings.Rate
		Particles.Rotation = NumberRange.new(0, 360)
		Particles.RotSpeed = NumberRange.new(10)
		Particles.Speed = NumberRange.new(S.smokeSettings.Speed - 5, S.smokeSettings.Speed + 5)
		Particles.VelocitySpread = S.smokeSettings.Spread
		Particles.Parent = Smoke
		
		Smoke.Parent = gunIgnore
		Smoke.CFrame = surfaceCF
		if (not H.Anchored) then
			local Weld = Instance.new("Weld", Smoke)
			Weld.Part0 = H
			Weld.Part1 = Smoke
			Weld.C0 = H.CFrame:toObjectSpace(surfaceCF)
			Smoke.Anchored = false
		end
		delay(0.1, function()
			Particles.Enabled = false
			wait(S.smokeSettings.Lifetime + 0.05)
			Smoke:Destroy()
		end)
	end
end)

----------------------------------------------------------------------
--------------------[ SHOCKWAVE HANDLING ]----------------------------
----------------------------------------------------------------------

local createShockwave = script:WaitForChild("createShockwave")
createShockwave.OnServerEvent:connect(function(_, Center, Radius, gunIgnore, S)
	local Shockwave = Instance.new("Part")
	Shockwave.BrickColor = S.shockwaveSettings.Color
	Shockwave.Material = Enum.Material.SmoothPlastic
	Shockwave.Name = "Shockwave"
	Shockwave.Anchored = true
	Shockwave.CanCollide = false
	Shockwave.FormFactor = Enum.FormFactor.Symmetric
	Shockwave.Size = V3(1, 1, 1)
	Shockwave.BottomSurface = Enum.SurfaceType.Smooth
	Shockwave.TopSurface = Enum.SurfaceType.Smooth
	local Mesh = Instance.new("SpecialMesh")
	Mesh.MeshType = Enum.MeshType.Sphere
	Mesh.Scale = V3()
	Mesh.Parent = Shockwave
	Shockwave.Parent = gunIgnore
	Shockwave.CFrame = CF(Center)
	spawn(function()
		local t0 = tick()
		while true do
			local Alpha = math.min((tick() - t0) / S.shockwaveSettings.Duration, 1)
			local Scale = 2 * Radius * Alpha
			Mesh.Scale = V3(Scale, Scale, Scale)
			Shockwave.Transparency = Alpha
			if Alpha == 1 then break end
			wait()
		end
		Shockwave:Destroy()
	end)
end)

----------------------------------------------------------------------
--------------------[ BLOOD HANDLING ]--------------------------------
----------------------------------------------------------------------

local createBlood = script:WaitForChild("createBlood")
createBlood.OnServerEvent:connect(function(_, H, P, D, gunIgnore, S)
	local bloodCF = CF(P, P + D) * CFANG(RAD(-90), 0, 0)
	local Blood = Instance.new("Part")
	Blood.Transparency = 1
	Blood.Anchored = true
	Blood.CanCollide = false
	Blood.FormFactor = "Custom"
	Blood.Size = V3(0.2, 1, 0.2)
	Blood.TopSurface = 0
	Blood.BottomSurface = 0
	
	local Particles = Instance.new("ParticleEmitter")
	Particles.Color = ColorSequence.new(S.bloodSettings.Color)
	Particles.LightEmission = 0
	Particles.Size = NumberSequence.new(S.bloodSettings.Size)
	Particles.Texture = S.bloodSettings.Texture
	Particles.Transparency = NumberSequence.new(
		{
			NumberSequenceKeypoint.new(0, S.bloodSettings.startTransparency);
			NumberSequenceKeypoint.new(1, 1);
		}
	)
	Particles.EmissionDirection = Enum.NormalId.Top
	Particles.Lifetime = NumberRange.new(S.bloodSettings.Lifetime - 0.05, S.bloodSettings.Lifetime + 0.05)
	Particles.Rate = S.bloodSettings.Rate
	Particles.Rotation = NumberRange.new(0, 90)
	Particles.Speed = NumberRange.new(S.bloodSettings.Speed)
	Particles.VelocitySpread = S.bloodSettings.Spread
	Particles.Parent = Blood
	
	Blood.Parent = gunIgnore
	Blood.CFrame = bloodCF
	if (not H.Anchored) then
		local Weld = Instance.new("Weld", Blood)
		Weld.Part0 = H
		Weld.Part1 = Blood
		Weld.C0 = H.CFrame:toObjectSpace(bloodCF)
		Blood.Anchored = false
	end
	delay(0.15, function()
		Particles.Enabled = false
		wait(S.bloodSettings.Lifetime + 0.05)
		Blood:Destroy()
	end)
end)

----------------------------------------------------------------------
--------------------[ TRAIL HANDLING ]--------------------------------
----------------------------------------------------------------------

local createTrail = script:WaitForChild("createTrail")
createTrail.OnServerEvent:connect(function(_, Origin, P, gunIgnore, S)
	local Trail = Instance.new("Part")
	Trail.BrickColor = S.trailSettings.Color
	Trail.Transparency = S.trailSettings.Transparency
	Trail.Anchored = true
	Trail.CanCollide = false
	Trail.Size = V3(1, 1, 1)
	local Mesh = Instance.new("CylinderMesh")
	Mesh.Offset = V3(0, -(P - Origin).magnitude / 2, 0)
	Mesh.Scale = V3(S.trailSettings.Thickness, (P - Origin).magnitude, S.trailSettings.Thickness)
	Mesh.Parent = Trail
	Trail.Parent = gunIgnore
	Trail.CFrame = CF(Origin, P) * CFANG(RAD(90), 0, 0)
	delay(S.trailSettings.visibleTime, function()
		if S.trailSettings.disappearTime > 0 then
			local t0 = tick()
			while true do
				local Alpha = math.min((tick() - t0) / S.trailSettings.disappearTime, 1)
				Trail.Transparency = numLerp(S.trailSettings.Transparency, 1, Alpha)
				if Alpha == 1 then break end
				wait()
			end
			Trail:Destroy()
		else
			Trail:Destroy()
		end
	end)
end)