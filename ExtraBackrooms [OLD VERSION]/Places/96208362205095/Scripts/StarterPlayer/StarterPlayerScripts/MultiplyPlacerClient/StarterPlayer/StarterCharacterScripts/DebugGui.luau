local EBL = require(script.Parent:WaitForChild("EBLibbary"))
local plr = game.Players.LocalPlayer
local chr = plr.Character or plr.CharacterAdded:Wait()
local humrootpart = chr:WaitForChild("HumanoidRootPart")
local hum = chr:WaitForChild("Humanoid")
local debuggui = plr.PlayerGui:WaitForChild("Debug")

local h = debuggui.Health
local w = debuggui.Water
local s = debuggui.Stamina
local f = debuggui.Food
local m = debuggui.Mental
local o = debuggui.Oxygen

while wait() do
	if debuggui.Enabled then
		w.Text = "Water: "..tostring( math.round(EBL.GetStats("Water")*100)/100  )
		f.Text = "Food: "..tostring(math.round(EBL.GetStats("Food")*100)/100)
		s.Text = "Stamina: "..tostring(math.round(EBL.GetStats("Stamina")*100)/100)
		m.Text = "Mental: "..tostring(math.round(EBL.GetStats("Mental")*100)/100)
		o.Text = "Oxygen: "..tostring(math.round(EBL.GetStats("Oxygen")*100)/100)
		h.Text = "Health: "..tostring(math.round(EBL.GetStats("Health")*100)/100).."/"..tostring(math.round(hum.MaxHealth*100)/100)
	end
end