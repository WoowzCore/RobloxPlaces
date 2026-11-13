local Humanoid = script.Parent.Humanoid
Humanoid:SetStateEnabled(Enum.HumanoidStateType.FallingDown,false)
Humanoid:SetStateEnabled(Enum.HumanoidStateType.GettingUp,false)
Humanoid:SetStateEnabled(Enum.HumanoidStateType.Ragdoll,false)
Humanoid:SetStateEnabled(Enum.HumanoidStateType.Swimming,false)
Humanoid:SetStateEnabled(Enum.HumanoidStateType.Flying,false)
Humanoid:SetStateEnabled(Enum.HumanoidStateType.Climbing,false)

local function upd()
	for _, part in pairs(script.Parent:GetDescendants()) do
		if part:IsA("ParticleEmitter") then
			part:Destroy()
		end
	end	
end
upd()
wait(1)
upd()
wait(1)
upd()
script.Enabled = false

