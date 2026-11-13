
light = script.Parent.Parent.Screen.PointLight
function onclick()
	light.Enabled = false
end

script.Parent.ClickDetector.MouseClick:connect(onclick)

