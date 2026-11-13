local dot = script.Parent.Center
local plr = game:GetService("Players").LocalPlayer
local chr = plr.Character or plr.CharacterAdded:Wait()
local base = require(chr:WaitForChild("PlayerBase"))
local circleprogressbar = script.Parent.CircleProgressBar

function lerp(x,y,z)
	return x * (1-z) + y * z
end

while wait() do
	if dot.Parent.Enabled == true then
		if base.ThrowPower ~= 0 then
			dot.Visible = false
			circleprogressbar.Visible = true
			local righttop = circleprogressbar.RightTop
			local rightbottom = circleprogressbar.RightBottom
			local leftbottom = circleprogressbar.LeftBottom
			local lefttop = circleprogressbar.LeftTop
			local pow = base.ThrowPower
			
			local rt = lerp(-180,-88,math.min(pow/25,1))
			local rb = lerp(-180,-88,math.max(math.min(pow/25-1,1),0))
			local lb = lerp(-180,-88,math.max(math.min(pow/25-2,1),0))
			local lt = lerp(-180,-88,math.max(math.min(pow/25-3,1),0))
			righttop.UIGradient.Rotation = rt
			rightbottom.UIGradient.Rotation = rb
			leftbottom.UIGradient.Rotation = lb
			lefttop.UIGradient.Rotation = lt
		else
			dot.Visible = true
			circleprogressbar.Visible = false
			if base.Data.Mouse.Drag then
				dot.Image = "rbxassetid://15211605120"
			else
				if base.AttackMode and base.ToolFirearm then
					dot.Image = "rbxassetid://16616082453"
				else
					dot.Image = "rbxassetid://15211580521"
				end
			end
		end
	end
end