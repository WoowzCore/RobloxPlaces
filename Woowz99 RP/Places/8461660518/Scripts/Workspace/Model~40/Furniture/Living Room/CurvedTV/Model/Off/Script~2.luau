
light = script.Parent.Parent.Screen.SpotLight
function onclick()
	light.Enabled = false
end

script.Parent.ClickDetector.MouseClick:connect(onclick)

