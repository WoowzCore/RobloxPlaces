-- declarations

local head = script.Parent

function onTouched(part)
	local h = part.Parent:findFirstChild("Humanoid")
	if h~=nil then
if part.Parent:findFirstChild("Head"):findFirstChild("face").Texture == nil then return end
part.Parent:findFirstChild("Head"):findFirstChild("face").Texture="717dea9c5a1659640155f77c84892c "	end
end

script.Parent.Touched:connect(onTouched)