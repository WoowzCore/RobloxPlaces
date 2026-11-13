script.Parent.casing.OnServerEvent:Connect(function()
	script.Parent.Parent.Handle.shoot:Play()
	script.Parent.Parent.Bolt.Transparency = 1
	script.Parent.Parent.BoltBack.Transparency = 0
	local casing = script.Parent.Parent.shell:Clone()
	script.Parent.Parent.Flash.Light.Enabled =true
	script.Parent.Parent.Flash.lite.Enabled =true
	casing.Parent = workspace
	casing.Transparency = 0
	casing:BreakJoints()
	casing.Position = script.Parent.Parent.shell.Position
	wait(0.08)
	script.Parent.Parent.Flash.Light.Enabled =false
	script.Parent.Parent.Flash.lite.Enabled =false
	script.Parent.Parent.Bolt.Transparency = 0
	script.Parent.Parent.BoltBack.Transparency = 1
	wait(2)
	casing:Destroy()
	end)