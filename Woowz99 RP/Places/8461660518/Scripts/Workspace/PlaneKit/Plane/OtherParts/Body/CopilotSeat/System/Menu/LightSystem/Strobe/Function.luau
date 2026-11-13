local FE = script.Parent.Parent.StrobeFE
local LocalLight = script.Parent.Parent.LocalLight.Value
local Toggle = LocalLight.StrobeValue
local Button = script.Parent

if Toggle.Value == false then
	Button.BackgroundColor3 = Color3.new(255,0,0)
else
	Button.BackgroundColor3 = Color3.new(0,255,0)
end

function Light()
	if Toggle.Value == false then
		Toggle.Value = true
		Button.BackgroundColor3 = Color3.new(0,255,0)
		
	else
		Toggle.Value = false
		Button.BackgroundColor3 = Color3.new(255,0,0)
		
	end
end

FE.OnServerEvent:Connect(Light)
