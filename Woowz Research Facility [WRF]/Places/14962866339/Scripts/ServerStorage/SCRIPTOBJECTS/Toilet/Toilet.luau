local sliv = script.Parent.sliv
local base = require(game:GetService("ServerScriptService").Base)
local water = script.Parent.base.Weld

local slivatewaiting = false
local waiting = false

script.Parent.TriggerToilet.Touched:Connect(function() end)
local function removetoolsfromtrigger()
	for _, part in pairs(script.Parent.TriggerToilet:GetTouchingParts()) do
		if part ~= nil then
			if part.Parent ~= nil then
				if part.Parent:IsA("Tool") or part:IsA("Tool") then
					local tool = part
					if part.Parent:IsA("Tool") then
						tool = part.Parent
					end
					if tool.Parent ~= nil then
						if not tool.Parent:FindFirstChildOfClass("Humanoid") then
							tool:Destroy()
						end
					end
				end
			end
		end
	end
end

local function slivate()
	if waiting == false and slivatewaiting == true then
		base.ts(script.Parent.slivbasa.Weld,TweenInfo.new(0.2),{C1 = CFrame.new(-0.05, 0, 0)})
		wait(0.2)
		script.Parent.base.nedosliv.PlaybackSpeed = math.random(80,120)/100
		script.Parent.base.nedosliv:Play()
		base.ts(script.Parent.slivbasa.Weld,TweenInfo.new(0.2),{C1 = CFrame.new()})
	end
	if slivatewaiting then return end
	slivatewaiting = true
	waiting = true
	base.ts(script.Parent.slivbasa.Weld,TweenInfo.new(0.2),{C1 = CFrame.new(-0.05, 0, 0)})
	wait(0.2)
	script.Parent.base.sliv.PlaybackSpeed = math.random(90,110)/100
	script.Parent.base.sliv:Play()
	base.ts(script.Parent.slivbasa.Weld,TweenInfo.new(0.2),{C1 = CFrame.new()})
	base.ts(water,TweenInfo.new(3),{C0 = CFrame.new(0, 0.3, 0)})
	local rnd = math.random(40,50)/10 
	base.ts(script.Parent.water,TweenInfo.new(rnd),{Size = Vector3.new(1.719, 0.036, 1.414)})
	wait(rnd)
	removetoolsfromtrigger()
	base.ts(water,TweenInfo.new(6),{C0 = CFrame.new(-0.1, -0.1, 0)})
	base.ts(script.Parent.water,TweenInfo.new(math.random(120,130)/10),{Size = Vector3.new(1.219, 0.036, 1.003)})
	wait(8)
	waiting = false
	wait(25)
	slivatewaiting = false
end

sliv.ClickDetector.ClickDetectorScript.Event.Event:Connect(function()
	slivate()
end)