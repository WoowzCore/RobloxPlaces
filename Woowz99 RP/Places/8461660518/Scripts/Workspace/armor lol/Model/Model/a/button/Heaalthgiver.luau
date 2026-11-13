-- ello made by aetehel!11

script.Parent.Touched:Connect(function(hit)
	if hit.Parent:findFirstChild("Humanoid") ~= nil and hit.Parent:findFirstChild("Chest") == nil then
		hit.Parent.GoreH.Health.Value += 50
		hit.Parent.GoreLA.Health.Value += 50
		hit.Parent.GoreLL.Health.Value += 50
		hit.Parent.GoreRA.Health.Value += 50
		hit.Parent.GoreRL.Health.Value += 50
	end	
end)