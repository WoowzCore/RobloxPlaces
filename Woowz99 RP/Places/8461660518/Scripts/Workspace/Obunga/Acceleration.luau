local NPC = script.Parent
local h = NPC.Humanoid
local hrp = NPC:WaitForChild("HumanoidRootPart")
local bf = Instance.new("BodyForce", hrp)

h:GetPropertyChangedSignal("WalkToPoint"):Connect(function()
	if hrp.Velocity.Magnitude > 30 then
		bf.Force = (h.WalkToPoint - hrp.Position).Unit * 10000
	else
		bf.Force = (h.WalkToPoint - hrp.Position).Unit * math.random(10000, 12000)
	end
	if h.WalkToPoint == nil then
		bf.Force = Vector3.new(0, 0, 0)
	end
end)