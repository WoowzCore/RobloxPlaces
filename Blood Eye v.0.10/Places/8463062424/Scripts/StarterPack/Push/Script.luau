script.Parent.Push.OnServerEvent:Connect(function(player, toPush)

	local playerRoot = player.Character:FindFirstChild("HumanoidRootPart")
	local pushRoot = toPush:FindFirstChild("HumanoidRootPart")


	if(playerRoot and not playerRoot:FindFirstChild("PushF") and pushRoot and not pushRoot:FindFirstChild("PushF") and (playerRoot.Position - pushRoot.Position).magnitude <= 10) then
		local pushF = Instance.new("BodyVelocity")
		pushF.Name = "PushF"
		pushF.MaxForce = Vector3.new(1000000, 1000000, 1000000)
		pushF.Velocity = (-pushRoot.CFrame.lookVector) * 110

		pushF.Parent = pushRoot

		wait(0.3) 

		pushF:Destroy()
		local Tool = script.Parent
		local Animation = Tool.Animation

		Tool.Activated:Connect(function()
			local Character = Tool.Parent
			local Humanoid = Character.Humanoid

			local AnimationTrack = Humanoid:LoadAnimation(Animation)
			AnimationTrack:Play()
			wait(0.01)
			script.Disabled = true
			wait(6)
			script.Disabled = false
		end)
	end
end)