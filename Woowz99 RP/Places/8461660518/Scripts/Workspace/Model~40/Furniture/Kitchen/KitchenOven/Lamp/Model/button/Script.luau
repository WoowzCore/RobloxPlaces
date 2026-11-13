
light = script.Parent.c.PointLight
function onclick()
	light.Enabled = not light.Enabled
end

script.Parent.ClickDetector.MouseClick:connect(onclick)

