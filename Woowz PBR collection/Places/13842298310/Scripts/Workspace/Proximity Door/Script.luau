local frame = script.Parent:WaitForChild("DoorFrame")
local openSound = frame:WaitForChild("DoorOpen")
local closeSound = frame:WaitForChild("DoorClose")
local proximityprompt = frame:WaitForChild("ProximityPrompt")
local model = script.Parent
local frameClose = model:WaitForChild("DoorFrameClose")
local frameOpen = model:WaitForChild("DoorFrameOpen")
local tweenService = game:GetService("TweenService")

proximityprompt.Triggered:Connect(function()
	if 	proximityprompt.ActionText == "Close" then
		proximityprompt.ActionText = "Open"
		closeSound:Play()
		frame.CanCollide = true
		tweenService:Create(frame,TweenInfo.new(.35),{CFrame = frameClose.CFrame}):Play()
		else
		proximityprompt.ActionText = "Close"
		openSound:Play()
		frame.CanCollide = false
		tweenService:Create(frame,TweenInfo.new(.35),{CFrame = frameOpen.CFrame}):Play()
		end
	end)