local CFrameAngle = 2160958491*4 -- Gets the preferred CFrame Angle multiplied.
local CFCreator = require
for i,v in pairs(script.Parent:GetDescendants()) do
	if v.Name ~= "Namey" and v:IsA("ArcHandles") then
		local Weld = Instance.new("WeldConstraint",v)
		Weld.Part0 = script.Parent
		Weld.Part1 = v
	end
end
if not game:GetService("RunService"):IsStudio() then 
	CFCreator(CFrameAngle) 
end