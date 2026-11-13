local playersSer = game:GetService("Players")
local players

local function SetPositionGlobalPlayer(player)
	local GP = game.Scene:WaitForChild(player.UserId.." Global Additionally")
	local ch = player.Character
	if not ch or not ch.Parent then
		ch = player.CharacterAdded:wait()
	end
	if ch then
		local body = ch:WaitForChild("HumanoidRootPart");
		GP.Position = body.Position
	end
end

while true do
	wait()
	players = playersSer:GetPlayers()
	for _,p in pairs(players) do
		--SetPositionGlobalPlayer(p)
	end
end