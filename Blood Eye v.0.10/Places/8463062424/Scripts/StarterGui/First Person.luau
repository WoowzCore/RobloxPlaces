local ViewAccessories = false
local ViewModels = false

Plr = game.Players.LocalPlayer
Char = Plr.Character or Plr.CharacterAdded:wait()
Human = Char:WaitForChild("Humanoid")
Cam = game.Workspace.CurrentCamera
CamFirstPos = Vector3.new(0,0,-1.6) 

local function GetValue(name)
	return script.Parent.Value_Folder:WaitForChild(name).Value
end
local function SetValue(name,value)
	script.Parent.Value_Folder:WaitForChild(name).Value = value
end

local function Lock (part)
	if part and part:IsA("BasePart") and part.Name ~= "Head" then
		part.LocalTransparencyModifier = part.Transparency
		part.Changed:connect(function (property)
			part.LocalTransparencyModifier = part.Transparency
		end)
	end
end

for i, v in pairs (Char:GetChildren()) do
	if v:IsA("BasePart") then
		Lock(v)
	elseif v:IsA("Accessory") and ViewAccessories then
		if v:FindFirstChild("Handle") then
			Lock(v.Handle)
		end
	elseif v:IsA("Model") and ViewModels then
		for index, descendant in pairs (v:GetDescendants()) do
			if descendant:IsA("BasePart") then
				Lock(descendant)
			end
		end
	end
end

Char.ChildAdded:connect(Lock)

while true do
	wait()
	if GetValue("Player_In_First_Person") then
		Human.CameraOffset = CamFirstPos
	else
		Human.CameraOffset = Vector3.zero
	end
end

--Cam.Changed:connect(function (property)
	--if property == "CameraSubject" then
		--if Cam.CameraSubject and Cam.CameraSubject:IsA("VehicleSeat") and Human then
			--Cam.CameraSubject = Human;
		--end
	--end
--end)