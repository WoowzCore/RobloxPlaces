local Camera = game.Workspace.CurrentCamera
local Sound = script:WaitForChild("Sound")

local RobloxHasWorkingIsPlaying = false -- change me to true when roblox updates IsPlaying
	local SoundDeleteTimeForNonLooped = 1 -- set me while roblox still has non working IsPlaying

function PlaySound()
	Sound.Name = "SteppedSound"
	Sound.Parent = Camera
	if RobloxHasWorkingIsPlaying then
		Sound.Changed:connect(function(Property) if Property == "IsPlaying" and Sound.IsPlaying == false then Sound:Destroy(); script:Destroy() end end)
		Sound:Play()
	elseif not Sound.Looped then
		game.Debris:AddItem(Sound,SoundDeleteTimeForNonLooped)
		Sound:Play()
		script:Destroy()
	else
		Sound:Play()
		script:Destroy()
	end
end

function Soundify()
	local OldSound = Camera:FindFirstChild("SteppedSound")
	if OldSound ~= nil then
		if OldSound.SoundId ~= Sound.SoundId then
			OldSound:Destroy()
			PlaySound()
		else
			script:Destroy()
		end
	else
		PlaySound()
	end
end

Soundify()