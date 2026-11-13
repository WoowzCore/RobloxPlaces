local u = game:GetService("UserInputService")

local setting = script.Parent

local slider = setting.background_slider
local slidertaked = false
local mouseonslider = false

local left,right = script.Parent.ValueLeft.Value,script.Parent.ValueRight.Value
local negative = math.abs(math.min(left,0))
if negative ~= 0 then
	left = 0
	right += negative
end

local del = script.Parent.ValueDel.Value
script.Parent.Left.Text = left-negative
script.Parent.Right.Text = right-negative

local function upd(val)
	local raz = (val-left)/right
	val -= negative
	slider.ImageButton.Position = UDim2.new(raz,0,0,0)
	local result = 0
	
	if del == -1 then
		result = val
	elseif del == 0 then
		result = math.round(val*10)/10
	elseif del == 1 then
		result = math.round(val)
	elseif del == 2 then
		result = math.round(val/10)*10
	elseif del == 3 then
		result = math.round(val/100)*100
	end
	
	if result == -0 then
		result = 0
	end
	
	slider.ImageButton.TextLabel.Text = result
	script.Parent.Value.Value = result
end
upd(script.Parent.Value.Value+negative)

script.Parent.Reset.Event:Connect(function()
	upd(script.Parent.DefaultValue.Value + negative)
end)

slider.ImageButton.InputBegan:Connect(function()
	mouseonslider = true
end)
slider.ImageButton.InputEnded:Connect(function()
	mouseonslider = false
end)

u.InputEnded:Connect(function(i)
	if i.UserInputType == Enum.UserInputType.MouseButton1 then
		slidertaked = false
	end
end)

u.InputBegan:Connect(function(i)
	if i.UserInputType == Enum.UserInputType.MouseButton1 and mouseonslider then
		slidertaked = true
	end
end)

while wait() do
	if slidertaked then
		local mpos = u:GetMouseLocation().X
		local center = slider.AbsolutePosition.X
		local prcnt = math.clamp((mpos-center)/slider.AbsoluteSize.X,0,1)
		
		local val = prcnt*(right-left)+left
		upd(val)
	end
end