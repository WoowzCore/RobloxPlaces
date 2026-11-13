
local tk = Instance.new("Motor", script.Parent.Parent.Misc.TK.SS)
local hd = Instance.new("Motor", script.Parent.Parent.Misc.HD.SS)
local d1 = Instance.new("Motor", script.Parent.Parent.Misc.D1.SS)
local d2 = Instance.new("Motor", script.Parent.Parent.Misc.D2.SS)
local d3 = Instance.new("Motor", script.Parent.Parent.Misc.D3.SS)
local d4 = Instance.new("Motor", script.Parent.Parent.Misc.D4.SS)

tk.MaxVelocity = 0.03
tk.Part0 = script.Parent.TK
tk.Part1 = tk.Parent

d1.MaxVelocity = 0.03
d1.Part0 = script.Parent.D1
d1.Part1 = d1.Parent

d2.MaxVelocity = 0.03
d2.Part0 = script.Parent.D2
d2.Part1 = d2.Parent

d3.MaxVelocity = 0.03
d3.Part0 = script.Parent.D3
d3.Part1 = d3.Parent

d4.MaxVelocity = 0.03
d4.Part0 = script.Parent.D4
d4.Part1 = d4.Parent

hd.MaxVelocity = 0.03
hd.Part0 = script.Parent.HD
hd.Part1 = hd.Parent