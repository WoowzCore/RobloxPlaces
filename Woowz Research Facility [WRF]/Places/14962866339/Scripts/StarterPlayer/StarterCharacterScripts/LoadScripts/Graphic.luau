local plr = game:GetService("Players").LocalPlayer
local chr = plr.Character or plr.CharacterAdded:Wait()
local base = require(chr:WaitForChild("PlayerBase"))
local plrscript = require(chr:WaitForChild("PlayerScript"))
local light = game:GetService("Lighting")
local setting = require(plr.PlayerScripts:WaitForChild("Settings"))
local s_ss = true
local s_st = true
local s_ls = true
local loaded = false

local function ChangeShadows(part,bool)
	if part ~= nil then
		for _, p in pairs(part:GetDescendants()) do
			if p:IsA("Light") then
				p.Shadows = bool
			end
		end
	end
end

local function f_ss(part)
	if part.Name == "SirenLamp" then
		ChangeShadows(part:FindFirstChild("light1"),s_ss)
		ChangeShadows(part:FindFirstChild("light2"),s_ss)
	end
end
local function f_st(part)
	if part.Name == "Sink" then
		ChangeShadows(part:FindFirstChild("LightBase"),s_st)
	end
	if part.Name == "Portrait" then
		ChangeShadows(part:FindFirstChild("lamp"),s_st)
		ChangeShadows(part:FindFirstChild("lamp1"),s_st)
	end
	if part.Name == "EmergencyLamp" then
		ChangeShadows(part:FindFirstChild("glass"),s_st)
	end
	if part.Name == "DateDisplay" then
		ChangeShadows(part:FindFirstChild("light"),s_st)
		ChangeShadows(part:FindFirstChild("light2"),s_st)
	end
	if part.Name == "ExitSign" then
		part:WaitForChild("force").PointLight.Shadows = s_st
	end
	if part.Name == "GasStove" then
		ChangeShadows(part:FindFirstChild("Kamforka1"),s_st)
		ChangeShadows(part:FindFirstChild("Kamforka2"),s_st)
		ChangeShadows(part:FindFirstChild("Kamforka3"),s_st)
		ChangeShadows(part:FindFirstChild("Kamforka4"),s_st)
		ChangeShadows(part:FindFirstChild("Kamforka5"),s_st)
		ChangeShadows(part:FindFirstChild("Kamforka6"),s_st)
		ChangeShadows(part:FindFirstChild("Kamforka7"),s_st)
		ChangeShadows(part:FindFirstChild("Kamforka8"),s_st)
	end
	if part.Name == "HolidayDecorations" then
		if part:FindFirstChild("christmas tree") then
			local part_ = part:FindFirstChild("christmas tree").ChristmasTree
			ChangeShadows(part_:FindFirstChild("ChristmasTree"),s_st)
		end
	end
end
local function f_ls(part)
	if part:IsA("Light") then
		local function checkparent(p)
			local names = {"SirenLamp","Sink","EmergencyLamp","HolidayDecorations","GasStove","ExitSign","DateDisplay","Portrait"}
			local r = names[p]
			local result = true
			if r then
				result = false
			end
			if p:IsA("Tool") then
				result = false
			end
			return result
		end
		if part.Parent ~= nil then
			local r = checkparent(part.Parent)
			if part.Parent.Parent ~= nil then
				r = checkparent(part.Parent.Parent)
				if part.Parent.Parent.Parent ~= nil then
					r = checkparent(part.Parent.Parent.Parent)
					if part.Parent.Parent.Parent.Parent ~= nil then
						r = checkparent(part.Parent.Parent.Parent.Parent)
						if part.Parent.Parent.Parent.Parent.Parent ~= nil then
							r = checkparent(part.Parent.Parent.Parent.Parent.Parent)
							if r then
								part.Shadows = s_ls
							end
						else
							if r then
								part.Shadows = s_ls
							end
						end
					else
						if r then
							part.Shadows = s_ls
						end
					end
				else
					if r then
						part.Shadows = s_ls
					end
				end
			else
				if r then
					part.Shadows = s_ls
				end
			end
		end
	end
end

light.Stamina.Enabled = true
light.Poison.Enabled = true
local poisongradient = ColorSequence.new({ColorSequenceKeypoint.new(0,Color3.fromRGB(99, 190, 89)),ColorSequenceKeypoint.new(1,Color3.fromRGB(190, 190, 98))})
local changed = false
game:GetService("RunService").RenderStepped:Connect(function(dt)
	local stamina = math.abs((base.Stamina/100)-1)
	light.Stamina.Saturation = -0.3 * stamina
	light.Stamina.Contrast = 0.2 * stamina
	
	light.DepthOfField.Enabled = setting.Graphic.DOF
	local bloom = 0
	if setting.Graphic.Bloom then bloom = 1 end
	light.Bloom.Intensity = bloom
	light.GlobalShadows = setting.Optimization.GlobalShadows
	light.EnvironmentSpecularScale = setting.Graphic.SpecularScale/10
	light.ExposureCompensation = setting.Graphic.Brightness
	local cc = light.SettingsColorCorrection
	local saturation = setting.Other.ColorCorrectionSaturation*10
	local contrast = setting.Other.ColorCorrectionContrast/2*10
	if setting.Other.ColorCorrectionBlackWhite then
		saturation = -1
	end
	if setting.Other.ColorCorrectionInverse then
		contrast = -2
	end
	cc.Saturation = saturation
	cc.Contrast = contrast
	light.SettingsBlur.Size = (setting.Other.ColorCorrectionBlur/10)*56
	
	local poison = (math.min(base.Poison/300,1))
	light.Poison.Contrast = poison
	light.Poison.Saturation = -1*poison
	local poisoncolor = plrscript.GetColorFromGradient(poisongradient,math.sin(base.Poison*3))
	light.Poison.TintColor = Color3.new(1-(1-poisoncolor.r)*poison,1-(1-poisoncolor.g)*poison,1-(1-poisoncolor.b)*poison)
	
	light.Drunk.Size = 56*(math.min(1,(base.Drunk/100)+(poison)))
	
	if loaded then
	
	if setting.Optimization.SirensShadows ~= s_ss then
		s_ss = setting.Optimization.SirensShadows
		changed = true
		for _, part in pairs(game.Workspace:GetDescendants()) do
			f_ss(part)
		end
	end
	if setting.Optimization.SmolThingsShadows ~= s_st then
		s_st = setting.Optimization.SmolThingsShadows
		changed = true
		for _, part in pairs(game.Workspace:GetDescendants()) do
			f_st(part)
		end
	end
	if setting.Optimization.LightingShadows ~= s_ls then
		s_ls = setting.Optimization.LightingShadows
		changed = true
		for _, part in pairs(game.Workspace:GetDescendants()) do
			f_ls(part)
		end
	end
	
	end
end)

wait(5)
loaded=true

while wait(10) do
	if changed then
		for _, part in pairs(game.Workspace:GetDescendants()) do
			f_ss(part)
			f_ls(part)
			f_st(part)
		end
	end
end