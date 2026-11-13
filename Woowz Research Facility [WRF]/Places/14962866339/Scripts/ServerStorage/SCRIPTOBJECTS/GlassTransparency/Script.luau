local basa = require(game:GetService("ServerScriptService").Base)
local polsynok = script.Parent.polsynok
local polsynokpos = polsynok.Position
local timewait = 2

local activated = false
local waiting = false

local function ChangeTransparency(to,t)
	for _, glass in pairs(script.Parent.Parent:GetDescendants()) do
		if glass.Name == "Glass" then
			basa.ts(glass,TweenInfo.new(t),{Transparency = to})
		end
	end
end

local function Activated()
	if waiting then return end
	activated = not activated
	if activated then
		waiting = true
		basa.ts(polsynok,TweenInfo.new(timewait),{CFrame = CFrame.new(polsynokpos)*CFrame.Angles(0,0,math.rad(-179))})
		ChangeTransparency(0,timewait)
		wait(timewait)
		waiting = false
	else
		waiting = true
		basa.ts(polsynok,TweenInfo.new(timewait),{CFrame = CFrame.new(polsynokpos)*CFrame.Angles(0,0,0)})
		ChangeTransparency(0.85,timewait)
		wait(timewait)
		waiting = false
	end
end
script.Parent.CD.ClickDetector.ClickDetectorScript.Event.Event:Connect(Activated)

if math.random(0,100) >= 70 then
	Activated()
end