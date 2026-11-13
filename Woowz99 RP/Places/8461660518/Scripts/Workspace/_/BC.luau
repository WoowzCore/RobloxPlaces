--// Made By Aetehel.

local NameYes="Humanoid"
local button = script.BloodClearPart

robo=script.Parent:clone()

local de = false
script.BloodClearPart.Touched:Connect(function()
	if not de then
		de = true
		
		for _,v in pairs(game.Workspace.ignore:GetChildren()) do
			if v.Name == "splat" then
				v:Destroy()
			end
		end
		
		wait(2)
		
		de = false
	end
end)


