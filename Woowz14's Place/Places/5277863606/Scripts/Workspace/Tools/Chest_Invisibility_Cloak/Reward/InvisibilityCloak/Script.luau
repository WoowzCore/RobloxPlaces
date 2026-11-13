local FADE_IN_TIME = 1
local DURATION = 5
local FADE_OUT_TIME = 1
local COOLDOWN = 5

local tool = script.Parent
local canActivate = tool.CanActivate

local function callOnChildren(object, func)
	func(object)
	for _, child in pairs(object:GetChildren()) do
		if not child:IsA("Tool") or child == tool then
			callOnChildren(child, func)
		end
	end
end

local function makeInvisible(object, delta, originalTransparencies)
	if object:IsA("BasePart") or object:IsA("Decal") then
		if not originalTransparencies[object] then
			originalTransparencies[object] = object.Transparency
		end
		object.Transparency = originalTransparencies[object] + delta
	end
end

local function onActivated()
	if canActivate.Value then
		canActivate.Value = false
		
		local originalTransparencies = {}
		originalTransparencies[tool.Handle] = 0
		local character = tool.Parent		
		
		local fadeInSteps = FADE_IN_TIME * 30
		if fadeInSteps <= 1 then
			fadeInSteps = 1
		end		
		for t = 0, fadeInSteps do
			callOnChildren(character, function(object)
				makeInvisible(object, t / fadeInSteps, originalTransparencies)
				makeInvisible(tool, t / fadeInSteps, originalTransparencies)
			end)
			wait(1/30)
		end
		tool.Handle.Transparency = 1
		
		wait(DURATION)
		
		local fadeOutSteps = FADE_OUT_TIME * 30
		for t = fadeOutSteps, 0, -1 do
			callOnChildren(character, function(object)
				makeInvisible(object, t / fadeOutSteps, originalTransparencies)
				makeInvisible(tool, t / fadeInSteps, originalTransparencies)
			end)
			wait(1/30)
		end
		tool.Handle.Transparency = 0
				
		
		wait(COOLDOWN)
		
		canActivate.Value = true
	end
end

tool.Activated:connect(onActivated)
tool.Equipped:connect(function()
	if canActivate.Value then
		tool.Handle.Transparency = 0
	end
end)
