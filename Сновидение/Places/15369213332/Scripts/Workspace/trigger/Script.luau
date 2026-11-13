local trigger = script.Parent
local wall = workspace.trigger_wall1
local ts = game:GetService("TweenService")

local bool = false
local work = false

local function upd()
	if work then return end
	work = true
	local t = math.random(20,60)
	if bool then
		ts:Create(wall,TweenInfo.new(t),{Size = Vector3.new(83, 12.96, 18)}):Play()
	else
		ts:Create(wall,TweenInfo.new(t),{Size = Vector3.new(83, 12.96, 8)}):Play()
	end
	wait(t)
	work = false
end

trigger.Touched:Connect(function(part)
	if part.Name == "HumanoidRootPart" then
		bool = not bool
		upd()
	end
end)