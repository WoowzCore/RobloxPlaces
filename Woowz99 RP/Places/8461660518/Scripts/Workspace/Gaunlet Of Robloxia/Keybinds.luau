local tool = script.Parent
local Human = tool.Parent
local Player = game.Players.LocalPlayer
local mouse = Player:GetMouse()
local candamage = true

game:GetService("UserInputService").InputBegan:connect(function(input,IsTyping)
	if input.KeyCode == Enum.KeyCode.Q and IsTyping == false then
		script.Parent.Handle.Snap:Play()
		script.Parent.SnapEvent:FireServer()
	end 
end)

game:GetService("UserInputService").InputBegan:connect(function(input1,IsTyping)
	if input1.KeyCode == Enum.KeyCode.E and IsTyping == false then
		script.Parent.Handle.Use:Play()
		Player.Character.HumanoidRootPart.CFrame = CFrame.new(mouse.Hit.p)
		script.Parent.TP:FireServer()
	end 
end)

game:GetService("UserInputService").InputBegan:connect(function(input2,IsTyping)
	if input2.KeyCode == Enum.KeyCode.F and IsTyping == false then
		script.Parent.Handle.Use:Play()
		local mousehit2 = mouse.Target
		script.Parent.Real:FireServer(mousehit2)
	end 
end)

tool.Activated:Connect(function(click)
	if candamage == true then
		script.Parent.Handle.Use:Play()
		local mousehit = mouse.Hit
		script.Parent.RemoteEvent:FireServer(mousehit)
		candamage = false
		wait(0.5)
		candamage = true
	end
end)
game:GetService("UserInputService").InputBegan:connect(function(input1,IsTyping)
	if input1.KeyCode == Enum.KeyCode.Z and IsTyping == false then
		script.Parent.Handle.Use:Play()
		local Mousehit = mouse.Target
		script.Parent.SingleSnapEvent:FireServer(Mousehit.Parent)
	end 
end)
game:GetService("UserInputService").InputBegan:connect(function(input1, IsTyping)
	if input1.KeyCode == Enum.KeyCode.T and IsTyping == false then
		script.Parent.Handle.Use:Play()
		local tar = mouse.Target
		script.Parent.Time:FireServer(tar)
	end 
end)
game:GetService("UserInputService").InputBegan:connect(function(input1,IsTyping)
	if input1.KeyCode == Enum.KeyCode.X and IsTyping == false then
		script.Parent.Handle.Use:Play()
		local Mousehit = mouse.Target
		script.Parent.Meteor:FireServer(Mousehit)
	end 
end)
tool.Equipped:Connect(function(equip)
	script.Parent.Handle.Equip:Play()
	script.Parent.BuffEvent:FireServer()
end)

tool.Unequipped:Connect(function(equip)
	script.Parent.BuffOffEvent:FireServer()
end)

