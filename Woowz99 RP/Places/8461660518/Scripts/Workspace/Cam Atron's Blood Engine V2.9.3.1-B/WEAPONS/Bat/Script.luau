-- ello 
local cd = 3 -- cooldown 
local equipped = false
local combo = 0 
local deb = false
local renderresr = game:GetService("RunService")
local BaseDamage = 10
local RaycastHitbox = require(game:GetService("ReplicatedStorage").RaycastHitboxV3
)
local canuneq = true
local Hitbox 
local emt

script.Parent.Equipped:Connect(function()
	equipped = true
	local tool = script.Parent
	Hitbox = RaycastHitbox:Initialize(tool, {script.Parent.Parent})
	Hitbox:DebugMode(true)
	Hitbox.OnHit:Connect(blow)
end)

script.Parent.Unequipped:Connect(function()
	equipped = false
	Hitbox:HitStop()
end)


function COMBO1()
	local exampkle=script.Parent.Parent.Humanoid:LoadAnimation(script.Parent.Handle.Animation)
	exampkle:Play()
end

function COMBO2()
	local exampkle2=script.Parent.Parent.Humanoid:LoadAnimation(script.Parent.Handle.Animation2)
	exampkle2:Play()
end

function COMBO3()
	local exampkle3=script.Parent.Parent.Humanoid:LoadAnimation(script.Parent.Handle.Animation3)
	exampkle3:Play()
end

function blow(Hit)
	if Hit.Parent:FindFirstChild("Humanoid") ~= nil then
		Hit.Parent.Humanoid:TakeDamage(20)
	end
end





script.Parent.Activated:Connect(function()
	if not deb then
		deb = true
		script.Parent.Parent.Humanoid.WalkSpeed = 12
		Hitbox:HitStart()
		script.Parent.Handle.Trail.Enabled = true
		script.Parent.Blade.Clicked.Value = true
		if combo == 0 then
			combo += 2
			COMBO1()
		elseif combo == 2 then
			combo += 1
			COMBO2()
		elseif combo == 3 then
			COMBO3()
			wait(.1)
			combo = 0
		end
		print(combo)
		canuneq = false
		wait(1.3)
		script.Parent.Parent.Humanoid.WalkSpeed = 16
		Hitbox:HitStop()
		script.Parent.Blade.Clicked.Value = false
		wait(cd)
		wait(.1)
		deb = false
	end
end)


