local tool = script.Parent
local on = false
local lighttrigger = tool.LightTrigger

local function Toggle(tog, dontplaysound)
	on = tog
	if tog then
		script.Parent:WaitForChild("Light").Shadow.Enabled = true
		script.Parent:WaitForChild("Front"):WaitForChild("SurfaceLight").Enabled = true
		local p = script.Parent:WaitForChild("dust"):FindFirstChildOfClass("ParticleEmitter")
		if p then
			p.Enabled = true
		end
		lighttrigger.CanTouch = true
		if dontplaysound~=true then
			tool.Handle.On:Play()
		end
	else
		script.Parent:WaitForChild("Light").Shadow.Enabled = false
		script.Parent:WaitForChild("Front"):WaitForChild("SurfaceLight").Enabled = false
		local p = script.Parent:WaitForChild("dust"):FindFirstChildOfClass("ParticleEmitter")
		if p then
			p.Enabled = false
		end
		lighttrigger.CanTouch = false
		if dontplaysound~=true then
			tool.Handle.Off:Play()
		end
	end
end

script.Parent.Activated:Connect(function()
	Toggle(not on)
end)

script.Parent.Equipped:Connect(function()

end)
script.Parent.Unequipped:Connect(function()
	Toggle(false,true)
end)