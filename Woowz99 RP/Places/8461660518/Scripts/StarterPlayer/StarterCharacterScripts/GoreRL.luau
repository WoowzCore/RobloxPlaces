local health = script.Health
local aa = script.HeadDecap
local LA = script.Parent ["Right Leg"]
local LA2 = script.Parent.Torso:FindFirstChild("Right Hip")
local Bone = game.Lighting.L_Gore
local S = script.Gib_Sound
local character = script.Parent

LA.Touched:Connect(function(touched)
	if touched.Parent:FindFirstChild("Blade") then
		local blade = touched.Parent.Blade
		if blade.Clicked.Value == true then
			health.Value -= blade.LimbDamages.RL.Value
			if health.Value < 1  then
				aa.Disabled = false
				local h = Bone:Clone()
				h.Name = 'RLeg_Bone'
				h.Parent = character.Torso
				h.Position = character.Torso.Position
				h.Rotation = character.Torso.Rotation
				local weld = Instance.new("Weld",character.Torso)
				weld.Part0 = character.Torso
				weld.Part1 = h
				weld.C0 = CFrame.new(0.5,-1,0)
				script.Disabled = true
				wait(0.1)
				LA:Destroy()
				S:Play()
			end
			wait(2)
			script.Disabled = false
		end
	end
end)

LA.Touched:Connect(function(touched2)
	if touched2.Parent:FindFirstChild("Explosion") then
		aa.Disabled = false
		script.Parent.Humanoid.Health = 0
		local h = Bone:Clone()
		h.Name = 'RLeg_Bone'
		h.Parent = character.Torso
		h.Position = character.Torso.Position
		h.Rotation = character.Torso.Rotation
		local weld = Instance.new("Weld",character.Torso)
		weld.Part0 = character.Torso
		weld.Part1 = h
		weld.C0 = CFrame.new(0.5,-1,0)
		script.Disabled = true
		wait(0.1)
		LA:Destroy()
		S:Play()
	end
end)
