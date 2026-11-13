--[[
	   ___  _____
	  / _ |/ ___/	Avxnturador | Novena
	 / __ / /__			 LuaInt | Novena
	/_/ |_\___/   Build 6C, Version 1.4, Update 4
	
	Please install this chassis from scratch.
	More info can be found in the README.
	
	New values will have (Username) appended to the end of the description.
]]

local Tune = {}

--[[Misc]]
	Tune.LoadDelay		= 3.0		-- Delay before initializing chassis (in seconds)
	Tune.AutoStart		= true		-- Set to false if using manual ignition plugin
	Tune.AutoFlip		= true		-- Set to false if using manual flip plugin
	Tune.AutoUpdate		= true		-- Automatically applies minor updates to the chassis if any are found.
									-- Will NOT apply major updates, but will notify you of any.
									-- Set to false to mute notifications, or if using modified Drive.
	
--[[Wheel Alignment]]
	--[Don't physically apply alignment to wheels]
	--[Values are in degrees]
	Tune.FCamber		= 1
	Tune.RCamber		= 1
	Tune.FCaster		= 0
	Tune.RCaster		= 0	--Will only work with 4WS enabled (Avxnturador)
	Tune.FToe			= 0	
	Tune.RToe			= 0	
	
--[[Weight and CG]]
	Tune.Weight			= 3439		-- Total weight (in pounds)
	Tune.WeightBSize	= {			-- Size of weight brick (dimmensions in studs ; larger = more stable)
	 --[[Width]]		6		,
	 --[[Height]]		4		,
	 --[[Length]]		15		}
	Tune.WeightDist		= 54		-- Weight distribution (0 - on rear wheels, 100 - on front wheels, can be <0 or >100)
	Tune.CGHeight		= .8		-- Center of gravity height (studs relative to median of all wheels)
	Tune.WBVisible		= false		-- Makes the weight brick visible
	
	--Unsprung Weight
	Tune.FWheelDensity	= .1		-- Front Wheel Density
	Tune.RWheelDensity	= .1		-- Rear Wheel Density
	
	Tune.AxleSize		= 2			-- Size of structural members (larger = MORE STABLE / carry more weight)
	Tune.AxleDensity	= .1		-- Density of structural members
	
--[[Susupension]]
	Tune.SusEnabled		= true		-- Sets whether suspension is enabled 
	
	--Front Suspension
	Tune.FSusDamping	= 500		-- Spring Dampening
	Tune.FSusStiffness	= 9000		-- Spring Force
	Tune.FAntiRoll 		= 50		-- Anti-Roll (Gyro Dampening)
	
	Tune.FSusLength		= 2			-- Suspension length (in studs)
	Tune.FPreCompress	= .3		-- Pre-compression adds resting length force
	Tune.FExtensionLim	= .3		-- Max Extension Travel (in studs)
	Tune.FCompressLim	= .1		-- Max Compression Travel (in studs)
	Tune.FSusAngle		= 80		-- Suspension Angle (degrees from horizontal)
		
	Tune.FWsBoneLen		= 5			-- Wishbone Length
	Tune.FWsBoneAngle	= 0			-- Wishbone angle (degrees from horizontal)
	Tune.FAnchorOffset	= {			-- Suspension anchor point offset (relative to center of wheel)
	 --[[Lateral]]		-.4		,	-- positive = outward
	 --[[Vertical]]		-.5		,	-- positive = upward
	 --[[Forward]]		0		}	-- positive = forward
	Tune.FSpringOffset	= {			-- Suspension anchor point offset (relative to ABOVE anchor offset) (Avxnturador)
	 --[[Lateral]]		0		,	-- positive = outward 
	 --[[Vertical]]		0		,	-- positive = upward
	 --[[Forward]]		0		}	-- positive = forward
	
	--Rear Suspension
	Tune.RSusDamping	= 500		-- Spring Dampening
	Tune.RSusStiffness	= 9000		-- Spring Force
	Tune.RAntiRoll 		= 50		-- Anti-Roll (Gyro Dampening)

	Tune.RSusLength		= 2			-- Suspension length (in studs)
	Tune.RPreCompress	= .3		-- Pre-compression adds resting length force
	Tune.RExtensionLim	= .3		-- Max Extension Travel (in studs)
	Tune.RCompressLim	= .1		-- Max Compression Travel (in studs)
	Tune.RSusAngle		= 80		-- Suspension Angle (degrees from horizontal)
		
	Tune.RWsBoneLen		= 5			-- Wishbone Length
	Tune.RWsBoneAngle	= 0			-- Wishbone angle (degrees from horizontal)
	Tune.RAnchorOffset	= {			-- Suspension anchor point offset (relative to center of wheel)
	 --[[Lateral]]		-.4		,	-- positive = outward
	 --[[Vertical]]		-.5		,	-- positive = upward
	 --[[Forward]]		0		}	-- positive = forward
	Tune.RSpringOffset	= {			-- Suspension anchor point offset (relative to ABOVE anchor offset) (Avxnturador)
	 --[[Lateral]]		0		,	-- positive = outward 
	 --[[Vertical]]		0		,	-- positive = upward
	 --[[Forward]]		0		}	-- positive = forward
	
	--Aesthetics	
	Tune.SusVisible		= true			-- Spring Visible
	Tune.SusRadius		= .2			-- Suspension Coil Radius
	Tune.SusThickness	= .1			-- Suspension Coil Thickness
	Tune.SusColor		= "Bright red"	-- Suspension Color [BrickColor]
	Tune.SusCoilCount	= 6				-- Suspension Coil Count

--[[Wheel Stabilizer Gyro]]
	Tune.FGyroDamp		= 100		-- Front Wheel Non-Axial Dampening
	Tune.RGyroDamp		= 100		-- Rear Wheel Non-Axial Dampening
	
--[[Steering]]
	Tune.SteeringType	= 'New'		-- New = Precise steering calculations based on real life steering assembly (LuaInt)
									-- Old = Previous steering calculations
	-- New Options
	Tune.SteerRatio		= 15/1		-- Steering ratio of your steering rack, google it for your car
	Tune.LockToLock		= 2.6		-- Number of turns of the steering wheel lock to lock, google it for your car
	Tune.Ackerman		= .9		-- If you don't know what it is don't touch it, ranges from .7 to 1.2

	-- Old Options
	Tune.SteerInner		= 45		-- Inner wheel steering angle (in degrees)
	Tune.SteerOuter		= 38		-- Outer wheel steering angle (in degrees)
	
	--Four Wheel Steering (LuaInt)
	Tune.FWSteer			= 'Both'	-- Static, Speed, Both, or None
	Tune.RSteerOuter		= 12		-- Outer rear wheel steering angle (in degrees)
	Tune.RSteerInner		= 12		-- Inner rear wheel steering angle (in degrees)
	Tune.RSteerSpeed		= 60		-- Speed at which 4WS fully activates (Speed), deactivates (Static), or transition begins (Both) (SPS)
	Tune.RSteerDecay		= 330		-- Speed of gradient cutoff (in SPS)

	-- Rear Steer Gyro Tuning
	Tune.RSteerD			= 1000		-- Steering Dampening
	Tune.RSteerMaxTorque	= 50000		-- Steering Force
	Tune.RSteerP			= 100000	-- Steering Aggressiveness
	
	-- General Steering
	Tune.SteerSpeed		= .07		-- Steering increment per tick (in degrees)
	Tune.ReturnSpeed	= .1		-- Steering increment per tick (in degrees)
	Tune.SteerDecay		= 330		-- Speed of gradient cutoff (in SPS)
	Tune.MinSteer		= 10		-- Minimum steering at max steer decay (in percent)
	Tune.MSteerExp		= 1			-- Mouse steering exponential degree
	
	-- Steer Gyro Tuning
	Tune.SteerD			= 1000		-- Steering Dampening
	Tune.SteerMaxTorque	= 50000		-- Steering Force
	Tune.SteerP			= 100000	-- Steering Aggressiveness
	
--[[Engine (Avxnturador)]]

	-- Everything below can be illustrated and tuned with the graph below.
	-- https://www.desmos.com/calculator/oishj9m1tq
	-- This includes everything, from the engines, to boost, to electric.
	
	-- To import engines prior to AC6C V1.3, consult the README.
	
	-- Naturally Aspirated Engine
	Tune.Engine 		= true		
		
		Tune.Horsepower		= 220
		Tune.IdleRPM		= 750
		Tune.PeakRPM		= 6800
		Tune.Redline		= 8000
		Tune.EqPoint		= 5252
		Tune.PeakSharpness	= 10
		Tune.CurveMult		= 0.4
	
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
	Tune.Turbochargers	= 1				-- Number of turbochargers in the engine
										-- Set to 0 for no turbochargers
		Tune.T_Boost		= 7
		Tune.T_Efficiency	= 8.5
		
		Tune.T_Size			= 80		-- Turbo Size; Bigger size = more turbo lag
		
	-- Supercharger
	Tune.Superchargers	= 1				-- Number of superchargers in the engine
										-- Set to 0 for no superchargers
		Tune.S_Boost		= 7
		Tune.S_Efficiency	= 8.5
		
		Tune.S_Sensitivity	= 0.05		-- Supercharger responsiveness/sensitivity, applied per tick (recommended values between 0.05 to 0.1)
		
	--Misc
	Tune.ThrotAccel		= .05		-- Throttle acceleration, applied per tick (recommended values between 0.05 to 0.1)
	Tune.ThrotDecel		= .2		-- Throttle deceleration, applied per tick (recommended values between 0.1 to 0.3)
	
	Tune.BrakeAccel		= .2		-- Brake acceleration, applied per tick
	Tune.BrakeDecel		= .5		-- Brake deceleration, applied per tick
	
	Tune.RevAccel		= 250		-- RPM acceleration when clutch is off
	Tune.RevDecay		= 75		-- RPM decay when clutch is off
	Tune.RevBounce		= 500		-- RPM kickback from redline
	
	Tune.IdleThrottle	= 3			-- Percent throttle at idle
	Tune.Flywheel		= 500		-- Flywheel weight (higher = faster response, lower = more stable RPM)
	
	Tune.InclineComp	= 1			-- Torque compensation multiplier for inclines (applies gradient from 0-90 degrees)
	
--[[Drivetrain]]	
	Tune.Config			= "AWD"		-- "FWD" , "RWD" , "AWD"
	Tune.TorqueVector	= .4		-- AWD ONLY, "-1" has a 100% front bias, "0" has a 50:50 bias, and "1" has a 100% rear bias. Can be any number between that range.
	
	-- Differential Settings
	Tune.DifferentialType = 'New'	-- New: Fairly precise and accurate settings based on a real differential
									-- Old: Same differential as previous iterations of AC6
	
	-- Old Options
	Tune.FDiffSlipThres	= 50		-- 1 - 100%				(Max threshold of applying full lock determined by deviation from avg speed)
	Tune.FDiffLockThres	= 50		-- 0 - 100%				(0 - Bias toward slower wheel, 100 - Bias toward faster wheel)
	Tune.RDiffSlipThres	= 80		-- 1 - 100%
	Tune.RDiffLockThres	= 20		-- 0 - 100%
	Tune.CDiffSlipThres	= 50		-- 1 - 100%				[AWD Only]
	Tune.CDiffLockThres	= 50		-- 0 - 100%				[AWD Only]
	
	-- New Options (LuaInt)
	Tune.FDiffPower		= 30		-- 0 - 100				Higher values yield more wheel lock-up under throttle, more stability (Front wheels if driven only)
	Tune.FDiffCoast		= 10		-- 0 - 100				Higher values yield more wheel lock-up when off throttle, more stability (Front wheels if driven only)
	Tune.FDiffPreload	= 10		-- 0 - 100				Higher values will make the wheels generally lock up faster in any environment (Front wheels if driven only)
	Tune.RDiffPower		= 40		-- 0 - 100				(Rear wheels if driven only)
	Tune.RDiffCoast		= 20		-- 0 - 100				(Rear wheels if driven only)
	Tune.RDiffPreload	= 20		-- 0 - 100				(Rear wheels if driven only)
	
	-- Traction Control Settings
	Tune.TCSEnabled		= true		-- Implements TCS
	Tune.TCSThreshold	= 20		-- Slip speed allowed before TCS starts working (in SPS)
	Tune.TCSGradient	= 20		-- Slip speed gradient between 0 to max reduction (in SPS)
	Tune.TCSLimit		= 10		-- Minimum amount of torque at max reduction (in percent)
	
--[[Transmission]]
	Tune.Clutch			= true		-- Implements a realistic clutch, change to "false" for the chassis to act like AC6.81T.

	Tune.TransModes		= {"Semi","Manual"}												--[[
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
	Tune.ClutchEngage	= 10		-- How fast engagement is (0 = instant, 99 = super slow)	
	Tune.SpeedEngage 	= 20		-- Speed the clutch fully engages at (Based on SPS) 
	
	Tune.ClutchKick			= true	-- (LuaInt)
	Tune.KickMult			= 15	-- Torque multiplier on launch
	Tune.KickSpeedThreshold = 40	-- Speed limit on launch (SPS)
	Tune.KickRPMThreshold 	= 1000	-- RPM limit on launch, range is created below redline
	
	--Clutch: "Old" mode
	Tune.ClutchRPMMult	= 1.0		-- Clutch RPM multiplier, recommended to leave at 1.0
	
	--Torque Converter:
	Tune.TQLock 		= false		-- Torque converter starts locking at a certain RPM
	
	--Torque Converter and CVT:
	Tune.RPMEngage 		= 3500		-- Keeps RPMs to this level until passed
	
	--Neutral Rev Limiter (Avxnturador)
	Tune.NeutralLimit	= false		-- Enables a different redline RPM for when the car is in neutral
	Tune.NeutralRevRPM	= 5000		-- The rev limiter when the car is in neutral
	Tune.LimitClutch	= false		-- Will also limit RPMs while the clutch is pressed down
	
	--Automatic Settings
	Tune.AutoShiftMode	= "Speed"												--[[
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
	Tune.ShiftUpTime	= 0.25		-- Time required to shift into next gear, from a lower gear to a higher one.
	Tune.ShiftDnTime	= 0.125		-- Time required to shift into next gear, from a higher gear to a lower one.
	
	--Gear Ratios
	
	Tune.FinalDrive		= 3.545
	Tune.Ratios			= {
		--[[Reverse]]	3.28		,
		--[[Neutral]]	0			,
		--[[ 1 ]]		3.827		,
		--[[ 2 ]]		2.36		,
		--[[ 3 ]]		1.685		,
		--[[ 4 ]]		1.313		,
		--[[ 5 ]]		1			,
		--[[ 6 ]]		.793		,
	}
	Tune.FDMult			= 1			-- Ratio multiplier (keep this at 1 if car is not struggling with torque)
	
--[[Brakes]]
	Tune.ABSEnabled		= true		-- Implements ABS
	Tune.ABSThreshold	= 20		-- Slip speed allowed before ABS starts working (in SPS) 

	Tune.BrakeForce		= 2500		-- Total brake force (LuaInt)
	Tune.BrakeBias		= .57		-- Brake bias towards the front, percentage (1 = Front, 0 = Rear, .5 = 50/50)
	Tune.PBrakeForce	= 5000		-- Handbrake force
	Tune.PBrakeBias		= .57		-- Handbrake bias towards the front, percentage (1 = Front, 0 = Rear, .5 = 50/50)
	Tune.EBrakeForce	= 250		-- Engine braking force at redline
	
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
		ToggleTransMode			= Enum.KeyCode.M					,
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
	
return Tune