local tool = script.Parent
local plrsdatas = require(game:GetService("ServerStorage").PLAYERSDATA)
local enabled = false

local randcolor = {
	Color3.fromRGB(255,0,0),Color3.fromRGB(0,255,0),Color3.fromRGB(0,0,255),Color3.fromRGB(255,0,255),Color3.fromRGB(255,255,0)
}
local color = randcolor[math.random(1,#randcolor)]
tool.laserSTART.Color = color
tool.laserSTART.Beam.Color = ColorSequence.new(color,color)
tool.laserEND.Color = color

local waiting = false
local function setenabled(bool,ignorewait)
	if ignorewait == nil then ignorewait = false end
	if enabled == bool then return end
	if waiting and not ignorewait then return end
	waiting = true
	enabled = bool
	tool.EnabledTool.Value = enabled
	if enabled then
		tool.laserSTART.Material = Enum.Material.Neon
		tool.laserSTART.Beam.Enabled = true
		tool.laserEND.Transparency = 0
	else
		tool.laserSTART.Material = Enum.Material.Glass
		tool.laserSTART.Beam.Enabled = false
		tool.laserEND.Transparency = 1
	end
	tool.Handle.Sound:Play()
	if not ignorewait then wait(0.5) end
	waiting = false
end

tool.Use.Event:Connect(function()
	setenabled(not enabled)
end)

local backpack = nil
tool.RayFromTool.RayFromToolRE.OnServerEvent:Connect(function(plr,pos,hit,cframe)
	tool.laserEND.CFrame = pos
end)

while wait() do
	if tool.Parent:FindFirstChildOfClass("Humanoid") ~= backpack then
		backpack = tool.Parent:FindFirstChildOfClass("Humanoid")
		if backpack == nil then
			setenabled(false,true)
		end
	end
end