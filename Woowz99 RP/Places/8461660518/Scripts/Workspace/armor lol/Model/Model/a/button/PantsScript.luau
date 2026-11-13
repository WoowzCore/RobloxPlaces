function onTouched(hit)
	local h = hit.Parent:findFirstChild("Humanoid")
	if h~=nil then
		local s = hit.Parent:findFirstChild("Pants")
		if s~=nil and d~=nil then
			hit.Parent.Pants:remove()
			script.Parent.Pants:clone().Parent = hit.Parent
		elseif s~=nil then
			hit.Parent.Pants:remove()
			script.Parent.Pants:clone().Parent = hit.Parent
		elseif d~=nil then
			script.Parent.Pants:clone().Parent = hit.Parent
		elseif s==nil and d==nil then
			script.Parent.Pants:clone().Parent = hit.Parent
		end
	end
end

script.Parent.Touched:connect(onTouched)
	