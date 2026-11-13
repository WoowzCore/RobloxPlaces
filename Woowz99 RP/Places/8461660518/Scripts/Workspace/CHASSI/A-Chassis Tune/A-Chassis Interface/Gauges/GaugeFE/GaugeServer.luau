local Car = script.Parent.Parent.Parent.Car.Value
repeat wait() until Car ~= nil
repeat wait() until Car.Body.Display.GaugeDisplay.BMWGauges.BMWSystem

local On = script.Parent.Parent.Parent.IsOn.Value

Car.Body.Display.GaugeDisplay.BMWGauges.Enabled = Car.Electrics.Value
Car.Body.Display.BMWHeadupDisplay.G.Enabled = Car.Electrics.Value

Car.Electrics.Changed:Connect(function()
	Car.Body.Display.GaugeDisplay.BMWGauges.Enabled = Car.Electrics.Value
	Car.Body.Display.BMWHeadupDisplay.G.Enabled = Car.Electrics.Value
end)

local tneedle = Car.Body.Display.GaugeDisplay.BMWGauges.BMWSystem.Tac
local tnodes = Car.Body.Display.GaugeDisplay.BMWGauges.BMWSystem.TacN
local sneedle = Car.Body.Display.GaugeDisplay.BMWGauges.BMWSystem.Spd
local snodes = Car.Body.Display.GaugeDisplay.BMWGauges.BMWSystem.SpdN
local tstart = false
local sstart = false
local RPM = 0
local spd = 0
local function handleTach(rpm,turnOn)
	if not turnOn and not tstart then
		local rot1 = math.floor(rpm/500)*500
		local rot2 = math.min(rot1+500,require(Car["A-Chassis Tune"]).Redline)
		local lrpm = rpm-rot1
		tneedle.Rotation = (tnodes[rot2].Rotation * (1 - ((rot2 - rpm)/500)) + (tnodes[rot1].Rotation*((rot2 - rpm)/500)))
		local nx = (tnodes[rot2].Position.X.Scale * (1 - ((rot2 - rpm)/500)) + (tnodes[rot1].Position.X.Scale*((rot2 - rpm)/500)))
		local ny = (tnodes[rot2].Position.Y.Scale * (1 - ((rot2 - rpm)/500)) + (tnodes[rot1].Position.Y.Scale*((rot2 - rpm)/500)))
		tneedle.Position = UDim2.new(nx,0,ny,0)
		return true
	elseif turnOn and not tstart and (On or not Car.Electrics.Value) then
		tstart = true
		tneedle.Position = tnodes["0"].Position
		local startTime = time()
		while time() - startTime < 0.33 do
			tneedle.Rotation = ((tnodes["0"].Rotation - tnodes["N"].Rotation) * ((time() - startTime)/0.33)) + tnodes["N"].Rotation
			sneedle.Rotation = ((snodes["0"].Rotation - snodes["N"].Rotation) * ((time() - startTime)/0.33)) + snodes["N"].Rotation
			wait(.01)
		end 
		tstart = false
		return true
	elseif turnOn and not tstart and (not On or Car.Electrics.Value)then
		tstart = true
		tneedle.Position = tnodes["0"].Position
		local startTime = time()
		while time() - startTime < 0.25 do
			tneedle.Rotation = ((tnodes["N"].Rotation - tnodes["0"].Rotation) * ((time() - startTime)/0.25)) + tnodes["0"].Rotation
			sneedle.Rotation = ((snodes["N"].Rotation - snodes["0"].Rotation) * ((time() - startTime)/0.25)) + snodes["0"].Rotation
			wait(.01)
		end 
		tstart = false
		return true
	end
end

local function handleSpd(spd,turnOn)
	if not turnOn and not sstart then
		local rot1 = math.max(math.floor(spd/10)*10,0)
		local rot2 = math.min(rot1+10,270)
		local lrpm = spd-rot1
		sneedle.Rotation = (snodes[rot2].Rotation * (1 - ((rot2 - spd)/10)) + (snodes[rot1].Rotation*((rot2 - spd)/10)))
		local nx = (snodes[rot2].Position.X.Scale * (1 - ((rot2 - spd)/10)) + (snodes[rot1].Position.X.Scale*((rot2 - spd)/10)))
		local ny = (snodes[rot2].Position.Y.Scale * (1 - ((rot2 - spd)/10)) + (snodes[rot1].Position.Y.Scale*((rot2 - spd)/10)))
		sneedle.Position = UDim2.new(nx,0,ny,0)
		return true
	elseif turnOn and not sstart and (On or not Car.Electrics.Value) then
		sstart = true
		sneedle.Position = snodes["0"].Position
		local startTime = time()
		while time() - startTime < 0.33 do
			sneedle.Rotation = ((snodes["0"].Rotation - snodes["N"].Rotation) * ((time() - startTime)/0.33)) + snodes["N"].Rotation
			wait(.01)
		end 
		sstart = false
		return true
	elseif turnOn and not sstart and (not On or Car.Electrics.Value)then
		sstart = true
		sneedle.Position = snodes["0"].Position
		local startTime = time()
		while time() - startTime < 0.25 do
			sneedle.Rotation = ((snodes["N"].Rotation - snodes["0"].Rotation) * ((time() - startTime)/0.25)) + snodes["0"].Rotation
			wait(.01)
		end 
		sstart = false
		return true
	end
end

script.Parent.OnServerEvent:Connect(function(plr, Type, value)
	if Type == "EBrake" then
		Car.Body.Display.BMWHeadupDisplay.G.BRAKE.Visible = value
		Car.Body.Display.GaugeDisplay.BMWGauges.BMWSystem.SymbolLights.BRAKE.Visible = value
	elseif Type == "EBrakeFull" then
		Car.Body.Display.BMWHeadupDisplay.G.BRAKE.Visible = false
		Car.Body.Display.GaugeDisplay.BMWGauges.BMWSystem.SymbolLights.BRAKE.Visible = false
	end
	--if Type == "RPM" then
		--Car.Body.Display.GaugeDisplay.BMWGauges.BMWSystem.TachNeedle.Rotation = (value/7000 * 212) - 30
	--end
	if Type == "Gear" then
		if value == 0 then
			Car.Body.Display.GaugeDisplay.BMWGauges.BMWSystem.Gear.Text = "N"
			Car.Body.Display.GaugeDisplay.BMWGauges.BMWSystem.GearSport.Text = "N"
		elseif value == -1 then	
			Car.Body.Display.GaugeDisplay.BMWGauges.BMWSystem.Gear.Text = "R"
			Car.Body.Display.GaugeDisplay.BMWGauges.BMWSystem.GearSport.Text = "R"
		elseif value >= 1 then
			Car.Body.Display.GaugeDisplay.BMWGauges.BMWSystem.GearSport.Text = ""..tostring(value)
		end
	elseif Type == "TCS" then
		Car.Body.Display.GaugeDisplay.BMWGauges.BMWSystem.SymbolLights.TCS.Visible = not value
		Car.Body.Display.GaugeDisplay.BMWGauges.BMWSystem.SymbolLights.TRACTION.Visible = not value
	elseif Type == "ABS" then
		Car.Body.Display.GaugeDisplay.BMWGauges.BMWSystem.SymbolLights.ABS.Visible = not value
	elseif Type == "PBrake" then
		Car.Body.Display.GaugeDisplay.BMWGauges.BMWSystem.SymbolLights.ParkingBrake.Visible = value
	elseif Type == "TCSActive" then
		Car.Body.Display.GaugeDisplay.BMWGauges.BMWSystem.SymbolLights.TCS2.Visible = value
	elseif Type == "ABSActive" then
		Car.Body.Display.GaugeDisplay.BMWGauges.BMWSystem.SymbolLights.ABS2.Visible = value
	elseif Type == "On" then
		On = value
		if not On then
			local r = RPM
			local s = spd
			repeat 
				r=math.max(r-require(Car["A-Chassis Tune"]).RevDecay*1.5,0)
				s=math.max(spd-5,0)
				handleTach(r,false)
				handleSpd(s,false)
				wait()
			until r<=0 and s<=0
		end
		repeat wait() until handleTach(0,true)
	elseif Type == "RPM" then
		RPM = value
		if On and not tstart then handleTach(RPM,false) end
	elseif Type == "Speed" then
		spd = value
		if On and not sstart then handleSpd(spd,false) end
		Car.Body.Display.GaugeDisplay.BMWGauges.BMWSystem.Speed.Text = tostring(value)
	end
end)

while wait(.5) do
	Car.Body.Display.GaugeDisplay.BMWGauges.BMWSystem.Time.Text = string.sub(game.Lighting.TimeOfDay, 1, 5)
end
