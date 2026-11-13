local FE = script.Parent.Parent.HeadFE
local LocalLight = script.Parent.Parent.LocalLight.Value
local Toggle = LocalLight.HeadValue
local HeadLight = script.Parent.Parent.LocalHeadLight.Value
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
		HeadLight.Material = Enum.Material.Neon
		HeadLight.Light.Enabled = true
		HeadLight.Dynamic.Enabled = true
		HeadLight.White.Enabled = true
	else
		Toggle.Value = false
		Button.BackgroundColor3 = Color3.new(255,0,0)
		HeadLight.Material = Enum.Material.Glass
		HeadLight.Light.Enabled = false
		HeadLight.Dynamic.Enabled = false
		HeadLight.White.Enabled = false
	end
end

FE.OnServerEvent:Connect(Light)
