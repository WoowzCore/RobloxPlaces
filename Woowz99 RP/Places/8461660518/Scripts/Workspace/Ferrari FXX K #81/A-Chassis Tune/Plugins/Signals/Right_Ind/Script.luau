car = script.Parent.Parent.Parent.Car.Value

script.Parent.Changed:Connect(function()
wait(.2)	
if not script.Parent.Value then
if car.Body.Lights.FF.Light.Enabled then
car.Body.Lights.R_RL.Light.Enabled = true
car.Body.Lights.R_RL.Color = Color3.new(1, 1, 1)
car.Body.Lights.R_RL.Material = "Neon"
car.Body.Lights.R_TL.Light.Enabled = false
car.Body.Lights.R_TL.Material = "SmoothPlastic"
car.Body.Lights.L_RL.Light.Enabled = true
car.Body.Lights.L_RL.Color = Color3.new(1, 1, 1)
car.Body.Lights.L_RL.Material = "Neon"
car.Body.Lights.L_TL.Light.Enabled = false
car.Body.Lights.L_TL.Material = "SmoothPlastic"
elseif not car.Body.Lights.FF.Light.Enabled then
car.Body.Lights.R_RL.Light.Enabled = false
car.Body.Lights.R_RL.Color = Color3.new(1, 1, 1)
car.Body.Lights.R_RL.Material = "SmoothPlastic"
car.Body.Lights.R_TL.Light.Enabled = false
car.Body.Lights.R_TL.Material = "SmoothPlastic"
car.Body.Lights.L_RL.Light.Enabled = false
car.Body.Lights.L_RL.Color = Color3.new(1, 1, 1)
car.Body.Lights.L_RL.Material = "SmoothPlastic"
car.Body.Lights.L_TL.Light.Enabled = false
car.Body.Lights.L_TL.Material = "SmoothPlastic"
end
end	
	
if script.Parent.Value then
	
while script.Parent.Value == true do
car.Body.Lights.R_RL.Light.Enabled = true
car.Body.Lights.R_RL.Color = Color3.new(1, 170/255, 0)
car.Body.Lights.R_RL.Material = "Neon"
car.Body.Lights.R_TL.Light.Enabled = true
car.Body.Lights.R_TL.Material = "Neon"
car.Body.Lights.L_RL.Light.Enabled = false
car.Body.Lights.L_RL.Color = Color3.new(1, 1, 1)
car.Body.Lights.L_RL.Material = "SmoothPlastic"
car.Body.Lights.L_TL.Light.Enabled = false
car.Body.Lights.L_TL.Material = "SmoothPlastic"
wait(.5)
car.Body.Lights.R_RL.Light.Enabled = false
car.Body.Lights.R_RL.Color = Color3.new(1, 1, 1)
car.Body.Lights.R_RL.Material = "SmoothPlastic"
car.Body.Lights.R_TL.Light.Enabled = false
car.Body.Lights.R_TL.Material = "SmoothPlastic"
car.Body.Lights.L_RL.Light.Enabled = false
car.Body.Lights.L_RL.Color = Color3.new(1, 1, 1)
car.Body.Lights.L_RL.Material = "SmoothPlastic"
car.Body.Lights.L_TL.Light.Enabled = false
car.Body.Lights.L_TL.Material = "SmoothPlastic"
wait(.5)
end
end
end)