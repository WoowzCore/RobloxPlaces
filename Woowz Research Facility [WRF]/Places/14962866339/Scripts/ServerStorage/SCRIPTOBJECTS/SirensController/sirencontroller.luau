local sirens = require(game:GetService("ServerStorage").Datas).Sirens
local lab = require(game:GetService("ServerScriptService").Lab)
local base = require(game:GetService("ServerScriptService").Base)

script.Parent.button_start.ClickDetector.MouseClick:Connect(function()
	lab.ChangeSirenType(script.Parent.Selected.Value)
end)

local soundplaying = false
local function changeplayingtest(bool)
	if bool then
		local sirendata = sirens[script.Parent.Selected.Value]
		script.Parent.screen.SurfaceGui.base.sirentest.ImageLabel.Image = "rbxassetid://15229520205"
		script.Parent.sound.Sound.PlaybackSpeed = sirendata[1][2]
		script.Parent.sound.Sound.Volume = sirendata[1][3]
		script.Parent.sound.Sound.SoundId = "rbxassetid://"..sirendata[1][1]
		script.Parent.sound.Sound:Play()
	else
		script.Parent.screen.SurfaceGui.base.sirentest.ImageLabel.Image = "rbxassetid://15229086620"
		script.Parent.sound.Sound:Stop()
	end
end
script.Parent.button_play.ClickDetector.MouseClick:Connect(function()
	soundplaying = not soundplaying
	changeplayingtest(soundplaying)
end)

for _, button in pairs(script.Parent.screen.SurfaceGui.Frame:GetChildren()) do
	if button:IsA("Frame") then
		local x,y = button.AbsolutePosition.X,button.AbsolutePosition.Y
		button.selectbutton.CFrame = CFrame.new(34.328-(6.455*(x/776)), 7.312-(3.23*(y/388)), 730.664)
		button.selectbutton.ClickDetector.MouseClick:Connect(function()
			script.Parent.Selected.Value = button.Name
			base.ts(button,TweenInfo.new(0.1),{BackgroundColor3 = Color3.fromRGB(191, 191, 191)})
			base.ts(button.icon,TweenInfo.new(0.1),{ImageColor3 = Color3.fromRGB(255,255,255)})
			wait(0.1)
			base.ts(button,TweenInfo.new(0.1),{BackgroundColor3 = Color3.fromRGB(255,255,255)})
			base.ts(button.icon,TweenInfo.new(0.1),{ImageColor3 = Color3.fromRGB(0,0,0)})
			wait(0.1)
		end)
	end
end

local function upd(id)
	local dat = sirens[script.Parent.Selected.Value]
	local screen = script.Parent.screen.SurfaceGui.base
	if id == "empty" then
		soundplaying = false
		changeplayingtest(false)
		screen.sirenname.Text = dat[3][1]
		screen.sirencolor.Visible = false
		screen.sirentest.Visible = false
		screen.sirendescription.Visible = false
		screen.sirenspeed.Visible = false
	else
		screen.sirenname.Text = dat[3][1]
		screen.sirendescription.Text = dat[3][2]
		screen.sirenspeed.Text = math.round(dat[2][3]*10)
		screen.sirencolor.UIGradient.Color = ColorSequence.new(dat[2][1],dat[2][2])
		screen.sirencolor.Visible = true
		screen.sirentest.Visible = true
		screen.sirendescription.Visible = true
		screen.sirenspeed.Visible = true
		if soundplaying then
			changeplayingtest(true)
		end
	end
end
upd("empty")
local selected = "empty"
while wait() do
	if selected ~= script.Parent.Selected.Value then
		selected = script.Parent.Selected.Value
		upd(script.Parent.Selected.Value)
	end
end