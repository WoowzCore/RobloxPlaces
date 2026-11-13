local base = {}

base.Player = nil
base.Character = nil
base.Humanoid = nil

function base.Load(plr)
	base.Player = plr
	base.Character = plr.Character or plr.CharacterAdded:Wait()
	base.Humanoid = base.Character:WaitForChild("Humanoid")
end

base.Running = false

return base
