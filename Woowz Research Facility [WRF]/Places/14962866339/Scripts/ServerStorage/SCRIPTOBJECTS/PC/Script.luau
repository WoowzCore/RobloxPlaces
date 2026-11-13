wait(3)
local base = require(game:GetService("ServerScriptService").Base)
local pc = script.Parent
local id = pc.PC_ID.Value

local components = {}
for _, part in pairs(game.Workspace:GetDescendants()) do
	if part.Name == "PC_ID" then
		if part.Value == id and part ~= pc.PC_ID then
			table.insert(components,part.Parent)
		end 
	end
end

local enabled = pc.Active.Value

local buttonpressed = false
local function PressButton()
	if buttonpressed then return end
	buttonpressed = true
	base.ts(pc.Front.Weld,TweenInfo.new(0.05),{C1 = CFrame.new(0, 0, 0.03)})
	wait(0.05)
	enabled = not enabled
	script.Parent.Active.Value = enabled
	
	if enabled then
		pc.RedLine.Material = Enum.Material.Neon
		pc.YellowLine.Material = Enum.Material.Neon
		pc.EnableLight.Material = Enum.Material.Neon
		pc.RedLine.Color = Color3.fromRGB(255, 53, 53)
		pc.YellowLine.Color = Color3.fromRGB(255, 223, 148)
		pc.EnableLight.Color = Color3.fromRGB(35, 136, 203)
		pc.Tube.sound:Play()
	else
		pc.RedLine.Material = Enum.Material.Glass
		pc.YellowLine.Material = Enum.Material.Glass
		pc.EnableLight.Material = Enum.Material.Glass
		pc.RedLine.Color = Color3.fromRGB(58, 27, 27)
		pc.YellowLine.Color = Color3.fromRGB(100, 91, 70)
		pc.EnableLight.Color = Color3.fromRGB(31, 48, 63)
		pc.Tube.sound:Stop()
	end
	
	for _, part in pairs(components) do
		part.EnableFromPC:Fire(enabled)
	end
	
	base.ts(pc.Front.Weld,TweenInfo.new(0.05),{C1 = CFrame.new(0, 0, 0)})
	wait(0.05)
	buttonpressed = false
end

pc.Detector.ClickDetector.ClickDetectorScript.Event.Event:Connect(PressButton)

if math.random(0,100)>90 and not enabled then
	PressButton()
end