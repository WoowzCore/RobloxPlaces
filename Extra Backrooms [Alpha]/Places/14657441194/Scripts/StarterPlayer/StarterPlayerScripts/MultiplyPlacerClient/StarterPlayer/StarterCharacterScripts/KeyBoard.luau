local keyboard = {
	Keys = {}
	
}

local u = game:GetService("UserInputService")

u.InputBegan:Connect(function(input,pro)
	if pro then return end

	keyboard.Keys[input.KeyCode] = true
end)

u.InputEnded:Connect(function(input,pro)
	if pro then return end

	keyboard.Keys[input.KeyCode] = false
end)

return keyboard
