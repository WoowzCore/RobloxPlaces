local TweenService = game:GetService("TweenService")
local arm = nil
local savepos = nil
local work = false
local tool = script.Parent
local EBL = require(game:GetService("ServerScriptService").EBLibbary)
local lastplayer = nil

script.Parent.Activated:Connect(function()
	if not work then		
		arm = script.Parent.Parent:WaitForChild("Torso"):WaitForChild("Right Shoulder")
		
		work = true
		tool.Handle.CanTouch = true
		local t1 = game:GetService("TweenService"):Create(arm, TweenInfo.new(0.1), {C1 = CFrame.new(savepos.Position.X,savepos.Position.Y+1,savepos.Position.Z) * savepos.Rotation})
		t1:Play()
		t1.Completed:Wait()
		local t2 = game:GetService("TweenService"):Create(arm, TweenInfo.new(0.1), {C1 = savepos})
		t2:Play()
		t2.Completed:Wait()
		tool.Handle.CanTouch = false
		work = false
	end
end)

tool.Equipped:Connect(function()
	if lastplayer ~= game.Players:GetPlayerFromCharacter(script.Parent.Parent).UserId then
		lastplayer = game.Players:GetPlayerFromCharacter(script.Parent.Parent).UserId
		savepos = script.Parent.Parent:WaitForChild("Torso"):WaitForChild("Right Shoulder").C1
	end
end)

tool.Unequipped:Connect(function()
	if arm then
		arm.C1 = savepos
	end
end)

if tool:FindFirstChild("Handle") then
	tool.Handle.Touched:Connect(function(p)
		if p and tool.Parent ~= workspace and work then
			EBL.DetectHurt(p,10,"Sharp")
		end
	end)
end