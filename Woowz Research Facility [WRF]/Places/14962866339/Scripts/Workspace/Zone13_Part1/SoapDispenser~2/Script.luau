local dispenser = script.Parent
local soapcolors = {Color3.fromRGB(255, 152, 220),Color3.fromRGB(152, 255, 216),Color3.fromRGB(153, 255, 135),Color3.fromRGB(179, 193, 186)}
local color = soapcolors[math.random(1,#soapcolors)]
dispenser.Soap.Color = color
dispenser.Main.Output.Soap.Color = ColorSequence.new(color)
dispenser.Main.Output.Soap1.Color = ColorSequence.new(color)

local enabled = false
local function Enable()
	if not enabled then
		enabled = true
		dispenser.Main.Output.Soap.Enabled = true
		dispenser.Main.Output.Soap1.Enabled = true
		dispenser.Button.Sound:Play()
		wait(1)
		dispenser.Main.Output.Soap.Enabled = false
		dispenser.Main.Output.Soap1.Enabled = false
		enabled = false
	end
end

dispenser.Button.ClickDetector.ClickDetectorScript.Event.Event:Connect(Enable)