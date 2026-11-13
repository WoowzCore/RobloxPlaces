local d = {}

d.Player = nil
d.Character = nil
d.Humanoid = nil
d.Script = nil
d.Camera = nil

d.Keys = {}

d.HasFloor = false
d.Walk = false
d.WalkBackward = false

d.WalkStatus = {
	Walking = false,
	Running = false,
	Slow = false,
	Crawl = false,
	Lay = false
}

d.LerpValues = {
	WalkSpeed = 0.1
}

d.WalkSpeedValues = {
	Default = 10,
	Run = 25,
	Slow = 5,
	Crawl = 3,
	Lay = 1
}
d.WalkSpeed = d.WalkSpeedValues.Default

d.JumpPowerValues = {
	Default = 15
}
d.JumpPower = d.JumpPowerValues.Default

d.SensivityValues = {
	Default = 0.3,
	Lay = 0.1,
}
d.Sensivity = d.SensivityValues.Default

d.Install = function()
	d.Player = script.Parent.Parent
	d.Script = script.Parent.PlayerScript
	d.Character = d.Player.Character or d.Player.CharacterAdded:Wait()
	d.Humanoid = d.Character:WaitForChild("Humanoid")
	d.Camera = workspace.CurrentCamera
	d.Camera.CameraSubject = d.Character.Head.Eyes
	
	d.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Climbing,false)
	d.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Swimming,false)
	d.Humanoid:SetStateEnabled(Enum.HumanoidStateType.FallingDown,false)
	
	for _, locscr in pairs(game:GetService("StarterPlayer").StarterCharacterScripts:GetChildren()) do
		locscr:Clone().Parent = d.Character.LocalScripts
	end
end

return d
