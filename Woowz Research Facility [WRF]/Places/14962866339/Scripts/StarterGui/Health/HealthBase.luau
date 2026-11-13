local gui = script.Parent
local plr = script.Parent.Parent.Parent
local chr = plr.Character or plr.CharacterAdded:Wait()
local ps = require(chr:WaitForChild("PlayerScript"))
local pb = require(chr:WaitForChild("PlayerBase"))

local head,head_gui = chr:WaitForChild("Head"), gui.background.Head
local torso,torso_gui = chr:WaitForChild("Torso"), gui.background.Torso
local larm,larm_gui = chr:WaitForChild("Left Arm"), gui.background.LeftArm
local rarm,rarm_gui = chr:WaitForChild("Right Arm"), gui.background.RightArm
local lleg,lleg_gui = chr:WaitForChild("Left Leg"), gui.background.LeftLeg
local rleg,rleg_gui = chr:WaitForChild("Right Leg"), gui.background.RightLeg
local health_gui = gui.background.Health

local light = game:GetService("Lighting")
local hurt = light.Hurt
hurt.Enabled = true
local blur = light.HurtBlur
blur.Enabled = true

local health_gradient = ColorSequence.new({
	ColorSequenceKeypoint.new(0,Color3.fromRGB(12, 12, 12)),
	ColorSequenceKeypoint.new(0.01,Color3.fromRGB(218, 18, 0)),
	ColorSequenceKeypoint.new(0.5,Color3.fromRGB(255, 217, 0)),
	ColorSequenceKeypoint.new(1,Color3.fromRGB(55, 255, 0))	})

local health_gradient_noblack = ColorSequence.new({
	ColorSequenceKeypoint.new(0,Color3.fromRGB(218, 18, 0)),
	ColorSequenceKeypoint.new(0.5,Color3.fromRGB(255, 217, 0)),
	ColorSequenceKeypoint.new(1,Color3.fromRGB(55, 255, 0))	})

local humanoid = chr:WaitForChild("Humanoid")

local savedhealth = -1
while wait(0.01) do
	local mh = humanoid.MaxHealth
	local healths = pb.Healths
	local h = healths["Head"][1] local h_max = healths["Head"][2]
	local t = healths["Torso"][1] local t_max = healths["Torso"][2]
	local la = healths["LeftArm"][1] local la_max = healths["LeftArm"][2]
	local ra = healths["RightArm"][1] local ra_max = healths["RightArm"][2]
	local ll = healths["LeftLeg"][1] local ll_max = healths["LeftLeg"][2] 
	local rl = healths["RightLeg"][1] local rl_max = healths["RightLeg"][2]
	local total = humanoid.Health/mh
	local inverttotal = math.clamp(math.abs(total-1),0,1)
	if total ~= savedhealth then
		savedhealth = total
		health_gui.Health.BackgroundColor3 = ps.GetColorFromGradient(health_gradient_noblack,total)
		health_gui.Health.Size = UDim2.new(total,0,1,0)
		health_gui.TextLabel.Text = math.round(total*mh)
		
		local h_health,t_health,la_health,ra_health,ll_health,rl_health = h/h_max*total, t/t_max*total, la/la_max*total, ra/ra_max*total, ll/ll_max*total, rl/rl_max*total
		
		head_gui.BackgroundColor3 = ps.GetColorFromGradient(health_gradient,h_health)
		savedcolor_h = h

		torso_gui.BackgroundColor3 = ps.GetColorFromGradient(health_gradient,t_health)
		savedcolor_t = t

		larm_gui.BackgroundColor3 = ps.GetColorFromGradient(health_gradient,la_health)
		savedcolor_la = la

		rarm_gui.BackgroundColor3 = ps.GetColorFromGradient(health_gradient,ra_health)
		savedcolor_ra = ra

		lleg_gui.BackgroundColor3 = ps.GetColorFromGradient(health_gradient,ll_health)
		savedcolor_ll = ll

		rleg_gui.BackgroundColor3 = ps.GetColorFromGradient(health_gradient,rl_health)
		savedcolor_rl = rl
		
		pb.PartsDead.Torso = (t_health==0)
		pb.PartsDead.RightArm = (ra_health==0)
		pb.PartsDead.LeftArm = (la_health==0)
		pb.PartsDead.RightLeg = (rl_health==0)
		pb.PartsDead.LeftLeg = (ll_health==0)

		hurt.Brightness = 0.5 * inverttotal
		hurt.Contrast = 0.5 * inverttotal
		hurt.Saturation = -1 * inverttotal
		hurt.TintColor = Color3.new(1,total,total)
		blur.Size = 16 * inverttotal
		if total <= 0 then
			hurt.TintColor = Color3.new(1,0,0)
			hurt.Saturation = -1
			hurt.Brightness = -3
			hurt.Contrast = 10
		end
	end
	
	script.Parent.background.Stamina.Stamina.Size = UDim2.new(pb.Stamina/100,0,1,0)
	script.Parent.background.Stamina.TextLabel.Text = math.round(pb.Stamina)
end