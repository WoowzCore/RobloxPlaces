wait()--omg i swear if this gets leaked i will never make something for someone else again
local Player = game.Players.LocalPlayer
local Car = script.Parent.Car.Value
local GamepadService = game:GetService("UserInputService")
local FE = workspace.FilteringEnabled

GamepadService.InputBegan:connect(function(Key,hi)
	if (Key.KeyCode == Enum.KeyCode.F or Key.KeyCode == Enum.KeyCode.DPadDown) and hi == false then
		if script.Parent.IsOn.Value == false and script.Parent.Values.Brake.Value == 1 then
			Car.DriveSeat.EngineStart:Play()
			if Car.Electrics.Value == false then
				Car.DriveSeat.Chime:Play()
			end
			script.Parent.IsOn.Value = true
			Car.engine:FireServer(true)
		elseif script.Parent.IsOn.Value == false and script.Parent.Values.Brake.Value == 0 and Car.Electrics.Value == false then
			Car.engine:FireServer(true)
			Car.DriveSeat.Chime:Play()
		elseif script.Parent.IsOn.Value == false and script.Parent.Values.Brake.Value == 0 and Car.Electrics.Value == true then
			Car.engine:FireServer(false)
		elseif script.Parent.IsOn.Value == true and script.Parent.Values.Brake.Value == 1 then
			script.Parent.IsOn.Value = false
			Car.DriveSeat.EngineStart:Stop()
			Car.DriveSeat.EngineKill:Play()
		elseif script.Parent.IsOn.Value == true then
			script.Parent.IsOn.Value = false
			Car.DriveSeat.EngineKill:Play()
			Car.engine:FireServer(false)
		end
	end
end)