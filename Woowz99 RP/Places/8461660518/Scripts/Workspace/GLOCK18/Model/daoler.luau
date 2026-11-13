script.Parent.reload.OnServerEvent:Connect(function()
script.Parent.Parent.Handle.load:Play()
local Mag = script.Parent.Parent.Mag
local maglone = Mag:Clone()
Mag.Transparency = 1
maglone.Parent = workspace
maglone:BreakJoints()
maglone.Position = Mag.Position
wait(0.8)
Mag.Transparency = 0
wait(5)
maglone:Destroy()
	end)