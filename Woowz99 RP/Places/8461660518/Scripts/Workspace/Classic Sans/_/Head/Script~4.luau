debounce = false

script.Parent.Touched:connect(function(hit)
if not debounce then
debounce = true
if(hit.Parent:FindFirstChild("Humanoid")~=nil)then
local player = game.Players:GetPlayerFromCharacter(hit.Parent)
local sound = script.Parent.Sound:Clone()
sound.Parent = player.PlayerGui
sound:Play()
wait(2)
end
debounce = false
end
end)
