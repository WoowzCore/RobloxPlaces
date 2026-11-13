---------------------------------------------------------------------------------------------------------
--[[
	
	AUTHOR: TurboFusion
	DATE CREATED: 4/8/16
	
	DESCRIPTION: This is a module that creates gui particles which simulates physical parts
	
	function Particle.new(Prop)
	
	ARGUMENT: Table {
		Table rayIgnore;	--This table contains objects that the visiblity checking ray should ignore (DEFAULT: {})
		Color3 Color;		--This color3 value is what color the particle will be (DEFAULT: Color3.new(1, 1, 1))
		float Length;		--This float value is how long the particle will be in world space (DEFAULT: 1)
		float Width;		--This float value is how wide the particle will be in world space (DEFAULT: 1)
		Vector3 p0;			--This Vector3 value is the initial position of the particle (Must exist)
		Vector3 v0;			--This Vector3 value is the initial velocity of the particle (Must exist)
		Vector3 a0;			--This Vector3 value is the initial acceleration of the particle (Must exist)
	}
	
	RETURNS: Metatable
	
	EDITABLE PROPERTIES:
		Particle.t = float Time --Sets a time value in seconds which is used to figure out where to render the particle (t=0 will be initial conditions)
		
	READ-ONLY PROPERTIES:
		Particle.p or Particle.position --Returns a world position of the particle
		Particle.v or Particle.velocity --Returns a world velocity of the particle
		Particle.obj or Particle.object --Returns the particle frame itself
		
	METHODS:
		Particle:delete() --This method deletes the particle and stops rendering calculations (use this instead of directly destroying the frame itself)
		
	EXAMPLE CODE:
		local t = 0
		local Particle = Particle.new(
			{
				Color = Color3.new(1, 1, 0);
				Width = 1;
				p0 = Vector3.new();
				v0 = Vector3.new(0, 100, 100);
				a0 = Vector3.new(0, -196.2, 0);
			}
		)
		Particle.obj.Parent = screenGui
		while true do
			Particle.t = t
			t = t + 1/30
			wait()
		end

--]]
---------------------------------------------------------------------------------------------------------

local Particle = {}

function Particle.new(Prop)
	----------[ CONSTANTS ]--------------------
	
	local Cam = workspace.CurrentCamera
	local rayIgnore = Prop.rayIgnore or {} --If the property doesn't exist, then set it to it's default
	local Color = Prop.Color or Color3.new(1, 1, 1)
	local Length = Prop.Length or 1
	local Width = Prop.Width or 1
	local p0 = Prop.p0 or error("Particle.new requires a p0 (origin position) property!", 0) --Give an error message if you don't this
	local v0 = Prop.v0 or error("Particle.new requires a v0 (initial velocity) property!", 0)
	local a0 = Prop.a0 or error("Particle.new requires an a0 (initial acceleration) property!", 0)
	
	----------[ VARIABLES ]--------------------
	
	local Deleted = false
	local p = p0 --Set the position, velocity, and acceleration as the intial conditions
	local v = v0
	local a = a0
	local t = 0
	
	----------[ FUNCTIONS ]--------------------
	
	local function worldWidthToScreenWidth(Width, Depth) --A function I made that gives you a screen width given a world width and depth
		local Center = Cam.CoordinateFrame * CFrame.new(0, 0, -Depth)
		local wp1 = (Center * CFrame.new(0, Width / 2, 0)).p
		local wp2 = (Center * CFrame.new(0, -Width / 2, 0)).p
		local sp1 = Cam:WorldToScreenPoint(wp1) --Use the WorldToScreenPoint method of the camera to get the screen width from the world width
		local sp2 = Cam:WorldToScreenPoint(wp2)
		return (sp1 - sp2).magnitude
	end
	
	----------[ MAIN PROGRAM ]-----------------
	
	local Container = Instance.new("Frame")
	Container.BackgroundTransparency = 1
	Container.Position = UDim2.new()
	Container.Size = UDim2.new()
	local Line = Instance.new("Frame")
	Line.BackgroundColor3 = Color
	Line.BorderSizePixel = 0
	Line.Position = UDim2.new()
	Line.Size = UDim2.new()
	Line.Parent = Container
	
	return setmetatable(
		{
			delete = function() --This function safely removes the particle
				Container:Destroy()
				Deleted = true
			end
		},
		{
			__index = function(_, Index)
				if Index == "p" or Index == "position" then --Return the world position of the particle
					return (Deleted and nil or p)
				elseif Index == "v" or Index == "velocity" then --Return the world velocity of the particle
					return (Deleted and nil or v)
				elseif Index == "obj" or Index == "object" then --Return the particle frame itself
					return (Deleted and nil or Container)
				else
					error(Index.." is not a member of Particle!", 0) --Give an error message if any other index is called
				end
			end;
			
			__newindex = function(_, Index, Value)
				if Index == "t" or Index == "time" and (not Deleted) then --Render the particle given a time value
					t = Value
					p = p0 + (v0 * t) + (0.5 * a0 * t * t) --update the position given the time
					v = v0 + (a0 * t) --update the velocity given the time
					
					local testRay1 = Ray.new(Cam.CoordinateFrame.p, (p + (v.unit * Length) / 2) - Cam.CoordinateFrame.p)
					local testRay2 = Ray.new(Cam.CoordinateFrame.p, (p - (v.unit * Length) / 2) - Cam.CoordinateFrame.p)
					local H1, _ = workspace:FindPartOnRayWithIgnoreList(testRay1, rayIgnore)
					local H2, _ = workspace:FindPartOnRayWithIgnoreList(testRay2, rayIgnore)
					
					if H1 and H2 then
						Line.Visible = false
					else
						local face1 = Cam:WorldToScreenPoint(p + (v.unit * Length) / 2) --Get the 2 endpoints of the particle in screen space
						local face2 = Cam:WorldToScreenPoint(p - (v.unit * Length) / 2)
						local Center, isVisible = Cam:WorldToScreenPoint(p) --Get the center of the particle in screen space
						
						local screenLength = (face1 - face2).magnitude
						local screenWidth = worldWidthToScreenWidth(Width, Center.Z)
						local Ang = math.atan2(face1.Y - face2.Y, face1.X - face2.X) --Get the angle the particle needs to be at in order to line up
						
						Line.Position = UDim2.new(0, 0, 0, -screenWidth / 2)
						Line.Size = UDim2.new(1, 0, 0, screenWidth)
						Line.Visible = isVisible --Make the particle invisible if the world point isn't on screen
						
						Container.Position = UDim2.new(
							0,
							face2.X + (math.cos(Ang) - 1) * screenLength / 2, --Yay trig!
							0,
							face2.Y + math.sin(Ang) * screenLength / 2
						)
						Container.Size = UDim2.new(0, screenLength, 0, 0)
						Container.Rotation = math.deg(Ang)
					end
				else
					error(Index.." is not a member of Particle!", 0) --Give an error message if any other index is being changed
				end
			end
		}
	)
end

return Particle