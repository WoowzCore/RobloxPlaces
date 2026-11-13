wait(0.1)


script.Parent.MouseButton1Click:Connect(function(ok)
script.Parent.Parent.power.Value = 0
script.Parent.Parent.torque.Value = 0
script.Parent.Parent.powerrpm.Value = 0
script.Parent.Parent.torquerpm.Value = 0
script.Parent.Parent.graph:ClearAllChildren()
end)