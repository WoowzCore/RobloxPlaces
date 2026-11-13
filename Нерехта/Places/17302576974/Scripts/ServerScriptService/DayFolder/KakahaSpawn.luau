local Kakaha = game.workspace:FindFirstChild("--Map--").Kakaha
local ss = game:GetService("ServerScriptService")

while wait(5) do
	for i = -100, 10 do
		local part = workspace["--Map--"].Kakaha:Clone()
		part.Parent = workspace["--Map--"]
		part.Size = Kakaha.Size * math.random(3,50)
		part.CFrame = CFrame.new(math.random(-500,500),500,math.random(-500,500))
		part.AssemblyLinearVelocity = Vector3.new(math.random(-30,30),-1000,math.random(-30,30))
		local sound = Instance.new("Sound")
		sound.Name = "KakahaSound"
		sound.SoundId = "rbxassetid://5486343441"
		sound.Parent = part
		sound.Volume = 50
		sound.Looped = false
		sound.RollOffMinDistance = 1
		sound.RollOffMaxDistance = 500
		sound.PlaybackSpeed = 1.05
		
		if math.random(0, 1000) >= 999 then
			sound.SoundId = "rbxassetid://5134377245"
			sound.Volume = math.huge
			part.Material = Enum.Material.ForceField
			part.Color = Color3.new(1, 0.701961, 0)	
			part.Size = part.Size * 10
			sound.PlaybackSpeed = math.random(80, 105)/100
		end
		
		part.Touched:Connect(function(p)
			p.Color = part.Color
			p.Material = Enum.Material.Glass
			sound:Play()
		end)
		local despawnscript = ss.LoadMap.DespawnScript:Clone()
		despawnscript.Parent = part
		despawnscript.Enabled = true
	end
end