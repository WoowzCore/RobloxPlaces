Brick = script.Parent
Sound = Brick.Sound

function onClicked()
Sound:Play()
script.Parent.ClickDetector.MaxActivationDistance = 0.1
wait (15.7)
script.Parent.ClickDetector.MaxActivationDistance = 32
end

script.Parent.ClickDetector.MouseClick:connect(onClicked)
