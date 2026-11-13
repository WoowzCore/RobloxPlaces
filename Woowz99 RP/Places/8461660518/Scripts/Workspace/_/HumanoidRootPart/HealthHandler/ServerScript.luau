--======== SCRIPTED BY AETEHEL LOL ==========
local hum = script.Parent.Parent.Parent:WaitForChild("Humanoid")
local humh = hum.Health 
local hummh = hum.MaxHealth
local TL =script.Parent.Main.TextLabel
local ello

while wait() do
	TL.Text = hum.Health .."/".. hum.MaxHealth
	script.Parent.Main.Frame:TweenSize(UDim2.new((hum.Health / hum.MaxHealth), 0, 1, 0), "Out", "Linear", 0.1, true, nil)
end