--SS3.33 Tesla Edit for Tesla Model X by Itzt (This is NOT SS3.33T.)
 
wait(0.1)
local player = game.Players.LocalPlayer
local lightOn = false
local HUB = script.Parent.HUB
local limitButton = HUB.Parent.Gauges.Circle.Zero.Limiter
local carSeat = script.Parent.CarSeat.Value
local mouse = game.Players.LocalPlayer:GetMouse()
local n = Instance.new("Motor")
local m = Instance.new("Motor")
local rwd = carSeat.Parent.Parent.RWD.RWD
local lwd = carSeat.Parent.Parent.LW.VS
local rrwd = carSeat.Parent.Parent.RW.VS
local windows = false
local winfob = HUB.Parent.Windows
local tailLights = carSeat.Parent.Taillights
local gear = 0
local ignition = 0
cc = script.Parent.CC

tq = 3.2
ftq = 3.2
brk = 6.4
cst = 0.2
 
m.Part0 = carSeat.Parent.Parent.Body2.MR
m.Part1 = carSeat.Parent.Parent.RW.SS
m.Parent = carSeat.Parent.Parent.Body2.MR
m.MaxVelocity = 0.05
n.Part0 = carSeat.Parent.Parent.Body2.ML
n.Part1 = carSeat.Parent.Parent.LW.SS
n.Parent = carSeat.Parent.Parent.Body2.ML
n.MaxVelocity = 0.05
 
 
a = false
d = false
w = false
s = false
q = false -- left
e = false -- right
r = false
 
local rightin = false
local leftin = false

-------------------------
 
mouse.KeyDown:connect(function (key)
    key = string.lower(key)
        if key == "a" then
            	a = true
        elseif key == "d" then
                d = true
        elseif key == "w" then
                w = true
                rwd.Throttle = gear*ignition
				rwd.Torque = tq
				lwd.Throttle = gear*ignition
				lwd.Torque = ftq
				rrwd.Throttle = gear*ignition
				rrwd.Torque = ftq
                carSeat.Throttle = 0
                carSeat.Torque = 0
				cc.Value = false
				if gear == 1 then
					rwd.MaxSpeed = 249*ignition
					lwd.MaxSpeed = 249*ignition
					rrwd.MaxSpeed = 249*ignition
				elseif gear == 0 then
					rwd.MaxSpeed = 0
					lwd.MaxSpeed = 0
					rrwd.MaxSpeed = 0
				elseif gear == -1 then
					rwd.MaxSpeed = 25*ignition
					lwd.MaxSpeed = 25*ignition
					rrwd.MaxSpeed = 25*ignition
				end
                elseif key == "s" then
                s = true    
                carSeat.Throttle = 0
                carSeat.Torque = 0
				rwd.Throttle = -1
				rwd.Torque = brk
				lwd.Throttle = -1
				lwd.Torque = brk
				rrwd.Throttle = -1
				rrwd.Torque = brk
				rwd.MaxSpeed = 0
				lwd.MaxSpeed = 0
				rrwd.MaxSpeed = 0
				cc.Value = false
				lightOn = true
				
				tailLights.A.Transparency = 0
				tailLights.A.Material = "Neon"
				tailLights.A.BrickColor = BrickColor.new("Really red")
				
				tailLights.B.Transparency = 0
				tailLights.B.Material = "Neon"
				tailLights.B.BrickColor = BrickColor.new("Really red")
				
				carSeat.Parent.Parent.SpoilerSys.Spoiler.BL.Transparency = 0
				carSeat.Parent.Parent.SpoilerSys.Spoiler.BL.Material = "Neon"
				carSeat.Parent.Parent.SpoilerSys.Spoiler.BL.BrickColor = BrickColor.new("Really red")
				
				tailLights.E.Lights.Enabled = true
				if ignition == 0 then
					ignition = 1
					carSeat.Startup:Play()
					carSeat.Parent.Runners.A.Material = "Neon"
					carSeat.Parent.Runners.B.Material = "Neon"
					carSeat.Parent.Runners.C.Material = "Neon"
					carSeat.Parent.Runners.D.Material = "Neon"
					carSeat.Parent.Runners.E.Material = "Neon"
					carSeat.Parent.Runners.F.Material = "Neon"
					carSeat.Parent.Runners.G.Material = "Neon"
					carSeat.Parent.Runners.H.Material = "Neon"
					carSeat.Parent.Runners.I.Material = "Neon"
					carSeat.Parent.Runners.J.Material = "Neon"
					carSeat.Parent.Runners.K.Material = "Neon"
					carSeat.Parent.Runners.L.Material = "Neon"
					carSeat.Parent.Runners.M.Material = "Neon"
					carSeat.Parent.Runners.N.Material = "Neon"
					carSeat.Parent.Runners.O.Disp.Enabled = true
					carSeat.Parent.Runners.P.Disp.Enabled = true
					if carSeat.Parent.Parent.DoorLD.Door.SS2.Motor.DesiredAngle < 0 then
						carSeat.Parent.Parent.DoorLD.Door.SS2.Motor.DesiredAngle = 0
						wait(0.58)
						carSeat.Parent.Parent.DoorLD.Door.Handle.DoorClose:Play()
					end
				end
                elseif key == "r" then --Gear selector
					if gear < 1 then
						gear = gear + 1
					end
                elseif key == "f" then
					if gear > -1 then
						gear = gear - 1
					end
				
				--// Car controls
				elseif key == "m" then --JOINTBREAKERS!!!!!
					if carSeat.SingleMode.Value == true then
					 if carSeat.Damage.Value == false then 
					  limitButton.Text = "Damage FX enabled"
					  carSeat.Parent.DE.JB.A.Disabled = false
					  carSeat.Parent.DE.JB.B.Disabled = false
					  carSeat.Parent.DE.JB2.A.Disabled = false
					  carSeat.Parent.DE.JB2.B.Disabled = false
					  carSeat.Damage.Value = true
					  wait(3)
					  limitButton.Text = ""
					 else carSeat.Damage.Value = false
					 limitButton.Text = "Damage FX disabled"
					  carSeat.Parent.DE.JB.A.Disabled = true
					  carSeat.Parent.DE.JB.B.Disabled = true
					  carSeat.Parent.DE.JB2.A.Disabled = true
					  carSeat.Parent.DE.JB2.B.Disabled = true
					  wait(3)
					  limitButton.Text = ""
					 end
					else
					  limitButton.Text = "Damage RESTRICTED"
					  carSeat.Parent.DE.JB.A.Disabled = true
					  carSeat.Parent.DE.JB.B.Disabled = true
					  carSeat.Parent.DE.JB2.A.Disabled = true
					  carSeat.Parent.DE.JB2.B.Disabled = true
				end
                elseif key == "j" then --Headlights
				 if carSeat.Lights.Value == false then 
				  limitButton.Text = "Lights on"
				  carSeat.Lights.Value = true
				
				  carSeat.Parent.Headlights.A.Lights.Enabled = true --A and B
				  carSeat.Parent.Headlights.A.Braking.Enabled = true
				  carSeat.Parent.Headlights.B.Lights.Enabled = true
				  carSeat.Parent.Headlights.B.Braking.Enabled = true
				
				  carSeat.Parent.Headlights.C.Material = "Neon" --Neons (Body)
				  carSeat.Parent.Headlights.D.Material = "Neon"
				  carSeat.Parent.Headlights.E.Material = "Neon"
				  carSeat.Parent.Parent.Trunk.TL.Material = "Neon" --Neons (Trunk)
				
				  tailLights.E.Light2.Enabled = true
				
				  wait(3)
				  limitButton.Text = ""
				 else carSeat.Lights.Value = false
				  limitButton.Text = "Lights off"
				
				  carSeat.Parent.Headlights.A.Lights.Enabled = false --A and B
				  carSeat.Parent.Headlights.A.Braking.Enabled = false
				  carSeat.Parent.Headlights.B.Lights.Enabled = false
				  carSeat.Parent.Headlights.B.Braking.Enabled = false
				
				  carSeat.Parent.Headlights.C.Material = "SmoothPlastic" --Neons (Body)
				  carSeat.Parent.Headlights.D.Material = "SmoothPlastic"
				  carSeat.Parent.Headlights.E.Material = "SmoothPlastic"
				  carSeat.Parent.Parent.Trunk.TL.Material = "SmoothPlastic" --Neons (Trunk)
				
				  tailLights.E.Light2.Enabled = false
				  wait(3)
				  limitButton.Text = ""
				 end
				elseif key == "p" then --Spoiler
				 if carSeat.Deployed.Value == false then 
				  limitButton.Text = "Spoiler deployed"
				  carSeat.Parent.Parent.Trunk.One.WH2.Motor.DesiredAngle = 0.06
				  carSeat.Parent.Parent.SpoilerSys.Two.WH3.Motor.DesiredAngle = 0.4
				  carSeat.Parent.Parent.SpoilerSys.Two.WH3.Motor.MaxVelocity = 0.02
				  carSeat.Deployed.Value = true
				  wait(3)
				  limitButton.Text = ""
				 else carSeat.Deployed.Value = false
				 limitButton.Text = "Spoiler retracted"
				  carSeat.Parent.Parent.Trunk.One.WH2.Motor.DesiredAngle = 0
				  carSeat.Parent.Parent.SpoilerSys.Two.WH3.Motor.DesiredAngle = 0
				  carSeat.Parent.Parent.SpoilerSys.Two.WH3.Motor.MaxVelocity = -0.05
				  wait(3)
				  limitButton.Text = ""
				 end
				elseif key == "b" then --Window controls
				 if windows == false then 
					winfob.Visible = true
					windows = true
				 else windows = false
					winfob.Visible = false
				 end

				--// Indicators
				elseif key == "q" then
					q = true
					if not leftin then
						leftin = true
						for i,v in pairs(carSeat.Parent:GetChildren()) do
							coroutine.resume(coroutine.create(function()
								if v.Name == "LeftIndicator" then
									while leftin do
										script.Parent:WaitForChild("TickTock").Pitch = 1
										script.Parent.TickTock:Play()
										v.PointLight.Enabled = false
										v.BillboardGui.Enabled = false
										limitButton.Parent.Left.Visible = false
										wait(0.35)
										script.Parent.TickTock.Pitch = .8
										script.Parent.TickTock:Play()
										v.BillboardGui.Enabled = true
										v.PointLight.Enabled = true
										limitButton.Parent.Left.Visible = true
										wait(0.35)
									end
									v.PointLight.Enabled = false
									v.BillboardGui.Enabled = false
									limitButton.Parent.Left.Visible = false
								end
							end))
						end
					else
						leftin = false
					end
				elseif key == "e" then
					e = true
					if not rightin then
						rightin = true
						for i,v in pairs(carSeat.Parent:GetChildren()) do
							coroutine.resume(coroutine.create(function()
								if v.Name == "RightIndicator" then
									while rightin do
										script.Parent:WaitForChild("TickTock").Pitch = 1
										script.Parent.TickTock:Play()
										v.PointLight.Enabled = false
										v.BillboardGui.Enabled = false
										limitButton.Parent.Right.Visible = false
										wait(0.35)
										script.Parent.TickTock.Pitch = .8
										script.Parent.TickTock:Play()
										v.BillboardGui.Enabled = true
										v.PointLight.Enabled = true
										limitButton.Parent.Right.Visible = true
										wait(0.35)
									end
									v.PointLight.Enabled = false
									v.BillboardGui.Enabled = false
									limitButton.Parent.Right.Visible = false
								end
							end))
						end
					else
						rightin = false
					    end
					end
				end)
 
mouse.KeyUp:connect(function (key)
    key = string.lower(key)
        if key == "a" then
                print("a up")
                if d == false then
                m.DesiredAngle = 0
                        n.DesiredAngle = m.DesiredAngle
                end
        elseif key == "d" then
                print("d up")
                if a == false then
                m.DesiredAngle = 0
                        n.DesiredAngle = m.DesiredAngle
end
        end
        a = false
        d = false
end)
 
mouse.KeyUp:connect(function (key)
    key = string.lower(key)
if key == "w" or key == "s" then
        rwd.Throttle = 0
        rwd.Torque = 0
	    lwd.Throttle = 0
		lwd.Torque = 0
		rrwd.Throttle = 0
		rrwd.Torque = 0

       carSeat.Throttle = 0
		lightOn = false
		carSeat.Torque = cst
		tailLights.A.Transparency = 0.7
		tailLights.A.Material = "SmoothPlastic"
		tailLights.A.BrickColor = BrickColor.new("Ghost grey")
		
		tailLights.B.Transparency = 0.7
		tailLights.B.Material = "SmoothPlastic"
		tailLights.B.BrickColor = BrickColor.new("Ghost grey")
		
		carSeat.Parent.Parent.SpoilerSys.Spoiler.BL.Transparency = 0.7
		carSeat.Parent.Parent.SpoilerSys.Spoiler.BL.Material = "SmoothPlastic"
		carSeat.Parent.Parent.SpoilerSys.Spoiler.BL.BrickColor = BrickColor.new("Ghost grey")
		
		tailLights.E.Lights.Enabled = false 
        end
end)   
------CruisinWithMyHomies v--- 
mouse.KeyDown:connect(function (key)
    key = string.lower(key)
             
if carSeat.Velocity.Magnitude > 25 and key == "x" and cc.Value == false then
	cc.Value = true
	rwd.MaxSpeed = carSeat.Velocity.Magnitude
	rrwd.MaxSpeed = carSeat.Velocity.Magnitude
	lwd.MaxSpeed = carSeat.Velocity.Magnitude
	rwd.Torque = tq
	rrwd.Torque = ftq
	lwd.Torque = ftq
	rwd.Throttle = 1
	rrwd.Throttle = 1
	lwd.Throttle = 1
elseif key == "x" and cc.Value == true then
	cc.Value = false
	
end
end) 
------CruisinWithMyHomies ^--- 

winfob.FL.Lock.MouseButton1Click:connect(function() --Window
 if carSeat.WindowFL.Value == false then 
  carSeat.WindowFL.Value = true
  carSeat.Parent.Parent.DoorLD.Window.SS.Motor.DesiredAngle = -0.25
 else carSeat.WindowFL.Value = false
  carSeat.Parent.Parent.DoorLD.Window.SS.Motor.DesiredAngle = 0
 end
end)

winfob.FR.Lock.MouseButton1Click:connect(function() --Window
 if carSeat.WindowFR.Value == false then 
  carSeat.WindowFR.Value = true
  carSeat.Parent.Parent.DoorRD.Window.SS.Motor.DesiredAngle = 0.25
 else carSeat.WindowFR.Value = false
  carSeat.Parent.Parent.DoorRD.Window.SS.Motor.DesiredAngle = 0
 end
end)

winfob.RL.Lock.MouseButton1Click:connect(function() --Window
 if carSeat.WindowRL.Value == false then 
  carSeat.WindowRL.Value = true
  carSeat.Parent.Parent.DoorL.W.SS.Motor.DesiredAngle = 0.25
 else carSeat.WindowRL.Value = false
  carSeat.Parent.Parent.DoorL.W.SS.Motor.DesiredAngle = 0
 end
end)

winfob.RR.Lock.MouseButton1Click:connect(function() --Window
 if carSeat.WindowRR.Value == false then 
  carSeat.WindowRR.Value = true
  carSeat.Parent.Parent.DoorR.W.SS.Motor.DesiredAngle = 0.25
 else carSeat.WindowRR.Value = false
  carSeat.Parent.Parent.DoorR.W.SS.Motor.DesiredAngle = 0
 end
end)
while true do --Loop
	wait()
	if gear == -1 then
		HUB.Parent.Gauges.Circle.Zero.Gear.Text = "R"
		carSeat.Parent.Parent.Trunk.R1.Material = "Neon"
		carSeat.Parent.Parent.Trunk.R2.Material = "Neon"
		carSeat.Parent.R1.Material = "Neon"
		carSeat.Parent.R2.Material = "Neon"
		carSeat.Parent.Parent.Trunk.R1.Transparency = 0
		carSeat.Parent.Parent.Trunk.R2.Transparency = 0
		carSeat.Parent.R1.Transparency = 0
		carSeat.Parent.R2.Transparency = 0
		carSeat.Parent.Runners.O.Disp.One.Visible = false
		carSeat.Parent.Runners.O.Disp.Two.Visible = true
	elseif gear == 0 then
		HUB.Parent.Gauges.Circle.Zero.Gear.Text = "N"
		carSeat.Parent.Parent.Trunk.R1.Material = "SmoothPlastic"
		carSeat.Parent.Parent.Trunk.R2.Material = "SmoothPlastic"
		carSeat.Parent.R1.Material = "SmoothPlastic"
		carSeat.Parent.R2.Material = "SmoothPlastic"
		carSeat.Parent.Parent.Trunk.R1.Transparency = 0.9
		carSeat.Parent.Parent.Trunk.R2.Transparency = 0.9
		carSeat.Parent.R1.Transparency = 0.9
		carSeat.Parent.Runners.O.Disp.One.Visible = true
		carSeat.Parent.Runners.O.Disp.Two.Visible = false
		carSeat.Parent.R2.Transparency = 0.9
	elseif gear == 1 then
		HUB.Parent.Gauges.Circle.Zero.Gear.Text = "D"
	end
	if carSeat.Throttle == 1 and gear >= 1 or gear == -1 and carSeat.Throttle == 1 then
		if carSeat.InsaneMode.Value == true and carSeat.Power.Value < 60 then
			carSeat.Power.Value = carSeat.Power.Value + 3
		elseif carSeat.InsaneMode.Value == false and carSeat.Power.Value < 40 then
			carSeat.Power.Value = carSeat.Power.Value +2
		end
	else
		carSeat.Power.Value = 0
	end
	limitButton.Parent.Time.Text = game.Lighting.TimeOfDay
end