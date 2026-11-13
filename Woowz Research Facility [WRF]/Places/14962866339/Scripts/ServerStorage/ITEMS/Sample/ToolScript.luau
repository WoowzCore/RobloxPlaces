local tool = script.Parent
local base = require(game:GetService("ServerScriptService").Base)
local rs = game:GetService("ReplicatedStorage")
local plrs = game:GetService("Players")

local data = require(game:GetService("ServerStorage").PLAYERSDATA).Data

local handle = tool.Handle

local InArm = false

tool.Activated:Connect(function()
	if tool:FindFirstChild("Use") then
		local plr = script:FindFirstAncestorWhichIsA("Player") or plrs:GetPlayerFromCharacter(script.Parent.Parent)
		
		local d = data[tostring(plr.UserId)]
		local firearm = (tool:FindFirstChild("Firearm") ~= nil or tool:FindFirstChild("UseOnlyAttackMode") ~= nil)
		local use = true
		
		if firearm and not d.AttackMode then
			use = false
		end
		if not firearm and d.AttackMode then
			use = false
		end
		
		local cuir = tool:FindFirstChild("CanUseInRagdoll")
		if not cuir then
			if d.Ragdoll or d.MovingData.Crawl then
				use = false
			end
		end
		
		if use then
			tool:FindFirstChild("Use"):Fire(plr)
		end
	end
end)

handle.ClickDetector.ClickDetectorScript.Event.Event:Connect(function(plr)
	if InArm then return end
	if script.CantTake.Value then return end
	
	local d = data[tostring(plr.UserId)]
	if d.CanTakeItem_TimeOut then return end
	
	if d.Died or d.Ragdoll or d.Tool or (d.PartsDead.RightArm and d.PartsDead.LeftArm) or d.AttackMode then return end
	
	rs.SetPlayerDataValue:InvokeClient(plr,"CanTakeItem_TimeOut",true)
	base.PlaySound(444895479,tool.Handle.Position,math.random(5,10)/10,10,math.random(90,110)/100)
	base.GetItem(tool,plr)
	
	for _, part in pairs(tool:GetDescendants()) do
		if part:IsA("Highlight") then
			part:Destroy()
		end
	end
end)

while wait() do
	InArm = (tool.Parent.Name == "Backpack" or (tool.Parent:FindFirstChildOfClass("Humanoid")))
	if handle:FindFirstChild("MouseOver") then
		handle:FindFirstChild("MouseOver").Value = not InArm
	end
end