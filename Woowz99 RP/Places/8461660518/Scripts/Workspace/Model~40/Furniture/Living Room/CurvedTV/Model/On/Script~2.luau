function clickit()
if script.Parent.Parent.Screen.Sound.IsPlaying == true then
	script.Parent.Parent.Screen.Sound:Stop()
else
	script.Parent.Parent.Screen.Sound:Play()
end
end

script.Parent.ClickDetector.MouseClick:connect(clickit)