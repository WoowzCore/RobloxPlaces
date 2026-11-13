--[[
	
	This module script contains all the main animations. I put it into this script so it'll be easier to edit.
	
	Both arms are welded to a single brick called "animBase". This makes it easier to edit movement animations because you only have to
	edit the cframe of one brick instead of 2 arms.
	
	The idling, walking, and running animations have a Pos and a Rot component. The Pos component is the position of the weld and the Rot component
	is the rotation of the weld. They're vector3 values so the script can multiply each value by an alpha and add them together to make the smooth
	transitions possible
	
	The table directly below lets you know how each component of the Vector affects the movement of the weld so it's easier to edit
	
	This module also contains the reload animation which I moved here for easier editing. The animation function has a parameter S that contains all
	the functions and variables that are necessary to make the animation run
	
	HOW TO EDIT THE RELOAD ANIMATION:
		-Make sure each block of the animation is made into a separate function, it needs to be like this so if the reload animation needs to be stopped
		midway, the arms don't glitch out
		-Each animation piece should only have one wait command at the end of the function
		-Multiply every duration value, including the wait time values by the animSpeed. That way if you change the reload time, you won't have to change
		each individual time value for all the animation components
	
--]]

local Animations = {
	
	Reload = function(S) --This is the main reload animation. The parameter S contains all the variables and functions that are necessary for this animation
		--[[
			FUNCTION LIST_
			
				S.tweenJoint(Joint, newC0, newC1, Alpha, Duration) --This function tweens a joint to a given C0 and C1. The Alpha parameter is function
					that returns a number between 0 and 1 given an argument of a number between 0 and 90. The Duration is how fast the joint tweens. NOTE,
					you can put nil as an argument for the newC0 or newC1 parameter and the function won't tween that specific property of the weld. This
					is useful if you only want to mess with the C0 or C1 property of a weld.
					
				S.makeMagInvisible() --This function makes the mag invisible so it looks like the mag was removed
				
				S.makeMagVisible() --This function makes the mag visible again at whatever the previous transparency of the mag parts were
				
				S.isMagVisible() --This function returns a true or false value based on whether or not the mag is visible. This can be used to tell if
					the animation was stopped midway and where to restart the animation
					
				S.isMagEmpty() --This function returns a true or false value based on whether or not the mag is empty, meaning the ammo is 0. This can be
					used to decide if a chambering animation should play after the reload animation
					
				S.setNewMag() --This function sets the newMag variable in the clientMain to true which basically lets the script know that a new mag was
					put into the gun. This is used so that if the reload animation is broken after the new mag was put in but before the chambering animation
					then the script will simply play the chambering animation instead of putting in another mag
					
				S.isNewMag() --This function returns a true or false value based on whether or not the mag that is currently attached to the gun is a new
					mag. In order for it to be a new mag, it needs to have full ammo. Once you fire, the mag becomes an old mag
					
				S.createMag(Key) --This functions clones the Mag and puts it in a table with a Key parameter so you can access the mag in a separate
					function and it returns a Model containing the Mag and a table that contains the original mag bricks and the corresponding clone. NOTE,
					the mag bricks will be made non can collide
					
				S.getMag(Key) --This function gets a Mag from the mag table given a Key argument and it returns the model that the mag is contained in
					and the brick that all the other mag parts are welded to
				
				S.attachGripToHead() --This function detaches the grip from the right arm and attaches it to the Head. This is so you can make reload
					animations that require using the right arm to manipulate the gun in any way. The C0 of the grip is changed so the gun stays in the
					position that it was in before you detached the grip from the right arm.
					
				S.attachGripToArm() --This function detaches the grip from the Head and attaches it to the Arm. The C0 of the grip is changed so the gun
					stays in the position that it was in before you detached the grip from the head
				
				S.Sine(X) --This function is an Alpha function for the tweenJoint function. Given a number between 0 and 90, the function will return the
					sine of that number, which is a number between 0 and 1, which is used to tween a Joint with a Sine movement
					
				S.Linear(X) --This function is an Alpha function for the tweenJoint function. Given a number between 0 and 90, the function will return
					the number / 90, which is a number between 0 and 1, which is used to a tween a Joint with a Linear movement
				
			VARIABLE LIST_
			
				S.Handle --This variable is the Handle of gun
				
				S.LArm --This variable is the left arm
				
				S.RArm --This variable is the right arm
				
				S.LWeld --This variable is the left arm weld which is attached to the animBase
				
				S.RWeld --This variable is the right arm weld which is attached to the animBase
				
				S.LC0 --This variable is the cframe of the left arm joint with respect to the torso
				
				S.RC0 --This variable is the cframe of the right arm joint with respect to the torso
				
				S.Grip --This variable is the Grip weld which is attached to right arm
				
				S.gunIgnore --This variable is the gun ignore model which contains the fake arms and bullets and other stuff
				
				S.Cam --This variable is the player camera
				
				S.CF --This variable is the shortened form of CFrame.new which you can use instead of CFrame.new
				
				S.CFANG --This variable is the shortened form of CFrame.Angles which you can use instead of CFrame.Angles
				
				S.V3 --This variable is the shortened form of Vector3.new which you can use instead of Vector3.new
				
				S.RAD --This variable is the shortened form of math.rad which you can use instead of math.rad
				
				S.reloadTimeLoaded --This variable is the reload time for when the gun is loaded which you can use to modify how fast the reload
					animation runs
					
				S.reloadTimeEmpty --This variable is the reload time for when the gun is empty which you can use to modify how fast the reload
					animation runs
		--]]
		
		local W1 = nil
		local W2 = nil
		local animSpeed = S.isMagEmpty() and S.reloadTimeEmpty / 1.3 or S.reloadTimeLoaded / 0.9
		return {
			function()
				if (not S.isNewMag()) then
					if S.isMagVisible() then
						local Mag1, magTable1 = S.createMag("Mag1")
							
						Mag1.Parent = S.gunIgnore
						
						W1 = Instance.new("Weld")
						W1.Part0 = magTable1[1].magClone
						W1.Part1 = S.Handle
						W1.C0 = magTable1[1].Original.CFrame:toObjectSpace(S.Handle.CFrame)
						W1.Parent = magTable1[1].magClone
						
						S.tweenJoint(S.LWeld, nil, S.CF(-0.9, 2, -1.1) * S.CFANG(S.RAD(-15), 0, S.RAD(-25)), S.Sine, 0.2 * animSpeed)
						S.tweenJoint(S.RWeld, nil, S.CF(0.3, 0.2, -0.31) * S.CFANG(S.RAD(-12), 0, S.RAD(25)), S.Sine, 0.2 * animSpeed)
						S.tweenJoint(S.Grip, nil, S.CFANG(0, S.RAD(20), S.RAD(10)), S.Sine, 0.1 * animSpeed)
						wait(0.2 * animSpeed)
					end
				end
			end;
			
			function()
				if (not S.isNewMag()) then
					if S.isMagVisible() then
						S.makeMagInvisible()
						W1:Destroy()
						local Mag1, magTable1 = S.getMag("Mag1")
						magTable1[1].magClone.Velocity = S.Handle.Velocity + S.Handle.CFrame:vectorToWorldSpace(S.V3(0, -1, 0)) * 20
						
						S.tweenJoint(S.RWeld, nil, S.CF(0.3, 0.2, -0.5) * S.CFANG(S.RAD(-20), S.RAD(10), S.RAD(25)), S.Sine, 0.25 * animSpeed)
						S.tweenJoint(S.Grip, nil, S.CFANG(0, S.RAD(20), S.RAD(10)), S.Sine, 0.2 * animSpeed)
					else
						S.tweenJoint(S.RWeld, nil, S.CF(0.6, 0.2, -0.61) * S.CFANG(S.RAD(-12), S.RAD(20), S.RAD(25)), S.Sine, 0.2 * animSpeed)
						S.tweenJoint(S.Grip, nil, S.CFANG(S.RAD(-10), S.RAD(20), S.RAD(10)), S.Sine, 0.2 * animSpeed)
					end
					
					S.tweenJoint(S.LWeld, nil, S.CF(0, 0.5, 0) * S.CFANG(S.RAD(95), 0, S.RAD(-25)), S.Sine, 0.2 * animSpeed)
					
					wait(0.25 * animSpeed)
				end
			end;
			
			function()
				if (not S.isNewMag()) then
					local Mag1, magTable1 = S.getMag("Mag1")
					if Mag1 then Mag1:Destroy() end
					
					local Mag2, magTable2 = S.createMag("Mag2")
					
					Mag2.Parent = S.gunIgnore
					
					local LArmCF = S.LWeld.Part0.CFrame * S.LWeld.C0 * (S.CF(0.58, 1.63, -1.4) * S.CFANG(S.RAD(-22), S.RAD(20), S.RAD(-60))):inverse()
					local RArmCF = S.RWeld.Part0.CFrame * S.RWeld.C0 * (S.CF(0.6, 0.2, -0.61) * S.CFANG(S.RAD(-15), S.RAD(20), S.RAD(25))):inverse()
					local handleOffsetCF = S.RArm.CFrame:toObjectSpace(S.RArm.CFrame * S.Grip.C0 * (S.CFANG(S.RAD(-10), S.RAD(20), S.RAD(10))):inverse())
					local originalMagOffsetCF = S.Handle.CFrame:toObjectSpace(magTable2[1].Original.CFrame)
					local newMagC0 = LArmCF:toObjectSpace(RArmCF * handleOffsetCF * originalMagOffsetCF)
					
					W2 = Instance.new("Weld")
					W2.Part0 = S.LArm
					W2.Part1 = magTable2[1].magClone
					W2.C0 = newMagC0
					W2.Parent = magTable2[1].magClone
					
					S.tweenJoint(S.LWeld, nil, S.CF(0.55, 1, -2.4) * S.CFANG(S.RAD(-20), S.RAD(20), S.RAD(-60)), S.Sine, 0.2 * animSpeed)--0.25
					S.tweenJoint(S.RWeld, nil, S.CF(0.6, 0.2, -0.61) * S.CFANG(S.RAD(-12), S.RAD(20), S.RAD(25)), S.Sine, 0.2 * animSpeed)
					S.tweenJoint(S.Grip, nil, S.CFANG(S.RAD(-10), S.RAD(20), S.RAD(10)), S.Sine, 0.2 * animSpeed)
					wait(0.2 * animSpeed)
				end
			end;
			
			function()
				if (not S.isNewMag()) then
					S.tweenJoint(S.Grip, nil, S.CFANG(S.RAD(-10), S.RAD(20), S.RAD(10)), S.Sine, 0.15 * animSpeed)
					S.tweenJoint(S.LWeld, nil, S.CF(0.58, 1.63, -1.4) * S.CFANG(S.RAD(-22), S.RAD(20), S.RAD(-60)), S.Sine, 0.15 * animSpeed)--0.25
					S.tweenJoint(S.RWeld, nil, S.CF(0.6, 0.2, -0.61) * S.CFANG(S.RAD(-15), S.RAD(20), S.RAD(25)), S.Sine, 0.2 * animSpeed)
					
					wait(0.2 * animSpeed)
				end
			end;
			
			function()
				if (not S.isNewMag()) then
					local Mag1, _ = S.getMag("Mag1")
					local Mag2, _ = S.getMag("Mag2")
					S.makeMagVisible()
					S.setNewMag()
					if Mag1 then Mag1:Destroy() end
					Mag2:Destroy()
				end
			end;
			
			function()
				if S.isMagEmpty() then
					if S.isNewMag() then
						S.tweenJoint(S.Grip, nil, S.CFANG(S.RAD(-10), S.RAD(20), S.RAD(10)), S.Sine, 0.15 * animSpeed)
						S.tweenJoint(S.LWeld, nil, S.CF(0.58, 1.63, -1.4) * S.CFANG(S.RAD(-22), S.RAD(20), S.RAD(-60)), S.Sine, 0.15 * animSpeed)--0.25
						S.tweenJoint(S.RWeld, nil, S.CF(0.6, 0.2, -0.61) * S.CFANG(S.RAD(-15), S.RAD(20), S.RAD(25)), S.Sine, 0.2 * animSpeed)
					end
					S.tweenJoint(S.LWeld, nil, S.CF(0, 1.3, -0.55) * S.CFANG(S.RAD(-26), 0, 0), S.Sine, 0.2 * animSpeed)
					
					wait(0.2 * animSpeed)
				end
			end;
			
			function()
				if S.isMagEmpty() then
					S.tweenJoint(S.LWeld, nil, S.CF(0.4, 1.6, -0.55) * S.CFANG(S.RAD(-23), 0, S.RAD(-60)), S.Sine, 0.1 * animSpeed)
					
					wait(0.05 * animSpeed)
				end
			end;
			
			function()
				if S.isMagEmpty() then
					S.tweenJoint(S.RWeld, nil, S.CF(0.6, 0.2, -0.61) * S.CFANG(S.RAD(-15), S.RAD(20), S.RAD(20)), S.Sine, 0.05 * animSpeed)
					
					wait(0.15 * animSpeed)
				end
			end;
		}
	end;
	
	Cocking = function(S)
		
	end;
	
	Crawling = function(X, moveDirection, moveSpeed) --This is the animation for when you're crawling
		--[[
			The moveDirection gives you the angle at which your character is moving with respect to the way you're facing. So if you're
			moving to the right and you're facing forward then the moveDirection will give you an angle of -90. If you're moving backward
			and you're facing forward then the moveDirection will give you an angle of 180. I use this angle to adjust the crawling animation
			so that you're arms move in the direction that you're moving so it looks more realistic rather than the arms constantly moving forward
			
			The moveVelocity gives you how fast you're moving in the X-Z plane. It doesn't take your Y-velocity into account so if you're falling your
			moveVelocity will still be how fast you're moving horizontally. You can use this to adjust how fast the crawling animation runs so if you're
			moving really slow the animation will play slower
		--]]
		return {
			leftArm = CFrame.Angles( --This is what the cframe of the right arm will be when you're crawling
				0,
				math.rad(90),
				math.rad(-10)
			) * CFrame.new(
				math.sin(moveDirection) * (math.sin(X * 6) / 4) - 0.2,
				math.cos(moveDirection) * (math.sin(X * 6) / 2) - 0.1,
				math.max(math.cos(X * 6) / 4, 0) - 0.1
			) * CFrame.Angles(
				-math.max(math.cos(X * 6) / 4, 0),
				0,
				0
			);
			leftLeg = CFrame.new( --This is what the cframe of the left leg will be when you're crawling
				math.sin(moveDirection) * (-math.sin(X * 6) / 4) - 0.2,
				math.cos(moveDirection) * (math.sin(X * 6) / 2) + 0.3,
				math.max(math.cos(X * 6) / 4, 0) - 0.1
			):inverse() * CFrame.Angles(
				0,
				0,
				-math.rad(15) - math.cos(moveDirection) * (math.rad(15) * math.sin(X * 6))
			);
			rightArm = CFrame.Angles( --This is what the cframe of the left arm will be when you're crawling
				0,
				math.rad(-5),
				math.rad(10)
			) * CFrame.new(
				math.sin(moveDirection) * (-math.sin(X * 6) / 4) + 0.2,
				math.cos(moveDirection) * (-math.sin(X * 6) / 5) - 0.2,
				math.max(math.cos((X + math.rad(30)) * 6) / 10, 0) - 0.1
			) * CFrame.Angles(
				-math.max(math.cos((X + math.rad(30)) * 6) / 10, 0),
				0,
				0
			);
			rightLeg = CFrame.new( --This is what the cframe of the right leg will be when you're crawling
				math.sin(moveDirection) * (math.sin(X * 6) / 4) + 0.2,
				math.cos(moveDirection) * (-math.sin(X * 6) / 2) + 0.3,
				math.max(math.cos((X + math.rad(30)) * 6) / 4, 0) - 0.1
			):inverse() * CFrame.Angles(
				0,
				0,
				math.rad(15) - math.cos(moveDirection) * (math.rad(15) * math.sin(X * 6))
			);
			Grip = CFrame.Angles( --This is what the cframe of the grip will be when you're crawling
				math.max(math.cos((X + math.rad(30)) * 6) / 7, 0),
				math.rad(5),
				0
			);
			Camera = 1.5 * math.rad(math.cos((X + math.rad(30)) * 6)) + math.rad(0.5); --This is what the roll of the camera will be when you're crawling
		}
	end;
		
	Idling = { --This table holds the Idling animations
		
		unAimed = function(X) --This is the animation when the gun is not aimed
			return {
				Pos = Vector3.new(
					math.sin(X / 2) / 70, --Side to Side motion
					math.sin(X * 5 / 4) / 70, --Up and Down motion
					math.sin(X * 3 / 4) / 70 --Forward and backward motion
				);
				Rot = Vector3.new(
					0, --Pitch rotation
					0, --Yaw rotation
					0 --Roll rotation
				);
			}
		end;
		
		Aimed = function(X) --This is the animation when the gun is aimed
			return {
				Pos = Vector3.new(
					math.sin(X * 3 / 8) / 140,
					math.sin(X * 15 / 16) / 140,
					0
				);
				Rot = Vector3.new(
					0,
					0,
					0
				);
			}
		end;
		
	};
	
	Walking = { --This table holds the Walking animations
		
		unAimed = function(X) --This is the animation when the gun is not aimed
			return {
				Pos = Vector3.new(
					4 * math.sin(X * 4.5) / 50,
					1.5 * math.sin(X * 9) / 50,
					0
				);
				Rot = Vector3.new(
					0,
					0,
					math.rad(math.sin(X * 4.5)) * 2
				);
			}
		end;
		
		Aimed = function(X) --This is the animation when the gun is aimed
			return {
				Pos = Vector3.new(
					2 * math.sin(X * 3) / 150,
					0.75 * math.sin(X * 6) / 150,
					0
				);
				Rot = Vector3.new(
					0,
					0,
					math.rad(math.sin(X * 3)) / 3
				);
			}
		end;
		
	};
	
	Running = function(X) --This is the animation when the player is running
		return {
			Pos = Vector3.new(
				4 * math.sin(X * 4.5 * 1.5) / 30,
				1.5 * math.sin(X * 9 * 1.5) / 40 + 0.2,
				0
			);
			Rot = Vector3.new(
				0,
				-math.rad(math.sin(X * 4.5 * 1.5)) * 5 + math.rad(3),
				math.rad(math.sin(X * 4.5 * 1.5)) * 5
			);
		}
	end;
	
}

return Animations