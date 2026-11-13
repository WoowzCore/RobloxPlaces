local flare = script.Parent
local pressed = false

local lighter = Instance.new("Sound")
lighter.Name = "LighterSound"
lighter.SoundId = "rbxassetid://1773984066"
lighter.Parent = flare.Parent
lighter.Volume = 0.1
lighter.EmitterSize = 1
lighter.Looped = false
lighter.PlayOnRemove = false

flare.PromptButtonHoldBegan:Connect(function()
	if not pressed then
		lighter:Play()
	end
end)

local fuse = Instance.new("Sound")
fuse.Name = "FuseSound"
fuse.SoundId = "rbxassetid://4639307587"
fuse.Parent = flare.Parent
fuse.Volume = 0.09
fuse.EmitterSize = 1
fuse.Looped = true

flare.TriggerEnded:Connect(function()
	if not pressed then
		pressed = true
		flare.Enabled = false
		lighter:Destroy()
		fuse:Play()
		local fire = Instance.new("Fire")
		fire.Heat = 1
		fire.Color = Color3.new(0.705882, 0, 0.0117647)
		fire.SecondaryColor = Color3.new(1, 0, 0.0156863)
		fire.Size = 0.01
		fire.Parent = flare.Parent
		local light = Instance.new("PointLight")
		light.Color = Color3.new(1, 0, 0.0156863)
		light.Range = 13
		light.Brightness = 5
		light.Parent = flare.Parent
		light.Shadows = true
		wait(120)
		light:Destroy()
		fire:Destroy()
	end
end)