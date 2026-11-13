local FE = script.Parent.Parent.LogoFE
local LocalLight = script.Parent.Parent.LocalLight.Value
local Toggle = LocalLight.LogoValue
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
		LocalLight.Logo1.Light.Enabled = true
		LocalLight.Logo2.Light.Enabled = true
		LocalLight.LogoL1.Material = Enum.Material.Neon
		LocalLight.LogoL2.Material = Enum.Material.Neon
	else
		Toggle.Value = false
		Button.BackgroundColor3 = Color3.new(255,0,0)
		LocalLight.Logo1.Light.Enabled = false
		LocalLight.Logo2.Light.Enabled = false
		LocalLight.LogoL1.Material = Enum.Material.Glass
		LocalLight.LogoL2.Material = Enum.Material.Glass
	end
end

FE.OnServerEvent:Connect(Light)
