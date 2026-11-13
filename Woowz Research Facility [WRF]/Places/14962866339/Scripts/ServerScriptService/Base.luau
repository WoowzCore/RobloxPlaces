local ts = game:GetService("TweenService")
local serverinfo = script.Parent.ServerInfo
local ss = game:GetService("ServerStorage")
local scripts = ss.SCRIPTS
local rs = game:GetService("ReplicatedStorage")
local bs = game:GetService("BadgeService")
local plrservice = game:GetService("Players")
local gores = ss.GORE
local gorebase = require(script.Parent.Gore)
local data = require(game:GetService("ServerStorage").PLAYERSDATA)
local datas = require(game:GetService("ServerStorage").Datas)

local base = {}

base.Names = {"Авдей","Авксентий","Агапит","Агафон","Акакий","Акиндин","Александр","Алексей","Альберт","Анатолий","Андрей","Аникий","Аникита","Антон","Антонин","Анфим","Аристарх","Аркадий","Арсений","Артём","Артемий","Артур","Архипп","Афанасий","Богдан","Борис","Вавила","Вадим","Валентин","Валерий","Валерьян","Варлам","Василий","Виктор","Виталий","Владимир","Владислав","Влас","Всеволод","Вячеслав","Гавриил","Геннадий","Георгий","Герасим","Герман","Глеб","Григорий","Давид","Даниил","Денис","Дмитрий","Донат","Евгений","Евграф","Евдоким","Егор","Ефрем","Ждан","Зиновий","Иван","Игорь","Изот","Илья","Иннокентий","Ираклий","Исаак","Исидор","Иуда","Ким","Кир","Кирилл","Константин","Кузьма","Лаврентий","Лев","Леонид","Лука","Лукьян","Макар","Максим","Мамонт","Марк","Матвей","Мирослав","Михаил","Мстислав","Назар","Наум","Нестор","Никита","Олег","Онисим","Павел","Панкратий","Парфений","Пётр","Платон","Потап","Пров","Прохор","Разумник","Родион","Роман","Руслан","Савва","Святослав","Сила","Степан","Семён","Тарас","Тимур","Тит","Тихон","Урбан","Фаддей","Фёдор","Феликс","Филипп","Фома","Харитон","Христофор"}
base.Surnames = {"Иванов","Смирнов","Кузнецов","Попов","Васильев","Петров","Соколов","Михайлов","Новиков","Фёдоров","Морозов","Волков","Алексеев","Лебедев","Семёнов","Егоров","Павлов","Козлов","Степанов","Николаев","Орлов","Андреев","Макаров","Никитин","Захаров","Попов","Лебедев","Зайцев","Голубев","Богданов","Беляев","Тарасов","Комаров","Ершов","Лазарев","Соболев","Рябов","Жуков","Максимов","Белорусов","Бобров","Дмитриев","Калинин","Гаврилов","Карпов","Маслов","Сафонов","Капустин","Кириллов","Моисеев","Шаров","Устинов","Прохоров","Жуков","Сидоров","Матвеев","Анисимов","Муравьёв","Мухин","Рыбаков","Котов","Вувзов","Щукин","Шаров","Дьячков","Князев","Зимин","Орехов","Елисеев","Емельянов","Шашков","Куликов","Григорьев","Беляков","Филиппов","Фомин","Громов","Колесников","Логинов","Туров","Селезнёв","Жданов","Тетерин","Стрелков","Сысоев","Рожков","Шашков","Лихачёв"}
base.Professions = {"инженер","врач","логист","филосов","физик","астроном","астронавт","архитектор","художник","композитор","кондитер","писатель","дизайнер","депутат","генерал","электрик","токарь","блогер","эколог","геолог","повар","материаловед","учитель","професор","археолог","аквалангист","артист","бизнесмен","путешественник","учёный","космонавт","пилот"}

function base.ClickDetector(plr,cd)
	local d = data.Data[tostring(plr.UserId)]
	local chr = plr.Character or plr.CharacterAdded:Wait()

	if not d.AttackMode and not d.Paralysis then
		cd.ClickDetectorScript.Event:Fire(plr)

		local seat = nil
		if cd:FindFirstChild("Seat") then
			seat = cd:FindFirstChild("Seat").Value
		end

		if seat then
			local x,y,z = seat.CFrame:ToOrientation()
			if not (x>0.4 or x<-0.4 or z>0.4 or z<-0.4) then
				base.Sit(seat,plr)
			end
		end
	end
end

base.RainbowGradient = ColorSequence.new({
	ColorSequenceKeypoint.new(0,Color3.fromRGB(255,0,0)),
	ColorSequenceKeypoint.new(0.2,Color3.fromRGB(255,255,0)),
	ColorSequenceKeypoint.new(0.4,Color3.fromRGB(0,255,0)),
	ColorSequenceKeypoint.new(0.6,Color3.fromRGB(0,255,255)),
	ColorSequenceKeypoint.new(0.8,Color3.fromRGB(0,0,255)),
	ColorSequenceKeypoint.new(1,Color3.fromRGB(255,0,255)),
})

base.LabLightingEnabled = true

function base.GetColorFromGradient(sequence: ColorSequence, t: number)
	if tostring(t) == "nan" then
		return sequence.Keypoints[1].Value
	end
	if t <= 0 then
		return sequence.Keypoints[1].Value
	elseif t >= 1 then
		return sequence.Keypoints[#sequence.Keypoints].Value
	end

	for i = 1, #sequence.Keypoints - 1 do
		local thisKeypoint = sequence.Keypoints[i]
		local nextKeypoint = sequence.Keypoints[i + 1]
		if t >= thisKeypoint.Time and t < nextKeypoint.Time then
			local alpha = (t - thisKeypoint.Time) / (nextKeypoint.Time - thisKeypoint.Time)
			return Color3.new(
				(nextKeypoint.Value.R - thisKeypoint.Value.R) * alpha + thisKeypoint.Value.R,
				(nextKeypoint.Value.G - thisKeypoint.Value.G) * alpha + thisKeypoint.Value.G,
				(nextKeypoint.Value.B - thisKeypoint.Value.B) * alpha + thisKeypoint.Value.B
			)
		end
	end
end

function base.RandomColor(i)
	return base.GetColorFromGradient(base.RainbowGradient,math.random())
end

function base.SendSirensToPlayers()
	local result = {}
	
	if serverinfo.Data.SirenWork.Value then
		for _, part in pairs(game.Workspace:GetDescendants()) do
			if part.Name == "Siren" then
				if part:FindFirstChild("Enabled").Value == true then
					table.insert(result,part.PrimaryPart.Position)
				end
			end
		end
	end
	
	local s_data = datas.Sirens[serverinfo.Data.SirenType.Value]
	rs.SetSirensToPlayers:FireAllClients(result,s_data,serverinfo.Data.SirenType.Value)
end

function base.DropBackpack(plr)
	local backpack = plr.Backpack
	local chr = plr.Character or plr.CharacterAdded:Wait()
	local humbase = chr:WaitForChild("HumanoidRootPart")
	for _, item in pairs(backpack:GetChildren()) do
		rs.DropItemSERVER:Fire(item,humbase.CFrame)
	end
	local item = chr:FindFirstChildOfClass("Tool")
	if item~=nil then
		rs.DropItemSERVER:Fire(item,item.Handle.CFrame)
	end
end

function base.TryPhysicateObject(obj,power)
	local result = false
	local n = obj.Name
	
	if obj.Parent ~= nil then
		if n == "Telephone" and obj.Parent.Name == "Telephone" then
			obj.Anchored = false
		end
	end
	
	local function DestroyObj(obj)
		if obj ~= nil then
			if obj:IsA("BasePart") then
				if obj.Material == Enum.Material.Glass then
					base.PlaceParticle(obj.Position,"GlassBroken",0.5,obj)
					local glassbrokesound = {"6737582037","260496290","2978605361","7174031580"}
					base.PlaySound(glassbrokesound[math.random(1,#glassbrokesound)],obj.Position,math.random(20,30)/10,10,math.random(90,110)/100)
				end
			end
			obj:Destroy()
		end
	end
	
	for _, part in pairs(obj:GetChildren()) do
		if math.random(0,100)<power*7 then
			local function CheckAndIt()
				for _2,part2 in pairs(obj:GetChildren()) do
					if part2.Name == "Broke_AndItDestroy" then
						DestroyObj(part2.Value)
					end
				end
			end
			
			if part.Name == "Broke_Physic" then
				CheckAndIt()
				obj.Anchored = false
				if obj.CanCollide == false then
					obj.CanCollide = true
				end
				local dragdetector = ss.SCRIPTS.DragDetector:Clone()
				dragdetector.Parent = obj
			end
		
			if part.Name == "Broke_Destroy"then
				CheckAndIt()
				DestroyObj(obj)
			end
		end
	end
end

function base.PlaceParticle(pos,particle : string, t : number?, size, color : ColorSequence?)
	if typeof(pos) == "Vector3" then
		pos = CFrame.new(pos)
	end
	if typeof(color) == "Color3" then color = ColorSequence.new(color) end
	if color == nil then color = ColorSequence.new(Color3.fromRGB(255,255,255)) end
	if t == nil then t = 1 end
	local particle_effect = ss.PARTICLES:FindFirstChild(particle):Clone()
	particle_effect.Name = "Particle ["..particle.."]"
	particle_effect.Parent = game.Workspace
	particle_effect.CFrame = pos
	particle_effect.CanCollide = false
	particle_effect.CanTouch = false
	particle_effect.CanQuery = false
	particle_effect.Anchored = true
	
	for _, p in pairs(particle_effect:GetDescendants()) do
		if p.Name == "color" then
			p.Color = color
		end
	end
	
	if size == nil then size = particle_effect.Size end
	if typeof(size) ~= "Vector3" then
		size = size.Size
	end
	particle_effect.Size = size
	particle_effect.Transparency = 1
	local particle_script = scripts.ParticleScript:Clone()
	particle_script.Parent = particle_effect
	particle_script:SetAttribute("time",t)
	particle_script.Enabled = true
end
rs.PlaceParticle.Event:Connect(base.PlaceParticle)

function base.PlaceImpactDecal(ray : RaycastResult)
	if ray == nil then return end
	local normal, pos, hit = ray.Normal, ray.Position, ray.Instance
	if normal == nil then return end
	if pos == nil then return end
	if hit == nil then return end
	if not hit:IsA("Part") then return end
	
	local material = hit.Material
	local ishumanoid = (hit.Parent:FindFirstChildOfClass("Humanoid") or hit.Parent.Parent:FindFirstChildOfClass("Humanoid"))
	
	local decals = {
		["concrete"] = {Vector2.new(10,15),{"15491883080"},{"ImpactConcrete",false}},
		["dirt"] = {Vector2.new(15,20),{"14965465786"},{"ImpactConcrete",false}},
		["metal"] = {Vector2.new(10,18),{"15491789610"},{"ImpactConcrete",false}},
		["plastic"] = {Vector2.new(15,20),{"15491872410"},{"ImpactConcrete",false}},
		["sand"] = {Vector2.new(15,20),{"14965465786"},{"ImpactConcrete",false}},
		["glass"] = {Vector2.new(15,20),{"14965465786"},{"ImpactConcrete",false}},
		["wood"] = {Vector2.new(15,20),{"14965465786"},{"ImpactConcrete",false}},
		["leather"] = {Vector2.new(15,20),{"14965465786"},{"ImpactConcrete",false}},
		["human"] = {Vector2.new(10,15),{"15495203118"},{"Blood",true}},
	}
	local materials = {
		[Enum.Material.Concrete] = "concrete",
		[Enum.Material.Neon] = "glass",
		[Enum.Material.Glass] = "glass",
		[Enum.Material.Mud] = "dirt",
		[Enum.Material.Plastic] = "plastic",
		[Enum.Material.Metal] = "metal",
		[Enum.Material.Water] = nil,
		[Enum.Material.CrackedLava] = "concrete",
		[Enum.Material.Air] = nil,
		[Enum.Material.Ice] = "glass",
		[Enum.Material.Foil] = "metal",
		[Enum.Material.Rock] = "concrete",
		[Enum.Material.Salt] = "sand",
		[Enum.Material.Sand] = "sand",
		[Enum.Material.Snow] = "sand",
		[Enum.Material.Wood] = "wood",
		[Enum.Material.Brick] = "concrete",
		[Enum.Material.Grass] = "dirt",
		[Enum.Material.Slate] = "concrete",
		[Enum.Material.Basalt] = "concrete",
		[Enum.Material.Carpet] = "sand",
		[Enum.Material.Ground] = "dirt",
		[Enum.Material.Marble] = "concrete",
		[Enum.Material.Pebble] = "concrete",
		[Enum.Material.Rubber] = "leather",
		[Enum.Material.Asphalt] = "concrete",
		[Enum.Material.Glacier] = "glass",
		[Enum.Material.Granite] = "concrete",
		[Enum.Material.Leather] = "leather",
		[Enum.Material.Plaster] = "concrete",
		[Enum.Material.Pavement] = "concrete",
		[Enum.Material.Cardboard] = "plastic",
		[Enum.Material.Limestone] = "concrete",
		[Enum.Material.Sandstone] = "concrete",
		[Enum.Material.ForceField] = nil,
		[Enum.Material.LeafyGrass] = "dirt",
		[Enum.Material.WoodPlanks] = "wood",
		[Enum.Material.Cobblestone] = "concrete",
		[Enum.Material.CeramicTiles] = "concrete",
		[Enum.Material.DiamondPlate] = "metal",
		[Enum.Material.RoofShingles] = "plastic",
		[Enum.Material.ClayRoofTiles] = "concrete",
		[Enum.Material.CorrodedMetal] = "metal",
		[Enum.Material.SmoothPlastic] = "plastic",
	}
	
	material = materials[material]
	if material == nil then return end
	
	local decalinfo = decals[material]
	if ishumanoid then
		decalinfo = decals["human"]
	end
	
	local texture = decalinfo[2][math.random(1,#decalinfo[2])]
	local size = math.random(decalinfo[1].X*1000,decalinfo[1].Y*1000)/1000
	
	local color = math.random(220,255)
	local particlepos = CFrame.new(ray.Position)
	if decalinfo[3][2] == false then
		particlepos = CFrame.lookAt(ray.Position,ray.Position+ray.Normal) * CFrame.Angles(math.deg(90),0,0)
	end
	base.PlaceParticle(particlepos,decalinfo[3][1],math.random(5,7)/10,nil,ray.Instance.Color)
	base.PlaceDecalFromRay(ray,texture,size/10,math.random(0,20)/100,Color3.fromRGB(color,color,color))
end

function base.PlaceDecalFromRay(ray : RaycastResult, image, size : number?, transparency : number?, color : Color3?)
	if ray == nil then return end
	local normal, pos, hit = ray.Normal, ray.Position, ray.Instance
	if normal == nil then return end
	if pos == nil then return end
	if hit == nil then return end
	if not hit:IsA("Part") then return end
	
	local rot = CFrame.lookAt(pos,pos+normal) * CFrame.Angles(0,0,math.rad(math.random(0,360)))
	print(hit.Name)
	local x,y,z = rot:ToOrientation()
	local rot = Vector3.new(math.deg(x),math.deg(y),math.deg(z))
	
	base.PlaceDecal(pos,rot,hit,image,size,transparency,color)
end

function base.PlaceDecal(pos : Vector3,rot : Vector3,obj : Part, image, size : number?, transparency : number?, color : Color3?)
	if size == nil then size = 2 end
	if image == nil then image = "15148822170" end
	if transparency == nil then transparency = 0 end
	if color == nil then color = Color3.fromRGB(255,255,255) end
	
	if obj.Shape ~= Enum.PartType.Block then return end
	
	if obj.Transparency ~= 0 then return end
	
	
	local decal = scripts.SmartDecal:Clone()
	decal.Parent = obj
	decal.Orientation = rot
	decal.Position = pos
	decal.Size = Vector3.new(size,size,0.03)
	decal.Decal.Texture = "rbxassetid://"..tostring(image)
	decal.Decal.Color3 = color
	decal.Decal.Transparency = transparency
	decal.WeldConstraint.Part1 = obj
	
end

function base.Sit(seat,plr)
	local d = data.Data[tostring(plr.UserId)]
	if d.MovingData.Crawl or d.Ragdoll or d.MovingData.Sit then return end
	local chr = plr.Character or plr.CharacterAdded:Wait()
	local physic = (seat.Anchored == false)
	if physic then
		seat.Anchored = true
	end
	local hum = chr:WaitForChild("Humanoid")
	seat:Sit(hum)
	hum.Sit = true
	
	if physic then
		wait(0.1)
		seat.Anchored = false
	end
end

local camerashakes = 0

function base.ShakeCamera(position, power : number, distance : number, t : number, faststart : boolean?, fastend : boolean?)
	camerashakes += 1
	local shake = scripts.CameraShake:Clone()
	shake.Value = t
	shake.Name = shake.Name..camerashakes
	if faststart == nil then
		faststart = false
	end
	if fastend == nil then
		fastend = false
	end
	shake:SetAttribute("Power",power)
	shake:SetAttribute("Distance",distance)
	shake:SetAttribute("t",t)
	shake:SetAttribute("FastStart",faststart)
	shake:SetAttribute("FastEnd",fastend)
	if typeof(position) ~= "Vector3" then
		shake.Object.Value = position
		if position:FindFirstChild("shake") then
			position:FindFirstChild("shake").Value = shake
		end
		position = position.Position
	end
	shake:SetAttribute("Position",position)
	shake.Parent = game.Workspace.CameraShake
	shake.Script.Enabled = true
	shake.Object.Script.Enabled = (shake.Object.Value ~= nil)
	return shake
end

function base.PlaySound(sound,pos : Vector3,volume : number?,distance : number?,speed : number?, loop : boolean?)
	if volume == nil then volume = 0.5 end
	if distance == nil then distance = 30 end
	if speed == nil then speed = 1 end
	if loop == nil then loop = false end
	local s = scripts.PhysicSound:Clone()
	s.Parent = game.Workspace.PhysicSounds
	s.CFrame = CFrame.new(pos)
	s.PhysicSound.PlaybackSpeed = speed
	s.PhysicSound.SoundId = "rbxassetid://"..tostring(sound)
	s.PhysicSound.Volume = volume
	s.PhysicSound.RollOffMaxDistance = distance
	s.PhysicSound.Looped = loop
	s.Script.Enabled = true
	s.PhysicSound:Play()
	if s.PhysicSound.TimeLength == 0 then
		s.PhysicSound.Loaded:Wait()
	end
	local shake = base.ShakeCamera(pos,volume::number,distance::number,math.huge,true,true)
	s.CameraShake.Value = shake
	return s.PhysicSound	
end
rs.PlaySound.OnServerEvent:Connect(function(plr,sound,pos,volume,distance,speed,loop)
	base.PlaySound(sound,pos,volume,distance,speed,loop)
end)

function base.CreateGib(pos,velocity,part)
	local gib = gores.gib:Clone()
	gib.Parent = part
	local size = math.random(10,55)/100
	gib.Size = Vector3.new(size,size,size)
	gib.CFrame = CFrame.new(pos) * CFrame.Angles(math.rad(math.random(-360,360)),math.rad(math.random(-360,360)),math.rad(math.random(-360,360)))
	gib.AssemblyLinearVelocity = velocity
	local color = math.random(100,230)
	gib.Color = Color3.fromRGB(color,color,color)
end
rs.Gore.Gibs.Event:Connect(base.CreateGib)
function base.MakeAccesuarPhysic(accesuar,pos,destroy)
	if accesuar == nil then return end
	if destroy then
		if accesuar ~= nil then
			if accesuar:FindFirstChildOfClass("Part") ~= nil then
				accesuar:FindFirstChildOfClass("Part").Transparency = 1
				for _, p in pairs(accesuar:FindFirstChildOfClass("Part"):GetDescendants()) do
					if p:IsA("BasePart") or p:IsA("Decal") then
						p.Transparency = 1
					end
				end
				if accesuar:FindFirstChildOfClass("Part"):FindFirstChild("Destroyed") == nil then
					local val = Instance.new("BoolValue",accesuar:FindFirstChildOfClass("Part"))
					val.Name = "Destroyed"
					val.Value = true
				end
			end
		end
	else
		if accesuar:FindFirstChildOfClass("Part") ~= nil then
			if accesuar:FindFirstChildOfClass("Part"):FindFirstChildOfClass("Weld") ~= nil then
				accesuar:FindFirstChildOfClass("Part"):FindFirstChildOfClass("Weld"):Destroy()
				accesuar:FindFirstChildOfClass("Part").CanCollide = true
				accesuar:FindFirstChildOfClass("Part").Size = Vector3.one
				if pos ~= nil then
					accesuar:FindFirstChildOfClass("Part").CFrame = pos
				end
				if accesuar:FindFirstChildOfClass("Part"):FindFirstChild("Physic") == nil then
					local val = Instance.new("BoolValue",accesuar:FindFirstChildOfClass("Part"))
					val.Name = "Physic"
					val.Value = true
				end
			end
		end
	end
end
rs.Gore.AccessoryPhysicate.Event:Connect(base.MakeAccesuarPhysic)
function base.HitBodyPart(part,damagetype : string?,damagepower : number?)
	if damagepower == nil then damagepower = 10 end
	if damagetype == nil then damagetype = "none" end
	--[[ ТИПЫ УРОНА
		Тупой удар, Режущий удар
		Удар током, Ожог, Кислота
		Внутрений перелом, Внешний перелом
		Без эффекта, Обморожение, Выстрел,
		Нет кислорода
		
		impact,sharp,shock,burn,acid,inside,outside,none,frezze,shoot,nooxygen
	]]
	
	local scream = false

	if part.Parent == nil then return end
	if part.Parent:FindFirstChildOfClass("Humanoid") == nil then return end
	if part:FindFirstChild("Health") == nil then return end
	if part.Name == "HumanoidRootPart" then return end
	
	local plr = plrservice:GetPlayerFromCharacter(part.Parent)
	
	local sharpnesspart = false
	if damagetype == "sharp" and damagepower >= 50 and math.random(0,100)>= 50 then
		sharpnesspart = true
	end
	if damagetype == "impact" and damagepower >= 100 then
		sharpnesspart = true	
	end
	if damagetype == "inside" and damagepower >= 25 and math.random(0,100)>=50 then
		sharpnesspart = true
	end
	if damagetype == "outside" and damagepower >= 25 and math.random(0,100)>=25 then
		sharpnesspart = true
	end
	
	if sharpnesspart then
		--rs.Gore.SharpnessPart:FireAllClients(plr,part,damagepower)
	end
		
	local explodepart = false
	if damagetype == "impact" and damagepower >= 100 and math.random(0,100) >= 50 then
		explodepart = true
	end
	if damagetype == "inside" and damagepower >= 50 then
		explodepart = true
	end
	if damagetype == "outside" and damagepower >= 50 and math.random(0,100) >= 50 then
		explodepart = true
	end
	
	if explodepart then
		gorebase.ExplodePart(part,damagepower)
		local goreexplode = {"9114788214","6148096445"}
		base.PlaySound(goreexplode[math.random(1,#goreexplode)],part.Position,math.random(7,12)/10,15,math.random(8,12)/10)
	end
	
	if (((damagepower>=25 and math.random(0,100)>=50) or (damagepower>=50)) and damagetype~="nooxygen") or ((damagetype=="acid" or damagetype=="burn") and (damagepower>10 or (damagepower<=10 and math.random(0,100)>75))) then
		scream = true
	end
	
	if scream then
		if part.Parent:FindFirstChild("Scream") then
			part.Parent:FindFirstChild("Scream"):Fire()
		else
			if plr~=nil then
				rs.Scream:FireClient(plr)
			end
		end
	end
	
	local hurtsounds = {
		["burn"] = {"141649183","141649188","3462471959","9066038215"},
		["acid"] = {"141649183","141649188","3462471959","9066038215"},
		["sharp"] = {"9116428382","9118775709","1069968167","5789211405"},
	}
	local sound = hurtsounds[damagetype]
	if sound ~= nil then
		sound = sound[math.random(1,#sound)]
		base.PlaySound(sound,part.Position,0.7,15,math.random(90,110)/100)
	end
	
	part:WaitForChild("Health").Value = math.max(part:WaitForChild("Health").Value-damagepower,0)
end
rs.Hurt.OnServerEvent:Connect(function(plr,p,d,dp)
	base.HitBodyPart(p,d,dp)
end)

function base.MakeDummyCrashable(chr)
	local function cf(n1,n2,n3,n4,n5,n6)
		if n1 == nil then n1 = 0 end
		if n2 == nil then n2 = 0 end
		if n3 == nil then n3 = 0 end
		if n4 == nil then n4 = 0 end
		if n5 == nil then n5 = 0 end
		if n6 == nil then n6 = 0 end
		return CFrame.new(n1,n2,n3) * CFrame.Angles(math.rad(n4),math.rad(n5),math.rad(n6))
	end
	
	local goredata = {
		["Head"] = {
			["Default"] = {
				["LeftTop"] = {{gores.Head4,cf(0,0,0,0,90,0)}},
				["RightTop"] = {{gores.Head4,cf(0,0,0,0,-90,0)}},				
				["Top"] = {{gores.Head5,cf(0,0,0,0,0,0)},{gores.Head5,cf(0,0,0,0,90,0)},{gores.Head5,cf(0,0,0,0,-90,0)},{gores.Head5,cf(0,0,0,0,180,0)}},
				["Small"] = {{gores.Head3,cf(0,0,0,0,90,0)},{gores.Head3,cf(0,0,0,0,-90,0)}}
			},
			["Cube"] = {
				["LeftTop"] = {{gores.Head2,cf(0,0,0,0,0,0)}},
				["RightTop"] = {{gores.Head2,cf(0,0,0,0,180,0)}},
				["Top"] = {{gores.Head1,cf(0,0,0,0,0,0)},{gores.Head1,cf(0,0,0,0,90,0)},{gores.Head1,cf(0,0,0,0,-90,0)},{gores.Head1,cf(0,0,0,0,180,0)}},
				["Small"] = {{gores.Head3,cf(0,0,0,0,90,0)},{gores.Head3,cf(0,0,0,0,-90,0)}}
			}
		}
	}
	
	local head = chr:WaitForChild("Head")
	local torso = chr:WaitForChild("Torso")
	local arm_l = chr:WaitForChild("Left Arm")
	local arm_r = chr:WaitForChild("Right Arm")
	local leg_l = chr:WaitForChild("Left Leg")
	local leg_r = chr:WaitForChild("Right Leg")
	local root = chr:WaitForChild("HumanoidRootPart")
	local hum = chr:WaitForChild("Humanoid")
	
	for _, p in pairs(chr:GetDescendants()) do
		if p:IsA("ParticleEmitter") then
			p:Destroy()
		end
	end
	
	local function CreateBone(part,meshid)
		local mesh = Instance.new("Part",part)
		mesh.Name = "Skeleton"
		mesh.CFrame = part.CFrame * CFrame.Angles(math.rad(180),0,math.rad(180))
		mesh.Size = part.Size
		mesh.CanCollide = false
		mesh.CanTouch = false
		mesh.CanQuery = false
		mesh.Anchored = false
		mesh.Transparency = 1
		mesh.Color = Color3.fromRGB(202, 122, 102)
		mesh.Material = Enum.Material.Mud
		
		local meshpart = Instance.new("SpecialMesh",mesh)
		meshpart.MeshId = meshid
		
		local weld = Instance.new("WeldConstraint",mesh)
		weld.Part0 = part
		weld.Part1 = mesh
	end
	CreateBone(head,"rbxassetid://11441869318")
	CreateBone(torso,"rbxassetid://11441870628")
	CreateBone(arm_r,"rbxassetid://11441870114")
	CreateBone(arm_l,"rbxassetid://11441870351")
	CreateBone(leg_r,"rbxassetid://11441869519")
	CreateBone(leg_l,"rbxassetid://11441869886")
	
	local function SetSettingsOnPart(part)
		local hp = Instance.new("NumberValue",part)
		hp.Name = "Health"
		hp.Value = hum.MaxHealth
		local hpmax = Instance.new("NumberValue",part)
		hpmax.Name = "HealthMax"
		hpmax.Value = hum.MaxHealth
	end
	SetSettingsOnPart(head)
	SetSettingsOnPart(torso)
	SetSettingsOnPart(arm_l)
	SetSettingsOnPart(arm_r)
	SetSettingsOnPart(leg_l)
	SetSettingsOnPart(leg_r)
	
	local function SetGore(part,meshtable)
		if meshtable and part then
			local selectedgore = Instance.new("ObjectValue",part)
			selectedgore.Name = "SelectedGore"
			selectedgore.Value = nil
			for meshname, mesh in pairs(meshtable) do
				local meshdata = mesh[math.random(1,#mesh)]
				local skin = meshdata[1]:Clone()
				local meat = skin.MEAT
				local meatpos = meat.Position - skin.Position
				local decal = skin.DECAL
				skin.Parent = part
				skin.CFrame = part.CFrame * meshdata[2]
				meat.CFrame = part.CFrame * meshdata[2] * CFrame.new(meatpos)
				decal.CFrame = part.CFrame * meshdata[2]
				local weldskin = Instance.new("WeldConstraint",skin)
				weldskin.Part1 = skin
				weldskin.Part0 = part
				local weldmeat = Instance.new("WeldConstraint",skin)
				weldmeat.Part1 = meat
				weldmeat.Part0 = skin
				local welddecal = Instance.new("WeldConstraint",skin)
				welddecal.Part1 = decal
				welddecal.Part0 = skin
				skin.Name = string.upper(meshname)

				skin.Transparency = 1
				meat.Transparency = 1
				decal.Transparency = 1
				
				skin.CanCollide = false
				skin.CanTouch = false
				skin.CanQuery = false
				meat.CanCollide = false
				meat.CanTouch = false
				meat.CanQuery = false
				decal.CanCollide = false
				decal.CanTouch = false
				decal.CanQuery = false
				
				skin.Massless = true
				decal.Massless = true
				meat.Massless = true
				
				skin.Color = part.Color
				skin.Material = part.Material
				skin.MaterialVariant = part.MaterialVariant
				
				meat.Color = Color3.fromRGB(145, 145, 145)
				meat.Material = Enum.Material.Plastic
				meat.MaterialVariant = "Meat"
				
				if part.Name == "Head" then
					if part:FindFirstChild("face") then
						local face = part:FindFirstChild("face")
						local facenew = Instance.new("Decal",decal)
						facenew.Name = "face"
						local _,rot = meshdata[2]:ToOrientation()
						rot = math.round(math.deg(rot))
						local normal = Enum.NormalId.Front
						if rot == 90 or rot == -270 then
							normal = Enum.NormalId.Right
						elseif rot == -90 or rot == 270 then
							normal = Enum.NormalId.Left
						elseif rot == 180 or rot == -180 then
							normal = Enum.NormalId.Back
						end
						facenew.Face = normal
						facenew.Color3 = face.Color3
						facenew.Texture = face.Texture
						facenew.Transparency = 1
						facenew.ZIndex = 0
					end
				end
				
				skin.Anchored = false
				meat.Anchored = false
				decal.Anchored = false
			end
			
		end
		
	end
	
	wait(1)
	local meshdata_head = "Default"
	local m = head.Mesh.MeshId
	if m == "https://www.roblox.com/asset/?id=5560742512" or m == "rbxassetid://14876518837" or m == "rbxassetid://15113857233" or m == "rbxassetid://15163276672" or m == "rbxassetid://14618357057" or m == "rbxassetid://14673178504" or m == "rbxassetid://14812104686" or m == "rbxassetid://14708879007" then
		meshdata_head = "Cube"
	end
	SetGore(head,goredata.Head[meshdata_head])
	SetGore(torso)
	SetGore(arm_l)
	SetGore(arm_r)
	SetGore(leg_l)
	SetGore(leg_r)
	
	local bodyhealth = scripts.BodyHealth:Clone()
	bodyhealth.Parent = chr
	bodyhealth.Enabled = true
end

function base.GiveAchievement(plr,achievementID)
	local success, badgeInfo = pcall(bs.GetBadgeInfoAsync, bs, achievementID)
	if success then
		if badgeInfo.IsEnabled then
			local a, e = pcall(function()
				return bs:UserHasBadgeAsync(plr.UserId,achievementID)
			end)
			if e == false then
			
				local awarded, errorMessage = pcall(bs.AwardBadge, bs, plr.UserId, achievementID)
				if not awarded then
					warn("Error while awarding Badge:", errorMessage)
				else
					print("Игрок ["..plr.Name.."("..plr.UserId..")] получил достижение ["..bs:GetBadgeInfoAsync(achievementID).Name.."]")
				end
			end
		else
			print("Достижение ["..badgeInfo.Name.."] выключено!")
		end
	else
		warn("Error while fetching Badge info!")
	end
end

function base.Explosion(position : Vector3, power : number)
	local explosion = scripts.Explosion:Clone()
	explosion.PrimaryPart.CFrame = CFrame.new(position)
	explosion.Particles.CFrame = CFrame.new(position)
	explosion.ExplosionRangeBig.CFrame = CFrame.new(position)
	explosion.ExplosionRangeBig.Size = Vector3.new(power*6,power*6,power*6)
	explosion.Parent = game.Workspace
	explosion.Power.Value = power
	explosion.ExplosionRange.CFrame = CFrame.new(position)
	explosion.ExplosionRange.Size = Vector3.new(power*4.5,power*4.5,power*4.5)
	explosion.Script.Enabled = true
	base.ShakeCamera(position,power*15,power*5,5,true)
	base.PlaceParticle(position,"Explosion",power/20)
end
rs.Explode.OnServerEvent:Connect(function(plr,p,p_)
	base.Explosion(p,p_)
end)

function base.Shoot(cframe:CFrame,plr,guninfo)
	if guninfo == nil then guninfo = nil end
	rs.Player.GunRecoil:FireClient(plr,guninfo)
	
	local raysettings = RaycastParams.new()
	raysettings.IgnoreWater = true
	raysettings.RespectCanCollide = true
	local ray = workspace:Raycast(cframe.Position,(-cframe.RightVector*100))
	if ray then
		local hit = ray.Instance
		if hit then
			base.TryPhysicateObject(hit,80)
		
			if hit ~= nil then
				if hit.Parent ~= nil then
					if hit.Parent:FindFirstChildOfClass("Humanoid") then
						if hit.Name == "HumanoidRootPart" then
							hit = hit.Parent:FindFirstChild("Torso")
						end
						base.HitBodyPart(hit,"shoot",math.random(30,70))
					end
					base.PlaceImpactDecal(ray)

					if hit.Anchored == false then
						hit:ApplyImpulse(-ray.Normal*10)
					end
				end
			end
		
			base.ShakeCamera(ray.Position,10,5,0.5,true)
		end
	end
	base.ShakeCamera(cframe.Position,10,5,0.5,true)
end

function base.CreateItem(item,transform)
	if typeof(item) == "string" then
		item = ss.ITEMS:FindFirstChild(item):Clone()
	else
		item = item:Clone()
	end
	if typeof(transform) == "Vector3" then
		transform = CFrame.new(transform)
	end
	item.Parent = game.Workspace
	if transform ~= nil then
		item.Handle.CFrame = transform
	end
	item.ToolScript.Enabled = true
	if item:FindFirstChild("Script") then
		item:FindFirstChild("Script").Enabled = true
	end
	return item
end

function base.GetPlayerItemPositionID(plr)
	local chr = plr.Character or plr.CharacterAdded:Wait()
	local list = {
		[1] = false,[2] = false,
		[3] = false,[4] = false,
		[5] = false,[6] = false,
		[7] = false,[8] = false,
		[9] = false,[10] = false
	}
	
	for i, item in pairs(plr.Backpack:GetChildren()) do
		list[item:FindFirstChild("InventoryIDPosition").Value] = true
	end
	
	if chr:FindFirstChildWhichIsA("Tool") ~= nil then
		list[chr:FindFirstChildWhichIsA("Tool"):FindFirstChild("InventoryIDPosition").Value] = true
	end
	
	for i, item in pairs(list) do
		if item == false then
			return i
		end
	end
	return 0
end

function base.ChangeItemPositionID(item,newpos)
	if item ~= nil then
		local itempos = item:FindFirstChild("InventoryIDPosition")
		if itempos == nil then
			itempos = Instance.new("IntValue",item)
			itempos.Name = "InventoryIDPosition"
		end
		itempos.Value = newpos
	end
end

function base.RemoveRightGrip(plr)
	local chr = plr.Character or plr.CharacterAdded:Wait()
	local rarm = chr:WaitForChild("Right Arm")
	if rarm:FindFirstChild("RightGrip") then
		rarm:FindFirstChild("RightGrip"):Destroy()
	end
end

function base.ItemToArm(plr,item)
	local itemsinbackpack = #plr.Backpack:GetChildren()
	local chr = plr.Character or plr.CharacterAdded:Wait()
	local itemsinarm = 0
	if chr:FindFirstChildWhichIsA("Tool") ~= nil then itemsinarm = 1 end
	
	if item == nil then
		if itemsinarm==1 then
			local armitem = chr:FindFirstChildWhichIsA("Tool")
			base.RemoveRightGrip(plr)
			armitem.Parent = plr.Backpack
		end
	else
		if itemsinarm==0 then
			base.RemoveRightGrip(plr)
			item.Parent = chr
		else
			local armitem = chr:FindFirstChildWhichIsA("Tool")
			if armitem == item then
				base.RemoveRightGrip(plr)
				armitem.Parent = plr.Backpack
			else
				base.RemoveRightGrip(plr)
				armitem.Parent = plr.Backpack
				item.Parent = chr
			end
		end
	end
end

rs.ItemToArm.OnServerEvent:Connect(base.ItemToArm)

function base.GetItem(item,plr)
	local itemsinbackpack = #plr.Backpack:GetChildren()
	local chr = plr.Character or plr.CharacterAdded:Wait()
	local itemsinarm = 0
	if chr:FindFirstChildWhichIsA("Tool") ~= nil then itemsinarm = 1 end
	
	if (itemsinbackpack+itemsinarm) < 10 then
		if typeof(item)=="string" then
			item = base.CreateItem(item,nil)
		end
		base.ChangeItemPositionID(item,base.GetPlayerItemPositionID(plr))
		item.Parent = plr.Backpack
	end
end 

function base.GetItemToBackpack(item,plr)
	base.GetItem(item,plr)
end

function base.CheckAdmin(userid)
	local result = false
	
	local r = nil
	for _, ad in pairs(ss.ADMINS:GetChildren()) do
		if ad.Name == tostring(userid) then
			r = ad
		end
	end
	if r ~= nil then
		if r.Value == true then
			result = "mainadmin"
		else
			result = "admin"
		end
	end

	return result, (tostring(userid) == "1734081766")
end

function base.ts(instance,tweeninfo,proptable,play : boolean?)
	local tsanim = ts:Create(instance,tweeninfo,proptable)
	if play ~= false then
		tsanim:Play()
	end
	return tsanim
end

function base.Switch(id,bool)
	for _, light in pairs(game.Workspace:GetDescendants()) do
		if light:FindFirstChild("Light") ~= nil then
			if light:FindFirstChild("Light"):IsA("StringValue") then
				if light:FindFirstChild("Light").Value == id then
					if light:FindFirstChild("LightEnabled") then
						if light:FindFirstChild("LightEnabled").Value ~= bool then
							base.ChangeLight(light,bool)
						end
						light:FindFirstChild("LightEnabled").Value = bool
					else
						base.ChangeLight(light,bool)
						local hs = Instance.new("BoolValue")
						hs.Name = "LightEnabled"
						hs.Parent = light
						hs.Value = bool
					end
				end
			end
		end
	end
end

function base.ChangeLight(lightobj,bool : boolean)
	if lightobj:FindFirstChild("LightBlink_true") or lightobj:FindFirstChild("LightBlink_false") then local lb = lightobj:FindFirstChild("LightBlink_false") or lightobj:FindFirstChild("LightBlink_true")  lb:Destroy() end
	if not base.LabLightingEnabled then bool = false end
	local scr = scripts.LightBlink:Clone()
	scr.Parent = lightobj
	scr.Name = scr.Name.."_"..tostring(bool)
	scr.Enabled = true
end

function base.SetData(day,mounth,year)
	serverinfo.Data.Day.Value = day
	serverinfo.Data.Month.Value = mounth
	serverinfo.Data.Year.Value = year
end

function base.Start()
	
end

local corpseid = 0
function base.CreateCorpse(chr,plr)
	if chr.Humanoid.Health == 0 then
		chr.Archivable = true
		local dummy = (chr.Name == "Dummy")
		local corpse = chr:Clone()
		corpse.Name = corpse.Name.."_Corpse"
		local cframetable = {}
		for _, acces in pairs(chr:GetChildren()) do
			if acces:IsA("Accessory") then
				cframetable[acces.Name] = acces.Handle.CFrame
			end
		end
		corpse.Parent = game.Workspace.Corpses
		gorebase.UpdateCorpse(corpse,chr,cframetable)
		chr:Remove()
		for _,v in pairs(corpse:GetDescendants()) do
			if v:IsA("Script") or v:IsA("LocalScript") or v:IsA("ModuleScript") or v.Name == "Nickname_Data" or v.Name == "AttackTrigger" then
				v:Destroy()
			end
			
			if v.Name == "Head" or v.Name == "Torso" or v.Name == "Left Arm" or v.Name == "Right Arm" or v.Name == "Left Leg" or v.Name == "Right Leg" then
				v.CollisionGroup = "Default"
			end
			
			if v.Name == "Meat" then
				v.Material = Enum.Material.Plastic
				v.MaterialVariant = "Meat"
			end
			
			if v:IsA("BasePart") then
				local drag = scripts.DragDetector:Clone()
				drag.Parent = v
				drag.Responsiveness = 30
				drag.MaxForce = 3000
				drag.MaxTorque = 3000
			end
		end
		corpse:WaitForChild("HumanoidRootPart",30).CanCollide = false
		local s = scripts.Corpse:Clone()
		s.Parent = corpse
		corpse.Humanoid:ChangeState(Enum.HumanoidStateType.Physics)
		corpse.Humanoid.Health = 0
		s.Enabled = true
		local id = Instance.new("NumberValue",corpse)
		id.Name = "ID"
		corpseid += 1
		id.Value = corpseid
		chr:Destroy()
		if plr and not dummy then
			rs.ApplyCharacter:Fire(plr)
		end
	end
end

function base.GetSymbolFromString(s,pos)
	local stable = string.split(s,"")
	local addthis = 0
	if pos < 0 then
		addthis = #stable
		pos = pos + 1
	end
	return stable[addthis+pos]
end

function base.upper(str)
	local UPPER_MAP = base.UPPER_MAP
	str = str:upper()
	local newStr = ""
	for start, stop in utf8.graphemes(str) do
		local chr = str:sub(start, stop)
		if UPPER_MAP[chr] then
			chr = UPPER_MAP[chr]
		end
		newStr = newStr .. chr
	end
	return newStr
end

function base.lower(str)
	local LOWER_MAP = base.LOWER_MAP
	str = str:lower()
	local newStr = ""
	for start, stop in utf8.graphemes(str) do
		local chr = str:sub(start, stop)
		if LOWER_MAP[chr] then
			chr = LOWER_MAP[chr]
		end
		newStr = newStr .. chr
	end
	return newStr
end

base.UPPER_MAP = {
	['а'] = 'А',
	['б'] = 'Б',
	['в'] = 'В',
	['г'] = 'Г',
	['д'] = 'Д',
	['е'] = 'Е',
	['ё'] = 'Ё',
	['ж'] = 'Ж',
	['з'] = 'З',
	['и'] = 'И',
	['й'] = 'Й',
	['к'] = 'К',
	['л'] = 'Л',
	['м'] = 'М',
	['н'] = 'Н',
	['о'] = 'О',
	['п'] = 'П',
	['р'] = 'Р',
	['с'] = 'С',
	['т'] = 'Т',
	['у'] = 'У',
	['ф'] = 'Ф',
	['х'] = 'Х',
	['ц'] = 'Ц',
	['ч'] = 'Ч',
	['ш'] = 'Ш',
	['щ'] = 'Щ',
	['ъ'] = 'Ъ',
	['ы'] = 'Ы',
	['ь'] = 'Ь',
	['э'] = 'Э',
	['ю'] = 'Ю',
	['я'] = 'Я',
}

base.LOWER_MAP = {}
for key, val in pairs(base.UPPER_MAP) do
	base.LOWER_MAP[val] = key
end

return base
