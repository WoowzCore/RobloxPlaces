local activated = (math.random(0,100)>50)

function changelight(bool)
	local neon = script.Parent.light
	local light = script.Parent.light.SurfaceLight
	light.Enabled = bool
	if bool then
		neon.Transparency = 0
	else
		neon.Transparency = 1
	end
end
changelight(activated)

local working = false
script.Parent.button.ClickDetector.ClickDetectorScript.Event.Event:Connect(function()
	if working then return end
	working = true	
	activated = not activated
	changelight(activated)
	wait(0.1)
	working = false
end)