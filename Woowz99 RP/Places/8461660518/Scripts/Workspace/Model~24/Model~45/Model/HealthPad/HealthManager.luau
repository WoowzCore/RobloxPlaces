--UPDATE 1: Fixed reset bug
--			Renamed config to "Minimum Health Ratio"

local Pad=script.Parent

local Config=script.Parent.Configurations
local HealthRate=Config["Minimum Health Ratio"].Value
local HealRate=Config["Heal Rate"].Value
local Spin=Config.Spin.Value

local Healing=false

local Heal=function(Humanoid)coroutine.resume(coroutine.create(function()
	Healing=true
	local RecentSpeed=Humanoid.WalkSpeed
	Humanoid.WalkSpeed=0
	local Torso=Humanoid.Parent:FindFirstChild'Torso'
	local Force
	if Torso and Spin then
		Force=Instance.new("BodyAngularVelocity",Torso)
		Force.angularvelocity=Vector3.new(0,25,0)
		Force.maxTorque=Vector3.new(0,120000,0)
	end
	local Tag=Instance.new("BoolValue",Humanoid)
	Tag.Name="heal"
	Torso.CFrame=CFrame.new(Pad.Position+Vector3.new(0,3,0))
	repeat
		wait(1/30)
		Humanoid.Health=Humanoid.Health+HealRate
	until Humanoid.Health/Humanoid.MaxHealth>=1
	Tag:destroy()
	Humanoid.WalkSpeed=RecentSpeed
	if Force then
		Force:destroy()
	end
	Healing=false
end))end




Pad.Touched:connect(function(PartTouched)
	local Humanoid=PartTouched.Parent:FindFirstChild'Humanoid'
	local Torso=PartTouched.Parent:FindFirstChild'Torso'
	if Humanoid and Torso and Humanoid.Health/Humanoid.MaxHealth<=HealthRate and not(Humanoid:FindFirstChild'heal') and not(Healing)and Humanoid.Health>0 then
		Heal(Humanoid)
	end
end)