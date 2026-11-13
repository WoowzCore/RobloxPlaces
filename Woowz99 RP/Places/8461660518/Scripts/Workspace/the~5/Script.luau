local tool = script.Parent
tool.Bounce.OnServerEvent:Connect(function(player, event)
	print(player)
local mouse = player:GetMouse()
	local ball = tool.Handle
	tool.Parent = workspace
	ball.CFrame = tool.Handle.CFrame
		ball.CFrame = CFrame.new(ball.Position, event)
		
		local BV = Instance.new("BodyVelocity", ball);
		BV.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
		BV.Velocity = ball.CFrame.lookVector * 50 -- how fast it throws
		wait(.1)
		tool.Handle.BodyVelocity:Destroy()
end)