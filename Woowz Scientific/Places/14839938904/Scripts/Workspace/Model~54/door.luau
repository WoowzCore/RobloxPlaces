local door = script.Parent.doorpart
local ts = game:GetService("TweenService")

local lock1,lock2 = script.Parent.lock1,script.Parent.lock2

local scanning = false
local function ScanEyes()
	if scanning then return end
	lock2.i.ProximityPrompt.Enabled = false
	lock1.i.ProximityPrompt.Enabled = false
	scanning = true
	local function changescreens(t,t2)
		local function cs(s,t,t2)
			s.SurfaceGui.t1.Text = t
			s.SurfaceGui.t2.Text = t2
		end
		cs(lock1.screen1,t,t2)
		cs(lock1.screen2,t,t2)
	end
	changescreens("Verified!","You can move on")
	wait(1.5)
	ts:Create(door,TweenInfo.new(15),{CFrame = CFrame.new(163.675, -2225.419, -282.479)}):Play()
	wait(40)
	changescreens("Doors closing","")
	wait(4)
	ts:Create(door,TweenInfo.new(13),{CFrame = CFrame.new(163.675, -2235.234, -282.479)}):Play()
	wait(13)
	scanning = false
	lock2.i.ProximityPrompt.Enabled = true
	lock1.i.ProximityPrompt.Enabled = true
	changescreens("Hello!","Please look in the panel below")
end

lock1.i.ProximityPrompt.Triggered:Connect(ScanEyes)
lock2.i.ProximityPrompt.Triggered:Connect(ScanEyes)
