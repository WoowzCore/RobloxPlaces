local flashlight = script.Parent
local rs = game:GetService("ReplicatedStorage")

local lightcolors = {Color3.fromRGB(255,255,255),Color3.fromRGB(255, 253, 230),Color3.fromRGB(243, 255, 255),Color3.fromRGB(255, 243, 222)}

local randlightcolor = lightcolors[math.random(1,#lightcolors)]
flashlight.Light.PointLight.Color = randlightcolor
flashlight.Light.SpotLight.Color = randlightcolor
flashlight.Light.SpotLight2.Color = randlightcolor
flashlight.Light.LightEffect.BillboardGui.Light.ImageColor3 = randlightcolor

local activated = false

local function Activate(bool)
	flashlight.Light.Sound:Play()
	if bool then
		flashlight.Light.Transparency = 0
	else
		flashlight.Light.Transparency = 1
	end
	flashlight.Light.SpotLight.Enabled = bool
	flashlight.Light.SpotLight2.Enabled = bool
	flashlight.Light.PointLight.Enabled = bool
	flashlight.Light.LightEffect.BillboardGui.Enabled = bool
end

local waiting = false
flashlight.Use.Event:Connect(function()
	if waiting then return end
	waiting = true
	activated = not activated
	rs.Player.PlayAnimationOnce:FireClient(game:GetService("Players"):GetPlayerFromCharacter(flashlight.Parent),"Use")
	wait(0.2)
	Activate(activated)
	wait(0.5)
	waiting = false
end)

local backpack = false
while wait() do
	if flashlight.Parent.Name ~= backpack then
		backpack = flashlight.Parent.Name
		if backpack == "Backpack" then
			activated = false
			Activate(activated)
		end
	end
end