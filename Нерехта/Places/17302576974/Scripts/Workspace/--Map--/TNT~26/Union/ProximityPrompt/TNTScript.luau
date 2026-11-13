local tnt = script.Parent
local pressed = false

local lighter = Instance.new("Sound")
lighter.Name = "LighterSound"
lighter.SoundId = "rbxassetid://1773984066"
lighter.Parent = tnt.Parent
lighter.Volume = 0.1
lighter.EmitterSize = 1
lighter.Looped = false
lighter.PlayOnRemove = false

tnt.PromptButtonHoldBegan:Connect(function()
	if not pressed then
		lighter:Play()
	end
end)

local fuse = Instance.new("Sound")
fuse.Name = "FuseSound"
fuse.SoundId = "rbxassetid://4639307587"
fuse.Parent = tnt.Parent
fuse.Volume = 0.09
fuse.EmitterSize = 1
fuse.Looped = true

local boomsound = Instance.new("Sound")
boomsound.Name = "BoomSound"
boomsound.SoundId = "rbxassetid://166047765"
boomsound.Parent = tnt.Parent
boomsound.Volume = 1
boomsound.EmitterSize = 2
boomsound.PlayOnRemove = true

tnt.TriggerEnded:Connect(function()
	if not pressed then
		pressed = true
		tnt.Enabled = false
		lighter:Destroy()
		fuse:Play()
		local fire = Instance.new("Fire")
		fire.Heat = 2
		fire.Color = Color3.new(0.666667, 0.67451, 0.184314)
		fire.SecondaryColor = Color3.new(0.67451, 0.0705882, 0.0705882)
		fire.Size = 0.005
		fire.Parent = tnt.Parent
		wait(8)
		fuse:Destroy()
		fire:Destroy()
		boomsound:Play()
		local explosion = Instance.new("Explosion")
		explosion.BlastRadius = 10
		explosion.BlastPressure = 4500
		explosion.DestroyJointRadiusPercent = 0.6
		explosion.ExplosionType = Enum.ExplosionType.Craters
		explosion.Position = tnt.Parent.Position
		explosion.Parent = tnt.Parent.Parent.Part
		tnt.Parent:Destroy()
	end
end)