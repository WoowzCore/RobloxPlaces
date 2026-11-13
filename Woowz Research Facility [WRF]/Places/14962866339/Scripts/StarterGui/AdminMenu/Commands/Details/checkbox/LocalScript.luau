local button = script.Parent.TextButton

local function ChangeButton(bool)
	if bool then
		button.Text = "X"
	else
		button.Text = ""
	end
end
ChangeButton(script.Parent.Value.Value)

button.MouseButton1Click:Connect(function()
	script.Parent.Value.Value = not script.Parent.Value.Value
	ChangeButton(script.Parent.Value.Value)
end)