local EBL = require(script.Parent:WaitForChild("EBLibbary"))
local plr = game.Players.LocalPlayer
local chr = plr.Character or plr.CharacterAdded:Wait()
local humrootpart = chr:WaitForChild("HumanoidRootPart")
local hum = chr:WaitForChild("Humanoid")
local debuggui = plr.PlayerGui:WaitForChild("Debug")
local debugguistats = debuggui["Stats Background"].List

local h = debugguistats.Health
local w = debugguistats.Water
local s = debugguistats.Stamina
local f = debugguistats.Food
local m = debugguistats.Mental
local o = debugguistats.Oxygen

while wait() do
	if debuggui.Enabled then
		w.Text = "Water: "..tostring( math.round(EBL.GetStats("Water")*100)/100)
		f.Text = "Food: "..tostring(math.round(EBL.GetStats("Food")*100)/100)
		s.Text = "Stamina: "..tostring(math.round(EBL.GetStats("Stamina")*100)/100)
		m.Text = "Mental: "..tostring(math.round(EBL.GetStats("Mental")*100)/100)
		o.Text = "Oxygen: "..tostring(math.round(EBL.GetStats("Oxygen")*100)/100)
		h.Text = "Health: "..tostring(math.round(EBL.GetStats("Health")*1000)/100)
	end
end