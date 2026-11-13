local base = require(game:GetService("ServerScriptService").Base)
local chr = script.Parent
local hum = chr:WaitForChild("Humanoid")

local function createAttachment(parent,name,pos,rot)
	if rot == nil then
		rot = Vector3.zero
	end
	local at = Instance.new("Attachment")
	at.Name = name
	at.Parent = parent
	at.CFrame = CFrame.new(pos) * CFrame.Angles(math.rad(rot.X),math.rad(rot.Y),math.rad(rot.Z))
end
for _, part in pairs(chr:GetDescendants()) do
	if part.Name == "Torso" then
		createAttachment(part,"RagdollH",Vector3.new(0, 1, 0),Vector3.new(0,0,90))
		createAttachment(part,"RagdollAL",Vector3.new(-1, 0.6, 0))
		createAttachment(part,"RagdollAR",Vector3.new(1, 0.6, 0))
		createAttachment(part,"RagdollLL",Vector3.new(-0.5, -1, 0),Vector3.new(0,0,-90))
		createAttachment(part,"RagdollLR",Vector3.new(0.5, -1, 0),Vector3.new(0,0,-90))
	end
	if part.Name == "Head" then
		createAttachment(part,"RagdollH",Vector3.new(0, -0.5, 0),Vector3.new(0,0,90))
	end
	if part.Name == "Left Arm" then
		createAttachment(part,"RagdollAL",Vector3.new(0.5, 0.5, 0))
	end
	if part.Name == "Left Leg" then
		createAttachment(part,"RagdollLL",Vector3.new(0, 1, 0),Vector3.new(0,0,-90))
	end
	if part.Name == "Right Arm" then
		createAttachment(part,"RagdollAR",Vector3.new(-0.5, 0.5, 0))
	end
	if part.Name == "Right Leg" then
		createAttachment(part,"RagdollLR",Vector3.new(0, 1, 0),Vector3.new(0,0,-90))
	end
end

local dead = false
hum:GetPropertyChangedSignal("Health"):Connect(function()
	if not dead and hum.Health <= 0 then
		dead = true
		game:GetService("ReplicatedStorage").RagdollizeSERVER:Fire(chr,true,true)
		hum:ChangeState(Enum.HumanoidStateType.Physics)
		script:Destroy()
	end
end)

local a = script.Parent.Humanoid.Animator

---------------------------------------------------------------------
local Animations = {}
function CreateAnimation(name,anim,priority,speed)
	local animationinfo = Instance.new("Animation")
	animationinfo.Parent = a
	animationinfo.Name = name
	animationinfo.AnimationId = "http://www.roblox.com/asset/?id="..anim
	local animation = a:LoadAnimation(animationinfo)
	if priority == nil then priority = 1 end
	local p = {[1] = Enum.AnimationPriority.Core,[2] = Enum.AnimationPriority.Idle,[3] = Enum.AnimationPriority.Movement,[4] = Enum.AnimationPriority.Action,[5] = Enum.AnimationPriority.Action2,[6] = Enum.AnimationPriority.Action3,[7] = Enum.AnimationPriority.Action4}
	animation.Priority = p[priority]
	if speed == nil then speed = 1 end
	animation:AdjustSpeed(speed)
	Animations[name] = {animation,animationinfo,false,speed}
end
CreateAnimation("Idle","14976036298",1,0.125)
CreateAnimation("Idle2","14983423969",1,1.5)
CreateAnimation("Idle3","14983702247",1,1.25) 
CreateAnimation("Idle4","15148460719",1,0.25)
CreateAnimation("Idle5","15148482430",1,0.25)
CreateAnimation("Idle6","15148504247",1,0.25)

local lastanim = nil
function PlayAnimation(name,bool,transition)
	local anim = Animations[name]
	if anim == nil then return end
	if anim[3] ~= bool then
		anim[3] = bool
		if bool then
			anim[1]:Play(transition)
			anim[1]:AdjustSpeed(anim[4])
		else
			anim[1]:Stop(transition)
		end
	end
	lastanim = name
end

function PlayAllAnimation(bool,transition)
	for _, name in pairs(Animations) do
		PlayAnimation(name,bool,transition)
	end
end

function ChangeAnimationSpeed(name,speed)
	local anim = Animations[name]
	if anim == nil then return end
	if anim[1].Speed ~= speed then
		anim[1]:AdjustSpeed(speed)
	end
end

---------------------------------------------------------------------

script.Parent.LoadDummy.Enabled = true

local idleanims = {"Idle","Idle2","Idle3","Idle4","Idle5","Idle6"}

PlayAnimation(idleanims[math.random(1,#idleanims)],true,1)
while wait() do
	wait(math.random(15,40)/10)
	PlayAnimation(lastanim,false,1)
	PlayAnimation(idleanims[math.random(1,#idleanims)],true,1)
end