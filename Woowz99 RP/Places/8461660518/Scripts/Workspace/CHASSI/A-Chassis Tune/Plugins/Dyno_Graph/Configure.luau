wait(1)
local PowerRange = 500
local RPMRange = 8000






script.Parent.text.rpm0.Text = ""..(RPMRange*0)
script.Parent.text.rpm1.Text = ""..(RPMRange*0.000125)
script.Parent.text.rpm2.Text = ""..(RPMRange*0.00025)
script.Parent.text.rpm3.Text = ""..(RPMRange*0.000375)
script.Parent.text.rpm4.Text = ""..(RPMRange*0.0005)
script.Parent.text.rpm5.Text = ""..(RPMRange*0.000625)
script.Parent.text.rpm6.Text = ""..(RPMRange*0.00075)
script.Parent.text.rpm7.Text = ""..(RPMRange*0.000875)
script.Parent.text.rpm8.Text = ""..(RPMRange*0.001)
script.Parent.text.power0.Text = ""..(PowerRange*0)
script.Parent.text.power1.Text = ""..(PowerRange*0.25)
script.Parent.text.power2.Text = ""..(PowerRange*0.5)
script.Parent.text.power3.Text = ""..(PowerRange*0.75)
script.Parent.text.power4.Text = ""..(PowerRange*1)



while wait() do
script.Parent.s.Position = UDim2.new(script.Parent.Parent.Values.RPM.Value/RPMRange,0,0,0)
script.Parent.text.hs.Text = "Power ("..script.Parent.power.Value.." HP) @"..script.Parent.powerrpm.Value.." RPM"
script.Parent.text.tq.Text = "Torque ("..script.Parent.torque.Value.." ft-lbs) @"..script.Parent.torquerpm.Value.." RPM"
if script.Parent.dyno.Value == true then
if script.Parent.Parent.Values.Horsepower.Value>script.Parent.power.Value then
script.Parent.power.Value = script.Parent.Parent.Values.Horsepower.Value
script.Parent.powerrpm.Value = script.Parent.Parent.Values.RPM.Value
end
if script.Parent.Parent.Values.Torque.Value>script.Parent.torque.Value then
script.Parent.torque.Value = script.Parent.Parent.Values.Torque.Value
script.Parent.torquerpm.Value = script.Parent.Parent.Values.RPM.Value
end
local e  = Instance.new("Frame")
e.BackgroundColor3 = Color3.new(1,0,0)
e.Size = UDim2.new(0.01,0,0.01,0)
e.BorderSizePixel = 0
e.Position = UDim2.new(script.Parent.Parent.Values.RPM.Value/RPMRange,0,0.995-(script.Parent.Parent.Values.Horsepower.Value/PowerRange),0)
e.ZIndex = 2
e.Parent = script.Parent.graph
local e  = Instance.new("Frame")
e.BackgroundColor3 = Color3.new(0,0.25,1)
e.Size = UDim2.new(0.01,0,0.01,0)
e.BorderSizePixel = 0
e.Position = UDim2.new(script.Parent.Parent.Values.RPM.Value/RPMRange,0,0.995-(script.Parent.Parent.Values.Torque.Value/PowerRange),0)
e.ZIndex = 3
e.Parent = script.Parent.graph
end
end