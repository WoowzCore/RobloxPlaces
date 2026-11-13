local RS = game:GetService("ReplicatedStorage")
local DropTool_RS = RS.DropTool

function FindTool(character,arm)
	if character ~= nil then
		if arm == "Right" then
			for _, tool in pairs(character:GetChildren()) do
				if tool:IsA("Tool") then
					return tool
				end
			end
		end
	end
end

function ChangeTool(player,tool,arm)
	local Character = player.Character
	if not Character or not Character.Parent then
		Character = player.CharacterAdded:Wait()
	end
	
	if arm == "Right" then
		if tool ~= nil then
			local tol = FindTool(Character,"Right")
			if tol ~= nil then
				tol.Parent = player.Backpack
			end
			tool.Parent = Character
		else
			local tol = FindTool(Character,"Right")
			if tol ~= nil then
				tol.Parent = player.Backpack
			end
		end
	end
end

function DropTool(player,tool)
	if tool ~= nil then
		local Character = player.Character
		if not Character or not Character.Parent then
			Character = player.CharacterAdded:Wait()
		end
		local ToolInBackpack = false
		if tool.Parent.Name == "Backpack" then
			ToolInBackpack = true
		end
		local HumRootPart = Character:WaitForChild("HumanoidRootPart")
		local PlayerPosition = HumRootPart.Position
		tool.Getted.Value = false
		tool.Inventory_ID.Value = ""
		local NewTool = tool:Clone()
		NewTool.Parent = workspace

		if ToolInBackpack then
			NewTool.Handle.CFrame = HumRootPart.CFrame
		end	

		tool:Destroy()
	end
end

DropTool_RS.OnServerEvent:Connect(DropTool)
RS.ChangeTool.OnServerEvent:Connect(ChangeTool)