local car = script.Parent.Parent.Car.Value
local mouse = game.Players.LocalPlayer:GetMouse()
local cValues = script.Parent.Parent.Values
local Lights = car.Body.Lights
local gauge = car.Body.Display.GaugeDisplay.BMWGauges.BMWSystem
local Trunk = car.Misc.Trunk
local FL = car.Misc.FL
local FR = car.Misc.FR
local FE = workspace.FilteringEnabled
local handler = car:WaitForChild("Lights_FE")

local mode=0
local LightOn=false
local LInd=false
local RInd=false
local PsOn=true
local lSteer = 0
local rSteer = 0
local pulseDur = .6

handler:FireServer("ToggleBlinker",false,false,false,1)

function UpdateLight(prt,mat,col,trn,lon,lrg)
	if FE then
		handler:FireServer("UpdateLight",prt,mat,col,trn,lon,lrg)
	else
		prt.Material = mat
		prt.BrickColor = col
		prt.Transparency = trn
		prt.L.Enabled = lon
		prt.L.Range = lrg
	end
end

car.DriveSeat.ChildRemoved:connect(function(child)
	if child.Name=="SeatWeld" then
		UpdateLight(Lights.RV,Enum.Material.SmoothPlastic,BrickColor.new("Institutional white"),0,false,15)
		if LightOn then
			UpdateLight(Lights.FLI,Enum.Material.SmoothPlastic,BrickColor.new("Medium stone grey"),0,false,20)
			UpdateLight(FL.FLI2,Enum.Material.SmoothPlastic,BrickColor.new("Medium stone grey"),0,false,20)
			UpdateLight(Lights.FRI,Enum.Material.SmoothPlastic,BrickColor.new("Medium stone grey"),0,false,20)
			UpdateLight(FR.FRI2,Enum.Material.SmoothPlastic,BrickColor.new("Medium stone grey"),0,false,20)
			UpdateLight(Lights.Runner,Enum.Material.Neon,BrickColor.new("Maroon"),0.1,true,2)
			UpdateLight(Lights.RLI,Enum.Material.SmoothPlastic,BrickColor.new("Medium stone grey"),0.1,false,10)
			UpdateLight(Lights.RRI,Enum.Material.SmoothPlastic,BrickColor.new("Medium stone grey"),0.1,false,10)
		else
			UpdateLight(Lights.FLI,Enum.Material.SmoothPlastic,BrickColor.new("Medium stone grey"),0,false,20)
			UpdateLight(FL.FLI2,Enum.Material.SmoothPlastic,BrickColor.new("Medium stone grey"),0,false,20)
			UpdateLight(Lights.FRI,Enum.Material.SmoothPlastic,BrickColor.new("Medium stone grey"),0,false,20)
			UpdateLight(FR.FRI2,Enum.Material.SmoothPlastic,BrickColor.new("Medium stone grey"),0,false,20)
			UpdateLight(Lights.Runner,Enum.Material.SmoothPlastic,BrickColor.new("Maroon"),0,false,10)
			UpdateLight(Lights.RLI,Enum.Material.SmoothPlastic,BrickColor.new("Medium stone grey"),0,false,10)
			UpdateLight(Lights.RRI,Enum.Material.SmoothPlastic,BrickColor.new("Medium stone grey"),0,false,10)
		end
		if LInd or RInd then
			handler:FireServer("ToggleBlinker",LightOn,LInd,RInd,pulseDur)
		end
	end
end)

function ToggleLight()
	if LightOn then
		UpdateLight(Lights.F,Enum.Material.Neon,BrickColor.new("Institutional white"),0,true,60)
		UpdateLight(Lights.LED,Enum.Material.Neon,BrickColor.new("Royal purple"),0,true,60)
		UpdateLight(Lights.LED2,Enum.Material.Neon,BrickColor.new("Royal purple"),0,true,60)
		UpdateLight(FL.L,Enum.Material.Neon,BrickColor.new("Royal purple"),0,true,60)
		UpdateLight(FR.R,Enum.Material.Neon,BrickColor.new("Royal purple"),0,true,60)
        UpdateLight(Lights.Beam,Enum.Material.Neon,BrickColor.new("Institutional white"),1,true,60)
		if not LInd then UpdateLight(Lights.FLI,Enum.Material.SmoothPlastic,BrickColor.new("Neon orange"),0,false,20) end
		if not RInd then UpdateLight(Lights.FRI,Enum.Material.SmoothPlastic,BrickColor.new("Neon orange"),0,false,20) end
	else
		UpdateLight(Lights.F,Enum.Material.SmoothPlastic,BrickColor.new("Medium stone grey"),0,false,60)
		UpdateLight(Lights.LED,Enum.Material.SmoothPlastic,BrickColor.new("Really black"),0,false,60)
		UpdateLight(Lights.LED2,Enum.Material.SmoothPlastic,BrickColor.new("Really black"),0,false,60)
		UpdateLight(FL.L,Enum.Material.SmoothPlastic,BrickColor.new("Really black"),0,false,60)
		UpdateLight(FR.R,Enum.Material.SmoothPlastic,BrickColor.new("Really black"),0,false,60)
		UpdateLight(Lights.Beam,Enum.Material.SmoothPlastic,BrickColor.new("Medium stone grey"),1,false,60)
		if not LInd then UpdateLight(Lights.FLI,Enum.Material.SmoothPlastic,BrickColor.new("Medium stone grey"),0,false,20) end
		if not RInd then UpdateLight(Lights.FRI,Enum.Material.SmoothPlastic,BrickColor.new("Medium stone grey"),0,false,20) end
	end
	if cValues.Brake.Value>0 then
		UpdateLight(Lights.R,Enum.Material.SmoothPlastic,BrickColor.new("Maroon"),0,true,15)
		UpdateLight(Trunk.R2,Enum.Material.SmoothPlastic,BrickColor.new("Maroon"),0,true,15)
		if not LInd then UpdateLight(Lights.RLI,Enum.Material.SmoothPlastic,BrickColor.new("Medium stone grey"),0,false,15) end
		if not RInd then UpdateLight(Lights.RRI,Enum.Material.SmoothPlastic,BrickColor.new("Medium stone grey"),0,false,15) end
	else
		if LightOn then
			UpdateLight(Lights.Runner,Enum.Material.Neon,BrickColor.new("Maroon"),0.1,true,2)
			if not LInd then UpdateLight(Lights.RLI,Enum.Material.SmoothPlastic,BrickColor.new("Medium stone grey"),0.1,false,10) end
			if not RInd then UpdateLight(Lights.RRI,Enum.Material.SmoothPlastic,BrickColor.new("Medium stone grey"),0.1,false,10) end
		else
			UpdateLight(Lights.Runner,Enum.Material.SmoothPlastic,BrickColor.new("Maroon"),0,false,10)
			if not LInd then UpdateLight(Lights.RLI,Enum.Material.SmoothPlastic,BrickColor.new("Medium stone grey"),0,false,10) end
			if not RInd then UpdateLight(Lights.RRI,Enum.Material.SmoothPlastic,BrickColor.new("Medium stone grey"),0,false,10) end
		end
	end
end

cValues.Brake.Changed:connect(function()
	if cValues.Brake.Value>0 then
		UpdateLight(Lights.R,Enum.Material.Neon,BrickColor.new("Bright red"),0,true,12)
		UpdateLight(Trunk.R2,Enum.Material.Neon,BrickColor.new("Bright red"),0,true,12)
		if not LInd then UpdateLight(Lights.RLI,Enum.Material.SmoothPlastic,BrickColor.new("Medium stone grey"),0,false,15) end
		if not RInd then UpdateLight(Lights.RRI,Enum.Material.SmoothPlastic,BrickColor.new("Medium stone grey"),0,false,15) end
	else
		if LightOn then
			UpdateLight(Lights.R,Enum.Material.SmoothPlastic,BrickColor.new("Maroon"),0.1,true,8)
			UpdateLight(Lights.Runner,Enum.Material.Neon,BrickColor.new("Maroon"),0.1,true,4)
			UpdateLight(Trunk.R2,Enum.Material.SmoothPlastic,BrickColor.new("Maroon"),0.1,true,8)
			if not LInd then UpdateLight(Lights.RLI,Enum.Material.SmoothPlastic,BrickColor.new("Medium stone grey"),0.1,false,10) end
			if not RInd then UpdateLight(Lights.RRI,Enum.Material.SmoothPlastic,BrickColor.new("Medium stone grey"),0.1,false,10) end
		else
			UpdateLight(Lights.R,Enum.Material.SmoothPlastic,BrickColor.new("Maroon"),0,false,10)
			UpdateLight(Lights.Runner,Enum.Material.SmoothPlastic,BrickColor.new("Maroon"),0,false,10)
			UpdateLight(Trunk.R2,Enum.Material.SmoothPlastic,BrickColor.new("Maroon"),0.1,false,10)
			if not LInd then UpdateLight(Lights.RLI,Enum.Material.SmoothPlastic,BrickColor.new("Medium stone grey"),0,false,10) end
			if not RInd then UpdateLight(Lights.RRI,Enum.Material.SmoothPlastic,BrickColor.new("Medium stone grey"),0,false,10) end
		end
	end
end)

UpdateLight(Lights.RV,Enum.Material.SmoothPlastic,BrickColor.new("Institutional white"),0,false,15)
cValues.Gear.Changed:connect(function()
	if cValues.Gear.Value == -1 then
		UpdateLight(Lights.RV,Enum.Material.Neon,BrickColor.new("Institutional white"),0,true,12)
	else
		UpdateLight(Lights.RV,Enum.Material.SmoothPlastic,BrickColor.new("Institutional white"),0,false,15)
	end
end)

mouse.keyDown:connect(function(k)
	if k=="z" then
		if RInd then
			RInd=false
			LInd=true
		else
			LInd=not LInd
		end
	elseif k=="c" then
		if LInd then
			LInd=false
			RInd=true
		else
			RInd=not RInd
		end		
	elseif k=="x" then
		if LInd and RInd then
			LInd = false
			RInd = false
		else
			LInd = true
			RInd = true
		end
	elseif k=="h" then
		if mode==0 then
			mode= 1
			LightOn=true
			gauge.SymbolLights.HighBeams.Visible = true
		elseif mode==1 then
			mode=0
			LightOn=false
			gauge.SymbolLights.HighBeams.Visible = false
		end
		ToggleLight()
	end
end)

game:GetService("UserInputService").InputBegan:connect(function(input,IsRobloxFunction)
	if input.KeyCode ==Enum.KeyCode.DPadLeft and input.UserInputState == Enum.UserInputState.Begin then
		if RInd then
			RInd=false
			LInd=true
		else
			LInd=not LInd
		end
	elseif input.KeyCode ==Enum.KeyCode.DPadRight and input.UserInputState == Enum.UserInputState.Begin then
		if LInd then
			LInd=false
			RInd=true
		else
			RInd=not RInd
		end
	elseif input.KeyCode ==Enum.KeyCode.DPadUp and input.UserInputState == Enum.UserInputState.Begin then
		if LInd and RInd then
			LInd = false
			RInd = false
		else
			LInd = true
			RInd = true
		end
	end
end)

while wait(pulseDur) do
	PsOn = not PsOn
	if PsOn then
		if LInd then
			script.Parent.Left.Visible=true
			gauge.SymbolLights.Left.Visible = true
			UpdateLight(Lights.FLI,Enum.Material.Neon,BrickColor.new("New Yeller"),0,true,6)
			UpdateLight(FL.FLI2,Enum.Material.Neon,BrickColor.new("New Yeller"),0,true,6)
			UpdateLight(Lights.RLI,Enum.Material.Neon,BrickColor.new("New Yeller"),0,true,6)
		end
		if RInd then
			script.Parent.Right.Visible=true
			gauge.SymbolLights.Right.Visible = true
			UpdateLight(Lights.FRI,Enum.Material.Neon,BrickColor.new("New Yeller"),0,true,6)
			UpdateLight(FR.FRI2,Enum.Material.Neon,BrickColor.new("New Yeller"),0,true,6)
			UpdateLight(Lights.RRI,Enum.Material.Neon,BrickColor.new("New Yeller"),0,true,6)
		end
	else
		gauge.SymbolLights.Left.Visible = false
		gauge.SymbolLights.Right.Visible = false
		script.Parent.Left.Visible=false
		script.Parent.Right.Visible=false
		
		if (not LInd) and LightOn then
			UpdateLight(Lights.FLI,Enum.Material.SmoothPlastic,BrickColor.new("Medium stone grey"),0,false,20)
			UpdateLight(FL.FLI2,Enum.Material.SmoothPlastic,BrickColor.new("Medium stone grey"),0,false,20)
		else
			UpdateLight(Lights.FLI,Enum.Material.SmoothPlastic,BrickColor.new("Medium stone grey"),0,false,20)
			UpdateLight(FL.FLI2,Enum.Material.SmoothPlastic,BrickColor.new("Medium stone grey"),0,false,20)
		end
		if (not RInd) and LightOn then
			UpdateLight(Lights.FRI,Enum.Material.SmoothPlastic,BrickColor.new("Medium stone grey"),0,false,20)
			UpdateLight(FR.FRI2,Enum.Material.SmoothPlastic,BrickColor.new("Medium stone grey"),0,false,20)
		else
			UpdateLight(Lights.FRI,Enum.Material.SmoothPlastic,BrickColor.new("Medium stone grey"),0,false,20)
			UpdateLight(FR.FRI2,Enum.Material.SmoothPlastic,BrickColor.new("Medium stone grey"),0,false,20)
		end
		if cValues.Brake.Value>0 then
			if not LInd then 
				UpdateLight(Lights.RLI,Enum.Material.SmoothPlastic,BrickColor.new("Medium stone grey"),0,false,15)
			else
				UpdateLight(Lights.RLI,Enum.Material.SmoothPlastic,BrickColor.new("Medium stone grey"),0,false,10)
			end
			if not RInd then
				UpdateLight(Lights.RRI,Enum.Material.SmoothPlastic,BrickColor.new("Medium stone grey"),0,false,15)
			else
				UpdateLight(Lights.RRI,Enum.Material.SmoothPlastic,BrickColor.new("Medium stone grey"),0,false,10)
			end
		else
			if (not LInd) and LightOn then 
				UpdateLight(Lights.RLI,Enum.Material.SmoothPlastic,BrickColor.new("Medium stone grey"),0.1,false,10)
			else
				UpdateLight(Lights.RLI,Enum.Material.SmoothPlastic,BrickColor.new("Medium stone grey"),0,false,10)
			end
			if (not RInd) and LightOn then 
				UpdateLight(Lights.RRI,Enum.Material.SmoothPlastic,BrickColor.new("Medium stone grey"),0.1,false,10)
			else
				UpdateLight(Lights.RRI,Enum.Material.SmoothPlastic,BrickColor.new("Medium stone grey"),0,false,10)
			end
		end
	end
end