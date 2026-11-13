local NPC = script.Parent
local h = NPC.Humanoid
local hrp = NPC:WaitForChild("HumanoidRootPart")
local bf = Instance.new("BodyForce", hrp)

h:GetPropertyChangedSignal("WalkToPoint"):Connect(function()
	if hrp.Velocity.Magnitude > 28 then
		bf.Force = (h.WalkToPoint - hrp.Position).Unit * 10000
	else
		bf.Force = (h.WalkToPoint - hrp.Position).Unit * 11500
	end
end)