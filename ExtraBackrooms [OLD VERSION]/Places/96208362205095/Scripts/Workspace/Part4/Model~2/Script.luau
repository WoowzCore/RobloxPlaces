local EBL = require(game:GetService("ServerScriptService"):WaitForChild("EBLibbary"))

local trigger = script.Parent.Trigger
local sound = trigger.Sound

local ldoor = script.Parent.L
local rdoor = script.Parent.R
local ldoor2 = script.Parent.L2
local rdoor2 = script.Parent.R2
local ldoor3 = script.Parent.L3
local rdoor3 = script.Parent.R3

local lpos = ldoor.Position
local rpos = rdoor.Position

local ts = game:GetService("TweenService")

local open_ = false

local tinfo = TweenInfo.new(
	2,
	Enum.EasingStyle.Sine,
	Enum.EasingDirection.Out,
	0,false,0
)

local function open()
	if open_ then return end
	local tL = ts:Create(ldoor, tinfo, {Position = ldoor3.Position})
	local tR = ts:Create(rdoor, tinfo, {Position = rdoor3.Position})
	local tL2 = ts:Create(ldoor2, tinfo, {Position = ldoor3.Position})
	local tR2 = ts:Create(rdoor2, tinfo, {Position = rdoor3.Position})
	tL:Play()
	tR:Play()
	tL2:Play()
	tR2:Play()
	open_ = true
	sound.PlaybackSpeed = math.random(90,110)/100
	sound:Play()
end

local function close()
	if open_ == false then return end
	local tL = ts:Create(ldoor, tinfo, {Position = lpos})
	local tR = ts:Create(rdoor, tinfo, {Position = rpos})
	local tL2 = ts:Create(ldoor2, tinfo, {Position = lpos})
	local tR2 = ts:Create(rdoor2, tinfo, {Position = rpos})
	tL:Play()
	tR:Play()
	tL2:Play()
	tR2:Play()
	open_ = false
	sound.PlaybackSpeed = math.random(90,110)/100
	sound:Play()
end

trigger.Touched:Connect(function(part)
	if part.Parent:FindFirstChildOfClass("Humanoid") then
		open()
	end
end)

trigger.TouchEnded:Connect(function(part)
	if part.Parent:FindFirstChildOfClass("Humanoid") then
		close()
	end
end)
