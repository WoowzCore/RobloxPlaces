local i = 0
local i2 = {"waiting","waiting.","waiting..","waiting..."}
while wait(1) do
	if script.Parent.Parent.Parent.Parent.Parent.b.text.SurfaceGui.sign.Text ~= "waiting" then
		i += 1
		script.Parent.Text = i2[i]
		if i >= 4 then
			i = 0
		end
	else
		script.Parent.Text = "waiting"
	end
end