local GetTool = script
local Part = script.Parent
local GetToolDetect = Part.GetToolDetect
local Tool = nil
local Getted = false

if Part.Parent:IsA("Tool") then
	Tool = Part.Parent
else
	if Part.Parent.Parent:IsA("Tool") then
		Tool = Part.Parent.Parent
	else
		if Part.Parent.Parent.Parent:IsA("Tool") then
			Tool = Part.Parent.Parent.Parent
		else
			if Part.Parent.Parent.Parent.Parent:IsA("Tool") then
				Tool = Part.Parent.Parent.Parent.Parent
			else
				if Part.Parent.Parent.Parent.Parent.Parent:IsA("Tool") then
					Tool = Part.Parent.Parent.Parent.Parent.Parent
				else
					if Part.Parent.Parent.Parent.Parent.Parent.Parent:IsA("Tool") then
						Tool = Part.Parent.Parent.Parent.Parent.Parent.Parent
					else
						if Part.Parent.Parent.Parent.Parent.Parent.Parent.Parent:IsA("Tool") then
							Tool = Part.Parent.Parent.Parent.Parent.Parent.Parent.Parent
						else
							if Part.Parent.Parent.Parent.Parent.Parent.Parent.Parent.Parent:IsA("Tool") then
								Tool = Part.Parent.Parent.Parent.Parent.Parent.Parent.Parent.Parent
							else
								if Part.Parent.Parent.Parent.Parent.Parent.Parent.Parent.Parent.Parent:IsA("Tool") then
									Tool = Part.Parent.Parent.Parent.Parent.Parent.Parent.Parent.Parent.Parent
								else
									if Part.Parent.Parent.Parent.Parent.Parent.Parent.Parent.Parent.Parent.Parent:IsA("Tool") then
										Tool = Part.Parent.Parent.Parent.Parent.Parent.Parent.Parent.Parent.Parent.Parent
									else
										Tool = nil
										error("Can't find tool!!!")
									end
								end
							end
						end
					end
				end
			end
		end
	end
end

local Inv_Id = Tool.Inventory_ID
Getted = Tool.Getted.Value

if Getted then
	GetToolDetect.MaxActivationDistance = 0
	Part.CanCollide = false
	Part.CanQuery = false
	Part.CanTouch = false
else
	GetToolDetect.MaxActivationDistance = workspace.ForScripts.Values.GetToolDetectDistance.Value
	Part.CanCollide = true
	Part.CanQuery = true
	Part.CanTouch = true
end

function GetToolFunction(pl)
	if not Getted then
		local backpack = pl.Backpack
		Tool.Getted.Value = true
		
		local PlayerGui = pl:WaitForChild("PlayerGui")
		local Player_Inventory = PlayerGui:WaitForChild("Inventory")

		local NewTool = Tool:Clone()
		NewTool.Parent = backpack
		game.ReplicatedStorage.GetTool:FireClient(pl,NewTool)
		Tool:Destroy()
	end
end

GetToolDetect.MouseClick:Connect(GetToolFunction)