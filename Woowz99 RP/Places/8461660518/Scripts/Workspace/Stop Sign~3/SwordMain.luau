--scripted by Platformation123
local tool = script.Parent
local handle = tool:FindFirstChild("Handle")
local hit = tool:FindFirstChild("HitDetect")
local animations = {}
local animFolder = tool.Animations

local function onTouch(partother)
	local humanother = partother.Parent:FindFirstChild("Humanoid")
	if not humanother then return end
	if humanother.Parent == tool then return end
	humanother:TakeDamage(5)
	hit.SmackSound.PlaybackSpeed = math.random(95, 105)/100
	hit.SmackSound:Play()
	hit.Hit:Emit(5)
end

local function slash()
	SwingAnim = humanoid:LoadAnimation(animSet.OverHeadSwing)
	if SwingAnim then SwingAnim:Play() end
	SwingAnim:AdjustSpeed(1.5)
	handle.SlashSound.PlaybackSpeed = math.random(95, 105)/100
	handle.SlashSound:Play()
end

local function equip()
	character = tool.Parent
	humanoid = character:FindFirstChild("Humanoid")
	player = game.Players:GetPlayerFromCharacter(character)
	animSet = animFolder:FindFirstChild(humanoid.RigType)
	anims = {animSet.Hold,animSet.OverHeadSwing}
	humanoid.WalkSpeed = humanoid.WalkSpeed + 15
	humanoid.JumpPower = humanoid.JumpPower + 15
	handle.Song:Play()
	HoldAnim = humanoid:LoadAnimation(animSet.Hold)
	if HoldAnim then HoldAnim:Play() end
end

function unequip()
	if SwingAnim then SwingAnim:Stop() end
	if HoldAnim then HoldAnim:Stop() end
	handle.Song:Stop()
	humanoid.WalkSpeed = humanoid.WalkSpeed - 15
	humanoid.JumpPower = humanoid.JumpPower - 15
end

tool.Equipped:Connect(equip)
tool.Unequipped:Connect(unequip)
tool.Activated:Connect(slash)
tool.HitDetect.Touched:Connect(onTouch)