--[[
	   ___      _______                _        _____
	  / _ |____/ ___/ /  ___ ____ ___ (_)__    / ___/
	 / __ /___/ /__/ _ \/ _ `(_-<(_-</ (_-<   / /__
	/_/ |_|   \___/_//_/\_,_/___/___/_/___/	  \___/  
	
	Avxnturador, DJay500, RikOne2 | Novena
	
	*I assume you know what you're doing if you're gonna change something here.* ]]--
	
	--[[START]]
	
	script.Parent:WaitForChild("Car")
	script.Parent:WaitForChild("IsOn")
	script.Parent:WaitForChild("ControlsOpen")
	script.Parent:WaitForChild("Values")
	
	--[[Dependencies]]
	
	local player = game.Players.LocalPlayer
	local mouse = player:GetMouse()
	local UserInputService = game:GetService("UserInputService")
	local car = script.Parent.Car.Value
	local _Tune = require(car["A-Chassis Tune"])
	
	--[[Output Scaling Factor]]
	
	local hpScaling = _Tune.WeightScaling*10
	local FBrakeForce = _Tune.FBrakeForce
	local RBrakeForce = _Tune.RBrakeForce
	local PBrakeForce = _Tune.PBrakeForce
	if not workspace:PGSIsEnabled() then
		hpScaling = _Tune.LegacyScaling*10
		FBrakeForce = _Tune.FLgcyBForce
		RBrakeForce = _Tune.RLgcyBForce
		PBrakeForce = _Tune.LgcyPBForce
	end
	
	--[[Status Vars]]
	
	local _IsOn = _Tune.AutoStart
	if _Tune.AutoStart and (_Tune.Engine or _Tune.Electric) then script.Parent.IsOn.Value=true end
	
	local _GSteerT=0
	local _GSteerC=0
	local _GThrot=0
	local _InThrot=0
	local _IThrot=_Tune.IdleThrottle/100
	local _GBrake=0
	local _InBrake=0
	local _IBrake=0
	
	local _ClPressing = false
	local _Clutch = 0
	local _ClutchKick = 0
	local _ClutchModulate = 0
	local _RPM = 0
	local _HP = 0
	local _OutTorque = 0
	local _CGear = 0
	local _PGear = _CGear
	local _ShiftUp = false
	local _ShiftDn = false
	local _Shifting = false
	local _spLimit = 0
	
	local _Boost = 0
	local _TCount = 0
	local _TPsi = 0
	local _TBoost = 0
	local _SCount = 0
	local _SPsi = 0
	local _SBoost = 0
	local _NH = 0
	local _NT = 0
	local _EH = 0
	local _ET = 0
	local _TH = 0
	local _TT = 0
	local _SH = 0
	local _ST = 0
	local _BH = 0
	local _BT = 0
	
	local _TMode = _Tune.TransModes[1]
	
	local _MSteer = false
	local _SteerL = false
	local _SteerR = false
	local _PBrake = false
	local _TCS = _Tune.TCSEnabled
	local _TCSActive = false
	local _TCSAmt = 0
	local _ABS = _Tune.ABSEnabled
	local _ABSActive = false
	
	local FlipWait=tick()
	local FlipDB=false
	
	local _InControls = false
	
	
	--[[Shutdown]]
	
	car.DriveSeat.ChildRemoved:connect(function(child) if child.Name=="SeatWeld" and child:IsA("Weld") then script.Parent:Destroy() end end)
	
	--[[Controls]]
	
	local _CTRL = _Tune.Controls
	local Controls = Instance.new("Folder",script.Parent)
	Controls.Name = "Controls"
	for i,v in pairs(_CTRL) do
		local a=Instance.new("StringValue",Controls)
		a.Name=i
		a.Value=v.Name
		a.Changed:connect(function()
			if i=="MouseThrottle" or i=="MouseBrake" then
				if a.Value == "MouseButton1" or a.Value == "MouseButton2" then
					_CTRL[i]=Enum.UserInputType[a.Value]
				else
					_CTRL[i]=Enum.KeyCode[a.Value]
				end
			else
				_CTRL[i]=Enum.KeyCode[a.Value]
			end
		end)
	end
	
	--Deadzone Adjust
	local _PPH = _Tune.Peripherals
		for i,v in pairs(_PPH) do
		local a = Instance.new("IntValue",Controls)
		a.Name = i
		a.Value = v
		a.Changed:connect(function() 
			a.Value=math.min(100,math.max(0,a.Value))
			_PPH[i] = a.Value
		end)
	end
	
	--Input Handler
	function DealWithInput(input,IsRobloxFunction)
		if (UserInputService:GetFocusedTextBox()==nil) and not _InControls then --Ignore when UI Focus
			--Shift Down [Manual Transmission]
			if (input.KeyCode ==_CTRL["ContlrShiftDown"] or (_MSteer and input.KeyCode==_CTRL["MouseShiftDown"]) or ((not _MSteer) and input.KeyCode==_CTRL["ShiftDown"])) and ((_IsOn and ((_TMode=="Auto" and _CGear<=1) and _Tune.AutoShiftVers == "New") or _TMode=="Semi") or _TMode=="Manual") and input.UserInputState == Enum.UserInputState.Begin then
				if not _ShiftDn then _ShiftDn = true end
				
			--Shift Up [Manual Transmission]
			elseif (input.KeyCode ==_CTRL["ContlrShiftUp"] or (_MSteer and input.KeyCode==_CTRL["MouseShiftUp"]) or ((not _MSteer) and input.KeyCode==_CTRL["ShiftUp"])) and ((_IsOn and ((_TMode=="Auto" and _CGear<1) and _Tune.AutoShiftVers == "New") or _TMode=="Semi") or _TMode=="Manual") and input.UserInputState == Enum.UserInputState.Begin then
				if not _ShiftUp then _ShiftUp = true end
				
			--Toggle Clutch
			elseif (input.KeyCode ==_CTRL["ContlrClutch"] or (_MSteer and input.KeyCode==_CTRL["MouseClutch"]) or ((not _MSteer) and input.KeyCode==_CTRL["Clutch"])) and _TMode=="Manual" then
				if input.UserInputState == Enum.UserInputState.Begin then
					_ClPressing = true
				elseif input.UserInputState == Enum.UserInputState.End then
					_ClPressing = false
				end
				
			--Toggle PBrake
			elseif input.KeyCode ==_CTRL["ContlrPBrake"] or (_MSteer and input.KeyCode==_CTRL["MousePBrake"]) or ((not _MSteer) and input.KeyCode==_CTRL["PBrake"]) then
				if input.UserInputState == Enum.UserInputState.Begin then
					_PBrake = not _PBrake
				elseif input.UserInputState == Enum.UserInputState.End then
					if car.DriveSeat.Velocity.Magnitude>5 then _PBrake = false end
				end
				
			--Toggle Transmission Mode
			elseif (input.KeyCode == _CTRL["ContlrToggleTMode"] or input.KeyCode==_CTRL["ToggleTransMode"]) and input.UserInputState == Enum.UserInputState.Begin then
				local n=1
				for i,v in pairs(_Tune.TransModes) do
					if v==_TMode then n=i break end
				end
				n=n+1
				if n>#_Tune.TransModes then n=1 end
				_TMode = _Tune.TransModes[n]
				
			--Throttle
			elseif ((not _MSteer) and (input.KeyCode==_CTRL["Throttle"] or input.KeyCode == _CTRL["Throttle2"])) or ((((_CTRL["MouseThrottle"]==Enum.UserInputType.MouseButton1 or _CTRL["MouseThrottle"]==Enum.UserInputType.MouseButton2) and input.UserInputType == _CTRL["MouseThrottle"]) or input.KeyCode == _CTRL["MouseThrottle"])and _MSteer) then
				if input.UserInputState == Enum.UserInputState.Begin and _IsOn then
					_IThrot = 1
				else
					_IThrot = _Tune.IdleThrottle/100
				end
				
			--Brake
			elseif ((not _MSteer) and (input.KeyCode==_CTRL["Brake"] or input.KeyCode == _CTRL["Brake2"])) or ((((_CTRL["MouseBrake"]==Enum.UserInputType.MouseButton1 or _CTRL["MouseBrake"]==Enum.UserInputType.MouseButton2) and input.UserInputType == _CTRL["MouseBrake"]) or input.KeyCode == _CTRL["MouseBrake"])and _MSteer) then
				if input.UserInputState == Enum.UserInputState.Begin then
					_IBrake = 1
				else
					_IBrake = 0
				end
				
			--Steer Left
			elseif (not _MSteer) and (input.KeyCode==_CTRL["SteerLeft"] or input.KeyCode == _CTRL["SteerLeft2"]) then
				if input.UserInputState == Enum.UserInputState.Begin then
					_GSteerT = -1
					_SteerL = true
				else
					if _SteerR then
						_GSteerT = 1
					else
						_GSteerT = 0
					end
					_SteerL = false
				end
				
			--Steer Right
			elseif (not _MSteer) and (input.KeyCode==_CTRL["SteerRight"] or input.KeyCode == _CTRL["SteerRight2"]) then
				if input.UserInputState == Enum.UserInputState.Begin then
					_GSteerT = 1
					_SteerR = true
				else
					if _SteerL then
						_GSteerT = -1
					else
						_GSteerT = 0
					end
					_SteerR = false
				end
				
			--Toggle Mouse Controls
			elseif input.KeyCode ==_CTRL["ToggleMouseDrive"] then
				if input.UserInputState == Enum.UserInputState.End then
					_MSteer = not _MSteer
					_IThrot = _Tune.IdleThrottle/100
					_IBrake = 0
					_GSteerT = 0
				end
				
			--Toggle TCS
			elseif _Tune.TCSEnabled and _IsOn and input.KeyCode == _CTRL["ToggleTCS"] or input.KeyCode == _CTRL["ContlrToggleTCS"] then
				if input.UserInputState == Enum.UserInputState.End then _TCS = not _TCS end
			
			--Toggle ABS
			elseif _Tune.ABSEnabled and _IsOn and input.KeyCode == _CTRL["ToggleABS"] or input.KeyCode == _CTRL["ContlrToggleABS"] then
				if input.UserInputState == Enum.UserInputState.End then _ABS = not _ABS end
				
			end
			
			--Variable Controls
			if input.UserInputType.Name:find("Gamepad") then
				--Gamepad Steering
				if input.KeyCode == _CTRL["ContlrSteer"] then
					if input.Position.X>= 0 then
						local cDZone = math.min(.99,_Tune.Peripherals.ControlRDZone/100)
						if math.abs(input.Position.X)>cDZone then
							_GSteerT = (input.Position.X-cDZone)/(1-cDZone)
						else
							_GSteerT = 0
						end
					else
						local cDZone = math.min(.99,_Tune.Peripherals.ControlLDZone/100)
						if math.abs(input.Position.X)>cDZone then
							_GSteerT = (input.Position.X+cDZone)/(1-cDZone)
						else
							_GSteerT = 0
						end
					end
					
				--Gamepad Throttle
				elseif input.KeyCode == _CTRL["ContlrThrottle"] then
					if _IsOn then
						_IThrot = math.max(_Tune.IdleThrottle/100,input.Position.Z)
					else
						_IThrot = _Tune.IdleThrottle/100
					end
					
				--Gamepad Brake
				elseif input.KeyCode == _CTRL["ContlrBrake"] then
					_IBrake = input.Position.Z
				end
			end
		else
			_IThrot = _Tune.IdleThrottle/100
			_GSteerT = 0
			_IBrake = 0
		end
	end
	UserInputService.InputBegan:connect(DealWithInput)
	UserInputService.InputChanged:connect(DealWithInput)
	UserInputService.InputEnded:connect(DealWithInput)
	
	
	
	--[[Drivetrain Initialize]]
	
	local Drive={}
	
	--Power Front Wheels
		if _Tune.Config == "FWD" or _Tune.Config == "AWD" then for i,v in pairs(car.Wheels:GetChildren()) do if v.Name=="FL" or v.Name=="FR" or v.Name=="F" then table.insert(Drive,v) end end end
	
	--Power Rear Wheels
		if _Tune.Config == "RWD" or _Tune.Config == "AWD" then for i,v in pairs(car.Wheels:GetChildren()) do if v.Name=="RL" or v.Name=="RR" or v.Name=="R" then table.insert(Drive,v) end end end
	
	--Determine Wheel Size
	local wDia = 0 for i,v in pairs(Drive) do if v.Size.x>wDia then wDia = v.Size.x end end
	
	--Pre-Toggled PBrake
	for i,v in pairs(car.Wheels:GetChildren()) do if math.abs(v["#AV"].maxTorque.Magnitude-PBrakeForce)<1 then _PBrake=true end end
	
	--[[Throttle and Brake Input Smoothening]]
	
	function Inputs(dt)
		local deltaTime = (60/(1/dt))
		if _InThrot <= _IThrot then
			_InThrot = math.min(_IThrot,_InThrot+(_Tune.ThrotAccel*deltaTime))
		else
			_InThrot = math.max(_IThrot,_InThrot-(_Tune.ThrotDecel*deltaTime))
		end
		if _InBrake <= _IBrake then
			_InBrake = math.min(_IBrake,_InBrake+(_Tune.BrakeAccel*deltaTime))
		else
			_InBrake = math.max(_IBrake,_InBrake-(_Tune.BrakeDecel*deltaTime))
		end
	end
	
	--[[Steering]]
	
	function Steering(dt)
		local deltaTime = (60/(1/dt))
		--Mouse Steer
		if _MSteer then
			local msWidth = math.max(1,mouse.ViewSizeX*_Tune.Peripherals.MSteerWidth/200)
			local mdZone = _Tune.Peripherals.MSteerDZone/100
			local mST = ((mouse.X-mouse.ViewSizeX/2)/msWidth)
			if math.abs(mST)<=mdZone then
				_GSteerT = 0
			else
				_GSteerT = (math.max(math.min((math.abs(mST)-mdZone),(1-mdZone)),0)/(1-mdZone))^_Tune.MSteerExp * (mST / math.abs(mST))
			end
		end
		
		--Interpolate Steering
		if _GSteerC < _GSteerT then
			if _GSteerC<0 then
				_GSteerC = math.min(_GSteerT,_GSteerC+(_Tune.ReturnSpeed*deltaTime))
			else
				_GSteerC = math.min(_GSteerT,_GSteerC+(_Tune.SteerSpeed*deltaTime))
			end
		else
			if _GSteerC>0 then
				_GSteerC = math.max(_GSteerT,_GSteerC-(_Tune.ReturnSpeed*deltaTime))
			else
				_GSteerC = math.max(_GSteerT,_GSteerC-(_Tune.SteerSpeed*deltaTime))
			end
		end
		
		--Steer Decay Multiplier
		local sDecay = (1-math.min(car.DriveSeat.Velocity.Magnitude/_Tune.SteerDecay,1-(_Tune.MinSteer/100)))
		
		--Apply Steering
		for i,v in pairs(car.Wheels:GetChildren()) do
			if v.Name=="F" then
				v.Arm.Steer.CFrame=car.Wheels.F.Base.CFrame*CFrame.Angles(0,-math.rad(_GSteerC*_Tune.SteerInner*sDecay),0)
			elseif v.Name=="FL" then
				if _GSteerC>= 0 then
					v.Arm.Steer.CFrame=car.Wheels.FL.Base.CFrame*CFrame.Angles(0,-math.rad(_GSteerC*_Tune.SteerOuter*sDecay),0)
				else
					v.Arm.Steer.CFrame=car.Wheels.FL.Base.CFrame*CFrame.Angles(0,-math.rad(_GSteerC*_Tune.SteerInner*sDecay),0)
				end
			elseif v.Name=="FR" then
				if _GSteerC>= 0 then
					v.Arm.Steer.CFrame=car.Wheels.FR.Base.CFrame*CFrame.Angles(0,-math.rad(_GSteerC*_Tune.SteerInner*sDecay),0)
				else
					v.Arm.Steer.CFrame=car.Wheels.FR.Base.CFrame*CFrame.Angles(0,-math.rad(_GSteerC*_Tune.SteerOuter*sDecay),0)
				end
			end
		end
	end
	
	
	
	--[[Engine]]
	
	local fFD = _Tune.FinalDrive*_Tune.FDMult
	local fFDr = fFD*30/math.pi
	local cGrav = workspace.Gravity*_Tune.InclineComp/32.2
	local wDRatio = wDia*math.pi/60
	local cfWRot = CFrame.Angles(math.pi/2,-math.pi/2,0)
	local cfYRot = CFrame.Angles(0,math.pi,0)
	
	--Old Engine Setup
	if car["A-Chassis Tune"]:FindFirstChild("#ENGINE") then
		local E_Tune = require(car["A-Chassis Tune"]["#ENGINE"])
		_Tune.InclineComp = E_Tune.InclineComp
		
		_Tune.Engine = E_Tune.Engine
		_Tune.Electric = E_Tune.Electric
		if E_Tune.Aspiration~="Natural" then
			if E_Tune.Aspiration~="Super" then
				_Tune.Superchargers = 0
				if E_Tune.Aspiration=="Single" then
					_Tune.Turbochargers = 1
				elseif E_Tune.Aspiration=="Double" then
					_Tune.Turbochargers = 2
				end
			elseif E_Tune.Aspiration=="Super" then
				_Tune.Turbochargers = 0
				_Tune.Superchargers = 1
			end
		else
			_Tune.Turbochargers = 0
			_Tune.Superchargers = 0
		end
			
		_Tune.IdleRPM = E_Tune.IdleRPM
		_Tune.Redline = E_Tune.Redline
		_Tune.PeakRPM = E_Tune.PeakRPM
		_Tune.Horsepower = E_Tune.Horsepower
		_Tune.MH_PeakSharp = E_Tune.PeakSharpness
		_Tune.MH_CurveMult = E_Tune.CurveMult
		_Tune.M_EqPoint = E_Tune.EqPoint
		_Tune.MT_PeakRPM = E_Tune.PeakRPM
		_Tune.MT_PeakSharp = E_Tune.PeakSharpness
		_Tune.MT_CurveMult = E_Tune.CurveMult
			
		_Tune.E_Redline = E_Tune.ElecRedline
		_Tune.E_Trans1 = E_Tune.ElecTransition1
		_Tune.E_Trans2 = E_Tune.ElecTransition2
		_Tune.E_Horsepower = E_Tune.ElecHorsepower
		_Tune.EH_FrontMult = E_Tune.ElecHpFrontMult
		_Tune.EH_EndMult = E_Tune.ElecHpEndMult
		_Tune.EH_EndPercent = E_Tune.ElecHpEndPercent
		_Tune.E_Torque = E_Tune.ElecMaxTorque
		_Tune.ET_EndMult = E_Tune.ElecTqEndMult
		_Tune.ET_EndPercent = E_Tune.ElecTqEndPercent
		
		_Tune.T_Boost = E_Tune.Boost
		_Tune.T_Efficiency = E_Tune.CompressRatio
		_Tune.TH_PeakSharp = E_Tune.PeakSharpness
		_Tune.TH_CurveMult = E_Tune.CurveMult
		_Tune.TT_PeakSharp = E_Tune.PeakSharpness
		_Tune.TT_CurveMult = E_Tune.CurveMult
		_Tune.T_Size = E_Tune.TurboSize
		
		_Tune.S_Boost = E_Tune.Boost
		_Tune.S_Efficiency = E_Tune.CompressRatio
		_Tune.SH_PeakSharp	= E_Tune.PeakSharpness
		_Tune.SH_CurveMult	= E_Tune.CurveMult
		_Tune.ST_PeakSharp	= E_Tune.PeakSharpness
		_Tune.ST_CurveMult	= E_Tune.CurveMult
		_Tune.S_Sensitivity	= E_Tune.Sensitivity
	end
	
	--Electric Only Setup
	
	if not _Tune.Engine and _Tune.Electric then 
		_Tune.Redline = _Tune.E_Redline 
		_Tune.PeakRPM = _Tune.E_Trans2 
		_Tune.Turbochargers = 0
		_Tune.Superchargers = 0
		_Tune.Clutch = false 
		_Tune.IdleRPM = 0 
		_Tune.ClutchType = "Clutch" 
		_Tune.AutoShiftType = "DCT" 
		_Tune.ShiftUpTime = 0.1 
		_Tune.ShiftDnTime = 0.1 
	end
	
	--Aspiration Setup
	
	_TCount = _Tune.Turbochargers
	_TPsi = _Tune.T_Boost*_Tune.Turbochargers
	
	_SCount = _Tune.Superchargers
	_SPsi = _Tune.S_Boost*_Tune.Superchargers
	
	--Engine Curve
	
	local HP_M = _Tune.Horsepower
	local HP_T = HP_M*(((_TPsi*(_Tune.T_Efficiency/10))/7.5)/2)
	local HP_S = HP_M*(((_SPsi*(_Tune.S_Efficiency/10))/7.5)/2)
	local PK_H, PK_T = _Tune.PeakRPM, _Tune.MT_PeakRPM
	local MC_H, MC_T = _Tune.MH_CurveMult, _Tune.MT_CurveMult
	local TC_H, TC_T = _Tune.TH_CurveMult, _Tune.TT_CurveMult
	local SC_H, SC_T = _Tune.SH_CurveMult, _Tune.ST_CurveMult
	local MP_H, MP_T = _Tune.MH_PeakSharp, _Tune.MT_PeakSharp
	local TP_H, TP_T = _Tune.TH_PeakSharp, _Tune.TT_PeakSharp
	local SP_H, SP_T = _Tune.SH_PeakSharp, _Tune.ST_PeakSharp
	local V_MT = {HP_M,PK_H,MC_H,MP_H,PK_T,MC_T,MP_T}
	local V_TC = {HP_T,PK_H,TC_H,TP_H,PK_T,TC_T,TP_T}
	local V_SC = {HP_S,PK_H,SC_H,SP_H,PK_T,SC_T,SP_T}
	
	function getCurve(RPM,HP,Peak,CurveMult,Sharpness)
		RPM=RPM/1000
		HP=HP/100
		Peak=Peak/1000
		return ((-(RPM-Peak)^2)*math.min(HP/(Peak^2),CurveMult^(Peak/HP))+HP)*(RPM-((RPM^Sharpness)/(Sharpness*Peak^(Sharpness-1))))
	end
	
	function getPeak(V)
		local HP,Peak_H,CurveMult_H,Sharpness_H,Peak_T,CurveMult_T,Sharpness_T=V[1]/100,V[2]/1000,V[3],V[4],V[5]/1000,V[6],V[7]
		local hp=((-(Peak_H-Peak_H)^2)*math.min(HP/(Peak_H^2),CurveMult_H^(Peak_H/HP))+HP)*(Peak_H-((Peak_H^Sharpness_H)/(Sharpness_H*Peak_H^(Sharpness_H-1))))
		local tq=((-(Peak_T-Peak_T)^2)*math.min(HP/(Peak_T^2),CurveMult_T^(Peak_T/HP))+HP)*(Peak_T-((Peak_T^Sharpness_T)/(Sharpness_T*Peak_T^(Sharpness_T-1))))
		return hp, tq
	end
	
	local PeakHP_N, PeakTQ_N = getPeak(V_MT)
	local PeakHP_T, PeakTQ_T = getPeak(V_TC)
	local PeakHP_S, PeakTQ_S = getPeak(V_SC)
	
	--Plot Current Horsepower
	function EngineCurve(x,gear,V,eq,peakhp,peaktq)
		local hp,peak_h,cm_h,sharp_h,peak_t,cm_t,sharp_t=V[1],V[2],V[3],V[4],V[5],V[6],V[7]
		local hp_r=(math.max(getCurve(x,hp,peak_h,cm_h,sharp_h)/(peakhp/hp),0))
		local tq_r=(math.max(getCurve(x,hp,peak_t,cm_t,sharp_t)/(peaktq/hp),0))
		return hp_r,((tq_r*(eq/x))*_Tune.Ratios[gear+2]*fFD*hpScaling)
	end
	
	--Electric Curve
	
	local EHP=_Tune.E_Horsepower/100
	local ETQ=_Tune.E_Torque/100
	local ETrans1=_Tune.E_Trans1/1000
	local ETrans2=_Tune.E_Trans2/1000
	local ELimit=_Tune.E_Redline/1000 
	
	function elecHP(RPM)
		RPM=RPM/1000
		local retVal=1e-9
		if RPM<=ETrans1 then
			retVal=((((RPM/ETrans1)^_Tune.EH_FrontMult)/(1/EHP))*(RPM/ETrans1))+((((RPM/ETrans1)^(1/_Tune.EH_FrontMult))/(1/EHP))*(1-(RPM/ETrans1)))
		elseif ETrans1<RPM and RPM<ETrans2 then
			retVal=EHP
		elseif ETrans2<=RPM then
			retVal=EHP-(((RPM-ETrans2)/(ELimit-ETrans2))^_Tune.EH_EndMult)/(1/(EHP*(_Tune.EH_EndPercent/100)))
		else
			error( "\n\t [AC6C]: Drive initialization failed!"
			.."\n\t    An unknown error occured when initializing electric horsepower."
			.."\n\t    Please send a screenshot of this message to Avxnturador."
			.."\n\t    R: "..RPM..", T1: "..ETrans1", T2: "..ETrans2", L: "..ELimit".")
		end
		return retVal
	end
	
	function elecTQ(RPM)
		RPM=RPM/1000
		local retVal=1e-9
		if RPM<ETrans1 then
			retVal=ETQ
		elseif ETrans1<=RPM then
			retVal=ETQ-(((RPM-ETrans1)/(ELimit-ETrans1))^_Tune.ET_EndMult)/(1/(ETQ*(_Tune.ET_EndPercent/100)))
		else
			error( "\n\t [AC6C]: Drive initialization failed!"
			.."\n\t    An unknown error occured when initializing electric torque."
			.."\n\t    Please send a screenshot of this message to Avxnturador."
			.."\n\t    R: "..RPM..", T1: "..ETrans1", T2: "..ETrans2", L: "..ELimit".")
		end
		return retVal
	end
	
	--Plot Current Electric Horsepower
	function ElecCurve(x,gear)
		local hp=(math.max(elecHP(x),0))*100
		local tq=(math.max(elecTQ(x),0))*100
		if gear~=0 then
			return hp,math.max(tq*_Tune.Ratios[gear+2]*fFD*hpScaling,0)
		else
			return 0,0
		end
	end
	
	--Output Cache	
	local NCache = {}
	local ECache = {}
	local TCache = {}
	local SCache = {}
	
	for gear,ratio in pairs(_Tune.Ratios) do
		local nhpPlot = {}
		local ehpPlot = {}
		local thpPlot = {}
		local shpPlot = {}
		for rpm = 0, math.ceil((_Tune.Redline+100)/100) do
			local ntqPlot = {}
			local etqPlot = {}
			local ttqPlot = {}
			local stqPlot = {}
			if rpm~=0 then
				if _Tune.Engine then
					ntqPlot.Horsepower,ntqPlot.Torque = EngineCurve(rpm*100,gear-2,V_MT,_Tune.M_EqPoint,PeakHP_N,PeakTQ_N)
					if _TCount~=0 then
						ttqPlot.Horsepower,ttqPlot.Torque = EngineCurve(rpm*100,gear-2,V_TC,_Tune.M_EqPoint,PeakHP_T,PeakTQ_T)
					else
						ttqPlot.Horsepower,ttqPlot.Torque = 0,0
					end
					if _SCount~=0 then
						stqPlot.Horsepower,stqPlot.Torque = EngineCurve(rpm*100,gear-2,V_SC,_Tune.M_EqPoint,PeakHP_S,PeakTQ_S)
					else
						stqPlot.Horsepower,stqPlot.Torque = 0,0
					end
				else
					ntqPlot.Horsepower,ntqPlot.Torque = 0,0
					ttqPlot.Horsepower,ttqPlot.Torque = 0,0
					stqPlot.Horsepower,stqPlot.Torque = 0,0
				end
				if _Tune.Electric then
					etqPlot.Horsepower,etqPlot.Torque = ElecCurve(rpm*100,gear-2)
				else
					etqPlot.Horsepower,etqPlot.Torque = 0,0
				end
			else
				ntqPlot.Horsepower,ntqPlot.Torque = 0,0
				etqPlot.Horsepower,etqPlot.Torque = 0,0
				ttqPlot.Horsepower,ttqPlot.Torque = 0,0
				stqPlot.Horsepower,stqPlot.Torque = 0,0
			end
			if _Tune.Engine then
				nhp,ntq = EngineCurve((rpm+1)*100,gear-2,V_MT,_Tune.M_EqPoint,PeakHP_N,PeakTQ_N)
				if _TCount~=0 then
					thp,ttq = EngineCurve((rpm+1)*100,gear-2,V_TC,_Tune.M_EqPoint,PeakHP_T,PeakTQ_T)
				else
					thp,ttq = 0,0
				end
				if _SCount~=0 then
					shp,stq = EngineCurve((rpm+1)*100,gear-2,V_SC,_Tune.M_EqPoint,PeakHP_S,PeakTQ_S)
				else
					shp,stq = 0,0
				end
			else
				nhp,ntq = 0,0
				thp,ttq = 0,0
				shp,stq = 0,0
			end
			if _Tune.Electric then
				ehp,etq = ElecCurve((rpm+1)*100,gear-2)
			else
				ehp,etq = 0,0
			end
			ntqPlot.HpSlope,ntqPlot.TqSlope = (nhp-ntqPlot.Horsepower),(ntq-ntqPlot.Torque)
			etqPlot.HpSlope,etqPlot.TqSlope = (ehp-etqPlot.Horsepower),(etq-etqPlot.Torque)
			ttqPlot.HpSlope,ttqPlot.TqSlope = (thp-ttqPlot.Horsepower),(ttq-ttqPlot.Torque)
			stqPlot.HpSlope,stqPlot.TqSlope = (shp-stqPlot.Horsepower),(stq-stqPlot.Torque)
			nhpPlot[rpm] = ntqPlot
			ehpPlot[rpm] = etqPlot
			thpPlot[rpm] = ttqPlot
			shpPlot[rpm] = stqPlot
		end
		table.insert(NCache,nhpPlot)
		table.insert(ECache,ehpPlot)
		table.insert(TCache,thpPlot)
		table.insert(SCache,shpPlot)
	end
	
	--Powertrain
	wait()
	
	--Automatic Transmission
	function Auto()
		local maxSpin=0
		for i,v in pairs(Drive) do if v.RotVelocity.Magnitude>maxSpin then maxSpin = v.RotVelocity.Magnitude end end
		if _IsOn then
			if _Tune.AutoShiftVers == "Old" and _CGear == 0 then _CGear = 1 _ClPressing = false end
			if _CGear >= 1 then
				if (_CGear==1 and _InBrake > 0 and car.DriveSeat.Velocity.Magnitude < 5) and _Tune.AutoShiftVers == "Old" then
					_CGear = -1 _ClPressing = false
				elseif car.DriveSeat.Velocity.Magnitude > 5 then
					if _Tune.AutoShiftMode == "RPM" then
						if _RPM>(_Tune.PeakRPM+_Tune.AutoUpThresh) then
							if not _ShiftUp and not _Shifting then _ShiftUp = true end
						elseif math.max(math.min(maxSpin*_Tune.Ratios[_CGear+1]*fFDr,_Tune.Redline+100),_Tune.IdleRPM)<(_Tune.PeakRPM-_Tune.AutoDownThresh) and _CGear>1 then
							if not _ShiftDn and not _Shifting then _ShiftDn = true end 
						end
					else
						if car.DriveSeat.Velocity.Magnitude > math.ceil(wDRatio*(_Tune.PeakRPM+_Tune.AutoUpThresh)/_Tune.Ratios[_CGear+2]/fFD) then
							if not _ShiftUp and not _Shifting then _ShiftUp = true end
						elseif car.DriveSeat.Velocity.Magnitude < math.ceil(wDRatio*(_Tune.PeakRPM-_Tune.AutoDownThresh)/_Tune.Ratios[_CGear+1]/fFD) and _CGear>1 then
							if not _ShiftDn and not _Shifting then _ShiftDn = true end
						end
					end
				end
			else
				if (_InThrot-(_Tune.IdleThrottle/100) > 0 and car.DriveSeat.Velocity.Magnitude < 5) and _Tune.AutoShiftVers == "Old" then
					_CGear = 1 _ClPressing = false
				end
			end
		end 
	end
	
	function Gear()
		local maxSpin=0
		for i,v in pairs(Drive) do if v.RotVelocity.Magnitude>maxSpin then maxSpin = v.RotVelocity.Magnitude end end
		if _ShiftUp and not _Shifting then
			if (_TMode == "Manual" and not _ClPressing) or (_TMode == "Manual" and _Tune.ClutchRel and (_InThrot-(_Tune.IdleThrottle/100)>0)) or _CGear == #_Tune.Ratios-2 or (_TMode ~= "Manual" and not _IsOn) then _ShiftUp = false return end
			local NextGear = math.min(_CGear+3,#_Tune.Ratios)
			if _TMode~="Manual" then
				_Shifting = true
				if _CGear>0 then 
					if _Tune.AutoShiftType=="DCT" then 
						wait(_Tune.ShiftUpTime)
					elseif _Tune.AutoShiftType=="Rev" then
						repeat wait() until _RPM<=math.max(math.min(maxSpin*_Tune.Ratios[NextGear]*fFDr,_Tune.Redline-_Tune.RevBounce),_Tune.IdleRPM) or not _IsOn or _ShiftDn 
					end
				end
			end
			_ShiftUp = false
			_Shifting = false
			if _TMode ~= "Manual" and not _IsOn then return end
			_CGear = math.min(_CGear+1,#_Tune.Ratios-2)
			if _TMode ~= "Manual" or (_TMode == "Manual" and _CGear == 1) and _IsOn then _ClPressing = false end
		end
		if _ShiftDn and not _Shifting then
			if (_TMode == "Manual" and not _ClPressing) or _CGear == -1 or (_TMode ~= "Manual" and not _IsOn) then _ShiftDn = false return end
			local PrevGear = math.min(_CGear+1,#_Tune.Ratios)
			if _TMode~="Manual" then
				_Shifting = true
				if _CGear>1 then 
					if _Tune.AutoShiftType=="DCT" then 
						wait(_Tune.ShiftDnTime)
					elseif _Tune.AutoShiftType=="Rev" then
						repeat wait() until _RPM>=math.max(math.min(maxSpin*_Tune.Ratios[PrevGear]*fFDr,_Tune.Redline-_Tune.RevBounce),_Tune.IdleRPM) or not _IsOn or _ShiftUp
					end
				end
			end
			_ShiftDn = false
			_Shifting = false
			if _TMode ~= "Manual" and not _IsOn then return end
			_CGear = math.max(_CGear-1,-1)
			if _TMode ~= "Manual" or (_TMode == "Manual" and _CGear == -1) and _IsOn then _ClPressing = false end
		end
	end
	
	local tqTCS = 1
	local sthrot = 0
	local _StallOK = false
	local ticc = tick()
	--Apply Power
	function Engine(dt)
		local deltaTime = (60/(1/dt))
		--Neutral Gear
		if ((_CGear == 0 or _Shifting) and _IsOn) then 
			_ClPressing = true
			_Clutch = 1
			_StallOK = false
		end
		
		local revMin = _Tune.IdleRPM 
		local goalMin = _Tune.IdleRPM 
		if _Tune.Stall and _Tune.Clutch then revMin = 0 end
		
		if _Shifting and _ShiftUp then 
			_GThrot = 0
		elseif _Shifting and _ShiftDn then
			_GThrot = (_Tune.ShiftThrot/100)
		else
			if (_Tune.AutoShiftVers == "Old" and _CGear==-1 and _TMode=="Auto") then
				_GThrot = _InBrake
			else
				_GThrot = _InThrot
			end
		end
		
		if (_Tune.AutoShiftVers == "Old" and _CGear==-1 and _TMode=="Auto") then
			_GBrake = _InThrot-(_Tune.IdleThrottle/100)
		else
			_GBrake = _InBrake
		end
		
		if not _IsOn then 
			ticc = tick()
			revMin = 0 
			goalMin = 0
			_GThrot = _Tune.IdleThrottle/100
			if _TMode~="Manual" then 
				_CGear = 0 
				_ClPressing = true 
				_Clutch = 1 
			end
		end
		
		--Determine RPM
		local maxSpin=0
		local maxCount=0
		local _GoalRPM=0
		for i,v in pairs(Drive) do maxSpin = maxSpin + v.RotVelocity.Magnitude maxCount = maxCount + 1 end
		maxSpin=maxSpin/maxCount
		
		if _Tune.Engine or _Tune.Electric then
			_GoalRPM = math.max(math.min((_RPM-_Tune.RevDecay*deltaTime)+((_Tune.RevDecay+_Tune.RevAccel)*_GThrot*deltaTime),_Tune.Redline+100),goalMin)
		end
		
		if _GoalRPM>_Tune.Redline then 
			if _CGear<#_Tune.Ratios-2 then
				_GoalRPM = _GoalRPM-_Tune.RevBounce
			else
				_GoalRPM = _GoalRPM-_Tune.RevBounce*.5
			end
		end
		
		local _WheelRPM = maxSpin*_Tune.Ratios[_CGear+2]*fFDr
		
		if _Tune.Clutch then
			if script.Parent.Values.AutoClutch.Value and _IsOn then
				if _Tune.ClutchType == "Clutch" then
					if _ClPressing then _ClutchKick = 1 end
					_ClutchKick = _ClutchKick*(_Tune.ClutchEngage/100)		
					local ClRPMInfluence = math.max((_RPM-_Tune.IdleRPM)*_Tune.ClutchRPMMult/(_Tune.Redline-_Tune.IdleRPM),0)
					if _Tune.ClutchMode == "New" then ClRPMInfluence = 0 end
					_ClutchModulate = math.min(((((script.Parent.Values.Velocity.Value.Magnitude/_Tune.SpeedEngage)/math.abs(_CGear)) + ClRPMInfluence) - _ClutchKick), 1)
				elseif _Tune.ClutchType == "CVT" or (_Tune.ClutchType == "TorqueConverter" and _Tune.TQLock) then
					if (_GThrot-(_Tune.IdleThrottle/100)==0 and script.Parent.Values.Velocity.Value.Magnitude<_Tune.SpeedEngage) or (_GThrot-(_Tune.IdleThrottle/100)~=0 and (_RPM < _Tune.RPMEngage and _WheelRPM < _Tune.RPMEngage)) then
						_ClutchModulate = math.min(_ClutchModulate*(_Tune.ClutchEngage/100), 1)
					else
						_ClutchModulate = math.min(_ClutchModulate*(_Tune.ClutchEngage/100)+(1-(_Tune.ClutchEngage/100)), 1)
					end
				elseif _Tune.ClutchType == "TorqueConverter" and not _Tune.TQLock then
					_ClutchModulate = math.min((_RPM/_Tune.Redline)*0.7, 1)
				end
				if not _ClPressing then _Clutch = math.min(1-_ClutchModulate,1) else _Clutch = 1 end
				_StallOK = (_Clutch<=0.01) or _StallOK
			else
				_StallOK = _Tune.Stall
				_Clutch = script.Parent.Values.Clutch.Value
			end
		else
			_StallOK = false
			if not _ClPressing and not _Shifting then _Clutch = 0 else _Clutch = 1 end
		end
		
		local aRPM = math.max(math.min((_GoalRPM*_Clutch) + (_WheelRPM*(1-_Clutch)),_Tune.Redline+100),revMin)
		local clutchP = math.min(math.abs(aRPM-_RPM)/(_Tune.Flywheel*deltaTime),.9)
		if _ClPressing then clutchP = 0 end
		_RPM = _RPM*clutchP  +  aRPM*(1-clutchP)
		
		if _RPM<=(_Tune.IdleRPM/4) and _StallOK and (tick()-ticc>=0.2) then script.Parent.IsOn.Value = not _Tune.Stall end
		
		--Rev Limiter
		_spLimit = (_Tune.Redline+100)/(fFDr*_Tune.Ratios[_CGear+2])
		if _RPM>_Tune.Redline then 
			if _CGear<#_Tune.Ratios-2 then
				_RPM = _RPM-_Tune.RevBounce
			else
				_RPM = _RPM-_Tune.RevBounce*.5
			end
		end
		
		--Aspiration
		local TPsi = _TPsi/_TCount
		
		local _BThrot = _GThrot
		
		if _Tune.Engine then
			if _TCount~=0 then
				_TBoost = _TBoost + ((((((_HP*(_BThrot*1.2)/_Tune.Horsepower)/8)-(((_TBoost/TPsi*(TPsi/15)))))*((8/(_Tune.T_Size/(deltaTime)))*2))/TPsi)*15)
				if _TBoost < 0.05 then _TBoost = 0.05 elseif _TBoost > 2 then _TBoost = 2 end
			else
				_TBoost = 0
			end
			if _SCount~=0 then
				if _BThrot>sthrot then
					sthrot=math.min(_BThrot,sthrot+_Tune.S_Sensitivity*deltaTime)
				elseif _BThrot<sthrot then
					sthrot=math.max(_BThrot,sthrot-_Tune.S_Sensitivity*deltaTime)
				end
				_SBoost = (_RPM/_Tune.Redline)*(.5+(1.5*sthrot))
			else
				_SBoost = 0
			end
		else
			_TBoost = 0
			_SBoost = 0
		end
		
		--Torque calculations
		if _Tune.Engine then
			local cTq = NCache[_CGear+2][math.floor(math.min(_Tune.Redline,math.max(0,_RPM))/100)]
			_NH = cTq.Horsepower+(cTq.HpSlope*(((_RPM-math.floor(_RPM/100))/100)%1))
			_NT = cTq.Torque+(cTq.TqSlope*(((_RPM-math.floor(_RPM/100))/100)%1))
			if _TCount~=0 then
				local tTq = TCache[_CGear+2][math.floor(math.min(_Tune.Redline,math.max(0,_RPM))/100)]
				_TH = (tTq.Horsepower+(tTq.HpSlope*(((_RPM-math.floor(_RPM/100))/100)%1)))*(_TBoost/2)
				_TT = (tTq.Torque+(tTq.TqSlope*(((_RPM-math.floor(_RPM/100))/100)%1)))*(_TBoost/2)
			else
				_TH,_TT = 0,0
			end
			if _SCount~=0 then
				local sTq = SCache[_CGear+2][math.floor(math.min(_Tune.Redline,math.max(0,_RPM))/100)]
				_SH = (sTq.Horsepower+(sTq.HpSlope*(((_RPM-math.floor(_RPM/100))/100)%1)))*(_SBoost/2)
				_ST = (sTq.Torque+(sTq.TqSlope*(((_RPM-math.floor(_RPM/100))/100)%1)))*(_SBoost/2)
			else
				_SH,_ST = 0,0
			end
			_BH = _TH+_SH
			_BT = _TT+_ST
		else
			_NH,_NT = 0,0
			_TH,_TT = 0,0
			_SH,_ST = 0,0
			_BH,_BT = 0,0
		end
		
		if _Tune.Electric and _CGear~=0 then
			local eTq = ECache[_CGear+2][math.floor(math.min(_Tune.Redline,math.max(100,_RPM))/100)]
			_EH = eTq.Horsepower+(eTq.HpSlope*(((_RPM-math.floor(_RPM/100))/100)%1))
			_ET = eTq.Torque+(eTq.TqSlope*(((_RPM-math.floor(_RPM/100))/100)%1))
		else
			_EH,_ET = 0,0
		end
		
		_HP = _NH + _BH + _EH
		_OutTorque = _NT + _BT + _ET
		
		local iComp =(car.DriveSeat.CFrame.lookVector.y)*cGrav
		if _CGear==-1 then iComp=-iComp end
		_OutTorque = _OutTorque*math.max(1,(1+iComp))
		
		--Average Rotational Speed Calculation
		local fwspeed=0
		local fwcount=0
		local rwspeed=0
		local rwcount=0
		
		for i,v in pairs(car.Wheels:GetChildren()) do
			if v.Name=="FL" or v.Name=="FR" or v.Name == "F" then
				fwspeed=fwspeed+v.RotVelocity.Magnitude
				fwcount=fwcount+1
			elseif v.Name=="RL" or v.Name=="RR" or v.Name == "R" then
				rwspeed=rwspeed+v.RotVelocity.Magnitude
				rwcount=rwcount+1
			end
		end
		fwspeed=fwspeed/fwcount
		rwspeed=rwspeed/rwcount	
		local cwspeed=(fwspeed+rwspeed)/2
		
		--Update Wheels
		for i,v in pairs(car.Wheels:GetChildren()) do
			--Reference Wheel Orientation
			local Ref=(CFrame.new(v.Position-((v.Arm.CFrame*cfWRot).lookVector),v.Position)*cfYRot).lookVector
			local aRef=1
			local diffMult=1
			if v.Name=="FL" or v.Name=="RL" then aRef=-1 end
			
			--Differential/Torque-Vectoring
			if v.Name=="FL" or v.Name=="FR" then
				diffMult=math.max(0,math.min(1,1+((((v.RotVelocity.Magnitude-fwspeed)/fwspeed)/(math.max(_Tune.FDiffSlipThres,1)/100))*((_Tune.FDiffLockThres-50)/50))))
				if _Tune.Config == "AWD" then
					diffMult=math.max(0,math.min(1,diffMult*(1+((((fwspeed-cwspeed)/cwspeed)/(math.max(_Tune.CDiffSlipThres,1)/100))*((_Tune.CDiffLockThres-50)/50)))))
				end
			elseif v.Name=="RL" or v.Name=="RR" then
				diffMult=math.max(0,math.min(1,1+((((v.RotVelocity.Magnitude-rwspeed)/rwspeed)/(math.max(_Tune.RDiffSlipThres,1)/100))*((_Tune.RDiffLockThres-50)/50))))
				if _Tune.Config == "AWD" then
					diffMult=math.max(0,math.min(1,diffMult*(1+((((rwspeed-cwspeed)/cwspeed)/(math.max(_Tune.CDiffSlipThres,1)/100))*((_Tune.CDiffLockThres-50)/50)))))
				end
			end
			
			_TCSActive = false
			_ABSActive = false
			--Output
			if _PBrake and ((_Tune.Config ~= "FWD" and (((v.Name=="FL" or v.Name=="FR") and car.DriveSeat.Velocity.Magnitude<20) or ((v.Name=="RR" or v.Name=="RL") and car.DriveSeat.Velocity.Magnitude>=20))) or (_Tune.Config == "FWD" and (v.Name=="RR" or v.Name=="RL")))  then
				--PBrake
				v["#AV"].maxTorque=Vector3.new(math.abs(Ref.x),math.abs(Ref.y),math.abs(Ref.z))*PBrakeForce*(60/workspace:GetRealPhysicsFPS())
				v["#AV"].angularvelocity=Vector3.new()
			else
				--Apply Power
				if _GBrake==0 then
					local driven = false
					for _,a in pairs(Drive) do if a==v then driven = true end end
					if driven then
						local on=1
						if not script.Parent.IsOn.Value then on=0 end
						local throt = _GThrot
						local clutch=1
						if _ClPressing then clutch=0 end
						local tq = _OutTorque
						
						--Apply AWD Vectoring
						if _Tune.Config == "AWD" then
							local bias = (_Tune.TorqueVector+1)/2
							if v.Name=="FL" or v.Name=="FR" then
								tq = tq*(1-bias)
							elseif v.Name=="RL" or v.Name=="RR" then
								tq = tq*bias
							end
						end
						
						--Apply TCS
						tqTCS = 1
						if _TCS then
							tqTCS = 1-(math.min(math.max(0,math.abs(v.RotVelocity.Magnitude*(v.Size.x/2) - v.Velocity.Magnitude)-_Tune.TCSThreshold)/_Tune.TCSGradient,1)*(1-(_Tune.TCSLimit/100)))
						end
						if tqTCS < 1 then
							_TCSAmt = tqTCS
							_TCSActive = true
						end
						
						--Update Forces
						local dir=1
						if _CGear==-1 then dir = -1 end
						v["#AV"].maxTorque=Vector3.new(math.abs(Ref.x),math.abs(Ref.y),math.abs(Ref.z))*tq*(60/workspace:GetRealPhysicsFPS())*(1+(v.RotVelocity.Magnitude/(120-workspace:GetRealPhysicsFPS()))^(((1-_Tune.Drag)*1.15)+(((1-_Tune.Drag)*.07)*(1-(60/workspace:GetRealPhysicsFPS())))))*throt*tqTCS*diffMult*on*clutch
						v["#AV"].angularvelocity=Ref*aRef*_spLimit*dir
					else
						v["#AV"].maxTorque=Vector3.new()
						v["#AV"].angularvelocity=Vector3.new()
					end
					
				--Brakes
				else
					local brake = _GBrake
					
					--Apply ABS
					local tqABS = 1
					if _ABS and math.abs(v.RotVelocity.Magnitude*(v.Size.x/2) - v.Velocity.Magnitude)-_Tune.ABSThreshold>0 then
						tqABS = 0
					end
					_ABSActive = (tqABS<1)
					
					--Update Forces
					if v.Name=="FL" or v.Name=="FR" or v.Name=="F" then
						v["#AV"].maxTorque=Vector3.new(math.abs(Ref.x),math.abs(Ref.y),math.abs(Ref.z))*FBrakeForce*(60/workspace:GetRealPhysicsFPS())*brake*tqABS
					else
						v["#AV"].maxTorque=Vector3.new(math.abs(Ref.x),math.abs(Ref.y),math.abs(Ref.z))*RBrakeForce*(60/workspace:GetRealPhysicsFPS())*brake*tqABS
					end
					v["#AV"].angularvelocity=Vector3.new()
				end
			end
		end
	end
	
	
	
	--[[Flip]]
	
	function Flip()
		--Detect Orientation
		if (car.DriveSeat.CFrame*CFrame.Angles(math.pi/2,0,0)).lookVector.y > .1 or FlipDB then
			FlipWait=tick()
			
		--Apply Flip
		else
			if tick()-FlipWait>=3 then
				FlipDB=true
				local gyro = car.DriveSeat.Flip
				gyro.maxTorque = Vector3.new(10000,0,10000)
				gyro.P=3000
				gyro.D=500
				wait(1)
				gyro.maxTorque = Vector3.new(0,0,0)
				gyro.P=0
				gyro.D=0
				FlipDB=false
			end
		end
	end
	
	
	--[[Run]]
	
	--Print Version
	local ver=require(car["A-Chassis Tune"].README)
	print("Novena: AC6C Loaded - Version "..ver..", Update "..script.Parent.Version.Value)
	
	--Runtime Loops
	
	-- ~60 c/s
	game["Run Service"].Heartbeat:connect(function(dt)
		--Update Internal Values
		_IsOn = script.Parent.IsOn.Value
		_InControls = script.Parent.ControlsOpen.Value
		
		--Inputs
		Inputs(dt)
		
		--Steering
		Steering(dt)
		
		--Gear
		Gear()
		
		--Power
		Engine(dt)
		
		--Update External Values
		_IsOn = script.Parent.IsOn.Value
		script.Parent.Values.Gear.Value = _CGear
		script.Parent.Values.RPM.Value = _RPM
		script.Parent.Values.Boost.Value = ((_TBoost/2)*_TPsi)+((_SBoost/2)*_SPsi)
		script.Parent.Values.BoostTurbo.Value = (_TBoost/2)*_TPsi
		script.Parent.Values.BoostSuper.Value = (_SBoost/2)*_SPsi
		script.Parent.Values.HpNatural.Value = _NH
		script.Parent.Values.HpElectric.Value = _EH
		script.Parent.Values.HpTurbo.Value = _TH
		script.Parent.Values.HpSuper.Value = _SH
		script.Parent.Values.HpBoosted.Value = _BH
		script.Parent.Values.Horsepower.Value = _HP
		script.Parent.Values.TqNatural.Value = _NT/_Tune.Ratios[_CGear+2]/fFD/hpScaling
		script.Parent.Values.TqElectric.Value = _ET/_Tune.Ratios[_CGear+2]/fFD/hpScaling
		script.Parent.Values.TqTurbo.Value = _TT/_Tune.Ratios[_CGear+2]/fFD/hpScaling
		script.Parent.Values.TqSuper.Value = _ST/_Tune.Ratios[_CGear+2]/fFD/hpScaling
		script.Parent.Values.TqBoosted.Value = script.Parent.Values.TqTurbo.Value+script.Parent.Values.TqSuper.Value
		script.Parent.Values.Torque.Value = script.Parent.Values.TqNatural.Value+script.Parent.Values.TqElectric.Value+script.Parent.Values.TqBoosted.Value
		script.Parent.Values.TransmissionMode.Value = _TMode
		script.Parent.Values.Throttle.Value = _GThrot
		script.Parent.Values.Brake.Value = _GBrake
		if script.Parent.Values.AutoClutch.Value then
			script.Parent.Values.Clutch.Value = _Clutch
		end
		script.Parent.Values.SteerC.Value = _GSteerC
		script.Parent.Values.SteerT.Value = _GSteerT
		script.Parent.Values.PBrake.Value = _PBrake
		script.Parent.Values.TCS.Value = _TCS
		script.Parent.Values.TCSActive.Value = _TCSActive
		script.Parent.Values.TCSAmt.Value = 1-_TCSAmt
		script.Parent.Values.ABS.Value = _ABS
		script.Parent.Values.ABSActive.Value = _ABSActive
		script.Parent.Values.MouseSteerOn.Value = _MSteer
		script.Parent.Values.Velocity.Value = car.DriveSeat.Velocity
	end)
	
	--15 c/s
	while wait(.0667) do
		--Automatic Transmission
		if _TMode == "Auto" then Auto() end
		
		--Flip
		if _Tune.AutoFlip then Flip() end
	end

--[[END]]