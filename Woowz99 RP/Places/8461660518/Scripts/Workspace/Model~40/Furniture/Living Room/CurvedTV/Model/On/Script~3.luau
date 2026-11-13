
light = script.Parent.Parent.Screen.PointLight
function onclick()
	light.Enabled = true
end

script.Parent.ClickDetector.MouseClick:connect(onclick)

