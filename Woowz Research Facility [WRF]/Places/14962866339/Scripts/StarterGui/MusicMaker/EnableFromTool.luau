local gui = script.Parent
local plr = game:GetService("Players").LocalPlayer
local chr = plr.Character or plr.CharacterAdded:Wait()
local base = require(chr:WaitForChild("PlayerBase"))

local toolname = gui.ToolName.Value

while wait() do
	local result = (base.ToolName == toolname and not base.Died and not base.AttackMode and base.ThrowPower <= 0 and not base.Data.Camera.FirstPerson)
	if base.VisibleGUI == false then
		result = false
	end
	base.VisibleGUI_DisableGameGui = result
	gui.Enabled = result
end