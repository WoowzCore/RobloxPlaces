wait(1)

local plrbase = require(script.Parent:WaitForChild("PlayerBase"))
local plrscript = require(script.Parent:WaitForChild("PlayerScript"))
local rotateheadfunc = game:GetService("ReplicatedStorage").RotateHead

local players = game:GetService("Players")

local RangeOfMotion = 45
local RangeOfMotionTorso = 90 - RangeOfMotion
local RangeOfMotionXZ = RangeOfMotion/140
local LerpSpeed = 0.005

local headrot = nil
local armrot = nil
local rlegrot = nil
local llegrot = nil
local rootrot = nil

local RootJointOriginalC0 = plrbase.Parts.Root.RootJoint.C0
local RightHipOriginalC0 = plrbase.Parts.Torso['Right Hip'].C0
local LeftHipOriginalC0 = plrbase.Parts.Torso['Left Hip'].C0
RangeOfMotion = math.rad(RangeOfMotion)
RangeOfMotionTorso = math.rad(RangeOfMotionTorso)
function Calculate( dt, HumanoidRootPart, Humanoid, Torso )
	local speed = Humanoid.WalkSpeed
	if speed == 0 then speed = 1 end
	local DirectionOfMovement = HumanoidRootPart.CFrame:VectorToObjectSpace( HumanoidRootPart.AssemblyLinearVelocity )
	DirectionOfMovement = Vector3.new( DirectionOfMovement.X / speed, 0, DirectionOfMovement.Z / speed )

	local XResult = ( DirectionOfMovement.X * (RangeOfMotion - (math.abs( DirectionOfMovement.Z ) * (RangeOfMotion / 2) ) ) )
	local XResultTorso = ( DirectionOfMovement.X * (RangeOfMotionTorso - (math.abs( DirectionOfMovement.Z ) * (RangeOfMotionTorso / 2) ) ) )
	local XResultXZ = ( DirectionOfMovement.X * (RangeOfMotionXZ - (math.abs( DirectionOfMovement.Z ) * (RangeOfMotionXZ / 2) ) ) )

	if DirectionOfMovement.Z > 0.1 then

		XResult *= -1
		XResultTorso *= -1
		XResultXZ *= -1

	end

	local RightHipResult = RightHipOriginalC0 * CFrame.new(-XResultXZ, 0, -math.abs(XResultXZ) + math.abs( -XResultXZ ) ) * CFrame.Angles( 0, -XResult, 0 )
	local LeftHipResult = LeftHipOriginalC0 * CFrame.new(-XResultXZ, 0, -math.abs(-XResultXZ) + math.abs( -XResultXZ ) ) * CFrame.Angles( 0, -XResult, 0 )
	local RootJointResult = RootJointOriginalC0 * CFrame.Angles( 0, 0, -XResultTorso )

	local LerpTime = 1 - LerpSpeed ^ dt

	Torso['Right Hip'].C0 = Torso['Right Hip'].C0:Lerp(RightHipResult, LerpTime)
	Torso['Left Hip'].C0 = Torso['Left Hip'].C0:Lerp(LeftHipResult, LerpTime)
	HumanoidRootPart.RootJoint.C0 = HumanoidRootPart.RootJoint.C0:Lerp(RootJointResult, LerpTime)
	rlegrot = Torso['Right Hip'].C0
	llegrot = Torso['Left Hip'].C0
	rootrot = HumanoidRootPart.RootJoint.C0
end

local once = false
game:GetService("RunService").RenderStepped:Connect(function(dt)
	if plrbase.Ragdoll then return end
	
	local camdir = plrbase.Parts.Root.CFrame:toObjectSpace(plrbase.Camera.CFrame).lookVector
	
	if plrbase.Parts.Neck then
		local rotcrawl = -math.asin(camdir.x)
		if plrbase.MovingData.Crawl then rotcrawl = -math.asin(camdir.x)/8 end
		headrot = CFrame.new(0,plrbase.CharacterInfo.NeckYOffset,0) * CFrame.Angles(0,math.rad(180),0) * CFrame.Angles(0, rotcrawl, 0) * CFrame.Angles(-math.asin(camdir.y)-math.rad(90),0,0)
		plrbase.Parts.Neck.C0 = headrot
	end
	
	local rotarm = plrscript.AimHand
	if not plrbase.MovingData.Crawl and not plrbase.Ragdoll then
		local offsetarm = CFrame.new()
		
		if plrbase.Tool ~= nil then
			if plrbase.Tool:FindFirstChild("MoveArmOffset") then
				local ofsarm = plrbase.Tool:FindFirstChild("MoveArmOffset").Value
				offsetarm = CFrame.Angles(math.rad(ofsarm.X),math.rad(ofsarm.Y),math.rad(ofsarm.Z))
			end
		end
		
		if rotarm then
			local hit = plrbase.Mouse.Hit
			local dir = (hit.LookVector * 500000)
			if plrbase.Tool == nil and plrbase.Drag ~= nil then
				dir = (hit.LookVector)
			end
			local rotoffset = (plrbase.Parts.Root.CFrame - plrbase.Parts.Root.CFrame.Position):inverse()
			local handrot = rotoffset * CFrame.new(Vector3.zero,dir)
			local x,y,z = handrot:ToOrientation()
			x,y,z = math.deg(x),math.deg(y),math.deg(z)
			armrot = CFrame.new(Vector3.new(1,0.5,0)) * CFrame.Angles(math.rad(math.max(math.min(x,70),-70)), math.rad(math.max(math.min(y,70),-90)),math.rad(z)) * CFrame.Angles(math.pi/2,math.rad(90),0) * offsetarm
			plrbase.Parts.RightShoulder.C0 = armrot
		end
		
		Calculate(dt, plrbase.Parts.Root, plrbase.Humanoid, plrbase.Parts.Torso)
		once = false
	else
		if not once then
			once = true
			plrbase.Parts.Torso['Right Hip'].C0 = RightHipOriginalC0 
			plrbase.Parts.Torso['Left Hip'].C0 = LeftHipOriginalC0
			plrbase.Parts.Root.RootJoint.C0 = RootJointOriginalC0
			rlegrot = RightHipOriginalC0 
			llegrot = LeftHipOriginalC0
			rootrot = RootJointOriginalC0
		end
	end
	if not rotarm then
		armrot = CFrame.new(Vector3.new(1,0.5,0)) * CFrame.Angles(0,math.rad(90),0)
		plrbase.Parts.RightShoulder.C0 = armrot
	end
end)

while wait() do
	local rotheads,armrots,llegrots,rlegrots,rootrots = rotateheadfunc:InvokeServer(headrot,armrot,llegrot,rlegrot,rootrot)
	for _, plr in pairs(players:GetPlayers()) do
		if plr.UserId ~= plrbase.UserID and rotheads[tostring(plr.UserId)] ~= nil then
			local chr = plr.Character or plr.CharacterAdded:Wait()
			if chr ~= nil then
				if chr:FindFirstChild("Torso") then
					local t = chr:FindFirstChild("Torso")
					if t:FindFirstChild("Neck") then
						t:FindFirstChild("Neck").C0 = rotheads[tostring(plr.UserId)] or CFrame.new()
					end
					if t:FindFirstChild("Right Shoulder") then
						t:FindFirstChild("Right Shoulder").C0 = armrots[tostring(plr.UserId)] or CFrame.new()
					end
					if t:FindFirstChild("Right Hip") then
						t:FindFirstChild("Right Hip").C0 = rlegrots[tostring(plr.UserId)] or CFrame.new()
					end
					if t:FindFirstChild("Left Hip") then
						t:FindFirstChild("Left Hip").C0 = llegrots[tostring(plr.UserId)] or CFrame.new()
					end
					if chr:FindFirstChild("HumanoidRootPart"):FindFirstChild("RootJoint") then
						chr:FindFirstChild("HumanoidRootPart"):FindFirstChild("RootJoint").C0 = rootrots[tostring(plr.UserId)] or CFrame.new()
					end
				end
			end
		end
	end
end