-- UAEmaple



function onTouch(part) 
local human = part.Parent:findFirstChild("Humanoid") 
if human ~= nil then 
part.Parent:findFirstChild("Head").Transparency = 1 
part.Parent:findFirstChild("Torso").Transparency = 1 
part.Parent:findFirstChild("Left Arm").Transparency = 1 
part.Parent:findFirstChild("Right Arm").Transparency = 1 
part.Parent:findFirstChild("Left Leg").Transparency = 1 
part.Parent:findFirstChild("Right Leg").Transparency = 1 
if part.Parent:findFirstChild("Torso"):findFirstChild("roblox") == nil then return end 
part.Parent:findFirstChild("Torso"):findFirstChild("roblox"):remove() 
end 
end 
script.Parent.Touched:connect(onTouch)