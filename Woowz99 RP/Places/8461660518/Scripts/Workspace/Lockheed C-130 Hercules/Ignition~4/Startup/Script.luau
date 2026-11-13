prop = script.Parent.Parent.Parent.PlaneKit.Plane.OtherParts.Body.ROTOR4

function onClicked()
prop.START:Play()
wait (3.5)
prop.TopSurfaceInput = "Constant"
prop.TopParamA = -.025
prop.TopParamB = .025
wait (.5)
prop.TopParamA = -.05
prop.TopParamB = .05
wait (.5)
prop.TopParamA = -.075
prop.TopParamB = .075
wait (.5)
prop.TopParamA = -.1
prop.TopParamB = .1
wait (1)
prop.TopParamA = -.17
prop.TopParamB = .17
wait (1)
prop.TopParamA = -.25
prop.TopParamB = .25
wait (1)
prop.TopParamA = -.37
prop.TopParamB = .37
wait (1)
prop.TopParamA = -.5
prop.TopParamB = .5
wait (1)
prop.TopParamA = -.67
prop.TopParamB = .67
wait (2)
prop.TopParamA = -.75
prop.TopParamB = .75
wait (2)
prop.TopParamA = -.87
prop.TopParamB = .87
wait (2)
prop.TopParamA = -1
prop.TopParamB = 1
wait(2)
prop.TopParamA = -1.25
prop.TopParamB = 1.25
wait (2)
prop.TopParamA = -1.5
prop.TopParamB = 1.5
wait(2)
prop.TopParamA = -1.75
prop.TopParamB = 1.75
wait (2)
prop.TopParamA = -2
prop.TopParamB = 2
wait(2)
prop.TopParamA = -1.25
prop.TopParamB = 1.25
wait (2)
prop.TopParamA = -2.5
prop.TopParamB = 2.5
wait (3)
prop.TopParamA = -1.75
prop.TopParamB = 1.75
wait (4)
prop.TopParamA = -3
prop.TopParamB = 3

end

script.Parent.ClickDetector.MouseClick:connect(onClicked)