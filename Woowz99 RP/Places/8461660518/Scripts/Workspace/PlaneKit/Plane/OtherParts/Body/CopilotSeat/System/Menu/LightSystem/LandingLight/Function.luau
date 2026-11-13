local FE = script.Parent.Parent.LandingFE
local LocalLight = script.Parent.Parent.LocalLight.Value
local Toggle = LocalLight.LandingValue
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
		LocalLight.Landing1.Material = Enum.Material.Neon
		LocalLight.Landing2.Material = Enum.Material.Neon
		LocalLight.Landing3.Material = Enum.Material.Neon
		LocalLight.Landing4.Material = Enum.Material.Neon
		LocalLight.Landing1.Light.Enabled = true
		LocalLight.Landing2.Light.Enabled = true
		LocalLight.Landing3.Light.Enabled = true
		LocalLight.Landing4.Light.Enabled = true
		LocalLight.Landing1.Dynamic.Enabled = true
		LocalLight.Landing4.Dynamic.Enabled = true
		LocalLight.Landing2.White.Enabled = true
		LocalLight.Landing3.White.Enabled = true
	else
		Toggle.Value = false
		Button.BackgroundColor3 = Color3.new(255,0,0)
		LocalLight.Landing1.Material = Enum.Material.Glass
		LocalLight.Landing2.Material = Enum.Material.Glass
		LocalLight.Landing3.Material = Enum.Material.Glass
		LocalLight.Landing4.Material = Enum.Material.Glass
		LocalLight.Landing1.Light.Enabled = false
		LocalLight.Landing2.Light.Enabled = false
		LocalLight.Landing3.Light.Enabled = false
		LocalLight.Landing4.Light.Enabled = false
		LocalLight.Landing1.Dynamic.Enabled = false
		LocalLight.Landing4.Dynamic.Enabled = false
		LocalLight.Landing2.White.Enabled = false
		LocalLight.Landing3.White.Enabled = false
	end
end

FE.OnServerEvent:Connect(Light)
