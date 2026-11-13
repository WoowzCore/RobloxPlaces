function onTouched(hit)
local head = hit.Parent:findFirstChild("Head")
if head ~= nil then
local face = head:findFirstChild("face")
if face ~= nil then
head.face.Texture = "0"
end
end
end

script.Parent.Touched:connect(onTouched)

