local car = script.Parent.Parent
local Lights = car.Body.Lights
local FL = car.Misc.FL
local FR = car.Misc.FR
local gauge = car.Body.Display.GaugeDisplay.BMWGauges.BMWSystem
local F = {}

local LightOn = false
local LInd = false
local RInd = false
local pulseDur = .6

F.UpdateLight = function(prt,mat,col,trn,lon,lrg)
	prt.Material = mat
	prt.BrickColor = col
	prt.Transparency = trn
	prt.L.Enabled = lon
	prt.L.Range = lrg
end

F.ToggleBlinker = function(lo, li, ri, pd)
	LightOn = lo
	LInd = li
	RInd = ri
	pulseDur = pd
end


script.Parent.OnServerEvent:connect(function(pl,Fnc,...)
	F[Fnc](...)
end)

while wait(pulseDur) do
	if LInd or RInd then
		PsOn = not PsOn
		if PsOn then
			if LInd then
				F.UpdateLight(Lights.FLI,Enum.Material.Neon,BrickColor.new("New Yeller"),0,true,6)
				F.UpdateLight(FL.FLI2,Enum.Material.Neon,BrickColor.new("New Yeller"),0,true,6)
				F.UpdateLight(Lights.RLI,Enum.Material.Neon,BrickColor.new("New Yeller"),0,true,6)
				gauge.SymbolLights.Left.Visible = true
			end
			if RInd then
				F.UpdateLight(Lights.FRI,Enum.Material.Neon,BrickColor.new("New Yeller"),0,true,6)
				F.UpdateLight(FR.FRI2,Enum.Material.Neon,BrickColor.new("New Yeller"),0,true,6)
				F.UpdateLight(Lights.RRI,Enum.Material.Neon,BrickColor.new("New Yeller"),0,true,6)
				gauge.SymbolLights.Right.Visible = true
			end
		else
			if (not LInd) and LightOn then
				F.UpdateLight(Lights.FLI,Enum.Material.Neon,BrickColor.new("New Yeller"),0,false,20)
				F.UpdateLight(FL.FLI2,Enum.Material.Neon,BrickColor.new("New Yeller"),0,false,20)
				F.UpdateLight(Lights.RLI,Enum.Material.Neon,BrickColor.new("New Yeller"),0.1,false,10)
				gauge.SymbolLights.Left.Visible = true
			else
				F.UpdateLight(Lights.FLI,Enum.Material.SmoothPlastic,BrickColor.new("Medium stone grey"),0,false,20)
				F.UpdateLight(FL.FLI2,Enum.Material.SmoothPlastic,BrickColor.new("Medium stone grey"),0,false,20)
				F.UpdateLight(Lights.RLI,Enum.Material.SmoothPlastic,BrickColor.new("Medium stone grey"),0,false,10)
				gauge.SymbolLights.Left.Visible = false
			end
			if (not RInd) and LightOn then
				F.UpdateLight(Lights.FRI,Enum.Material.Neon,BrickColor.new("New Yeller"),0,false,20)
				F.UpdateLight(FR.FRI2,Enum.Material.Neon,BrickColor.new("New Yeller"),0,false,20)
				F.UpdateLight(Lights.RRI,Enum.Material.Neon,BrickColor.new("New Yeller"),0.1,false,10)
				gauge.SymbolLights.Right.Visible = true
			else
				F.UpdateLight(Lights.FRI,Enum.Material.SmoothPlastic,BrickColor.new("Medium stone grey"),0,false,20)
				F.UpdateLight(FR.FRI2,Enum.Material.SmoothPlastic,BrickColor.new("Medium stone grey"),0,false,20)
				F.UpdateLight(Lights.RRI,Enum.Material.SmoothPlastic,BrickColor.new("Medium stone grey"),0,false,10)
				gauge.SymbolLights.Right.Visible = false
			end
		end
	end
end