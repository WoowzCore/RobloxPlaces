local kill = script.Parent
local debounce = false
local waitTime = 1
local damage = 10

function onTouched(hit)
	
	if not debounce then
		debounce = true
		if hit.Parent and hit.Parent:FindFirstChild("Humanoid") then
			hit.Parent.Humanoid.Health = hit.Parent.Humanoid.Health - damage
		end
		wait(waitTime)
		debounce = false	
	end	
end

kill.Touched:connect(onTouched)

