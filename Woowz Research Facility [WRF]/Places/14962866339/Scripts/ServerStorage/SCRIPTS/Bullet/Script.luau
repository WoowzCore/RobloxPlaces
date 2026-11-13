local bullet = script.Parent
local base = require(game:GetService("ServerScriptService").Base)

local rayparams = RaycastParams.new()
rayparams.FilterType = Enum.RaycastFilterType.Exclude
rayparams.IgnoreWater = true
rayparams.FilterDescendantsInstances = {bullet}

local function BulletImpact(rr:RaycastResult)
	local hit = rr.Instance
	
	print("hit",hit)
	
	if hit.Parent:FindFirstChildOfClass("Humanoid") then
		if hit.Name == "HumanoidRootPart" then
			hit = hit.Parent:FindFirstChild("Torso")
		end
		base.HitBodyPart(hit,"shoot",math.random(30,70))
	end
	
	base.PlaceImpactDecal(rr)
end

local i = 0
while wait() do
	i+=1
	local rayresult = workspace:Raycast(bullet.Position,bullet.CFrame.RightVector*10,rayparams)
	if rayresult ~= nil then
		if rayresult.Instance ~= nil then
			BulletImpact(rayresult)
			bullet:Destroy()
			return
		end
	end
	if i >= 35 then
		bullet:Destroy()
		return
	end
end