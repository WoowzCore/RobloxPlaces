-- Made By: IMAXFilmmaker_Bee 
-- Edited By: 1962stingray
-- special thanks IMAXFilmmaker_Bee
--------------------------------------------------------------------------------------------------
local P = script.Parent

local Creator = "Nathaneil00089"
local NotAllowed = {"",""} -- look at this kid.

local LockMessage = "/e lockbandit"
local UnlockMessage = "/e unlockbandit"

local Locked = true --when true, only creator can drive, when false, anyone except NotAllowed can drive

local CreatorInGame = game.Players:FindFirstChild(Creator)
local CreatorMessage = function(msg)
	if Locked and msg == UnlockMessage then
		Locked = false
		print("Unlocked")
	elseif not Locked and msg == LockMessage then
		Locked = true
		print("Locked")
	end
end
local CreatorChatted = nil
if CreatorInGame then
	CreatorChatted = game.Players[Creator].Chatted:connect(CreatorMessage)
end

game.Players.PlayerRemoving:connect(function(it)
	if it.Name == Creator then
		if CreatorChatted then
			CreatorChatted:disconnect()
			CreatorChatted = nil
		end
	end
end)
game.Players.PlayerAdded:connect(function(it)
	if it.Name == Creator then
		CreatorChatted = nil
		CreatorChatted = game.Players[Creator].Chatted:connect(CreatorMessage)
	end
end)

script["wowzers u such baddie"].BLackout.YourName.Text = "~"..Creator

function GiveGui(player)
	for i,v in pairs(script:GetChildren()) do
		v:Clone().Parent = player.PlayerGui -- rip
	end
	wait(.4)
	player.Character.Humanoid.Jump = true -- clears GUI, useful for stopping DynDS abuse
	player.Character.Humanoid.Health = 0 -- kill him!
	script.Parent.Fail:Play()
	script.Parent.ALARM:Play()
end

P.ChildAdded:connect(function(child)
	if child:IsA("Weld") and child.Part1 and child.Part1.Parent:FindFirstChild("Humanoid") then
		local player = game.Players:GetPlayerFromCharacter(child.Part1.Parent)
		for _,k in pairs (NotAllowed) do
			if k == player.Name then
				GiveGui(player)
				return
			end
			if Locked and player.Name ~= Creator then
				GiveGui(player)
			end
		end
	end	
end)
