script.Parent.ClickDetector.MouseClick:Connect(function()
	if script.Parent.Parent.Light.Value == 1 then
		script.Parent.Parent.Light.Value = 2
	elseif script.Parent.Parent.Light.Value == 2 then
		script.Parent.Parent.Light.Value = 3
	elseif script.Parent.Parent.Light.Value == 3 then
		script.Parent.Parent.Light.Value = 4
	elseif script.Parent.Parent.Light.Value == 4 then
		script.Parent.Parent.Light.Value = 1
	end
end)