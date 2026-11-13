local UserInputService = game:GetService("UserInputService")

local kb = {}

kb.Keys = {}

kb.KeysPressed = {}

UserInputService.InputBegan:Connect(function(i)
	kb.Keys[i.KeyCode] = true
	if kb.KeysPressed[i.KeyCode] ~= nil then
		kb.KeysPressed[i.KeyCode] = not kb.KeysPressed[i.KeyCode]
	else
		kb.KeysPressed[i.KeyCode] = true
	end
end)

UserInputService.InputEnded:Connect(function(i)
	kb.Keys[i.KeyCode] = false
end)

function kb.ClearKeysPressed()
	kb.KeysPressed = {}
end

return kb
