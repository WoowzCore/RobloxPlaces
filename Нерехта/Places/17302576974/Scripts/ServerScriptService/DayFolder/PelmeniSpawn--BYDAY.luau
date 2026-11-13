wait(5)

local sound = Instance.new("Sound")
sound.Name = "PelmenSiren"
sound.SoundId = "rbxassetid://8610623488"
sound.Parent = workspace
sound.Volume = 100
sound.Looped = true
sound:Play()

wait(5)

local Pelmen = game.workspace:FindFirstChild("--Map--").Pelmen

while wait() do
	local part = workspace["--Map--"].Pelmen:Clone()
	part.Parent = workspace["--Map--"]
	part.CFrame = CFrame.new(math.random(-500,500),1000,math.random(-500,500))
	local size = math.random(Pelmen.Size.X,40)
	part.Size = Vector3.new(size,size,size)
	part.AssemblyLinearVelocity = Vector3.new(math.random(-300,300),math.random(-300,300),math.random(-300,300))
end