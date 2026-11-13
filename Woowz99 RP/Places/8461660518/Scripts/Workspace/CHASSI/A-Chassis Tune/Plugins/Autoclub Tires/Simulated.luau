  				    --//AC6 Ported Plugin [SS6]//--
				  --//SecondLogic x INSPARE 2017//--
				
--Tuning tips: If your car tends to oversteer, increase the ratio of friction towards the front (E.G. .65 front .6 rear), do the opposite in case of understeer

--Tune

local _Select = "AllSeason" --(AllSeason, Slicks, SemiSlicks, AllTerrain, DragRadials, Custom) Caps and space sensitive

local _Custom = {

	TireWearOn         = true    ,

    --Friction and Wear
    FWearSpeed        = 0    , --How fast your tires will degrade (Front)
    FTargetFriction    = .3   , --Friction in optimal conditions (Front)
    FMinFriction     = 0.3   , --Friction in worst conditions (Front)

    RWearSpeed        = 0    , --How fast your tires will degrade (Rear)
    RTargetFriction    = .3  ,  --Friction in optimal conditions (Rear)
    RMinFriction    = 0.3    , --Friction in worst conditions (Rear)

    --Tire Slip
    TCSOffRatio        = 1     , --How much optimal grip your car will lose with TCS off, set to 1 if you dont want any losses.
    WheelLockRatio    = 1/6    , --How much grip your car will lose when locking the wheels
    WheelspinRatio    = 1/1.2  , --How much grip your car will lose when spinning the wheels

    --Wheel Properties
    FFrictionWeight    = 2      , --Ratio of friction between wheel and terrain, the higher it is, the more true to target friction your grip wil be (Front) (PGS)
    RFrictionWeight    = 2      , --Ratio of friction between wheel and terrain, the higher it is, the more true to target friction your grip wil be (Rear) (PGS)
    FLgcyFrWeight    = 0        , --Ratio of friction between wheel and terrain, the higher it is, the more true to target friction your grip wil be (Front)
    RLgcyFrWeight    = 0        , --Ratio of friction between wheel and terrain, the higher it is, the more true to target friction your grip wil be (Rear)

    FElasticity        = 0     , --How much your wheel will bounce (Front) (PGS)
    RElasticity        = 0     , --How much your wheel will bounce (Rear) (PGS)
    FLgcyElasticity    = 0     , --How much your wheel will bounce (Front)
    RLgcyElasticity    = 0     , --How much your wheel will bounce (Rear)

    FElastWeight    = 1      , --Ratio of elasticity between wheel and terrain, the higher it is, the more true to the wheel elasticity it will be (Front) (PGS)
    RElastWeight    = 1      , --Ratio of elasticity between wheel and terrain, the higher it is, the more true to the wheel elasticity it will be (Rear) (PGS)
    FLgcyElWeight    = 10    , --Ratio of elasticity between wheel and terrain, the higher it is, the more true to the wheel elasticity it will be (Front)
    RLgcyElWeight    = 10    , --Ratio of elasticity between wheel and terrain, the higher it is, the more true to the wheel elasticity it will be (Rear)

    --Wear Regen
    RegenSpeed        = 0		, --Don't change this
}

local _AllSeason = {

	TireWearOn         = true    ,

    --Friction and Wear
    FWearSpeed        = .2    , --Don't change this
    FTargetFriction    = .6   , -- .58 to .63
    FMinFriction     = 0.35   , --Don't change this

    RWearSpeed        = .2    , --Don't change this
    RTargetFriction    = .6  , -- .58 to .63
    RMinFriction    = 0.35    , --Don't change this

    --Tire Slip
    TCSOffRatio        = 1     , --Don't change this
    WheelLockRatio    = 1/6    , --Don't change this
    WheelspinRatio    = 1/1.2  ,  --Don't change this

    --Wheel Properties
    FFrictionWeight    = 2      , --Don't change this
    RFrictionWeight    = 2      , --Don't change this
    FLgcyFrWeight    = 0        , --Don't change this
    RLgcyFrWeight    = 0        , --Don't change this

    FElasticity        = 0     , --Don't change this
    RElasticity        = 0     , --Don't change this
    FLgcyElasticity    = 0     , --Don't change this
    RLgcyElasticity    = 0     , --Don't change this

    FElastWeight    = 1      , --Don't change this
    RElastWeight    = 1      , --Don't change this
    FLgcyElWeight    = 10    , --Don't change this
    RLgcyElWeight    = 10    , --Don't change this

    --Wear Regen
    RegenSpeed        = 3.6		, --Don't change this
}

local _Slicks = {

	TireWearOn         = true    ,

    --Friction and Wear
    FWearSpeed        = .6    , --Don't change this
    FTargetFriction    = .93   , -- .88 to .93
    FMinFriction     = 0.35   , --Don't change this

    RWearSpeed        = .6    , --Don't change this
    RTargetFriction    = .93  , -- .88 to .93
    RMinFriction    = 0.35    , --Don't change this

    --Tire Slip
    TCSOffRatio        = 1     , --Don't change this
    WheelLockRatio    = 1/6    , --Don't change this
    WheelspinRatio    = 1/1.2  ,  --Don't change this

    --Wheel Properties
    FFrictionWeight    = 0.6      , --Don't change this
    RFrictionWeight    = 0.6      , --Don't change this
    FLgcyFrWeight    = 0        , --Don't change this
    RLgcyFrWeight    = 0        , --Don't change this

    FElasticity        = 0     , --Don't change this
    RElasticity        = 0     , --Don't change this
    FLgcyElasticity    = 0     , --Don't change this
    RLgcyElasticity    = 0     , --Don't change this

    FElastWeight    = 1      , --Don't change this
    RElastWeight    = 1      , --Don't change this
    FLgcyElWeight    = 10    , --Don't change this
    RLgcyElWeight    = 10    , --Don't change this

    --Wear Regen
    RegenSpeed        = 3.6		, --Don't change this
}

local _SemiSlicks = {

	TireWearOn         = true    ,

    --Friction and Wear
    FWearSpeed        = .5    , --Don't change this
    FTargetFriction    = .78   , -- .73 to .78
    FMinFriction     = 0.35   , --Don't change this

    RWearSpeed        = .5    , --Don't change this
    RTargetFriction    = .78  , -- .73 to .78
    RMinFriction    = 0.35    , --Don't change this

    --Tire Slip
    TCSOffRatio        = 1     , --Don't change this
    WheelLockRatio    = 1/6    , --Don't change this
    WheelspinRatio    = 1/1.2  ,  --Don't change this

    --Wheel Properties
    FFrictionWeight    = 0.6      , --Don't change this
    RFrictionWeight    = 0.6      , --Don't change this
    FLgcyFrWeight    = 0        , --Don't change this
    RLgcyFrWeight    = 0        , --Don't change this

    FElasticity        = 0     , --Don't change this
    RElasticity        = 0     , --Don't change this
    FLgcyElasticity    = 0     , --Don't change this
    RLgcyElasticity    = 0     , --Don't change this

    FElastWeight    = 1      , --Don't change this
    RElastWeight    = 1      , --Don't change this
    FLgcyElWeight    = 10    , --Don't change this
    RLgcyElWeight    = 10    , --Don't change this

    --Wear Regen
    RegenSpeed        = 3.6		, --Don't change this
}

local _AllTerrain = {

	TireWearOn         = true    ,

    --Friction and Wear
    FWearSpeed        = .3    , --Don't change this
    FTargetFriction    = .5   , -- .48 to .53
    FMinFriction     = 0.35   , --Don't change this

    RWearSpeed        = .3    , --Don't change this
    RTargetFriction    = .5  , -- .48 to .53
    RMinFriction    = 0.35    , --Don't change this

    --Tire Slip
    TCSOffRatio        = 1     , --Don't change this
    WheelLockRatio    = 1/6    , --Don't change this
    WheelspinRatio    = 1/1.2  ,  --Don't change this

    --Wheel Properties
    FFrictionWeight    = 10      , --Don't change this
    RFrictionWeight    = 10      , --Don't change this
    FLgcyFrWeight    = 0        , --Don't change this
    RLgcyFrWeight    = 0        , --Don't change this

    FElasticity        = 0     , --Don't change this
    RElasticity        = 0     , --Don't change this
    FLgcyElasticity    = 0     , --Don't change this
    RLgcyElasticity    = 0     , --Don't change this

    FElastWeight    = 1      , --Don't change this
    RElastWeight    = 1      , --Don't change this
    FLgcyElWeight    = 10    , --Don't change this
    RLgcyElWeight    = 10    , --Don't change this

    --Wear Regen
    RegenSpeed        = 3.6		, --Don't change this
}

local _DragRadials = {

	TireWearOn         = true    ,

    --Friction and Wear
    FWearSpeed        = 30    , --Don't change this
    FTargetFriction    = 1.2   , -- 1.18 to 1.23
    FMinFriction     = 0.35   , --Don't change this

    RWearSpeed        = 30    , --Don't change this
    RTargetFriction    = 1.2  , -- 1.18 to 1.23
    RMinFriction    = 0.35    , --Don't change this

    --Tire Slip
    TCSOffRatio        = 1     , --Don't change this
    WheelLockRatio    = 1/6    , --Don't change this
    WheelspinRatio    = 1/1.2  ,  --Don't change this

    --Wheel Properties
    FFrictionWeight    = 1      , --Don't change this
    RFrictionWeight    = 1      , --Don't change this
    FLgcyFrWeight    = 0        , --Don't change this
    RLgcyFrWeight    = 0        , --Don't change this

    FElasticity        = 0     , --Don't change this
    RElasticity        = 0     , --Don't change this
    FLgcyElasticity    = 0     , --Don't change this
    RLgcyElasticity    = 0     , --Don't change this

    FElastWeight    = 1      , --Don't change this
    RElastWeight    = 1      , --Don't change this
    FLgcyElWeight    = 10    , --Don't change this
    RLgcyElWeight    = 10    , --Don't change this

    --Wear Regen
    RegenSpeed        = 20		, --Don't change this
}


local car = script.Parent.Parent.Car.Value
local _Tune = require(car["A-Chassis Tune"])
local cValues = script.Parent.Parent:WaitForChild("Values")
local _WHEELTUNE = _AllSeason

if _Select == "DragRadials" then
	_WHEELTUNE = _DragRadials
elseif _Select == "Custom" then
	_WHEELTUNE = _Custom
elseif _Select == "AllTerrain" then
	_WHEELTUNE = _AllTerrain
elseif _Select == "Slicks" then
	_WHEELTUNE = _Slicks
elseif _Select == "SemiSlicks" then
	_WHEELTUNE = _SemiSlicks
else
	_WHEELTUNE = _AllSeason
end

car.DriveSeat.TireStats.Fwear.Value = _WHEELTUNE.FWearSpeed
car.DriveSeat.TireStats.Ffriction.Value = _WHEELTUNE.FTargetFriction
car.DriveSeat.TireStats.Fminfriction.Value = _WHEELTUNE.FMinFriction
car.DriveSeat.TireStats.Ffweight.Value = _WHEELTUNE.FFrictionWeight
		
car.DriveSeat.TireStats.Rwear.Value = _WHEELTUNE.RWearSpeed
car.DriveSeat.TireStats.Rfriction.Value = _WHEELTUNE.RTargetFriction
car.DriveSeat.TireStats.Rminfriction.Value = _WHEELTUNE.RMinFriction
car.DriveSeat.TireStats.Rfweight.Value = _WHEELTUNE.RFrictionWeight

car.DriveSeat.TireStats.TCS.Value = _WHEELTUNE.TCSOffRatio
car.DriveSeat.TireStats.Lock.Value = _WHEELTUNE.WheelLockRatio
car.DriveSeat.TireStats.Spin.Value = _WHEELTUNE.WheelspinRatio
car.DriveSeat.TireStats.Reg.Value = _WHEELTUNE.RegenSpeed

--Wheels Array
local fDensity = _Tune.FWheelDensity
local rDensity = _Tune.RWheelDensity
local fFwght = _WHEELTUNE.FFrictionWeight
local rFwght = _WHEELTUNE.RFrictionWeight
local fElast = _WHEELTUNE.FElasticity
local rElast = _WHEELTUNE.RElasticity
local fEwght = _WHEELTUNE.FElastWeight
local rEwght = _WHEELTUNE.RElastWeight
if not workspace:PGSIsEnabled() then
	fDensity = _Tune.FWLgcyDensity
	rDensity = _Tune.RWLgcyDensity
	fFwght = _WHEELTUNE.FLgcyFrWeight
	rFwght = _WHEELTUNE.FLgcyFrWeight
	fElast = _WHEELTUNE.FLgcyElasticity
	rElast = _WHEELTUNE.RLgcyElasticity
	fEwght = _WHEELTUNE.FLgcyElWeight
	rEwght = _WHEELTUNE.RLgcyElWeight
end
local Wheels = {}
for i,v in pairs(car.Wheels:GetChildren()) do
	local w = {}
	w.wheel = v
	local ca
	w.x = 0
	if v.Name == "FL" or v.Name == "FR" or v.Name == "F" then
		ca = (12-math.abs(_Tune.FCamber))/15
		w.x = fDensity
		w.BaseHeat = _WHEELTUNE.FTargetFriction-_WHEELTUNE.FMinFriction
		w.WearSpeed = _WHEELTUNE.FWearSpeed
		w.fWeight = fFwght
		w.elast = fElast
		w.eWeight = fEwght
	else
		ca = (12-math.abs(_Tune.RCamber))/15
		w.x = rDensity
		w.BaseHeat = _WHEELTUNE.RTargetFriction-_WHEELTUNE.RMinFriction
		w.WearSpeed = _WHEELTUNE.RWearSpeed
		w.fWeight = rFwght
		w.elast = rElast
		w.eWeight = rEwght
	end
	--if car:FindFirstChild("WearData")~=nil then
	--	w.Heat = math.min(w.BaseHeat,car.WearData[v.Name].Value+(((tick()-car.WearData.STime.Value)*_WHEELTUNE.RegenSpeed*15/10000)))
	--else
		w.Heat = w.BaseHeat
	--end
	w.stress = 0
	table.insert(Wheels,w)
end

--Close/Store Wear Data
car.DriveSeat.ChildRemoved:connect(function(child)
	if child.Name=="SeatWeld" then
		local wD=car:FindFirstChild("WearData")
		if car:FindFirstChild("WearData")==nil then
			wD = script.Parent.WearData:Clone()
			wD.Parent=car
		end
		for i,v in pairs(Wheels) do
			wD[v.wheel.Name].Value = v.Heat
		end
		wD.STime.Value=tick()
	end
end)

--Runtime Loop
while wait() do
	for i,v in pairs(Wheels) do
		--Vars
		local speed = car.DriveSeat.Velocity.Magnitude
		local wheel = v.wheel.RotVelocity.Magnitude
		local z = 0		
		local deg = 0.000126
		
		--Tire Wear
		local cspeed = (speed/1.298)*(2.6/v.wheel.Size.Y) 
		local wdif = math.abs(wheel-cspeed)
		if _WHEELTUNE.TireWearOn then
			if speed < 4 then
				--Wear Regen
				v.Heat = math.min(v.Heat + _WHEELTUNE.RegenSpeed/10000,v.BaseHeat)
			else
				--Tire Wear
				if wdif > 1 then
					v.Heat = v.Heat - wdif*deg*v.WearSpeed/28
				elseif v.Heat >= v.BaseHeat then
					v.Heat = v.BaseHeat
				end
			end
		end
		
		--Apply Friction
		if v.wheel.Name == "FL" or v.wheel.Name == "FR" or v.wheel.Name == "F" then
			z = _WHEELTUNE.FMinFriction+v.Heat
			deg = ((deg - 0.0001188*cValues.Brake.Value)*(1-math.abs(cValues.SteerC.Value))) + 0.00000126*math.abs(cValues.SteerC.Value)
		else
			z = _WHEELTUNE.RMinFriction+v.Heat
		end
		
		--Tire Slip
		if math.ceil((wheel/0.774/speed)*100) < 8 then
			--Lock Slip
			v.wheel.CustomPhysicalProperties = PhysicalProperties.new(v.x,z*_WHEELTUNE.WheelLockRatio,v.elast,v.fWeight,v.eWeight)
			v.Heat = math.max(v.Heat,0)
		elseif (_Tune.TCSEnabled and cValues.TCS.Value == false and math.ceil((wheel/0.774/speed)*100) > 80) then
			--TCS Off
			v.wheel.CustomPhysicalProperties = PhysicalProperties.new(v.x,z*_WHEELTUNE.TCSOffRatio,v.elast,v.fWeight,v.eWeight)
			v.Heat = math.max(v.Heat,0)
		elseif math.ceil((wheel/0.774/speed)*100) > 130 then
			--Wheelspin
			v.wheel.CustomPhysicalProperties = PhysicalProperties.new(v.x,z*_WHEELTUNE.WheelspinRatio,v.elast,v.fWeight,v.eWeight)		
			v.Heat = math.max(v.Heat,0)
		else
			--No Slip
			v.wheel.CustomPhysicalProperties = PhysicalProperties.new(v.x,z,v.elast,v.fWeight,v.eWeight)
			v.Heat = math.min(v.Heat,v.BaseHeat)
		end 
		
		--Update UI
		local vstress = math.abs(((((wdif+cspeed)/0.774)*0.774)-cspeed)/15)
		if vstress > 0.05 and vstress > v.stress then 
			v.stress = math.min(v.stress + 0.03,1)
		else
			v.stress = math.max(v.stress - 0.03,vstress)	
		end
		script.Parent:WaitForChild("Tires")
		local UI = script.Parent.Tires[v.wheel.Name]
		UI.First.Second.Image.ImageColor3 = Color3.new(math.min((v.stress*2),1), 1-v.stress, 0)
		UI.First.Position = UDim2.new(0,0,1-v.Heat/v.BaseHeat,0)
		UI.First.Second.Position = UDim2.new(0,0,v.Heat/v.BaseHeat,0)
	end
end