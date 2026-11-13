local held = false
local plr = game.Players.LocalPlayer
script.Parent.Equipped:Connect(function()
	chr = script.Parent.Parent
end)

script.Parent.Activated:Connect(function ()
	held = true
if script.Parent.Enabled == true then
	script.Parent.Enabled = false
	
	
	while held == true do
	if script.Parent.EDIT.BurstShots.Value >= 2 then
	for i = 1, script.Parent.EDIT.BurstShots.Value do
	script.Parent.Shoot:FireServer(chr.Humanoid.TargetPoint)
	fire:Play()
	wait(script.Parent.EDIT.BurstRate.Value)
	
    
	end
	else
	fire:Play()
	script.Parent.Shoot:FireServer(chr.Humanoid.TargetPoint)
	end
	if script.Parent.EDIT.Auto.Value == false then
		held = false
	end
	wait(script.Parent.EDIT.Firerate.Value + .1)
	end
	if script.Parent.EDIT.Auto.Value == false then
		wait(script.Parent.EDIT.Firerate.Value + .1)
	end
	script.Parent.Enabled = true
end
end)

script.Parent.Deactivated:Connect(function()
	held = false
	
end)
script.Parent.Equipped:Connect(function()
	wait()
	holdanim = chr.Humanoid:LoadAnimation(script.Parent.HoldAnim)
	holdanim:Play()
	rel = chr.Humanoid:LoadAnimation(script.Parent.ReloadAnim)
	fire = chr.Humanoid:LoadAnimation(script.Parent.FireAnim)
end)
script.Parent.Unequipped:Connect(function()
	held = false
	holdanim:Stop()
	fire:Stop()
	rel:Stop()
end)
game.Players.LocalPlayer:GetMouse().KeyDown:connect(function(KeyPressed)
	if KeyPressed == "r" and script.Parent.Parent == plr.Character then 
		script.Parent.Reload:FireServer()
		
		rel:Play()
	end
end)

--imagiraff1234