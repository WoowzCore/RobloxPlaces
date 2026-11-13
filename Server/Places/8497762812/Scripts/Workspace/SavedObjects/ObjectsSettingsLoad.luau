--Script Creator {Woowz11 (In ROBLOX "Woowz14")}
local folder = script.Parent
local Objects = folder:GetChildren()

local function CreateValueOrSetValue(obj, typ, name, value)
	if not obj:FindFirstChild(name) then
	local typevalue = typ.."Value"
	local valueobj = Instance.new(typevalue,obj)
	valueobj.Value = value 
	valueobj.Name = name
	valueobj.Parent = obj
	end
	
end

local function CreateSettings(obj)
	CreateValueOrSetValue(obj,"String","PlayerCreator","")--Никнейм игрока которы создал этот объект
	CreateValueOrSetValue(obj,"Bool","PlayerCanDragThis",true)--Игрок может перемещать этот объект?
end

for i = 1, #Objects do
	CreateSettings(Objects[i])
end