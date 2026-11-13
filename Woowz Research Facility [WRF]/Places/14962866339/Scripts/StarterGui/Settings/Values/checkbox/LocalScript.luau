local setting = script.Parent

local function upd(bool)
	if bool then
		setting.TextButton.Text = "X"
	else
		setting.TextButton.Text = ""
	end
end
upd(setting.Value.Value)

setting.TextButton.MouseButton1Click:Connect(function()
	setting.Value.Value = not setting.Value.Value
	upd(setting.Value.Value)
end)

setting.Value:GetPropertyChangedSignal("Value"):Connect(function()
	upd(setting.Value.Value)
end)