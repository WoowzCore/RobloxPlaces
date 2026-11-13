local handle = script.Parent.Handle
local doorOpen = false
local changingState = false
local openSound = script.Parent.Hinge.Open
local closeSound = script.Parent.Hinge.Close

handle.ClickDetector.MouseClick:Connect(function()
	if doorOpen == true and changingState == false then
		delay(.4, function() closeSound:Play() end)
		changingState = true
		for i = 1, 18 do
			script.Parent:SetPrimaryPartCFrame(script.Parent.PrimaryPart.CFrame * CFrame.Angles(0, math.rad(-7), 0))
			wait()
		end
		changingState = false
		doorOpen = false
	elseif changingState == false then
		openSound:Play()
		changingState = true
		for i = 1, 18 do
			script.Parent:SetPrimaryPartCFrame(script.Parent.PrimaryPart.CFrame * CFrame.Angles(0, math.rad(7), 0))
			wait()
		end
		changingState = false
		doorOpen = true
	end
end)