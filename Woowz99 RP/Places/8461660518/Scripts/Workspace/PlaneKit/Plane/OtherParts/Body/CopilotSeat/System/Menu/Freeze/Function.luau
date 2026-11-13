local FE = script.Parent.Parent.FreezeFE
local Main = script.Parent.Parent.Main.Value
local Toggle = Main.Variables.Freeze
local Button = script.Parent

if Toggle.Value == false then
	Button.BackgroundColor3 = Color3.new(255,0,0)
else
	Button.BackgroundColor3 = Color3.new(0,255,0)
end

function Freeze()
	if Toggle.Value == false then
		Toggle.Value = true
		Button.BackgroundColor3 = Color3.new(0,255,0)
		Main.Anchored = true
	else
		Toggle.Value = false
		Button.BackgroundColor3 = Color3.new(255,0,0)
		Main.Anchored = false
	end
end

FE.OnServerEvent:Connect(Freeze)
