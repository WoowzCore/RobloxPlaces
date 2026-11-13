
light = script.Parent.Parent.Screen.SpotLight
function onclick()
	light.Enabled = true
end

script.Parent.ClickDetector.MouseClick:connect(onclick)

