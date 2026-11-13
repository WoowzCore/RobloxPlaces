local base = require(game:GetService("ServerScriptService").Base)
local lightingid = script.Parent.LightID.Value
local enabled = script.Parent.Enabled.Value

local _, rot = script.Parent.PrimaryPart.CFrame:ToOrientation()
rot = math.floor(math.deg(rot))

local swich = script.Parent.Switch
local cframe = swich.CFrame
local active = enabled
local working = false

local function ChangeLight(bool)
	base.Switch(lightingid,bool)
end

local function Activate(bool,always)
	if not always then
		if working then return end
	end

	working = true
	swich.Sound.PlaybackSpeed = math.random(90,110)/100
	swich.Sound:Play()
	if bool then
		script.Parent.neon.Color = Color3.fromRGB(128, 193, 111)
		base.ts(script.Parent.Union.Weld,TweenInfo.new(0.3),{C1 = CFrame.new()})
	else
		script.Parent.neon.Color = Color3.fromRGB(193, 69, 53)
		base.ts(script.Parent.Union.Weld,TweenInfo.new(0.3),{C1 = CFrame.Angles(math.rad(90),0,0)})
	end
	ChangeLight(bool)
	
	if not always then
		wait(0.3)
	end
	working = false
end

script.Parent.CD.ClickDetector.ClickDetectorScript.Event.Event:Connect(function()
	active = not active
	Activate(active)
end)

script.Parent.Turn.Event:Connect(function(bool)
	Activate(bool,true)
end)

wait(1)
if not enabled then
	Activate(false,true)
end