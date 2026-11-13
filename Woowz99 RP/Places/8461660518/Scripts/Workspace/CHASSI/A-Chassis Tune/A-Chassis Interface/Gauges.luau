repeat wait() until script.Parent:FindFirstChild("Values")

script.Parent.Values.Velocity.Changed:Connect(function()
	script.GaugeFE:FireServer("Speed", ((math.floor(((10/12) * (60/88)) * script.Parent.Values.Velocity.Value.Magnitude))))
end)

script.Parent.Values.RPM.Changed:Connect(function()
	script.GaugeFE:FireServer("RPM", script.Parent.Values.RPM.Value)
end)

script.Parent.Values.TCS.Changed:Connect(function()
	script.GaugeFE:FireServer("TCS", script.Parent.Values.TCS.Value)
end)

script.Parent.Values.ABS.Changed:Connect(function()
	script.GaugeFE:FireServer("ABS", script.Parent.Values.ABS.Value)
end)

script.Parent.Values.PBrake.Changed:Connect(function()
	script.GaugeFE:FireServer("PBrake", script.Parent.Values.PBrake.Value)
end)

script.Parent.Values.TCSActive.Changed:Connect(function()
	script.GaugeFE:FireServer("TCSActive", script.Parent.Values.TCSActive.Value)
end)

script.Parent.Values.ABSActive.Changed:Connect(function()
	script.GaugeFE:FireServer("ABSActive", script.Parent.Values.ABSActive.Value)
end)


script.Parent.IsOn.Changed:Connect(function()
	script.GaugeFE:FireServer("On", script.Parent.IsOn.Value)
end)

script.Parent.Values.Gear.Changed:Connect(function()
	script.GaugeFE:FireServer("Gear", script.Parent.Values.Gear.Value)
end)
