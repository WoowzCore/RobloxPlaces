local Button = script.Parent
local Sound = Button:WaitForChild("Sound") -- change if you change the name of the sound
local SoundPlayer = script:WaitForChild("SoundPlayer")

function GiveSound(Character)
	local Player = game.Players:GetPlayerFromCharacter(Character)
	if Player ~= nil then
		local PlayerGui = Player:FindFirstChild("PlayerGui")
		if PlayerGui ~= nil then
			local SoundScript = SoundPlayer:clone()
			local SoundCopy = Sound:clone()
			SoundCopy.Name = "Sound"
			SoundCopy.Parent = SoundScript
			
			SoundScript.Parent = PlayerGui
			SoundScript.Disabled = false
		end
	end
end

function Stepped(Part)
	if Part.Parent == nil then return end
	GiveSound(Part.Parent)
end
Button.Touched:connect(Stepped)
