function onTouched(hit)
	local h = hit.Parent:findFirstChild("Humanoid")
	if h~=nil then
		local s = hit.Parent:findFirstChild("Shirt")
		if s~=nil and d~=nil then
			hit.Parent.Shirt:remove()
			script.Parent.Shirt:clone().Parent = hit.Parent
		elseif s~=nil then
			hit.Parent.Shirt:remove()
			script.Parent.Shirt:clone().Parent = hit.Parent
		elseif d~=nil then
			script.Parent.Shirt:clone().Parent = hit.Parent
		elseif s==nil and d==nil then
			script.Parent.Shirt:clone().Parent = hit.Parent
		end
	end
end

script.Parent.Touched:connect(onTouched)
	