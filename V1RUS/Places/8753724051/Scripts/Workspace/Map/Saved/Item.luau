local Item = script.Parent

local function CreateObjectValue(name,maybe_type,part)
	local value_type = tostring(typeof(maybe_type))
	print(value_type)
	local Create_This_Value = "BoolValue"
	if value_type == "string" then
		Create_This_Value = "StringValue"
	end
	if value_type == "number" then
		Create_This_Value = "NumberValue"
	end
	if value_type == "Vector3" then
		Create_This_Value = "Vector3Value"
	end
	if value_type == "Color3" then
		Create_This_Value = "Color3Value"
	end
	if value_type == "Instance" then
		Create_This_Value = "ObjectValue"
	end
	if value_type == "CFrame" then
		Create_This_Value = "CFrameValue"
	end
	if value_type == "BrickColor" then
		Create_This_Value = "BrickColorValue"
	end
	if value_type == "Ray" then
		Create_This_Value = "RayValue"
	end
	local instance = Item
	if part ~= nil then
		instance = part
	end
	local value_obj = Instance.new(Create_This_Value,instance)
	value_obj.Value = maybe_type
	value_obj.Name = name
end

local function GetObjectValue(name,if_else,part)
	local there = Item
	if part then
		there = part
	end
	
		local obj_value = there:FindFirstChild(name)
	if obj_value then
		return obj_value.Value
	else
			CreateObjectValue(name,if_else,there)
		return if_else
		end
end

local ItemType = GetObjectValue("Type","Trash")--[[Тип Предмета (Trash - Простой мусор, возможно используется только для крафта),(Melee - Оружие ближнего боя),(Flask - Тара которая используется для жидкости),(Gun - Огнестрельное ружие)]]
local ItemName = GetObjectValue("Title","Not Have Title")--[[Название объекта]]

local Pickable = GetObjectValue("Pickable",false)

local AllObjects = {}

local AllParts = {}

local AllSpecialParts = {
	Debug = {};
	Sharpness = {};--[[Острые объекты]]
}

local function IfThisPart(obj)
	local result = false
	if obj:IsA("Part") then
		if GetObjectValue("DEBUG",false,obj) == false then
			result = true
			
		else
			table.insert(AllSpecialParts.Debug,obj)
		end
		end

	return result
end

local function GetPartFromGetAllParts(part)
	if part then
		table.insert(AllObjects,part)
		if IfThisPart(part) then
			local Transparency = GetObjectValue("Transparency",part.Transparency,part)
			local HaveCollision = GetObjectValue("HaveCollision",part.CanCollide,part)
			
			table.insert(AllParts,part)
			if GetObjectValue("This_Sharp",false,part) == true then
				table.insert(AllSpecialParts.Sharpness,part)
			end
		end
	end
end

local function GetAllParts()
	for i,part in pairs(Item:GetChildren()) do
		GetPartFromGetAllParts(part)
		for i,part2 in pairs(part:GetChildren()) do
			GetPartFromGetAllParts(part2)
			for i,part3 in pairs(part2:GetChildren()) do
				GetPartFromGetAllParts(part3)
				for i,part4 in pairs(part3:GetChildren()) do
					GetPartFromGetAllParts(part4)
					for i,part5 in pairs(part4:GetChildren()) do
						GetPartFromGetAllParts(part5)
						for i,part6 in pairs(part5:GetChildren()) do
							GetPartFromGetAllParts(part6)
							for i,part7 in pairs(part6:GetChildren()) do
								GetPartFromGetAllParts(part7)
								for i,part8 in pairs(part7:GetChildren()) do
									GetPartFromGetAllParts(part8)
									for i,part9 in pairs(part8:GetChildren()) do
										GetPartFromGetAllParts(part9)
										for i,part10 in pairs(part9:GetChildren()) do
											GetPartFromGetAllParts(part10)
											for i,part11 in pairs(part10:GetChildren()) do
												GetPartFromGetAllParts(part11)
												for i,part12 in pairs(part11:GetChildren()) do
													GetPartFromGetAllParts(part12)

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
end
GetAllParts()