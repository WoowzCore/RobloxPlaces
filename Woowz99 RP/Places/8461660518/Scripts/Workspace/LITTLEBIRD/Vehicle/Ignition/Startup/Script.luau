prop = script.Parent.Parent.Parent.Heli.Plane.Body.ROTOR

function onClicked()
prop.TopSurfaceInput = "Constant"
prop.START:Play()
for i = 0, 2, .004 do
	prop.TopParamA = i
	prop.TopParamB = i
	wait(0.01)
end
end

script.Parent.ClickDetector.MouseClick:connect(onClicked)