local mine = script.Parent
local pressed = false

local rayOrigin = mine.Position
local rayDirection = Vector3.new(0, -100, 0)
local raycastResult = workspace:Raycast(rayOrigin, rayDirection)

if raycastResult then
	mine.Color = raycastResult.Instance.Color
	mine.Material = raycastResult.Instance.Material
end

local boomsound = Instance.new("Sound")
boomsound.Name = "BoomSound"
boomsound.SoundId = "rbxassetid://2648568095"
boomsound.Parent = mine
boomsound.Volume = 1
boomsound.EmitterSize = 2
boomsound.PlayOnRemove = true

local mineactivate = Instance.new("Sound")
mineactivate.Name = "BoomSound"
mineactivate.SoundId = "rbxassetid://6319076116"
mineactivate.Parent = mine
mineactivate.Volume = 1
mineactivate.EmitterSize = 2
mineactivate.PlayOnRemove = true
mineactivate.TimePosition = 1
function onTouched(hit)
	if hit.Parent and hit.Parent:FindFirstChild("Humanoid") and not pressed then
		pressed = true
		mineactivate:Play()
		local rand = math.random(0,15)/15
		wait(rand)
		local explosion = Instance.new("Explosion")
		explosion.BlastRadius = 20
		explosion.BlastPressure = 4500
		explosion.DestroyJointRadiusPercent = 0.8
		explosion.ExplosionType = Enum.ExplosionType.Craters
		explosion.Position = mine.Position
		explosion.Parent = mine
		boomsound:Play()
		wait(2)
		mine:Destroy()
	end
end

mine.Touched:connect(onTouched)