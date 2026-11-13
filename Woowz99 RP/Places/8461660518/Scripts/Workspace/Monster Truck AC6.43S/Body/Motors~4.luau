local fl = Instance.new("Motor", script.Parent.Parent.Misc.FL.Door.SS) --doors
local fr = Instance.new("Motor", script.Parent.Parent.Misc.FR.Door.SS)



local wl = Instance.new("Motor", script.Parent.Parent.Misc.FL.Window.SS) --windows
local wr = Instance.new("Motor", script.Parent.Parent.Misc.FR.Window.SS)


fl.MaxVelocity = 0.03
fl.Part0 = script.Parent.FL
fl.Part1 = fl.Parent

fr.MaxVelocity = 0.03
fr.Part0 = script.Parent.FR
fr.Part1 = fr.Parent


wl.MaxVelocity = 0.007
wl.Part0 = script.Parent.Parent.Misc.FL.Door.WD
wl.Part1 = wl.Parent

wr.MaxVelocity = 0.007
wr.Part0 = script.Parent.Parent.Misc.FR.Door.WD
wr.Part1 = wr.Parent


