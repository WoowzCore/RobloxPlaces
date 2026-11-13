local rs = game:GetService("ReplicatedStorage")

local gore = {}

function gore.GetGorePart(part)
	local result = nil
	for _, p in pairs(part:GetDescendants()) do
		if p.Name == "MEAT" and p:IsA("BasePart") then
			if p.Parent.Transparency == 0 then
				result = p.Parent
			end
		end
	end
	return result
end

function gore.ChangeTransparency(part)
	local chr = part
	local s,e = pcall(function()
		while chr.Name ~= "Head" and chr.Name ~= "Torso" and chr.Name ~= "Right Arm" and chr.Name ~= "Right Leg" and chr.Name ~= "Left Arm" and chr.Name ~= "Left Leg" do
			chr = chr.Parent
		end
		chr.Transparency = 1
		return true
	end)
	if s == false then
		return
	end
	
	for _, p in pairs(chr:GetDescendants()) do
		if p:IsA("BasePart") or p:IsA("Decal") then
			p.Transparency = 1
		end
	end
	
	for _, p in pairs(part:GetDescendants()) do
		if p:IsA("BasePart") or p:IsA("Decal") then
			if p.Name == "BLOOD" then
				p.Transparency = math.random(1,4)/10
			elseif p.Name == "DECAL" then
				p.Transparency = 0.02
			else
				p.Transparency = 0
			end
		end
	end
	part.Transparency = 0
end

function gore.CreateGibs(part,kolvo,power,stop)
	if part:FindFirstChild("GibsEnd") then
		return
	else
		if stop then
			local gibsend = Instance.new("BoolValue",part)
			gibsend.Name = "GibsEnd"
			gibsend.Value = true
		end
	end
	local i = 0
	while i < kolvo do
		i += 1
		rs.Gore.Gibs:Fire(part.Position,Vector3.new(math.random(-power,power),math.random(-power,power),math.random(-power,power)),part)
	end
end

local accessorysbase = {
	[Enum.AccessoryType.Face] = {},
	[Enum.AccessoryType.Neck] = {},
	[Enum.AccessoryType.Back] = {},
	[Enum.AccessoryType.Front] = {},
	[Enum.AccessoryType.Hat] = {},
	[Enum.AccessoryType.Hair] = {},
	[Enum.AccessoryType.Pants] = {},
	[Enum.AccessoryType.Shirt] = {},
	[Enum.AccessoryType.Waist] = {},
	[Enum.AccessoryType.Jacket] = {},
	[Enum.AccessoryType.Shorts] = {},
	[Enum.AccessoryType.TShirt] = {},
	[Enum.AccessoryType.Eyebrow] = {},
	[Enum.AccessoryType.Eyelash] = {},
	[Enum.AccessoryType.Sweater] = {},
	[Enum.AccessoryType.Unknown] = {},
	[Enum.AccessoryType.LeftShoe] = {},
	[Enum.AccessoryType.Shoulder] = {},
	[Enum.AccessoryType.RightShoe] = {},
	[Enum.AccessoryType.DressSkirt] = {}
}
function gore.GetAccessorys(chr)
	local accessorys = accessorysbase
	for _, p in pairs(chr:GetChildren()) do
		if p:IsA("Accessory") then
			table.insert(accessorys[p.AccessoryType],p.Handle)
		end
	end
	return accessorys
end

function gore.CoverBlood(part,chance)
	local bloodthis = {}
	for _, p in pairs(part:GetDescendants()) do
		if p.Name == "DECAL" then
			table.insert(bloodthis,p.Parent)
		end
	end
	table.insert(bloodthis,part)
	
	local function createdecal(p,n)
		local decal = script.BLOOD:Clone()
		decal.Parent = p
		decal.Face = n
		if p.Transparency == 0 then
			decal.Transparency = math.random(1,3)/10
		else
			decal.Transparency = 1
		end
	end
	local normals = {Enum.NormalId.Bottom,Enum.NormalId.Top,Enum.NormalId.Back,Enum.NormalId.Left,Enum.NormalId.Front,Enum.NormalId.Right}
	for _, p in pairs(bloodthis) do
		local i = 1
		while i < 7 do
			local make = true
			for _, d in pairs(p:GetChildren()) do
				if d.Name == "BLOOD" then
					if d.Face == normals[i] then
						make = false
					end
				end
			end
			if make and math.random(0,100) <= chance then
				createdecal(p,normals[i])
			end
			i+=1
		end
	end
end

function gore.ExplodePart(part,power)
	if part.Name == "Head" or part.Name == "Torso" or part.Name == "Left Arm" or part.Name == "Left Leg" or part.Name == "Right Arm" or part.Name == "Right Leg" then
		local accessorys = gore.GetAccessorys(part.Parent)
		local gorepart = gore.GetGorePart(part)
		if gorepart ~= nil then gorepart = gorepart.Name end
	
		if gorepart == nil and power >= math.random(20,40) then
			gorepart = "SMALL"
		end
	
		if power >= math.random(70,100) then
			gorepart = "TOP"
		else
			if gorepart == nil then
				if math.random(0,100) >= 50 then
					gorepart = "LEFTTOP"
				else
					gorepart = "RIGHTTOP"
				end
			else
				gorepart = "TOP"
			end
		end
		
		gore.ChangeTransparency(part:FindFirstChild(gorepart))
		rs.PlaceParticle:Fire(part.Position,"BloodSplash",math.random(3,5)/10)
		if gorepart == "TOP" then
			if part.Name == "Head" then
				gore.CoverBlood(part,100)
				gore.CoverBlood(part.Parent.Torso,25)
				gore.CoverBlood(part.Parent["Right Arm"],10)
				gore.CoverBlood(part.Parent["Left Arm"],10)
			elseif part.Name == "Torso" then
				gore.CoverBlood(part,100)
				gore.CoverBlood(part.Parent["Head"],25)
				gore.CoverBlood(part.Parent["Right Arm"],10)
				gore.CoverBlood(part.Parent["Left Arm"],10)
				gore.CoverBlood(part.Parent["Right Leg"],10)
				gore.CoverBlood(part.Parent["Left Leg"],10)
			elseif part.Name == "Left Arm" then
				gore.CoverBlood(part,100)
				gore.CoverBlood(part.Parent.Torso,25)
			elseif part.Name == "Right Arm" then
				gore.CoverBlood(part,100)
				gore.CoverBlood(part.Parent.Torso,25)
			elseif part.Name == "Left Leg" then
				gore.CoverBlood(part,100)
				gore.CoverBlood(part.Parent.Torso,25)
			elseif part.Name == "Right Leg" then
				gore.CoverBlood(part,100)
				gore.CoverBlood(part.Parent.Torso,25)
			end
			gore.CreateGibs(part,math.random(1,5),power,true)
		else
			gore.CoverBlood(part,25)
			gore.CreateGibs(part,math.random(1,3),power)
		end
		
		for typ,tab in pairs(accessorys) do
			if part.Name == "Head" then
				if typ == Enum.AccessoryType.Hat or typ == Enum.AccessoryType.Face then
					for _, p in pairs(tab) do
						gore.CoverBlood(p,75)
						if gorepart == "TOP" then
							rs.Gore.AccessoryPhysicate:Fire(p.Parent,p.CFrame,math.random(0,100)>=95)
						else
							if math.random(0,100) >= 50 then
								rs.Gore.AccessoryPhysicate:Fire(p.Parent,p.CFrame,math.random(0,100)>=75)
							end
						end
					end
				elseif typ == Enum.AccessoryType.Hair then
					for _, p in pairs(tab) do
						gore.CoverBlood(p,100)
						rs.Gore.AccessoryPhysicate:Fire(p.Parent,p.CFrame,(gorepart == "TOP"))
					end
				end
			end
		end
	end
end

function gore.UpdateCorpse(corps,chr,cframe_table)
	for _, acces in pairs(chr:GetChildren()) do
		if acces:IsA("Accessory") then
			for _, acces2 in pairs(corps:GetChildren()) do
				if acces2:IsA("Accessory") then
					if acces.Name == acces2.Name then
						if acces.Handle:FindFirstChild("Destroyed") then
							rs.Gore.AccessoryPhysicate:Fire(acces2,acces2.Handle.CFrame,true)
						elseif acces.Handle:FindFirstChild("Physic") then
							rs.Gore.AccessoryPhysicate:Fire(acces2,cframe_table[acces2.Name],false)
						end
					end
				end
			end
		end
	end
end

return gore
