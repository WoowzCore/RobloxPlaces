local base = {}

base.Player = game:GetService("Players").LocalPlayer
base.Character = nil
base.Humanoid = nil
base.Gui = base.Player.PlayerGui.GUI
base.PlayerScripts = base.Player.PlayerScripts.SPS
base.SaveData = require(base.PlayerScripts:WaitForChild("SaveData"))

function base.UpdateCharacter()
	base.Character = base.Player.Character or base.Player.CharacterAdded:Wait()
	base.Humanoid = base.Character:WaitForChild("Humanoid")
end

return base
