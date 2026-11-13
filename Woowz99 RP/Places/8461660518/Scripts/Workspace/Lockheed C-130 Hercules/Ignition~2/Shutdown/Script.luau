prop = script.Parent.Parent.Parent.PlaneKit.Plane.OtherParts.Body.ROTOR2

function onClicked()
prop.STOP:Play()
wait (5)
prop.TopParamA = -2.8
prop.TopParamB = 2.8
wait (1)
prop.TopParamA = -2.6
prop.TopParamB = 2.6
wait (1)
prop.TopParamA = -2.4
prop.TopParamB = 2.4
wait (1)
prop.TopParamA = -2.2
prop.TopParamB = 2.2
wait (1)
prop.TopParamA = -2
prop.TopParamB = 2
wait (1)
prop.TopParamA = -1.8
prop.TopParamB = 1.8
wait (1)
prop.TopParamA = -1.6
prop.TopParamB = 1.6
wait (1)
prop.TopParamA = -1.4
prop.TopParamB = 1.4
wait (1)
prop.TopParamA = -1.2
prop.TopParamB = 1.2
wait (1)
prop.TopParamA = -1
prop.TopParamB = 1
wait (1)
prop.TopParamA = -.8
prop.TopParamB = .8
wait (1)
prop.TopParamA = -.6
prop.TopParamB = .6
wait (1)
prop.TopParamA = -.5
prop.TopParamB = .5
wait (1)
prop.TopParamA = -.4
prop.TopParamB = .4
wait (1)
prop.TopParamA = -.3
prop.TopParamB = .3
wait (1)
prop.TopParamA = -.19
prop.TopParamB = .19
wait (2)
prop.TopParamA = -.15
prop.TopParamB = .15
wait (2)
prop.TopParamA = -.1
prop.TopParamB = .1
wait (3)
prop.TopParamA = -.075
prop.TopParamB = .075
wait (3)
prop.TopParamA = -.05
prop.TopParamB = .05
wait (5)
prop.TopParamA = -.025
prop.TopParamB = .025
wait (5)
prop.TopParamA = -.013
prop.TopParamB = .013
wait (5)
prop.TopSurfaceInput = "NoInput"
end

script.Parent.ClickDetector.MouseClick:connect(onClicked)