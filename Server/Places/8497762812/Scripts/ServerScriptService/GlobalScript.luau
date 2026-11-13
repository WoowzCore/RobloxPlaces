local RS = game.ReplicatedStorage
local nickname = "Woowz14"

local function GetValue(name)
	local ValuesHere = game.Players:FindFirstChild(nickname).StarterGui:WaitForChild("PlayerStarting").PlayerVariables
	return ValuesHere:WaitForChild(name).Value
end
local function SetValue(name,value)
	local ValuesHere = script.Parent:WaitForChild("PlayerStarting").PlayerVariables
	ValuesHere:WaitForChild(name).Value = value
end

local function GetGlobalValue(name)
	local ValuesHere = game.Workspace["Game Files"].WorldVariables
	return ValuesHere:WaitForChild(name).Value
end

print(GetValue("PlayerHealth"))

RS.PushObject.OnServerEvent:Connect(function(player,obj)
	
end)