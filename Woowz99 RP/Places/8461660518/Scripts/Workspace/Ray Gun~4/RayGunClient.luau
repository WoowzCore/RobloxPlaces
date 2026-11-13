local Tool = script.Parent
local Active = false
local BarrelColors = {"Lime green", "Lapis"}
local ADSColors = {"Really red", "Lapis", "New Yeller", "Lime green", "Hot pink", "Institutional white"}
local Debris = game:GetService("Debris")
local BaseUrl = "rbxassetid://"
local debounce = false
local GripPositioning = {Draw = CFrame.new(0,0,0, -1,0,-0, 0,1,-0,	0,0, -1)}

math.randomseed(tick())

function equip() -- equipping the tool
Active = true
ShootRay = Tool:FindFirstChild("ShootRay")
Drawing = Tool:FindFirstChild("Draw")
ChangeColor = Tool:FindFirstChild("ChangeColor")
ADS = Tool:FindFirstChild("ADS")
Barrel = Tool:FindFirstChild("Barrel")
Player = game.Players.LocalPlayer.Character
Humanoid = Tool.Parent:WaitForChild("Humanoid")
if Barrel then
ChangeColor:FireServer(Barrel,tostring(BarrelColors[math.random(1,#BarrelColors)]))
if ADS then
ChangeColor:FireServer(ADS,tostring(ADSColors[math.random(1,#ADSColors)]))
end
end
Drawing:FireServer(GripPositioning.Draw,"SetRegPose")
end


function unequip() -- unequipping the tool
Active = false
if Tool:FindFirstChild("Barrel") then
ChangeColor:FireServer(Barrel,"Lapis")
if Tool:FindFirstChild("ADS") then
ChangeColor:FireServer(ADS,"Really red")
end
end
end



function shoot() -- activating the tool
if debounce == false and Active == true then	
	debounce = true

local player = Tool.Parent
local Mouse = game.Players:FindFirstChild(player.Name):GetMouse()	
local targetPos = Humanoid.TargetPoint
local lookAt = (targetPos - Tool.Parent.Head.Position).unit

	ShootRay:FireServer(lookAt)

	
	local RaySound = Instance.new("Sound",Tool:WaitForChild("Handle"))
	RaySound.SoundId = (BaseUrl .. "131179973")
	RaySound.PlayOnRemove = true
	RaySound.Volume = 1
	Debris:AddItem(RaySound,0)
	Tool.Aim:WaitForChild("Spray"):Emit(300)
	Drawing:FireServer(GripPositioning.ShootPose,"SetShootPose")
	
	
	
	wait(0.35)
	Debris:AddItem(RaySound,0)
	Drawing:FireServer(GripPositioning.Draw,"SetRegPose")


debounce = false
end
end

Tool.Unequipped:connect(unequip)
Tool.Activated:connect(shoot)
Tool.Equipped:connect(equip)
