
function onTouch(part) 
local human = part.Parent:findFirstChild("Humanoid") 
if human ~= nil then 
part.Parent:findFirstChild("Head").Transparency = 1
part.Parent:findFirstChild("LeftFoot").Transparency = 1
part.Parent:findFirstChild("LeftHand").Transparency = 1
part.Parent:findFirstChild("LeftLowerArm").Transparency = 1
part.Parent:findFirstChild("LeftLowerLeg").Transparency = 1
part.Parent:findFirstChild("LeftUpperArm").Transparency = 1
part.Parent:findFirstChild("LeftUpperLeg").Transparency = 1
part.Parent:findFirstChild("LowerTorso").Transparency = 1
part.Parent:findFirstChild("RightFoot").Transparency = 1
part.Parent:findFirstChild("RightHand").Transparency = 1
part.Parent:findFirstChild("RightLowerArm").Transparency = 1
part.Parent:findFirstChild("RightLowerLeg").Transparency = 1
part.Parent:findFirstChild("RightUpperArm").Transparency = 1
part.Parent:findFirstChild("RightUpperLeg").Transparency = 1
part.Parent:findFirstChild("UpperTorso").Transparency = 1
if part.Parent:findFirstChild("Head"):findFirstChild("face") == nil then return end
part.Parent:findFirstChild("Head"):findFirstChild("face"):remove()
if part.Parent:findFirstChild("UpperTorso"):findFirstChild("roblox") == nil then return end
part.Parent:findFirstChild("UpperTorso"):findFirstChild("roblox"):remove()
end 
end 
script.Parent.Touched:connect(onTouch) 
