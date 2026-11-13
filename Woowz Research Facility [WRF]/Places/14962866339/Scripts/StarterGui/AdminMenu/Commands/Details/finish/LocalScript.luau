local enabledbutton = script.Parent.EnabledButton.Value
local button = script.Parent.TextButton

local function updbutton(bool)
	if bool then
		button.BackgroundColor3 = Color3.fromRGB(52, 221, 0)
		button.Text = "Активировать"
	else
		button.BackgroundColor3 = Color3.fromRGB(190, 6, 6)
		button.Text = "Вы не можете"
	end
end
updbutton(enabledbutton)

while wait() do
	if script.Parent.Visible then
		if script.Parent.EnabledButton.Value ~= enabledbutton then
			enabledbutton = script.Parent.EnabledButton.Value
			updbutton(enabledbutton)
		end
	end
end