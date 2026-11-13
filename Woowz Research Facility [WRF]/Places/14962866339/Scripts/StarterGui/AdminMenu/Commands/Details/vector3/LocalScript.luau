script.Parent.TextBox1.Text = script.Parent.Value.Value.X
script.Parent.TextBox2.Text = script.Parent.Value.Value.Y
script.Parent.TextBox3.Text = script.Parent.Value.Value.Z


local function changed()
	local x = tonumber(script.Parent.TextBox1.Text) or 0
	local y = tonumber(script.Parent.TextBox2.Text) or 0
	local z = tonumber(script.Parent.TextBox3.Text) or 0
	script.Parent.Value.Value = Vector3.new(x,y,z)
end

script.Parent.TextBox1:GetPropertyChangedSignal("Text"):Connect(changed)
script.Parent.TextBox2:GetPropertyChangedSignal("Text"):Connect(changed)
script.Parent.TextBox3:GetPropertyChangedSignal("Text"):Connect(changed)