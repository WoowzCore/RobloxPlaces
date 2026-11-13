--Made By Nightmare_waffle

--Place me in StarterCharacterScripts located in StarterPlayer
local character = script.Parent
local timesby = 1 --Multiplyer
local DamageVelocity = 100 --How fast you go to take damage

local humanoid = script.Parent:WaitForChild("Humanoid")
local humanoidRP = script.Parent:WaitForChild("HumanoidRootPart")
local stateType = Enum.HumanoidStateType
local speed = 0
local fell = false
while true do
	wait()
	if humanoidRP.Velocity.Y < -DamageVelocity then
		speed = speed + timesby
		fell = true
		humanoid:SetStateEnabled(stateType.GettingUp, false)
		character.Constraint.ConstraintHand.Enabled = true
		humanoid:ChangeState(stateType.FallingDown)
		
	end 		
	if humanoid.FloorMaterial ~= nil and humanoid.FloorMaterial ~= Enum.Material.Air and humanoid.FloorMaterial ~= Enum.Material.Fabric and humanoid.FloorMaterial ~= Enum.Material.Water and fell then
		fell = false
		humanoid:ChangeState(stateType.FallingDown)
		humanoid.Health = humanoid.Health - speed
		speed = 0
	elseif	humanoidRP.Velocity.Y > -DamageVelocity then
		wait()
		speed = 0
		character.Constraint.ConstraintHand.Enabled = false
		humanoid:SetStateEnabled(stateType.GettingUp, true)
--Collision
character.LowerTorso.CollisionGroupId = 0
character.RightLowerArm.CollisionGroupId = 0
character.LeftLowerArm.CollisionGroupId = 0
character.RightLowerLeg.CollisionGroupId = 0
character.LeftLowerLeg.CollisionGroupId = 0
	end
end
