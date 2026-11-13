local mouse = game.Players.LocalPlayer:GetMouse()


script.Parent.Activated:Connect(function()
	if(mouse.Target) then
		local model = mouse.Target.Parent

		if(model and model:FindFirstChild("Humanoid") and model.Name ~= game.Players.LocalPlayer.Name) then
			script.Parent.Push:FireServer(model)
		end
	end
end)
