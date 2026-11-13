wait(0.1)
local yes = false


script.Parent.MouseButton1Click:Connect(function(ok)
if yes == false then
script.Parent.Parent.dyno.Value = true
yes = true
elseif yes == true then
script.Parent.Parent.dyno.Value = false
yes = false
end
end)