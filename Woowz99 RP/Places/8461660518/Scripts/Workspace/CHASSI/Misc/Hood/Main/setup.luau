wait(1)
local a = script.Parent:Clone()
a.setup:Destroy()
a.Parent = script.Parent.Parent.Parent.Parent.Body
a.CFrame = script.Parent.CFrame
local e = Instance.new("Motor")
e.Parent = script.Parent
e.Part0 = a
e.Part1 = script.Parent

e.MaxVelocity = 0.02
