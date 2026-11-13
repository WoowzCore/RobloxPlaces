prop = script.Parent.Parent.Parent.Heli.Plane.Body.ROTOR

function onClicked()
prop.TopSurfaceInput = "NoInput"
prop.STOP:Play()
prop.TopParamA = 0
prop.TopParamB = 0
end

script.Parent.ClickDetector.MouseClick:connect(onClicked)