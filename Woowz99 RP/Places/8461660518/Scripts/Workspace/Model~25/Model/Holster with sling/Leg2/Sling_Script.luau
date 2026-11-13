-- Removes sling model on tool equip
-- Written by 3tianne
-- 10/07/2016

-- CONSTANT VARIABLES
local THIS = script
local SLING = THIS.Parent

-- OTHER VARIABLES
local WEP_NAME = "G45"

-- EVENTS
SLING.Parent.ChildAdded:connect(function(newChild)
	print("Child Added")
	if newChild.Name:lower() == WEP_NAME:lower() then
		for i, v in pairs(SLING:GetChildren()) do
			if v.Name == "G45" then
				if v:FindFirstChild("Decal") then
					for _, decal in pairs(v:GetChildren()) do
						if decal:IsA("Decal") then
							decal.Transparency = 1
						end
					end
				end
				v.Transparency = 1
			end
		end
	end
end)
SLING.Parent.ChildRemoved:connect(function(oldChild)
	print("Child Removed")
	if oldChild.Name:lower() == WEP_NAME:lower() then
		for i, v in pairs(SLING:GetChildren()) do
			if v.Name == "G45" then
				if v:FindFirstChild("Decal") then
					for _, decal in pairs(v:GetChildren()) do
						if decal:IsA("Decal") then
							decal.Transparency = 0
						end
					end
				end
				v.Transparency = 0
			end
		end
	end
end)