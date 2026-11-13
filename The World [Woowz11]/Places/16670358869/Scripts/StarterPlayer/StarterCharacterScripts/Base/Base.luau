local base = {}

base.Player = nil
base.Character = nil
base.Humanoid = nil
base.Config = nil

function base.SetRobloxCore(gui, CoreProperty, Toggle)
	repeat
		local success = pcall(function()
			if not gui then
				game.StarterGui:SetCore(CoreProperty, Toggle)
			else
				game.StarterGui:SetCoreGuiEnabled(CoreProperty, Toggle)
			end
		end)
		wait(0.02)
	until
	success
end;

return base
