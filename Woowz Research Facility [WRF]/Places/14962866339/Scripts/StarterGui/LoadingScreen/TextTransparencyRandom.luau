local gui = script.Parent

while wait() do
	if gui.Enabled then
		local t = math.random(20,35)/100
		gui.t1.TextTransparency = t
		gui.t2.TextTransparency = t
		gui.t3.TextTransparency = t
		gui.t4.TextTransparency = t
		gui.t5.TextTransparency = t
		gui.t6.TextTransparency = t
		gui.t7.TextTransparency = t
		gui.t8.TextTransparency = t
		gui.t9.TextTransparency = t
		gui.t10.TextTransparency = t
		gui.WRFIcon.ImageTransparency = (t-0.2)
	end
end