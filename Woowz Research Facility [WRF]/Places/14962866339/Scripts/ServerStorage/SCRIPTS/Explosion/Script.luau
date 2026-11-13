local range = script.Parent.ExplosionRange
local Particles = script.Parent.Particles
local power = script.Parent.Power.Value
local base = require(game:GetService("ServerScriptService").Base)
local rs = game:GetService("ReplicatedStorage")
local ss = game:GetService("ServerStorage")

range.Touched:Connect(function() end)
script.Parent.ExplosionRangeBig.Touched:Connect(function() end)

for _, obj in pairs(script.Parent.ExplosionRangeBig:GetTouchingParts()) do
	if obj.Name == "CEILING_TILE" and math.random(0,100)>=90 then
		local s = ss.SCRIPTS.DropTile:Clone()
		s.Parent = obj
		s.Enabled = true
	end
	
	base.TryPhysicateObject(obj,power*3)
	if obj~=nil then
		if obj.Parent~=nil then
			if obj.Parent:FindFirstChild("Doors") and math.random(0,100)>=90 then
				local doors = obj.Parent
				doors:FindFirstChild("Doors"):Destroy()
				for _, h in pairs(doors:GetDescendants()) do
					if h:FindFirstChildOfClass("HingeConstraint") and h.Anchored then
						h.Anchored = false
					end
					if h:IsA("HingeConstraint") or h:IsA("ClickDetector") or h.Name == "MouseOver" then
						h:Destroy()
					end
					if h:IsA("BasePart") then
						if h.CanCollide and h.Anchored == false then
							local drag = ss.SCRIPTS.DragDetector:Clone()
							drag.Parent = h
							drag.MaxForce = 1000
							drag.MaxTorque = 500
							drag.Responsiveness = 500
						end
					end
				end
			end

			if obj.Parent:FindFirstChildOfClass("Humanoid") then
				local chr = obj.Parent
				local plr = nil
				local suc,err = pcall(function()
					plr = game:GetService("Players"):GetPlayerFromCharacter(chr)
					rs.Player.Tinnitus:FireClient(plr,power/2)
				end)
			end
		end
	end 
end

local function ApplyImpulse(rang)
	for _, obj in pairs(rang:GetTouchingParts()) do
		if obj:IsA("BasePart") then
			if obj.Anchored == false then
				local multiply = 1
				if rang.Name == "ExplosionRangeBig" then
					multiply = 0.25
				end
				obj.AssemblyLinearVelocity = obj.CFrame:VectorToWorldSpace(obj.Position - rang.Position) * Vector3.new(power*2*multiply,power*2*multiply,power*2*multiply) * (1-((obj.Position - rang.Position).Magnitude/rang.Size.X))
			end
		end
	end
end

for _, obj in pairs(range:GetTouchingParts()) do
	if obj:IsA("BasePart") then
		if math.random(0,100)>=90 then
			if obj.Material == Enum.Material.Metal or obj.Material == Enum.Material.DiamondPlate or obj.Material == Enum.Material.CorrodedMetal and obj.MaterialVariant ~= "Metal Burned" then
				obj.Material = Enum.Material.Metal
				obj.MaterialVariant = "Metal Burned"
				local color = obj.Color
				obj.Color = Color3.new(math.clamp(color.r-0.2,0,1),math.clamp(color.g-0.2,0,1),math.clamp(color.b-0.2,0,1))
			end
		end
	end
	
	if obj.Parent ~= nil then
		if obj.Parent:FindFirstChildOfClass("Humanoid") then
			local chr = obj.Parent
			local plr = nil
			local suc,err = pcall(function()
				plr = game:GetService("Players"):GetPlayerFromCharacter(chr)
			end)
			if plr or chr.Name == "Dummy" or chr.Parent.Name == "Corpses" then
				base.HitBodyPart(obj,"inside",power*10)
			end
		end

		if obj.Parent:FindFirstChild("Exploded") then
			obj.Parent:FindFirstChild("Exploded"):Fire()
		end
	end
end

local c = math.random(230,255)
local col = Color3.fromRGB(255,c,c)
wait(0.1)
ApplyImpulse(range)

local sounds = {"3802269741","5400203733","2275292812","8741569477","2275292355"}
local debris = {"843732197","9118595442","9120479801","9119189657","5156967331","1741599172","9120479831"}

Particles.Sound.SoundId = "rbxassetid://"..sounds[math.random(1,#sounds)]
Particles.Sound:Play()

Particles.Sound2.SoundId = "rbxassetid://"..debris[math.random(1,#debris)]
Particles.Sound2:Play()

local p = 1+(power/100)
base.ts(Particles.PointLight,TweenInfo.new(0.4*p),{Brightness = 6*(power/10)})
wait(0.4*p)
ApplyImpulse(script.Parent.ExplosionRangeBig)
base.ts(Particles.PointLight,TweenInfo.new(1.2*p),{Brightness = 0})
wait(0.4*(1+(power/30)))
range:Destroy()
script.Parent.ExplosionRangeBig:Destroy()

wait(15)
Particles.Smoke.Enabled = false
wait(20)
script.Parent:Destroy()