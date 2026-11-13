local character = script.Parent

local DamagePower = {
	Sharp = 2;
}

local function DetectThisIsObjectOrNot(part)
	local result = false
	
	local Title = part:FindFirstChild("Title")
	if Title then
		result = true
	end
	
	return result
end

local function GetObject(part)
	local result = nil
	
	if DetectThisIsObjectOrNot(part) then
		result = part
	else
		local parent = part.Parent
		if DetectThisIsObjectOrNot(parent) then
			result = parent
		else
			local parent2 = part.Parent
			if DetectThisIsObjectOrNot(parent2) then
				result = parent2
			else
				local parent3 = part.Parent
				if DetectThisIsObjectOrNot(parent3) then
					result = parent3
				--else

				end
			end
		end
	end
	
	
	
	return result
end

local function Damage(part,weapon,damage)
	print("DAMAGE ".. damage)
	if damage > 0 then
		local partcolor = part.Color
		local PartColorR = partcolor.R + 0.1
		if PartColorR < 1 then
			part.Color = Color3.new(PartColorR,partcolor.G,partcolor.B)
		else
			part.Color = Color3.new(1,partcolor.G,partcolor.B)
		end
	end

end

local function IfDetect(body_part,part)
	local humanoid = part.Parent:FindFirstChild("Humanoid")
	if not humanoid then
		local sharp = part:FindFirstChild("This_Sharp")
		if sharp then
			local DamageSharpMultiply = 1
			if sharp.Value == true then
				DamageSharpMultiply = DamagePower.Sharp
			end
			
			local object = GetObject(part)
			local arm = object.Arm.Value
			
				if arm ~= body_part then
				local oldpos = part.Position
				wait(0.1)
				local damage = ((part.Position-oldpos).Magnitude) * DamageSharpMultiply
				Damage(body_part,part,damage)
			end
		end
	end
end

while wait() do
	for _,part in pairs(character:GetChildren()) do
		if part:IsA("Part") then
			local connection = part.Touched:Connect(function() end)
			local results = part:GetTouchingParts()
			connection:Disconnect()
			for _,res in ipairs(results) do
				IfDetect(part,res)
			end
		end
	end
end