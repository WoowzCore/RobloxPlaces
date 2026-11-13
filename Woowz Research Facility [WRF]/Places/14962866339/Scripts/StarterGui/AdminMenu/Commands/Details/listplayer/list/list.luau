local list = script.Parent
local moved = false
local mousein = false

for _, ui in pairs(script.Parent:GetChildren()) do
	if not ui:IsA("LocalScript") and not ui:IsA("UIListLayout") then
		ui.MouseMoved:Connect(function()
			moved = true
			mousein = true
		end)
		ui.MouseLeave:Connect(function()
			mousein = false
		end)
			

	end
end

game:GetService("UserInputService").InputBegan:Connect(function(input,gp)
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		if moved == false then
			mousein = true
		end
		if mousein == false then
			script.Parent.Visible = false
		end
	end
end)