function onTouched(part)

	local h = part.Parent:findFirstChild("Humanoid")
	if h~=nil then

	local pants = part.Parent:FindFirstChild("Pants")
	local top = part.Parent:FindFirstChild("Shirt")
	

	if top ~= nil then 
	top:remove()
		if pants ~= nil then 
		pants:remove()
		newpants = script.Parent.Pants:clone()
		newpants.Parent = part.Parent

		newshirt = script.Parent.Shirt:clone()
		newshirt.Parent = part.Parent

		else
		newpants = script.Parent.Pants:clone()
		newpants.Parent = part.Parent

		newshirt = script.Parent.Shirt:clone()
		newshirt.Parent = part.Parent
		end

	elseif pants ~= nil then 
	pants:remove()
	newpants = script.Parent.Pants:clone()
	newpants.Parent = part.Parent

	newshirt = script.Parent.Shirt:clone()
	newshirt.Parent = part.Parent
	else

	newpants = script.Parent.Pants:clone()
	newpants.Parent = part.Parent

	newshirt = script.Parent.Shirt:clone()
	newshirt.Parent = part.Parent

	end




	end
end



script.Parent.Touched:connect(onTouched)