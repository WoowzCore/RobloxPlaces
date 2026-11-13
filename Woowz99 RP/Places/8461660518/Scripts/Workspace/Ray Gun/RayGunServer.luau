local Tool =  script.Parent
local ShootRay = Tool:FindFirstChild("ShootRay")
local Draw = Tool:FindFirstChild("Draw")
local ChangeColor = Tool:FindFirstChild("ChangeColor")
local Debris = game:GetService("Debris")
local BaseUrl = "rbxassetid://"

	



function ChangingColor(Player,Object,Color)
	Object.BrickColor = BrickColor.new(Color)
end
ChangeColor.OnServerEvent:connect(ChangingColor)

function Drawing(Player,GripCFrame,TypeOfGrip)
if TypeOfGrip == "SetRegPose" then
Tool.Grip = GripCFrame	
elseif TypeOfGrip == "SetShootPose" then
Tool.GripForward = Vector3.new(0,-0.287,0.958)
end
end
Draw.OnServerEvent:connect(Drawing)

function ShootingRay(Player,Direction)
Rays = Instance.new("Part")
Rays.Name = "Ray"
Rays.Shape = "Ball"
Rays.Material = "Neon"
Rays.CanCollide = false
Rays.Transparency = 1
Rays.BrickColor = BrickColor.new("Lime green")
Rays.Size = Vector3.new(1,1,1)
Rays.Parent = workspace
Rays.CFrame = (Tool.Aim.CFrame)
	local RaySound = Instance.new("Sound",Tool:WaitForChild("Handle"))
	RaySound.SoundId = (BaseUrl .. "131179973")
	RaySound.PlayOnRemove = true
	RaySound.Volume = 1
	Debris:AddItem(RaySound,0)

local Explosion = Tool.Aim:WaitForChild("Explode"):Clone()
Explosion.Parent = Rays
local Creator = Instance.new("ObjectValue",Rays)
Creator.Name = "creator"
Creator.Value = Tool.Parent
local Trail = Tool.Aim:WaitForChild("Trail"):Clone()
Trail.Parent = Rays
Trail.Enabled = true
local Velocity = Instance.new("BodyVelocity")
Velocity.Parent = Rays

Velocity.Velocity = Direction * 200
Debris:AddItem(Rays,3)

Rays.Touched:connect(function(hit)

if hit.CanCollide and not hit:IsDescendantOf(Player.Character) and not Rays.Anchored  then
if hit.Parent ~= Creator.Value then
Rays.Anchored = true
Rays.Transparency = 1
Rays:WaitForChild("Trail").Enabled = false
Rays:WaitForChild("Explode"):Emit(10000)
Index(workspace)
wait(1)
Debris:AddItem(Rays,0)
end
end
end)
	
end
ShootRay.OnServerEvent:connect(ShootingRay)

function Index(Model)
local things = Model:GetChildren()
for i=1,#things do
	if things[i]:IsA("Model") then
		if things[i]:FindFirstChild("Torso",true)~= nil and things[i]:FindFirstChild("Torso",true):IsA("BasePart") then
			local Torso = things[i]:FindFirstChild("Torso",true)
			if things[i]:FindFirstChild("ForceField",true) == nil and things[i]:FindFirstChild("FlameShield",true)== nil and things[i]:FindFirstChild("BubbleShield",true)== nil then
			local Humanoid = Torso.Parent:GetChildren()
			local Humanoid2 = nil
			for x=1, #Humanoid do
				if Humanoid[x]:IsA("Humanoid") then
					Humanoid2 = Humanoid[x]
				end
			end
			if (Rays.Position - Torso.Position).magnitude <= 20 and Humanoid2 ~= nil and Humanoid2.Health ~= 0 then
				Humanoid2:TakeDamage(math.ceil(100-(Rays.Position - Torso.Position).magnitude))
				print("Splash Damaged " .. Torso.Parent.Name.. " by " .. math.ceil(100-(Rays.Position - Torso.Position).magnitude) )
end	
		end
	end
	end
end

end