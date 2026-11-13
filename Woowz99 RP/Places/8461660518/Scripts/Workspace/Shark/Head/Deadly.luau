local Debris = game:GetService("Debris")
local MyHumanoid = script.Parent.Parent:WaitForChild("Humanoid")

local function TagHumanoid(humanoid, player)
	local Creator_Tag = Instance.new("ObjectValue")
	Creator_Tag.Name = "creator"
	Creator_Tag.Value = player
	Debris:AddItem(Creator_Tag, 2)
	Creator_Tag.Parent = humanoid
end

local function OnTouched(hit)
	local human = hit.Parent:FindFirstChildOfClass("Humanoid")
	if human and human.Health > 0 and human.Parent.Name ~= script.Parent.Parent.Name and human.Parent ~= script.Parent.Parent then
		human:TakeDamage(20)
		TagHumanoid(human, MyHumanoid)
	end
end


script.Parent.Touched:Connect(OnTouched)
