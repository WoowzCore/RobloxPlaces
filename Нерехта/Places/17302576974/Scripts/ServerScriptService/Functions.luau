local RS = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")

function MovePart(Part,Velocity,Angle)
	Part.AssemblyLinearVelocity = Velocity
	if Angle~=nil then
		Part.AssemblyAngularVelocity = Angle
	end
end
RS.MovePart.OnServerEvent:Connect(function(plr,p,v,a) MovePart(p,v,a) end)

function ChangeCFrame(Part, NewCFrame)
	if Part:IsA("BasePart") then
		Part.CFrame = NewCFrame
	elseif Part:IsA("Model") or Part:IsA("Folder") then
		local parts = Part:GetDescendants()
		local center = nil
		for _, p in pairs(parts) do
			if p:IsA("BasePart") then
				if center == nil then
					center = p.Position
				end
				p.CFrame = CFrame.new(NewCFrame.Position + (p.Position - center))
			end
		end
	end
end
RS.ChangeCFrame.OnServerEvent:Connect(function(plr,p,c) ChangeCFrame(p,c) end)

function ChangeParent(Part,NewParent)
	Part.Parent = NewParent
end
RS.ChangeParent.OnServerEvent:Connect(function(plr,p,pp) ChangeParent(p,pp) end)

function SetNetworkOwner(Player, Prop)
	Prop:SetNetworkOwner(Player)
end
RS.SetNetworkOwner.OnServerEvent:connect(SetNetworkOwner)

function CheckBodyPositionAndGyro(Part)
	local result = false
	for _, plr in pairs(Players:GetPlayers()) do
		if RS.CheckBodyPositionAndGyroClient:InvokeClient(plr,Part) then
			result = true
		end
	end
	return result
end
RS.CheckBodyPositionAndGyro.OnServerInvoke = function(plr,part) return CheckBodyPositionAndGyro(part) end