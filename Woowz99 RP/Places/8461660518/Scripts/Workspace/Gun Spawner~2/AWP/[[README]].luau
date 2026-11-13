--[[
	
	VERSION: v0.0.4
	
	----------[ UPDATES ]----------------------------------------------------
	
	Pre-Release: -Added a copyright
	             -fixed the issue where you couldn't run when you selected the tool
	             -Added an ADS key and allowed ADS to either be toggle or hold
	             -Made the Ammo values external so they can be changed by outside scripts
	
	v0.0.2: -Created new arms for the gun
			-Fixed an issue where the arms would glitch if PlayerAnimations was set to false and the gun was fired
			-Updated credit security
			-Put the Arm cframes in the SETTINGS
			-Made the stance changing animations slightly smoother
			-Added bullet drop
			-Fixed some bullet hit handling code
			-Made the torso being able to rotate while sitting down a setting
			-Added bullet settings
			-Added shockwave settings
			-Added an Explosive guntype
			-Added a version label in the Gui
	
	v0.0.3: -Added an option to have player arms
			-Added grenades / throwables
			-Fixed the issue where if a player left a server without deselecting the gun, the bullet trails still remained
			-Added Gui Scopes
			-Fixed the issue where the guns would glitch if you switched weapons too fast
	
	v0.0.4: -Updated the Gui
			-Added a "Table Of Contents" in the clientMain
			-Added PLUGINS
			-Added the Arm CFrame when Running in the SETTINGS
			-Added Mouse Sensitivity settings
			-Fixed an issue where a humanoid wouldn't be damaged by bullets if there was no space between a wall and the humanoid
			-Fixed the issue where you couldn't steady the scope if the steady key was different from the run key
			-Added an example flashlight and laser (You can delete them and the gun will still work fine)
			-Moved the movement animations into a separate module script for easier editing
			-Added a single bullet mag option. It allows people to make guns where the mag is the bullet itself (i.e. arrows)
			-Moved grenades into a seperate folder and made them server-side so they don't get deleted when you die or switch guns
			-Added an option for a second knife animation
			-Added a setting to change the throwing speed of the grenades
			-Added an auto-knife feature
			-Added a setting for whether the gun can ADS or not
			-Added a flashbang and a molotov to the grenade list
			-Fixed an issue where bullets could only penetrate 1 wall
			-Added gun sway for when you move the gun around
			-Made the camera type scriptable when the gun is selected
			-Moved the ignore model creating code into a seperate server script so the ReadMe can be deleted
			-Redesigned the animations so the transitions between idling, walking, and running are smooth instead of choppy like previously
			-Added a fire select option
			-Added an equip animation option
			-Added a crawling animation option
			-Fixed the issue where you could dive and jump at the same time
			-Moved the reload animation into the ANIMATIONS modulescript for easier editing
			-Added an option to enable reloading while running
			-Added an option to enable firing while running
			-Redesigned the recoil animation and based it more on battlefield
			-Edited the reload so if a bullet is already chambered and you reload the ammo will be the ClipSize + 1
			-Fixed the issue where the ammo would go to 0 if you stopped the reload
			-Fixed the issue where if you stopped the reload before you put in a new mag the gun would take another full clipsize from the storedammo
			-Fixed an issue where if the gun was removed without being deselected, the camera would break
			-Got rid of the gunName and gunDescription settings because they're unnecessary and annoying to change
			-Moved bullet impact object creation to server side
			-Added a bullet smoke impact setting
			-Added a blood particle setting that appears on a player when they're shot
			-Updated the scope
			-Added CanCollide, transparency, and custom ignore settings to the penetration settings
			-Moved trail creation to server side to prevent client lag
			-Fixed an issue where shooting a player's hat would do damage
	
	-------------------------------------------------------------------------
	
	Hello there!
	
	Glad to know you're using my one and only Gun Kit!
	
	Even though this kit has many features and is rather advanced, it's pretty easy to use
	
	There are 4 things that this gun needs in order to function:
		One brick called "AimPart"
		At least one brick where the first 3 letters are "Mag"
		One brick called "Handle"
		One brick called "Main"
		
	The AimPart is what the gun will use to aim down the sights. When you aim down your sights, this brick will be in the center
	of the player's head. It basically allows the gun to have any type of sight, which can be placed anywhere on the gun. As long as
	the AimPart is aligned with the sight, the gun will aim down the sights properly.
	(NOTE: Make sure the AimPart is behind the Sight and the FRONT of the AimPart is facing the Sight)
	
	The Mag is what the gun will move around when you reload the gun. If the mag is made up of more than one brick, make sure the first
	3 leters of the bricks are also "Mag" so that the gun will move them around. If you set ReloadAnimation to false in the SETTINGS, you don't
	need any bricks called "Mag". But if ReloadAnimation is set to true, the gun needs at least one brick called "Mag" or it will break. It doesn't
	matter what comes after the "Mag", you can have a Mag brick called "Mag1" and another Mag brick called "MagA". As long as the first three letters are
	"Mag", then the gun will recognize it as a Mag
	
	The Handle is obviously the most important part of the Gun. Without it, the tool itself wouldn't work. It's that simple
	(NOTE: If you want a sound to play when you fire, name it "FireSound" and place it in the Handle. If you want a sound to play when
	you reload, name it "ReloadSound" and place it in the Handle)
	
	The Main is the brick where the bullets will originate from. It's also the brick where the flash effects are kept.
	(NOTE: If you want a muzzle flash effects, put them in the Main and call them "FlashFX". Also make sure they have an "Enabled"
	property so that the script can enable and disable them)
	
	----------[ INSTRUCTIONS ]-----------------------------------------------
	
	HOW TO USE THIS KIT:
		1) If the gun already has a Handle, make sure it is facing forward. If the gun doesn't have a Handle, create one and place
		   it wherever you like, and make sure it is facing forward
		
		2) If the gun already has a brick called "AimPart", move it to where you would like, and make sure it is facing the sight.
		   If the gun doesn't have a brick called "AimPart", create one and move it where you would like it to be, and make sure
		   it is facing the sight
		
		3) If the gun already has a brick called "Main", move it to the very front of the gun. If the gun doesn't have a brick
		   called "Main", create one and move it to the very front of the gun
		
		4) If ReloadAnimation is set to true in the SETTINGS, make sure the gun has at least one brick called "Mag". If
		   ReloadAnimation is set to false, the gun doesn't need any bricks called "Mag".
		
		5) Open the SETTINGS and edit them however you like
		
	That's it! Only 5 steps! It's not that complicated, just follow the Directions and it should work fine. If you have any questions /
	comments / concerns, message me.
	
	     ______   ______           __          ______           _                ______
	    / _/ _/  /_  __/_  _______/ /_  ____  / ____/_  _______(_)___  ____     /  /  /
	   / // /     / / / / / / ___/ __ \/ __ \/ /_  / / / / ___/ / __ \/ __ \    / // / 
	  / // /     / / / /_/ / /  / /_/ / /_/ / __/ / /_/ (__  ) / /_/ / / / /   / // /  
	 / // /     /_/  \__,_/_/  /_.___/\____/_/    \__,_/____/_/\____/_/ /_/  _/ // /   
	/__/__/                                                                 /__/__/    
	
--]]