-- declarations

local head = script.Parent
local sound = head:findFirstChild("Victory")

function onTouched(part)
	local h = part.Parent:findFirstChild("Humanoid")
	if h~=nil then
sound:play()
if part.Parent:findFirstChild("Head"):findFirstChild("face").Texture == nil then return end
part.Parent:findFirstChild("Head"):findFirstChild("face").Texture=script.Parent.Decal.Texture
	end
end

script.Parent.Touched:connect(onTouched)