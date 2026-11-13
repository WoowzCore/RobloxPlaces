local plr = game.Players.LocalPlayer
local basa = require(plr:WaitForChild("PlayerScripts"):WaitForChild("PlayerBasa"))

local function SetVelocity(pos,rot)
	
end

local savedobjectsbottom = nil
local sob_pos,sob_rot = Vector3.zero,Vector3.zero
local heartbeat = game:GetService("RunService").Heartbeat
local function UpdateVelocity(dt)
	if basa.Objects.Bottom ~= nil then
		if basa.Objects.Bottom:IsA("Part") or basa.Objects.Bottom:IsA("MeshPart") or basa.Objects.Bottom:IsA("UnionOperation") then 
			if savedobjectsbottom ~= basa.Objects.Bottom then
				savedobjectsbottom = basa.Objects.Bottom
				local pos = Vector3.new(savedobjectsbottom.CFrame.Position.X,0,savedobjectsbottom.CFrame.Position.Z)
				local x,y,z = savedobjectsbottom.CFrame:ToOrientation()
				local rot = Vector3.new(x,y,z)
				sob_pos = pos
				sob_rot = rot
			else
				local pos = Vector3.new(savedobjectsbottom.CFrame.Position.X,0,savedobjectsbottom.CFrame.Position.Z)
				local x,y,z = savedobjectsbottom.CFrame:ToOrientation()
				local rot = Vector3.new(x,y,z)
				savedobjectsbottom.AssemblyLinearVelocity = (pos-sob_pos)/dt
				savedobjectsbottom.AssemblyAngularVelocity = (rot-sob_rot)/dt
				sob_pos = pos
				sob_rot = rot
			end
		end
	end
end

game:GetService("RunService").Stepped:Connect(function(_,dt)
	UpdateVelocity(dt)
end)