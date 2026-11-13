local fl = Instance.new("Motor", script.Parent.Parent.Misc.FL.Door.SS) --doors
local fr = Instance.new("Motor", script.Parent.Parent.Misc.FR.Door.SS)
local ho = Instance.new("Motor", script.Parent.Parent.Misc.HO.SS) --trunk
local f = Instance.new("Motor", script.Parent.Parent.Misc.F.SS) --frunk

fl.MaxVelocity = 0.03
fl.Part0 = script.Parent.FL
fl.Part1 = fl.Parent

fr.MaxVelocity = 0.03
fr.Part0 = script.Parent.FR
fr.Part1 = fr.Parent

ho.MaxVelocity = 0.03
ho.Part0 = script.Parent.HO
ho.Part1 = ho.Parent

f.MaxVelocity = 0.03
f.Part0 = script.Parent.F
f.Part1 = f.Parent



