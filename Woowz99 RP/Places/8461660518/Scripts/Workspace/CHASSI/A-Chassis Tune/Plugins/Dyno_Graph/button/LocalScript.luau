wait(0.1)
local yes = false


script.Parent.MouseButton1Click:Connect(function(ok)
if yes == false then
script.Parent.Parent.Position = UDim2.new(0.2,0,0,0)
script.Parent.Parent.graph.Visible = true
script.Parent.Parent.backdrop1.Visible = true
script.Parent.Parent.backdrop2.Visible = true
script.Parent.Parent.backdrop3.Visible = true
script.Parent.Parent.text.Visible = true
script.Parent.Parent.powergridline.Visible = true
script.Parent.Parent.rpmgridline.Visible = true
script.Parent.Parent.s.Visible = true
script.Parent.Parent.start.Visible = true
script.Parent.Parent.clear.Visible = true
yes = true
elseif yes == true then
script.Parent.Parent.dyno.Value = false
script.Parent.Parent.Position = UDim2.new(0.2,0,-0.6376,0)
script.Parent.Parent.graph.Visible = false
script.Parent.Parent.backdrop1.Visible = false
script.Parent.Parent.backdrop2.Visible = false
script.Parent.Parent.backdrop3.Visible = false
script.Parent.Parent.text.Visible = false
script.Parent.Parent.powergridline.Visible = false
script.Parent.Parent.rpmgridline.Visible = false
script.Parent.Parent.s.Visible = false
script.Parent.Parent.start.Visible = false
script.Parent.Parent.clear.Visible = false
yes = false
end
end)