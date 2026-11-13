local handle = script.Parent.Handle
local hinge = script.Parent.Base
local originalCFrame = hinge.CFrame
local lidOpen = false

hinge.BodyGyro.cframe = originalCFrame

for i, v in pairs(script.Parent:GetChildren()) do
	if v:IsA("BasePart") then
		v.Anchored = false
	end
end

handle.ClickDetector.MouseClick:Connect(function()
	if lidOpen then
		lidOpen = false
		hinge.BodyGyro.cframe = originalCFrame
	else
		lidOpen = true
		hinge.BodyGyro.cframe = originalCFrame * CFrame.Angles(math.rad(90), 0, 0)
	end
end)