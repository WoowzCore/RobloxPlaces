local damage = 0.5
local function onTouch(hit)
	local human = hit.Parent:findFirstChild("Humanoid")
	if(human ~= nil) then
		human.Health = human.Health - damage
	end
end

script.Parent.Touched:Connect(onTouch)