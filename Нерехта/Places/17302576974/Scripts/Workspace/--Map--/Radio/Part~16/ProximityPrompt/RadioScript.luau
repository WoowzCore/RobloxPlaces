wait(2)

local musics = {
	"2492130469","1845306277","1841140365","6156812331","1836175982","1845888660","1846088114"
}

local radio = script.Parent

local radiomusic = Instance.new("Sound")
radiomusic.Name = "RadioMusic"
radiomusic.Parent = radio.Parent
radiomusic.Looped = true
radiomusic.RollOffMode = Enum.RollOffMode.Linear
radiomusic.Volume = 0.05
radiomusic.RollOffMinDistance = 0
radiomusic.RollOffMaxDistance = 12

local buttonsound = Instance.new("Sound")
buttonsound.Name = "RadioMusic"
buttonsound.SoundId = "rbxassetid://9119720940"
buttonsound.Parent = radio.Parent
buttonsound.EmitterSize = 1

radio.TriggerEnded:Connect(function()
	radiomusic.SoundId = "rbxassetid://"..musics[math.random(1,#musics)]
	buttonsound:Play()
	wait(0.1)
	if not radiomusic.IsPlaying then -- Вкл
		radio.Parent.Color = Color3.new(0.7, 0.1, 0.1)
		radio.Parent.Material = Enum.Material.Neon
		radiomusic:Play()
	else -- Выкл
		radio.Parent.Color = Color3.new(0.5, 0, 0)
		radio.Parent.Material = Enum.Material.Glass
		radiomusic:Stop()
	end
end)

while wait() do
	if radio.Parent:FindFirstChild("WoowzJoint") == nil then
		if radiomusic.IsPlaying then
			radiomusic:Stop()
		end
		radio.Enabled = false
		radio.Parent:Destroy()
	end
end