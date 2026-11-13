debounce = true

function onTouched(hit)
	if (hit.Parent:findFirstChild("Humanoid") ~= nil and debounce == true) then
		local c = hit.Parent:findFirstChild("Body Colors")
		debounce = false
		c:remove()
		wait(1)
		debounce = true
	end
end

script.Parent.Touched:connect(onTouched)