local Humanoid = script.Parent:WaitForChild("Humanoid")
local Debris = game:GetService("Debris")

local Connection
Connection = Humanoid.Died:Connect(function()
	if not Connection.Connected then
		return
	end

	Connection:Disconnect()
	Debris:AddItem(script.Parent, 4)
	for _, v in ipairs(script.Parent:FindFirstChild("Head"):GetChildren()) do
		if not v:IsA("BlockMesh") then
			v:Destroy()
		end
	end
end)