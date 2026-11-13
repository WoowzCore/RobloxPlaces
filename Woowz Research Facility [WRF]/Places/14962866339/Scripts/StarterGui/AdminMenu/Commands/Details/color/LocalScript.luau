script.Parent.TextBox1.Text = math.floor(script.Parent.Value.Value.R*255)
script.Parent.TextBox2.Text = math.floor(script.Parent.Value.Value.G*255)
script.Parent.TextBox3.Text = math.floor(script.Parent.Value.Value.B*255)

local function clamp(x, min, max)
	if x < min then return min end
	if x > max then return max end
	return x
end

local function changed()
	local r = math.floor(tonumber(script.Parent.TextBox1.Text) or 0)
	local g = math.floor(tonumber(script.Parent.TextBox2.Text) or 0)
	local b = math.floor(tonumber(script.Parent.TextBox3.Text) or 0)
	local color = Color3.fromRGB(clamp(r,0,255),clamp(g,0,255),clamp(b,0,255))
	script.Parent.Value.Value = color
	script.Parent.img.ImageColor3 = color
end

changed()
script.Parent.TextBox1:GetPropertyChangedSignal("Text"):Connect(changed)
script.Parent.TextBox2:GetPropertyChangedSignal("Text"):Connect(changed)
script.Parent.TextBox3:GetPropertyChangedSignal("Text"):Connect(changed)