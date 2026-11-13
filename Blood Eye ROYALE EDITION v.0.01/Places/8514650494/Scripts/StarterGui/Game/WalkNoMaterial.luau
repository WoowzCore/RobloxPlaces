wait(0.2)
local player = script.Parent.Parent.Parent

local c = player.Character
if not c or not c.Parent then
	c = player.CharacterAdded:Wait()
end

local hum = c:FindFirstChild("Humanoid")

local function LoadValue(name)
	local v = player.PlayerStarter.Values
	return v:FindFirstChild(name).Value
end
local function LoadScript(name)
	local v = player.PlayerStarter.Values.Scripts
	local v2 = v:FindFirstChild(name)
	return v2.Value
end

while true do
	wait(0.5)
	if LoadScript("WalkNoMaterial") then
		local m = LoadValue("CantRunThisMaterial")
		if hum.FloorMaterial == Enum.Material[m] then
			game.ReplicatedStorage.StartRandomPlayerEvent:FireServer(LoadValue("EventPlayerStepMaterial"))
		end
		end
end
