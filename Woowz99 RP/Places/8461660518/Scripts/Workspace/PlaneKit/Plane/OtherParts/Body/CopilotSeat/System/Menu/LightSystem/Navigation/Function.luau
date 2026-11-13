local FE = script.Parent.Parent.NavFE
local LocalLight = script.Parent.Parent.LocalLight.Value
local Toggle = LocalLight.NavValue
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
		LocalLight.NavGreen.PointLight.Enabled = true
		LocalLight.NavGreen.Green.Enabled = true
		LocalLight.NavRed.PointLight.Enabled = true
		LocalLight.NavRed.Red.Enabled = true
		LocalLight.NavGreen.Material = Enum.Material.Neon
		LocalLight.NavRed.Material = Enum.Material.Neon
	else
		Toggle.Value = false
		Button.BackgroundColor3 = Color3.new(255,0,0)
		LocalLight.NavGreen.PointLight.Enabled = false
		LocalLight.NavGreen.Green.Enabled = false
		LocalLight.NavRed.PointLight.Enabled = false
		LocalLight.NavRed.Red.Enabled = false
		LocalLight.NavGreen.Material = Enum.Material.Glass
		LocalLight.NavRed.Material = Enum.Material.Glass
	end
end

FE.OnServerEvent:Connect(Light)
