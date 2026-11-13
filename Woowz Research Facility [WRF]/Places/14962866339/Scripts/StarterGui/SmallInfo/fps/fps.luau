local RunService = game:GetService("RunService")
local FpsLabel = script.Parent

local player = game:GetService("Players").LocalPlayer
local chr = player.Character or player.CharacterAdded:Wait()
local base = require(chr:WaitForChild("PlayerBase"))

local TimeFunction = RunService:IsRunning() and time or os.clock

local LastIteration, Start
local FrameUpdateTable = {}

local function HeartbeatUpdate()
	if not FpsLabel.Parent.Enabled then return end
	LastIteration = TimeFunction()
	for Index = #FrameUpdateTable, 1, -1 do
		FrameUpdateTable[Index + 1] = FrameUpdateTable[Index] >= LastIteration - 1 and FrameUpdateTable[Index] or nil
	end

	FrameUpdateTable[1] = LastIteration
	base.FPS = math.floor(TimeFunction() - Start >= 1 and #FrameUpdateTable or #FrameUpdateTable / (TimeFunction() - Start))
	FpsLabel.Text = tostring(base.FPS) .. " FPS"
end

Start = TimeFunction()
RunService.Heartbeat:Connect(HeartbeatUpdate)