local rs = game:GetService("ReplicatedStorage")
wait(1)
local screen = script.Parent.Adornee

script.Parent.Liquid.Text = screen.Parent.Liquid.Value

script.Parent.Liquid:GetPropertyChangedSignal("Text"):Connect(function()
	if script.Parent.Liquid.Text ~= "" then
		rs.PlaySound:FireServer("9116156872",screen.Parent.keys.Position,math.random(80,100)/100,25,math.random(90,110)/100)
	end
end)

screen.Parent.Liquid:GetPropertyChangedSignal("Value"):Connect(function()
	wait(0.1)
	local result = screen.Parent.Liquid.Value
	if string.find(result,"error") then
		result = ""
	end
	script.Parent.Liquid.Text = result
end)

script.Parent.Liquid.TextEditable = not screen.Parent.Worked.Value
screen.Parent.Worked:GetPropertyChangedSignal("Value"):Connect(function()
	script.Parent.Liquid.TextEditable = not screen.Parent.Worked.Value
end)

while wait() do
	local t = math.random()*0.35
	script.Parent.TextLabel.TextTransparency = t
	script.Parent.TextLabel1.TextTransparency = t
end