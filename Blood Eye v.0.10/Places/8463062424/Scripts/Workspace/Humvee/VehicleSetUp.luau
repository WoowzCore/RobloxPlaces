Speed = 80
Vehicle = script.Parent
if Vehicle.Parent:FindFirstChild("Origin"..Vehicle.Name) == nil then
Origin = Instance.new("Vector3Value", Vehicle.Parent)
Origin.Name = "Origin"..Vehicle.Name
Origin.Value = Vehicle:GetModelCFrame().p
end

if Vehicle.Parent:FindFirstChild("CFrame"..Vehicle.Name) == nil then
Origin = Instance.new("CFrameValue", Vehicle.Parent)
Origin.Name = "CFrame"..Vehicle.Name
Origin.Value = Vehicle:GetModelCFrame()
end


ChasisLock = Vehicle["Car"].Body["ChasisLock"]
Chasis = Vehicle["Turret"].Bottom
Turret = Vehicle:FindFirstChild("Turret")
Chasis:MakeJoints()
DriverSeat = Chasis["DriverSeat"]
EngineOn = Vehicle.EngineOn
Fuel = Vehicle.Fuel
Engine = Vehicle["Car"].Body["Engine"]
AvailableColors = {"Brick yellow"}
SelectedColor = AvailableColors[math.random(1, #AvailableColors)]
FuelFrame = nil
function Weld(A, B)
	local Weld = Instance.new("Weld", B)
	Weld.C0 = A.CFrame:toObjectSpace(B.CFrame)
	Weld.Part0 = A
	Weld.Part1 = B
end
function Unanchor(Mod)
	local Mod = Mod:GetChildren()
	for i = 1, #Mod do
		local Got = Mod[i]
		if Got:IsA("BasePart") or Got:IsA("MeshPart") then
			Got.Anchored = false
		end
	end
end
function WeldVehicle()
	local W = Instance.new("Weld", script)
	W.Part0 = Chasis.Chasis
	W.Part1 = ChasisLock
	W.C1 = CFrame.new(0,0,0)
	W.C0 = CFrame.new(0,0,0)
	if Turret then
	local W = Instance.new("Weld", script)
	W.C1 = CFrame.new(0,0,0)
	W.C0 = CFrame.new(0,0,0)
	W.Part0 = Turret.Body
	W.Part1 = Vehicle.MountAttach
	Turret.Body.Anchored = false
	end
	local Get = Vehicle:GetChildren()
	for i = 1, #Get do
		local Got = Get[i]
		if Got.Name ~= ChasisLock and Got:IsA("BasePart") or Got.Name ~= ChasisLock and Got:IsA("MeshPart") then
			Weld(Got, ChasisLock)
		end
	end
	
	local Get = Chasis:GetChildren()
	for i = 1, #Get do
		local Got = Get[i]
		if Got.Name ~= "Chasis" and Got:IsA("BasePart") or Got.Name ~= "Chasis" and Got:IsA("MeshPart") then
			Weld(Got, Chasis.Chasis)
		end
	end
	
	if Turret then
	local Get = Turret.Bottom:GetChildren()
	for i = 1, #Get do
		local Got = Get[i]
		if Got.Name ~= "Middle" and Got:IsA("BasePart") or Got.Name ~= "Middle" and Got:IsA("MeshPart") then
			Weld(Got, Turret.Bottom.Middle)
			--Got.Parent = Turret
		end
	end

	local Get = Turret.Top:GetChildren()
	for i = 1, #Get do
		local Got = Get[i]
		if Got.Name ~= "Middle" and Got:IsA("BasePart") or Got.Name ~= "Middle" and Got:IsA("MeshPart") then
			Weld(Got, Turret.Top.ArmL)
			--Got.Parent = Turret
		end
	end	
	w = Instance.new("Weld") --Spine(Body, Middle)
	w.Part0 = Turret.Body
	w.Part1 = Turret.Bottom.Middle
	w.C0 = CFrame.new()
	w.C1 = CFrame.new(0,0,0)
	w.Parent = Turret.Body
	w.Name = "Spine"
	
	w = Instance.new("Weld")--ShoulderR(ArmL, ShoulderL)
	w.Part0 = Turret.Bottom.ShoulderL
	w.Part1 = Turret.Top.ArmL
	w.C0 = CFrame.new()
	w.C1 = CFrame.new(0,0,0)
	w.Parent = Turret.Body
	w.Name = "ShoulderL"
	Unanchor(Turret.Bottom)
	Unanchor(Turret.Top)
	Unanchor(Turret)
	end
	
	Unanchor(Vehicle)
	Unanchor(Chasis)
end
local EngineDB = false
EngineOn.Changed:connect(function()
	if EngineDB then return end
	EngineDB = true
	local Val = EngineOn.Value
	if Val then
		if Fuel.Value > 0 then
			DriverSeat.MaxSpeed = Speed
			Engine.EngineSound:Play()
			while EngineOn.Value == true and Fuel.Value > 0 do
				wait(1)
				Engine.EngineSound:Play()
				Fuel.Value = Fuel.Value - 1
			end
			Engine.EngineSound:Stop()
			DriverSeat.MaxSpeed = 0
			EngineOn.Value = false
			Engine.EngineOff:Play()
		else
			Engine.EngineSound:Stop()
			Engine.EngineOff:Play()
			DriverSeat.MaxSpeed = 0
			EngineOn.Value = false
		end
	else
		Engine.EngineSound:Stop()
		DriverSeat.MaxSpeed = 0
		Engine.EngineOff:Play()
	end
	EngineDB = false
end)
DriverSeat.ChildAdded:connect(function(New)
	local New = New
	if New.ClassName ~= "Weld" then return end
	if New.Part1 == nil then return end
	local Torso = New.Part1
	local Player = game.Players:GetPlayerFromCharacter(Torso.Parent)
	value2 = Instance.new("ObjectValue",script.Parent)
	value2.Value = Player
	value2.Name = "Owner"
	if Turret then
		value =	script.Parent.Vehicle:Clone()
		value.Parent = game.Workspace
		local newHandle = Instance.new("Part")
	 	newHandle.Size = Vector3.new(.1, .1, .1)
	 	newHandle.Transparency = 1
	 	newHandle.Name = "Handle"
	 	newHandle.Parent = value
		newHandle.CustomPhysicalProperties = PhysicalProperties.new(0,0,0,0,0)
		value.Vehicle.Value = Vehicle
		value.Parent = Player.Character
	end
	--Vehicle.Parent = Player.Character
	delay(0,function()
	Player.Character.Humanoid.Jumping:connect(function()
		if Turret then
		value:remove()
		end
	end)
	end)
	delay(0,function()
		Vehicle.Health.Changed:connect(function()
			if Vehicle.Health.Value < 0 then
				Player.Character:FindFirstChild("VehicleEnter").Value = false
				Player.Character.Humanoid.Health = 0
			end
		end)
	end)
	--local HUD = game.Lighting.VehicleHUD:Clone()
	--HUD.Parent = Player.PlayerGui
	--FuelFrame = HUD.Main.Fuel
	--FuelFrame.Text = ("FUEL["..Fuel.Value.."/"..Fuel.MaxValue.."]")
	--local Val = Instance.new("ObjectValue", HUD)
	--Val.Value = Vehicle
	--Val.Name = "Link"
end)
DriverSeat.ChildRemoved:connect(function(Old)

	--Vehicle.Parent = game.Workspace
	local Old = Old
	if Old.ClassName ~= "Weld" then return end
	if Old.Part1 == nil then return end
		
	local Torso = Old.Part1
	local Player = game.Players:GetPlayerFromCharacter(Torso.Parent)
	Player.Character:FindFirstChild("VehicleEnter").Value = false
	if value then
		value:remove()
	end	
	if value2 then
		value2:remove()
	end
	if Player.Character:FindFirstChild("Vehicle") then
	Player.Character:FindFirstChild("Vehicle"):remove()
	end
	if FuelFrame and FuelFrame.Parent then
		--FuelFrame.Parent.Parent:Remove()
	end
	FuelFrame = nil
end)
Fuel.Changed:connect(function()
	if FuelFrame and FuelFrame.Parent then
		--FuelFrame.Text = ("FUEL["..Fuel.Value.."/"..Fuel.MaxValue.."]")
	end
end)
--Fuel.Value = math.random(300, 400)
repeat wait() until Vehicle:FindFirstChild("Ready") ~= nil
repeat wait() until Vehicle.Ready.Value == true
WeldVehicle()