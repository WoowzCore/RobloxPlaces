local fireflies = {}
local MAX_FIREFLIES = 5

function onActivate()
	local firefly = game.ServerStorage.FireFlySwarm:Clone()
	firefly.Parent = game.Workspace
	firefly:SetPrimaryPartCFrame(script.Parent.Handle.CFrame)
	table.insert(fireflies, firefly)
	if #fireflies > MAX_FIREFLIES then
		local oldFirefly = table.remove(fireflies, 1)
		oldFirefly:Destroy()
	end
end

if not game.ServerStorage:FindFirstChild("FireFlySwarm") then
	script.Parent:FindFirstChild("FireFlySwarm").Parent = game.ServerStorage
else
	if script.Parent:FindFirstChild("FireFlySwarm") then
		script.Parent:FindFirstChild("FireFlySwarm"):Destroy()
	end
end

script.Parent.Activated:connect(onActivate)