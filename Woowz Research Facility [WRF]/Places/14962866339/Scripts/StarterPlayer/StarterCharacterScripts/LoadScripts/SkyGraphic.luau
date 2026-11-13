local base = require(script.Parent:WaitForChild("PlayerBase"))
local l = game:GetService("Lighting")
local height = base.Camera.CFrame.Position.Y
local skymultiply = (math.clamp(height,130,180)-130)/50

local function lerp(a,b,t) return a * (1-t) + b * t end

local function ChangeSky()
	local sky = l.Sky
	local t = game.Workspace.Terrain
	local skytextures = {"91458024","91457980","91458024","91458024","91458024","91458002"}
	local stars = 5000
	if skymultiply <= 0 then
		skytextures = {"15026376861","15026376861","15026376861","15026376861","15026376861","15026376861"} --[[15017909846]]
		stars = 0
	end
	
	sky.SkyboxBk = "rbxassetid://"..skytextures[1]
	sky.SkyboxDn = "rbxassetid://"..skytextures[2]
	sky.SkyboxFt = "rbxassetid://"..skytextures[3]
	sky.SkyboxLf = "rbxassetid://"..skytextures[4]
	sky.SkyboxRt = "rbxassetid://"..skytextures[5]
	sky.SkyboxUp = "rbxassetid://"..skytextures[6]
	sky.StarCount = stars
	
	l.Brightness = 6*skymultiply
	
	t.Clouds.Enabled = (skymultiply>0)
end
ChangeSky()

local savedskymultiply = 0
while wait() do
	if base.Camera then
		height = base.Camera.CFrame.Position.Y
		skymultiply = (math.clamp(height,130,180)-130)/50
		if savedskymultiply ~= skymultiply then
			savedskymultiply = skymultiply
			ChangeSky()
		end
	end
end