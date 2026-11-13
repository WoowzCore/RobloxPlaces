local Obj = script.Parent
local Material = string.gsub(tostring(Obj.Material),"Enum.Material.","")
local Velocity = Vector3.zero
local Speed = 0

local HitSound = Obj:FindFirstChild(Obj.Name.."Sound")

local function GetAllChildrens(obj)
	local childrens = {}

	local tablet
	if type(obj) == "table" then
		tablet = obj
	else
		tablet = obj:GetChildren()
	end

	for _,c in ipairs(tablet) do
		for _,c2 in ipairs(c:GetChildren()) do
			for _,c3 in ipairs(c2:GetChildren()) do
				for _,c4 in ipairs(c3:GetChildren()) do
					for _,c5 in ipairs(c4:GetChildren()) do
						for _,c6 in ipairs(c5:GetChildren()) do
							for _,c7 in ipairs(c6:GetChildren()) do
								for _,c8 in ipairs(c7:GetChildren()) do
									for _,c9 in ipairs(c8:GetChildren()) do
										table.insert(childrens,c9)
									end
									table.insert(childrens,c8)
								end
								table.insert(childrens,c7)
							end
							table.insert(childrens,c6)
						end
						table.insert(childrens,c5)
					end
					table.insert(childrens,c4)
				end
				table.insert(childrens,c3)
			end
			table.insert(childrens,c2)
		end
		table.insert(childrens,c)
	end
	return childrens
end

local function GetObjectRay(obj)
	if obj then
		if obj.Name == "Base" or obj.Name == "Block" or obj.Name == "BlockColor" then
			print(obj.Name)
		if obj:IsA("Model") then
			local objmodel = obj.PrimaryPart
			if objmodel.Name == "Base" then
				return objmodel	
			else
				local child = obj:GetChild()
				for _,c in pairs(child) do
					if c.Name == "Base" then
						return c
					end
				end
			end
		else
			if obj.Name == "Base" then
				return obj
			else
				local obj2 = obj.Parent 
				if obj2.Name == "Base" then
					return obj2
				else
					local obj3 = obj2.Parent 
					if obj3.Name == "Base" then
						return obj3
					else
							local obj4 = obj3.Parent 
							if obj4.Name == "Base" then
								return obj4
							else
								local obj5 = obj4.Parent 
								if obj5.Name == "Base" then
									return obj5
								else
									local obj6 = obj5.Parent 
									if obj6.Name == "Base" then
										return obj6
									else
										
										local obj7 = obj6.Parent 
										if obj7.Name == "Base" then
											return obj7
										else

											local obj8 = obj7.Parent 
											if obj8.Name == "Base" then
												return obj8
											else

												return nil
											end
										end
									end
								end
							end
					end
				end
			end
		end

	end end


end

local Base = GetObjectRay(Obj)

local Motor6d = nil

local BrakeSpeed = 60

local function FindJoint(obj)
	for _,j in ipairs(GetAllChildrens(Base)) do
		if j:IsA("Motor6D") then
			if j.Part1 == obj then	
				return j
			end
		else if j:IsA("HingeConstraint") then
				if j.Attachment0.Parent == obj then	
					return j
				end
			end
		end

	end
end
Motor6d = FindJoint(Obj)

local function DestroyJoints(obj,rand)
	if obj then
		if obj.Name == "Base" then

			for _,j in ipairs(obj:GetChildren()) do
				if j:IsA("Motor6D") then
					local random = math.random(0,100)
					if random < rand then
						j:Destroy()
					end
				else
					for _,j2 in ipairs(j:GetChildren()) do
						if j2:IsA("Motor6D") then
							local random = math.random(0,100)
							if random < rand then
								j2:Destroy()
							end
						else
							for _,j3 in ipairs(j2:GetChildren()) do
								if j3:IsA("Motor6D") then
									local random = math.random(0,100)
									if random < rand then
										j3:Destroy()
									end
								else
									for _,j4 in ipairs(j3:GetChildren()) do
										if j4:IsA("Motor6D") then
											local random = math.random(0,100)
											if random < rand then
												j4:Destroy()
											end
										end
									end
								end
							end
						end
					end
				end
			end


		end
	end
end

local function BrakeJoint(joint)
	if joint then
		if joint.Name ~= "Unbrk" then
		local parent
		if joint:IsA("Motor6D") then
			parent = joint.Part0

			if parent then
				local ParentJoint = FindJoint(parent)
				if ParentJoint then
					BrakeJoint(ParentJoint)
				end
			end
		end

			if joint:IsA("HingeConstraint") then
				local att = joint.Attachment0
				local att2 = joint.Attachment1
				if att then
					att:Destroy()
				end
				if att2 then
					att2:Destroy()
				end
		end

		joint:Destroy()
	end end
end

local HitSounds = {
	["Wood"] = { sounds = {[0] = "6153835670",[1] = "6215002046"}, soundsCount = 1 }
}

local function PlayHitSound(volume)
	HitSound.Volume = volume
	local sounds = HitSounds.Wood.sounds[math.random(0,HitSounds.Wood.soundsCount)]
	HitSound.SoundId = "rbxassetid://".. sounds 

	HitSound.Playing = true
end

local function BrakePart()
	if Material == "Glass" then
		Obj:Destroy()
	end
	
	BrakeJoint(Motor6d)
	
end

local function OnPartTouched(OtherObj)
	local BaseOther = GetObjectRay(OtherObj)
	if BaseOther == Base then

	else

		PlayHitSound(Speed/20)

		if OtherObj:IsA("Part") or OtherObj:IsA("MeshPart") then
			if OtherObj.Velocity.Magnitude > (BrakeSpeed/(OtherObj.Mass/10)) then
				if Obj.Name == "Base" then
					DestroyJoints(Obj,(BrakeSpeed/(OtherObj.Mass/10))-OtherObj.Velocity.Magnitude)
				else
					BrakePart()
				end
			end	
		end
		if Speed > BrakeSpeed then
			if Obj.Name == "Base" then
				print(math.abs(BrakeSpeed-Speed)/20)
				DestroyJoints(Obj,math.abs(BrakeSpeed-Speed)/20)
			else
				BrakePart()
			end
		end end
end
Obj.Touched:Connect(OnPartTouched)

while true do
	wait(0.1)
	Velocity = Obj.Velocity
	Speed = Velocity.Magnitude
end