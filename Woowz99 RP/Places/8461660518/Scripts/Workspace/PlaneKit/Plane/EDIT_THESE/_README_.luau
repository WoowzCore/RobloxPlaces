[[

This describes what each object in the EDIT_THESE parent does.
Do NOT change the name of any objects, including the one this script is in

PlaneName
	Change this value to whatever you want to name your plane. This
	name will appear on the GUI displayed to the pilot.

MaxBank
	The maximum degree the plane can bank on turn. If greater than
	90, the plane script will read it as 90. If a negative number is
	given, your plane will bank in the opposite direction that the plane
	is turning in.

MaxSpeed*
	The speed your plane will travel at when level.

StallSpeed*
	The speed at which is needed to be airborne. If the current speed
	is below or equal to the StallSpeed, then the plane will fall. If the
	plane is on the ground and under the StallSpeed, then the plane
	will be in Taxi mode, in which the plane moves like a ground vehicle.

Acceleration*
	If the speed is not where it should be, the speed will change based
	on this value every frame (0.03 seconds). Therefore, this number
	should be kept low to keep the realism higher

ThrottleIncrease*
	This is how much the throttle will increase/decrease when you press
	and hold the hotkey for speed up or speed down. NOTE: This number
	should be EXTREMELY low, since max throttle is just 1, and the
	incriment will apply every frame. Suggested value is 0.01

SpeedDifferential*
	How much the speed will vary based on the angle of the plane. For
	example, if the SpeedDifferential is 50 and the MaxSpeed is 200,
	then when you go straight down, you will go 250, and when you go
	up, you will travel at 150.

CanCrash
	If checked, then your plane can crash. If false, the plane will not
	crash.

	CanCrash.Force*
		The force of which is needed in order to cause the crash. For
		example, if the plane is traveling at 200 and hits a stationary
		object, the plane will only "crash" if the Force is set at 200
		or below

	CanCrash.SpinSpeed
		How much the plane spins (degree) per frame (0.03 sec) while
		crashing. Change between negative and positive numbers to
		change the direction of the spin.

	CanCrash.VisualFX
		If checked, then smoke and fire will be shown from the plane
		while crashing. If not checked, then the plane will not emit any
		smoke or fire.

AltitudeRestrictions
	If checked, the plane will be restricted within a certain altitude limit.
	MinAltitude
		If the plane goes below this altitude, the plane will blow up.
	MaxAltitude
		If the plane goes above this altitude, the plane will stall until
		the altitude is within the restrictions again.
	MaxAltitude must be at least 100 greater than MinAltitude. If not, the
	main script will correct it.
	SetByOrigin
		If checked, then MaxAltitude and MinAltitude will be added to the
		starting altitude. For example, if the plane is spawned at an
		altitude of 500 and the MaxAltitude is set to 200, then the max
		altitude will now be 700. If NOT checked, then the altitude will
		be read strictly from the Y position of the plane.

Hotkeys
	Keys that are pressed to simplify an operation.
	LandingGear
		Retract/Extend landing gear
	Engine
		Engine on/off
	SpeedUp**
		Increase throttle
	SpeedDown**
		Decrease throttle




*	This value will be turned into an absolute value, which means that if
	a negative number is given, it will be turned into a positive number.

**	Instead of just letters, you can type in ArrowKeyUp or ArrowKeyDown
