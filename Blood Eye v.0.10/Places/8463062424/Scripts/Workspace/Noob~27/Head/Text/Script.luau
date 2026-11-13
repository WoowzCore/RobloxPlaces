while true do
wait(0.3)
	script.Parent.HealthFront.Size = UDim2.new(script.Parent.Parent.Parent.Humanoid.Health / script.Parent.Parent.Parent.Humanoid.MaxHealth,0,0.25,0)
end
