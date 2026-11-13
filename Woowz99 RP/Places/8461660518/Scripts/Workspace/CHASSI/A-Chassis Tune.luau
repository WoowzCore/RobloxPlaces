--[[
	   ___      _______                _        _____
	  / _ |____/ ___/ /  ___ ____ ___ (_)__    / ___/
	 / __ /___/ /__/ _ \/ _ `(_-<(_-</ (_-<   / /__
	/_/ |_|   \___/_//_/\_,_/___/___/_/___/	  \___/
	
					Avxnturador | Novena
						DJay500 | Novena
						RikOne2 | Novena
						
	To upgrade from past vesions of A-Chassis, please consult the "README" script.
]]

local Tune = {}

--[[Misc]]
	Tune.LoadDelay		= 4.0		-- Delay before initializing chassis (in seconds)
	Tune.AutoStart		= false		-- Set to false if using manual ignition plugin
	Tune.AutoFlip		= true		-- Set to false if using manual flip plugin
	Tune.AutoUpdate		= true		-- Automatically applies minor updates to the chassis if any are found.
									-- Will NOT apply major updates, but will notify you of any.
									-- Set to false to mute notifications, or if using modified Drive.
--[[Wheel Alignment]]
	--[Don't physically apply alignment to wheels]
	--[Values are in degrees]
	Tune.FCamber		= 0
	Tune.RCamber		= 0
	Tune.FCaster		= 0
	Tune.FToe			= 0
	Tune.RToe			= 0
	
--[[Weight and CG]]
	Tune.Weight			= 3550			-- Total weight (in pounds)
	Tune.WeightBSize	= {			-- Size of weight brick (dimmensions in studs ; larger = more stable)
	 --[[Width]]		6		,
	 --[[Height]]		4		,
	 --[[Length]]		15		}
	Tune.WeightDist		= 40		-- Weight distribution (0 - on rear wheels, 100 - on front wheels, can be <0 or >100)
	Tune.CGHeight		= .4		-- Center of gravity height (studs relative to median of all wheels)
	Tune.WBVisible		= false		-- Makes the weight brick visible
	
	--Unsprung Weight
	Tune.FWheelDensity	= .1		-- Front Wheel Density
	Tune.RWheelDensity	= .1		-- Rear Wheel Density
	Tune.FWLgcyDensity	= 1			-- Front Wheel Density [PGS OFF]
	Tune.RWLgcyDensity	= 1			-- Rear Wheel Density [PGS OFF]
	
	Tune.AxleSize		= 2			-- Size of structural members (larger = MORE STABLE / carry more weight)
	Tune.AxleDensity	= .1		-- Density of structural members
	
--[[Susupension]]
	Tune.SusEnabled		= true		-- Sets whether suspension is enabled for PGS
	
	--Front Suspension
	Tune.FSusDamping	= 600		-- Spring Dampening
	Tune.FSusStiffness	= 9000		-- Spring Force
	Tune.FAntiRoll 		= 800		-- Anti-Roll (Gyro Dampening)
	
	Tune.FSusLength		= 4			-- Suspension length (in studs)
	Tune.FPreCompress	= .2		-- Pre-compression adds resting length force
	Tune.FExtensionLim	= 10		-- Max Extension Travel (in studs)
	Tune.FCompressLim	= 10		-- Max Compression Travel (in studs)
	Tune.FSusAngle		= 90		-- Suspension Angle (degrees from horizontal)
		
	Tune.FWsBoneLen		= 5			-- Wishbone Length
	Tune.FWsBoneAngle	= 0			-- Wishbone angle (degrees from horizontal)
	Tune.FAnchorOffset	= {			-- Suspension anchor point offset (relative to center of wheel)
	 --[[Lateral]]		-.2		,	-- positive = outward
	 --[[Vertical]]		-.6		,	-- positive = upward
	 --[[Forward]]		0		}	-- positive = forward
	
	--Rear Suspension
	Tune.RSusDamping	= 600		-- Spring Dampening
	Tune.RSusStiffness	= 9000		-- Spring Force
	Tune.RAntiRoll 		= 800		-- Anti-Roll (Gyro Dampening)

	Tune.RSusLength		= 4			-- Suspension length (in studs)
	Tune.RPreCompress	= .2		-- Pre-compression adds resting length force
	Tune.RExtensionLim	= 10		-- Max Extension Travel (in studs)
	Tune.RCompressLim	= 10		-- Max Compression Travel (in studs)
	Tune.RSusAngle		= 90		-- Suspension Angle (degrees from horizontal)
		
	Tune.RWsBoneLen		= 10			-- Wishbone Length
	Tune.RWsBoneAngle	= 0			-- Wishbone angle (degrees from horizontal)
	Tune.RAnchorOffset	= {			-- Suspension anchor point offset (relative to center of wheel)
	 --[[Lateral]]		-.0		,	-- positive = outward
	 --[[Vertical]]		0		,	-- positive = upward
	 --[[Forward]]		0		}	-- positive = forward

	--Aesthetics	
	Tune.SusVisible		= false			-- Spring Visible
	Tune.WsBVisible		= false			-- Wishbone Visible
	Tune.SusRadius		= .2			-- Suspension Coil Radius
	Tune.SusThickness	= .1			-- Suspension Coil Thickness
	Tune.SusColor		= "Bright red"	-- Suspension Color [BrickColor]
	Tune.SusCoilCount	= 6				-- Suspension Coil Count
	Tune.WsColor		= "Black"		-- Wishbone Color [BrickColor]
	Tune.WsThickness	= .1			-- Wishbone Rod Thickness

--[[Wheel Stabilizer Gyro]]
	Tune.FGyroDamp		= 1000	-- Front Wheel Non-Axial Dampening
	Tune.RGyroDamp		= 1000	-- Rear Wheel Non-Axial Dampening
	
--[[Steering]]
	Tune.SteerInner		= 50		-- Inner wheel steering angle (in degrees)
	Tune.SteerOuter		= 50		-- Outer wheel steering angle (in degrees)
	Tune.SteerSpeed		= .5		-- Steering increment per tick (in degrees)
	Tune.ReturnSpeed	= .5		-- Steering increment per tick (in degrees)
	Tune.SteerDecay		= 330		-- Speed of gradient cutoff (in SPS)
	Tune.MinSteer		= 10		-- Minimum steering at max steer decay (in percent)
	Tune.MSteerExp		= 1			-- Mouse steering exponential degree
	
	--Steer Gyro Tuning
	Tune.SteerD			= 2200		-- Steering Dampening
	Tune.SteerMaxTorque	= 60000		-- Steering Force
	Tune.SteerP			= 40000	-- Steering Aggressiveness
	
--[[Engine]]

	-- Everything below can be illustrated and tuned with the graph below.
	-- https://www.desmos.com/calculator/x1h2vdccu1
	-- This includes everything, from the engines, to boost, to electric.
	
	-- To import engines prior to AC6C V1.3, consult the README.
	
	-- Naturally Aspirated Engine
	Tune.Engine 		= true		
		
		Tune.IdleRPM		= 900
		Tune.Redline		= 7000
		Tune.PeakRPM		= 6900
		-- Horsepower
		Tune.Horsepower		= 382
		Tune.MH_PeakRPM		= Tune.PeakRPM
		Tune.MH_PeakSharp	= 2
		Tune.MH_CurveMult	= 9.5
		-- Torque
		Tune.M_EqPoint		= 5500
		Tune.MT_PeakRPM		= 7000
		Tune.MT_PeakSharp	= 1.4
		Tune.MT_CurveMult	= 10
	
	-- Electric Engine
	Tune.Electric		= false
		
		Tune.E_Redline	= 12700
		Tune.E_Trans1	= 4000
		Tune.E_Trans2	= 7000
		-- Horsepower
		Tune.E_Horsepower	= 223
		Tune.EH_FrontMult	= 0.15
		Tune.EH_EndMult		= 2.9
		Tune.EH_EndPercent	= 7
		-- Torque
		Tune.E_Torque		= 286
		Tune.ET_EndMult		= 1.505
		Tune.ET_EndPercent	= 27.5
		
	-- Turbocharger
	Tune.Turbochargers	= 0				-- Number of turbochargers in the engine
										-- Set to 0 for no turbochargers
		Tune.T_Boost		= 2
		Tune.T_Efficiency	= 4.15
		--Horsepower
		Tune.TH_PeakSharp	= 12.8
		Tune.TH_CurveMult	= 1.4
		--Torque
		Tune.TT_PeakSharp	= 2
		Tune.TT_CurveMult	= 0.6
		
		Tune.T_Size			= 80		-- Turbo Size; Bigger size = more turbo lag
		
	-- Supercharger
	Tune.Superchargers	= 0				-- Number of superchargers in the engine
										-- Set to 0 for no superchargers
		Tune.S_Boost		= 4
		Tune.S_Efficiency	= 8
		--Horsepower
		Tune.SH_PeakSharp	= 10.9
		Tune.SH_CurveMult	= 1.2
		--Torque
		Tune.ST_PeakSharp	= 13.2
		Tune.ST_CurveMult	= 4.8
		
		Tune.S_Sensitivity	= 0.05		-- Supercharger responsiveness/sensitivity, applied per tick (recommended values between 0.05 to 0.1)
		
	--Misc
	Tune.ThrotAccel		= .1		-- Throttle acceleration, applied per tick (recommended values between 0.05 to 0.1)
	Tune.ThrotDecel		= .2		-- Throttle deceleration, applied per tick (recommended values between 0.1 to 0.3)
	
	Tune.BrakeAccel		= .2		-- Brake acceleration, applied per tick
	Tune.BrakeDecel		= .5		-- Brake deceleration, applied per tick
	
	Tune.RevAccel		    = 250	-- RPM acceleration when clutch is off
	Tune.RevDecay		= 75		-- RPM decay when clutch is off
	Tune.RevBounce		= 100		-- RPM kickback from redline
	
	Tune.IdleThrottle	= 3			-- Percent throttle at idle
	Tune.Flywheel		= 900		-- Flywheel weight (higher = faster response, lower = more stable RPM)
	
	Tune.InclineComp	= 1		-- Torque compensation multiplier for inclines (applies gradient from 0-90 degrees)
	
	--Aero
	Tune.Drag			= 1		-- 0 to 1, edit to change drag effect (0 = no effect like older AC6C, 1 = full effect) 
	
--[[Drivetrain]]	
	Tune.Config			= "RWD"		-- "FWD" , "RWD" , "AWD"
	Tune.TorqueVector	= 0			-- AWD ONLY, "-1" has a 100% front bias, "0" has a 50:50 bias, and "1" has a 100% rear bias. Can be any number between that range.
	
	--Differential Settings	
	Tune.FDiffSlipThres	= 50		-- 1 - 100%				(Max threshold of applying full lock determined by deviation from avg speed)
	Tune.FDiffLockThres	= 50		-- 0 - 100%				(0 - Bias toward slower wheel, 100 - Bias toward faster wheel)
	Tune.RDiffSlipThres	= 80		-- 1 - 100%
	Tune.RDiffLockThres	= 20		-- 0 - 100%
	Tune.CDiffSlipThres	= 50		-- 1 - 100%				[AWD Only]
	Tune.CDiffLockThres	= 50		-- 0 - 100%				[AWD Only]
	
	--Traction Control Settings
	Tune.TCSEnabled		= true		-- Implements TCS
	Tune.TCSThreshold	= 20		-- Slip speed allowed before TCS starts working (in SPS)
	Tune.TCSGradient	= 20		-- Slip speed gradient between 0 to max reduction (in SPS)
	Tune.TCSLimit		= 10		-- Minimum amount of torque at max reduction (in percent)
	
--[[Transmission]]
	Tune.Clutch			= true		-- Implements a realistic clutch, change to "false" for the chassis to act like AC6.81T.

	Tune.TransModes		= {"Semi"}												--[[
	[Modes]
		"Auto"		: Automatic shifting
		"Semi"		: Clutchless manual shifting, dual clutch transmission
		"Manual"	: Manual shifting with clutch
		
		>Include within brackets
			eg: {"Semi"} or {"Auto", "Manual"}								
	>First mode is default mode													]]
	
	Tune.ClutchMode		= "New"												--[[
	[Modes]
		"New"		: Speed controls clutch engagement			(AC6C V1.2)
		"Old"		: Speed and RPM control clutch engagement	(AC6C V1.1)		]]
	
	Tune.ClutchType 	= "Clutch"										--[[
	[Types]
		"Clutch"			: Standard clutch, recommended
		"TorqueConverter"	: Torque converter, keeps RPM up
		"CVT"				: CVT, found in scooters
																		]] 
	--[[Transmission]]
	--Transmission Settings
	Tune.Stall			= true		-- Stalling, enables the car to stall. An ignition plugin would be necessary. Disables if Tune.Clutch is false.
	Tune.ClutchRel		= false		-- If true, the driver must let off the gas before shifting to a higher gear. Recommended false for beginners.
	Tune.ClutchEngage	= 0		-- How fast engagement is (0 = instant, 99 = super slow)	
	Tune.SpeedEngage 	= 5		-- Speed the clutch fully engages at (Based on SPS) 
	
	--Clutch: "Old" mode
	Tune.ClutchRPMMult	= 1.0		-- Clutch RPM multiplier, recommended to leave at 1.0
	
	--Torque Converter:
	Tune.TQLock 		= false		-- Torque converter starts locking at a certain RPM
	
	--Torque Converter and CVT:
	Tune.RPMEngage 		= 3500		-- Keeps RPMs to this level until passed
	
	--Automatic Settings
	Tune.AutoShiftMode	= "RPM"												--[[
	[Modes]
		"Speed"		: Shifts based on wheel speed
		"RPM"		: Shifts based on RPM										]]	
	Tune.AutoShiftType	= "DCT"												--[[
	[Types]
		"Rev"		: Clutch engages fully once RPM reached			(AC6C V1)
		"DCT"		: Clutch engages after a set time has passed	(AC6.81T)	]]
	Tune.AutoShiftVers	= "New"												--[[
	[Versions]
		"New"		: Shift from Reverse, Neutral, and Drive		(AC6.81T)
		"Old"		: Auto shifts into R or D when stopped.			(AC6.52S2)	]]
	Tune.AutoUpThresh	= -200		-- Automatic upshift point 	(relative to peak RPM, positive = Over-rev)
	Tune.AutoDownThresh = 1400		-- Automatic downshift point (relative to peak RPM, positive = Under-rev)
	
	--Automatic: Revmatching
	Tune.ShiftThrot		= 100		-- Throttle level when shifting down to revmatch, 0 - 100%
	
	--Automatic: DCT
	Tune.ShiftUpTime	= 0.05		-- Time required to shift into next gear, from a lower gear to a higher one.
	Tune.ShiftDnTime	= 0.05		-- Time required to shift into next gear, from a higher gear to a lower one.
	
	--Gear Ratios
	
	Tune.FinalDrive		= 5.40
	Tune.Ratios			= {
		--[[Reverse]]	5			,
		--[[Neutral]]	0			,
		--[[ 1 ]]		4.00			,
		--[[ 2 ]]		3.36		,
		--[[ 3 ]]		2.17		,
		--[[ 4 ]]		1.72		,
		--[[ 5 ]]		1.32		,
		--[[ 6 ]]		1.00		,
		--[[ 7 ]]		0.85		,
		--[[ 8 ]]      0.70
	}
	Tune.FDMult			= 1			-- Ratio multiplier (keep this at 1 if car is not struggling with torque)
	
--[[Brakes]]
	Tune.ABSEnabled		= true		-- Implements ABS
	Tune.ABSThreshold	= 20		-- Slip speed allowed before ABS starts working (in SPS) 

	Tune.FBrakeForce   	= 1300		-- Front brake force
	Tune.RBrakeForce	= 1000		-- Rear brake force
	Tune.PBrakeForce	= 9000		-- Handbrake force
	
	Tune.FLgcyBForce	= 15000		-- Front brake force [PGS OFF]
	Tune.RLgcyBForce	= 10000		-- Rear brake force [PGS OFF]
	Tune.LgcyPBForce	= 25000		-- Handbrake force [PGS OFF]
	
--[[[Default Controls]]
	--Peripheral Deadzones
	Tune.Peripherals = {
		MSteerWidth				= 67		,	-- Mouse steering control width	(0 - 100% of screen width)
		MSteerDZone				= 10		,	-- Mouse steering deadzone (0 - 100%)
		
		ControlLDZone			= 5			,	-- Controller steering L-deadzone (0 - 100%)
		ControlRDZone			= 5			,	-- Controller steering R-deadzone (0 - 100%)
	}
	
	--Control Mapping
	Tune.Controls = {
		
	--Keyboard Controls
		--Mode Toggles
		ToggleTCS				= Enum.KeyCode.T					,
		ToggleABS				= Enum.KeyCode.Y					, 
		ToggleMouseDrive		= Enum.KeyCode.R					,
		
		--Primary Controls
		Throttle				= Enum.KeyCode.Up					,
		Brake					= Enum.KeyCode.Down					,
		SteerLeft				= Enum.KeyCode.Left					,
		SteerRight				= Enum.KeyCode.Right				,
		
		--Secondary Controls
		Throttle2				= Enum.KeyCode.W					,
		Brake2					= Enum.KeyCode.S					,
		SteerLeft2				= Enum.KeyCode.A					,
		SteerRight2				= Enum.KeyCode.D					,
		
		--Manual Transmission
		ShiftUp					= Enum.KeyCode.E					,
		ShiftDown				= Enum.KeyCode.Q					,
		Clutch					= Enum.KeyCode.LeftShift			,
		
		--Handbrake
		PBrake					= Enum.KeyCode.P					,
		
	--Mouse Controls
		MouseThrottle			= Enum.UserInputType.MouseButton1	,
		MouseBrake				= Enum.UserInputType.MouseButton2	,
		MouseClutch				= Enum.KeyCode.W					,
		MouseShiftUp			= Enum.KeyCode.E					,
		MouseShiftDown			= Enum.KeyCode.Q					,
		MousePBrake				= Enum.KeyCode.LeftShift			,
		
	--Controller Mapping
		ContlrThrottle			= Enum.KeyCode.ButtonR2				,
		ContlrBrake				= Enum.KeyCode.ButtonL2				,
		ContlrSteer				= Enum.KeyCode.Thumbstick1			,
		ContlrShiftUp			= Enum.KeyCode.ButtonY				,
		ContlrShiftDown			= Enum.KeyCode.ButtonX				,
		ContlrClutch			= Enum.KeyCode.ButtonR1				,
		ContlrPBrake			= Enum.KeyCode.ButtonL1				,
		ContlrToggleTMode		= Enum.KeyCode.DPadUp				,
		ContlrToggleTCS			= Enum.KeyCode.DPadDown				,
		ContlrToggleABS			= Enum.KeyCode.DPadRight			,
	}
	
--[[Standardized Values: Don't touch unless needed]]
	
	--[WEIGHT // Cubic stud : pounds ratio]
	Tune.WeightScaling = 1/50	--Default = 1/50 (1 cubic stud = 50 lbs)
	Tune.LegacyScaling = 1/10	--Default = 1/10 (1 cubic stud = 10 lbs) [PGS OFF]
	
return Tune