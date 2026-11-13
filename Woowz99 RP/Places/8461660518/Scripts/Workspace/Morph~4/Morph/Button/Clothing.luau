debounce = true

function onTouched(hit)
	if (hit.Parent:findFirstChild("Humanoid") ~= nil and debounce == true) then
		local g = script.Parent.Parent:findFirstChild("Outfit Morph")
		wait(0.1)
		p = g.Pants:clone()
		s = g.Shirt:clone()
		p.Parent = hit.Parent
		s.Parent = hit.Parent
		wait(0.9)
		debounce = true
	end
end

script.Parent.Touched:connect(onTouched)