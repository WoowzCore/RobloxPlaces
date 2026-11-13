function onClick()
script.Parent.Sound:Play()
wait(2)
script.Parent.Sound:Stop()
end
script.Parent.ClickDetector.MouseClick:connect(onClick)


