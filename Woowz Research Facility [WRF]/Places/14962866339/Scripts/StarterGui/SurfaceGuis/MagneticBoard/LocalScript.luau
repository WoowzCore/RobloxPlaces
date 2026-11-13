wait(1)
local typedata = script.Parent.TypeData.Value
local guileft = script.Parent.GuiLeft.Value

local l1,l2,l3 = script.Parent.Line1,script.Parent.Line2,script.Parent.Line3

local function randline(l)
	l.Rotation = math.random(-30,30)/10
	l.TextSize = math.random(60,80)
end

randline(l1) randline(l2) randline(l3)

if guileft == false then
	l1.Position = UDim2.new(0.02,0,0.02,0)
	l2.Position = UDim2.new(0.01,0,0.2,0)
	l3.Position= UDim2.new(0.01,0,0.4,0)
	script.Parent.image.Position = UDim2.new(0.5,0,0,0)
end

script.Parent.image.Image = script.Parent.Adornee.Parent.Image.Value
local color = script.Parent.Adornee.Parent.Color.Value

local colors = {
	["red"] = Color3.fromRGB(220, 0, 0),
	["green"] = Color3.fromRGB(75, 190, 4),
	["blue"] = Color3.fromRGB(0, 76, 190),
	["yellow"] = Color3.fromRGB(216, 180, 0),
	["black"] = Color3.fromRGB(0,0,0)
}
script.Parent.image.ImageColor3 = colors[color]

script.Parent.Line1.TextColor3 = colors[script.Parent.Adornee.Parent.Line1Color.Value]
script.Parent.Line2.TextColor3 = colors[script.Parent.Adornee.Parent.Line2Color.Value]
script.Parent.Line3.TextColor3 = colors[script.Parent.Adornee.Parent.Line3Color.Value]