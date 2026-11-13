local plr = game:GetService("Players").LocalPlayer
local chr = plr.Character or plr.CharacterAdded:Wait()
local base = require(chr:WaitForChild("PlayerBase"))

wait()
local tool = script.Parent.Parent
local mouse = game.Players.LocalPlayer:GetMouse()

local rayparams = RaycastParams.new()
rayparams.FilterType = Enum.RaycastFilterType.Exclude
rayparams.IgnoreWater = true
local ignoreglass = false
if script.Parent.Parent:FindFirstChild("RayIgnoreGlass") then
	ignoreglass = script.Parent.Parent:FindFirstChild("RayIgnoreGlass").Value
end

local rayobj = tool.RayObject.Value
local raymouse = false

local function UpdateIgnore()
	local ignore = {}
	for _, p in pairs(tool:GetDescendants()) do
		table.insert(ignore,p)
	end
	for _, p in pairs(tool.Parent:GetDescendants()) do
		table.insert(ignore,p)
	end
	for _, p in pairs(workspace:GetDescendants()) do
		if p:IsA("BasePart") or p:IsA("UnionOperation") then
			local result = false
			
			if p.Transparency == 1 then
				result = true
			end
			
			if (p.Material == Enum.Material.Glass or p.Material == Enum.Material.ForceField) and p.Transparency > 0.01 and ignoreglass then
				result = true
			end
			
			if result then
				table.insert(ignore,p)
			end
		end
	end
	
	rayparams.FilterDescendantsInstances = ignore
end

tool.Equipped:Connect(function()
	UpdateIgnore()
end)

game:GetService("RunService").RenderStepped:Connect(function(dt)
	if tool.Parent:FindFirstChildOfClass("Humanoid") then
		if tool:FindFirstChild("EnabledTool") then
			if tool.EnabledTool.Value == false then return end
		end
		if rayobj == nil then return end
		local rayobjwc = rayobj
		if tool.RayObject.Value:IsA("Attachment") then
			rayobjwc = rayobj.WorldCFrame
		else
			rayobjwc = rayobjwc.CFrame
		end
		if raymouse and base.Data.Camera.FirstPerson and tool.Parent:FindFirstChild("Torso"):FindFirstChild("Right Shoulder").Enabled then
			local rotresult = CFrame.new(rayobj.Position,mouse.Hit.Position)
			rotresult = rotresult:ToWorldSpace(CFrame.Angles(0,0,0))
			script.Parent.RayFromToolRE:FireServer(mouse.Hit,mouse.Target,rayobjwc,rotresult)
		else
			local result1,result2 = rayobj.Position,-rayobj.CFrame.RightVector*1000
			local ray = workspace:Raycast(result1,result2,rayparams)
			local result = CFrame.new(result2)
			local result_instance = nil
			if ray then
				result = CFrame.new(ray.Position)
				result_instance = ray.Instance
			end
			script.Parent.RayFromToolRE:FireServer(result,result_instance,rayobjwc)
		end
	end
end)