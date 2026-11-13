local base = require(game:GetService("ServerScriptService").Base)
local savelight = {}

local function Glow(light,bool,brightness)
	if brightness == nil then brightness = 1 end
	local color = nil
	if light:FindFirstChild("GlowColor") ~= nil then
		color = light:FindFirstChild("GlowColor").Value
	end
	if light:IsA("Light") then
		local sound = "3466798390"
		if bool then
			local soundenabled = {"4288784832","4398878054"}
			sound = soundenabled[math.random(1,#soundenabled)]
			light.Enabled = true
			light.Brightness = light:FindFirstChild("GlowBrightness").Value*brightness
		else
			light.Enabled = false
		end
		base.PlaySound(sound,light.Parent.CFrame.Position,0.1,50,math.random(8,12)/10)
	elseif light:IsA("Part") then
		if bool then
			light.Material = Enum.Material.Neon
			brightness = math.min(brightness+0.5,1)
			light.Color = Color3.new(color.r*brightness,color.g*brightness,color.b*brightness)
		else
			light.Material = Enum.Material.Glass
			light.Color = Color3.new(color.r-30,color.g-30,color.b-30)
		end
	elseif light:IsA("Sound") then
			if bool then
				light:Play()
			else
				light:Stop()
			end
	else
		if bool then
			light.Color3 = color
		else
			light.Color3 = Color3.fromRGB(30,30,30)
		end
	end
end

local function ChangeLight(bool,brightness)
	if bool then
		for _, light in pairs(savelight) do
			Glow(light,true,brightness)
		end
	else
		for _, light in pairs(savelight) do
			Glow(light,false)
		end
	end
end

local l = {}
for _, light in pairs(script.Parent:GetDescendants()) do
	table.insert(l,light)
end
table.insert(l,script.Parent)
for _, light in pairs(l) do
	if light:IsA("Sound") then
		table.insert(savelight,light)
	end
	if light:IsA("Light") then
		if light:FindFirstChild("GlowBrightness") == nil then
			local bv = Instance.new("NumberValue")
			bv.Value = light.Brightness
			bv.Name = "GlowBrightness"
			bv.Parent = light
		end
		table.insert(savelight,light)
	end
	if light:IsA("Part") then
		if light.Material == Enum.Material.Neon or light:FindFirstChild("GlowColor") then
			if light:FindFirstChild("GlowColor") == nil then
				local bv = Instance.new("Color3Value")
				bv.Value = light.Color
				bv.Name = "GlowColor"
				bv.Parent = light
			end
			table.insert(savelight,light)
		end
	end
	if light:IsA("Decal") then
		if light.Color3.r > 1 or light.Color3.g > 1 or light.Color3.b > 1 or light:FindFirstChild("GlowColor") then
			if light:FindFirstChild("GlowColor") == nil then
				local bv = Instance.new("Color3Value")
				bv.Value = light.Color3
				bv.Name = "GlowColor"
				bv.Parent = light
			end
			
			table.insert(savelight,light)
		end
	end
end

if script.Name == "LightBlink_true" then
	wait(math.random(1,30)/100)
	if math.random(0,100) > 10 then
		ChangeLight(true,math.random(30,80)/1000)
		wait(math.random(1,25)/100)
		ChangeLight(false)
		wait(math.random(1,25)/100)
		ChangeLight(true,math.random(30,80)/1000)
		if math.random(0,100) > 30 then
			wait(math.random(1,25)/100)
			ChangeLight(false)
			wait(math.random(1,25)/100)
			ChangeLight(true,math.random(30,80)/1000)
			if math.random(0,100) > 60 then
				wait(math.random(1,25)/100)
				ChangeLight(false)
				wait(math.random(1,25)/100)
				ChangeLight(true,math.random(30,80)/1000)
			end
		end
	end
	ChangeLight(true,1)
else
	wait(math.random(1,30)/100)
	ChangeLight(false)
end

script:Destroy()