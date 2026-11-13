local chr = script.Parent
local light = game:GetService("Lighting")
local root = chr:WaitForChild("HumanoidRootPart")

game:GetService("RunService").RenderStepped:Connect(function()
	local saturation = 0
	
	local y = root.Position.Y
	
	y = math.min(math.max(y,50),100)
	y -= 50
	y /= 50
	
	saturation = y-1
	light.ColorCorrection.Saturation = saturation
end)