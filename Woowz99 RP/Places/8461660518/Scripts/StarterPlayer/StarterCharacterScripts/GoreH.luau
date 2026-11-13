local health = script.Health
local aa = script.HeadDecap
local LA = script.Parent.Head
local Par = game.Lighting.Crush_Particle
local S = script.Gib_Sound
local character = script.Parent

LA.Touched:Connect(function(touched)
	if touched.Parent:FindFirstChild("Blade") then
		local blade = touched.Parent.Blade
		if blade.Clicked.Value == true then
			health.Value -= blade.LimbDamages.Head.Value
			if health.Value < 1 then
				aa.Disabled = false
				script.Parent.Humanoid.Health = 0
				local h = Par:Clone()
				h.Name = 'HeadPar'
				h.Parent = character.Torso
				h.Position = character.Torso.Position
				h.Rotation = character.Torso.Rotation
				local weld = Instance.new("Weld",character.Torso)
				weld.Part0 = character.Torso
				weld.Part1 = h
				weld.C0 = CFrame.new(0,0.8,0)
				local h2 = game.Lighting.Cereb:Clone()
				h2.Name = 'HeadPar'
				h2.Parent = character.Torso
				h2.Position = character.Torso.Position
				h2.Rotation = character.Torso.Rotation
				local weld2 = Instance.new("Weld",character.Torso)
				weld.Part0 = character.Torso
				weld.Part1 = h2
				weld.C0 = CFrame.new(0,0.8,0)
				local h3 = game.Lighting.Frontal:Clone()
				h3.Name = 'HeadPar'
				h3.Parent = character.Torso
				h3.Position = character.Torso.Position
				h3.Rotation = character.Torso.Rotation
				local weld3 = Instance.new("Weld",character.Torso)
				weld.Part0 = character.Torso
				weld.Part1 = h3
				weld.C0 = CFrame.new(0,0.8,0)
				local h4 = game.Lighting.Occipit:Clone()
				h4.Name = 'HeadPar'
				h4.Parent = character.Torso
				h4.Position = character.Torso.Position
				h4.Rotation = character.Torso.Rotation
				local weld4 = Instance.new("Weld",character.Torso)
				weld.Part0 = character.Torso
				weld.Part1 = h4
				weld.C0 = CFrame.new(0,0.8,0)
				local h5 = game.Lighting.Pariet:Clone()
				h4.Name = 'HeadPar'
				h4.Parent = character.Torso
				h4.Position = character.Torso.Position
				h4.Rotation = character.Torso.Rotation
				local weld5 = Instance.new("Weld",character.Torso)
				weld.Part0 = character.Torso
				weld.Part1 = h5
				weld.C0 = CFrame.new(0,0.8,0)
				local h6 = game.Lighting.Pitua:Clone()
				h5.Name = 'HeadPar'
				h5.Parent = character.Torso
				h5.Position = character.Torso.Position
				h5.Rotation = character.Torso.Rotation
				local weld6 = Instance.new("Weld",character.Torso)
				weld.Part0 = character.Torso
				weld.Part1 = h6
				weld.C0 = CFrame.new(0,0.8,0)
				local h7 = game.Lighting.Stem:Clone()
				h6.Name = 'HeadPar'
				h6.Parent = character.Torso
				h6.Position = character.Torso.Position
				h6.Rotation = character.Torso.Rotation
				local weld7 = Instance.new("Weld",character.Torso)
				weld.Part0 = character.Torso
				weld.Part1 = h7
				weld.C0 = CFrame.new(0,0.8,0)
				script.Disabled = true
				wait(0.1)
				LA:Destroy()
				S:Play()
				local h8 = game.Lighting.Temp:Clone()
				h8.Name = 'HeadPar'
				h8.Parent = character.Torso
				h8.Position = character.Torso.Position
				h8.Rotation = character.Torso.Rotation
				local weld8 = Instance.new("Weld",character.Torso)
				weld.Part0 = character.Torso
				weld.Part1 = h8
				weld.C0 = CFrame.new(0,0.8,0)
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
		local h = Par:Clone()
		h.Name = 'HeadPar'
		h.Parent = character.Torso
		h.Position = character.Torso.Position
		h.Rotation = character.Torso.Rotation
		local weld = Instance.new("Weld",character.Torso)
		weld.Part0 = character.Torso
		weld.Part1 = h
		weld.C0 = CFrame.new(0,0.8,0)
		script.Disabled = true
		wait(0.1)
		LA:Destroy()
		S:Play()
	end
end)
