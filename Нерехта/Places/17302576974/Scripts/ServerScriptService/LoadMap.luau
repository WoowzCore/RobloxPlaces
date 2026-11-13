local woowzphysic = script.WoowzPhysic
local map = workspace["--Map--"]

function GetItemParent(parent)
	local CheckParent = function(p)
		if p == nil then return true end
		if p == workspace then return true end

		return p.Name == "--Map--"
	end

	for i=0,10 do
		if CheckParent(parent.Parent) then
			if parent.Parent == workspace then
				return nil
			end
			break
		else
			parent = parent.Parent
		end
	end
	return parent
end

function SetPhyisc(part)
	if part:IsA("BasePart") then
		if not part:FindFirstChild("WoowzPhysic") then
			local partparent = GetItemParent(part)
			
			if partparent~=nil then
				local pp = partparent.Parent
				if pp ~= nil then
					if pp.Name == "--Map--" then
						local trigger = Instance.new("Part")
						trigger.Size = part.Size + Vector3.one*0.1
						trigger.CastShadow = false
						trigger.Massless = true
						trigger.CanCollide = false
						trigger.CFrame = part.CFrame
						trigger.Parent = workspace
						trigger.Touched:Connect(function()end)
			
						for _, p in pairs(trigger:GetTouchingParts()) do
							if p~=part and p~=trigger and GetItemParent(p)==partparent then
								local stop = false
								for _2, p2 in pairs(p:GetJoints()) do
									if p2.Name ~= "WoowzJoint" then
										stop = true
									end
								end
							
								if not stop then
									local weld = Instance.new("WeldConstraint")
									weld.Name = "WoowzJoint"
									weld.Parent = part
									weld.Part0 = part
									weld.Part1 = p
								end
							end
						end
			
						trigger:Destroy()
						local wp = woowzphysic:Clone()
						wp.Parent = part
						wp.Enabled = true
					end
				end
			end
		end
	end
end

for _, part in pairs(map:GetDescendants()) do
	SetPhyisc(part)
end

map.ChildAdded:Connect(function(part)
	SetPhyisc(part)
end)
