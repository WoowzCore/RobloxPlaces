local rs = game:GetService("ReplicatedStorage")
local ss = game:GetService("ServerStorage")
local is = game:GetService("InsertService")
local plrservice = game:GetService("Players")
local basa = require(script.Parent.Base)
local lab = require(script.Parent.Lab)
local commandsdata = require(ss.COMMANDSDATA)
local l = require(ss.LIQUIDS)

local function sethealth(part,health)
	part:WaitForChild("Health",60).Value = health
end
rs.SetHealth.OnServerEvent:Connect(function(plr,part,health)
	sethealth(part,health)
end)

local materials = {
	["plastic"] = Enum.Material.Plastic,
	["metal"] = Enum.Material.Metal,
	["glass"] = Enum.Material.Glass,
	["smoothplastic"] = Enum.Material.SmoothPlastic,
	["brick"] = Enum.Material.Brick,
	["wood"] = Enum.Material.Wood,
	["corrodedmetal"] = Enum.Material.CorrodedMetal,
	["ground"] = Enum.Material.Ground,
	["ice"] = Enum.Material.Ice,
	["foil"] = Enum.Material.Foil,
	["forcefield"] = Enum.Material.ForceField,
	["rock"] = Enum.Material.Rock,
	["neon"] = Enum.Material.Neon,
	["pebble"] = Enum.Material.Pebble,
	["pavement"] = Enum.Material.Pavement,
	["mud"] = Enum.Material.Mud,
	["sand"] = Enum.Material.Sand,
	["slate"] = Enum.Material.Slate,
	["diamondplate"] = Enum.Material.DiamondPlate,
	["crackedlava"] = Enum.Material.CrackedLava,
	["woodplanks"] = Enum.Material.WoodPlanks,
	["snow"] = Enum.Material.Snow,
	["sandstone"] = Enum.Material.Sandstone,
	["marble"] = Enum.Material.Marble,
	["limestone"] = Enum.Material.Limestone,
	["leafygrass"] = Enum.Material.LeafyGrass,
	["granite"] = Enum.Material.Granite,
	["grass"] = Enum.Material.Grass,
	["glacier"] = Enum.Material.Glacier,
	["fabric"] = Enum.Material.Fabric,
	["concrete"] = Enum.Material.Concrete,
	["cobblestone"] = Enum.Material.Cobblestone,
	["asphalt"] = Enum.Material.Asphalt,
	["basalt"] = Enum.Material.Basalt,
	["rubber"] = Enum.Material.Rubber,
	["carpet"] = Enum.Material.Carpet,
	["cardboard"] = Enum.Material.Cardboard,
	["ceramictiles"] = Enum.Material.CeramicTiles,
	["plaster"] = Enum.Material.Plaster,
	["clayrooftiles"] = Enum.Material.ClayRoofTiles,
	["roofshingles"] = Enum.Material.RoofShingles,
	["leather"] = Enum.Material.Leather
}

local function GetPlayers(mainplr,value)
	local plrs = {}
	if value == "EVERYONE" then
		return plrservice:GetPlayers()
	elseif value == "EVERYONENOTME" then
		for _, plr in pairs(plrservice:GetPlayers()) do
			if plr.UserId ~= mainplr.UserId then
				table.insert(plrs,plr)
			end
			return plrs
		end
	else
		return {plrservice:FindFirstChild(value)}
	end
end

local function Command(mainplr,plrs,id,values)
	local commanddata = commandsdata.Data[id]
	
	if commanddata["Settings"]["mainadmin"] and basa.CheckAdmin(mainplr.UserId) ~= "mainadmin" then return "Ты не Главный Админ, ты не Можешь Использовать эту Команду!" end
	
	if not commanddata["Settings"]["canusemainadmin"] then
		if (#plrs == 1 and plrs[1].UserId == mainplr.UserId and id ~= "teleport") then 
			local result = {}
			for _, plr in pairs(plrs) do
				if basa.CheckAdmin(plr.UserId) ~= "mainadmin" then
					table.insert(result,plr)
				end
			end
			plrs = result
		end
	end
	
	if id == "kill" then
		for _, plr in pairs(plrs) do
			local chr = plr.Character or plr.CharacterAdded:Wait()
			local hum = chr:WaitForChild("Humanoid",60)
			basa.HitBodyPart(chr.Head,"none",math.huge)
			basa.HitBodyPart(chr.Torso,"none",math.huge)
			basa.HitBodyPart(chr["Left Arm"],"none",math.huge)
			basa.HitBodyPart(chr["Right Arm"],"none",math.huge)
			basa.HitBodyPart(chr["Left Leg"],"none",math.huge)
			basa.HitBodyPart(chr["Right Leg"],"none",math.huge)
		end
		local result = #plrs.." игроков убито!"
		local rresult = "Игроки убиты!"
		if #plrs == 1 then
			result = "Игрок ["..plrs[1].Name.." ("..plrs[1].UserId..")] убит!"
			rresult = "Игрок убит!"
		end
		print("S-Admin: "..result)
		return rresult
	end
	
	if id == "op" then
		local deop = values["deop"]
		for _, plr in pairs(plrs) do
			if deop then
				local admin = ss.ADMINS:FindFirstChild(tostring(plr.UserId))
				if admin ~= nil then
					if admin.Value == false then admin:Destroy() end
				end
			else
				local admin = ss.ADMINS:FindFirstChild(tostring(plr.UserId))
				if admin == nil then
					admin = Instance.new("BoolValue",ss.ADMINS)
					admin.Value = false
					admin.Name = tostring(plr.UserId)
				end
			end
			
			local checkadmin, dev = basa.CheckAdmin(plr.UserId)
			if dev then checkadmin = "dev" end
			rs.UpdateAdmin:FireClient(plr,checkadmin)
		end
	
		local consoleresult = #plrs.." игрокам выдан оператор!"
		local r = "Игрокам выдан оператор!"
		if deop then consoleresult = "У "..#plrs.." игроков забран оператор!" r="У игроков забран оператор!" end
		if #plrs == 1 then
			consoleresult = "Игроку ["..plrs[1].Name.." ("..plrs[1].UserId..")] выдан оператор!"
			r = "Игроку выдан оператор!"
			if deop then consoleresult = "У игрока ["..plrs[1].Name.." ("..plrs[1].UserId..")] забран оператор!" r="У игрока забран оператор!" end
		end
		print("S-Admin:"..consoleresult)
		return r
	end
	
	if id == "giveitem" then
		local drop = values["drop"]
		for _, plr in pairs(plrs) do
			if drop then
				local chr = plr.Character or plr.CharacterAdded:Wait()
				basa.CreateItem(values["item"],chr:FindFirstChild("Torso").CFrame)
			else
				basa.GetItemToBackpack(values["item"],plr)
			end
			print("S-Admin: Игроку ["..plr.Name.." ("..plr.UserId..")] Выдан Предмет ["..values["item"].."] с физикой ["..tostring(drop).."]")
		end
		return "Предмет выдан!"
	end
	
	if id == "kick" then
		local reason = values["reason"]
		local show = values["show"]
		for _, plr in pairs(plrs) do
			if reason ~= "" then
				if show then
					plr:Kick("Вас кикнул оператор ["..mainplr.Name.." ("..mainplr.UserId..")] по причине ("..reason..")")
				else
					plr:Kick(reason)
				end
				print("S-Admin: Игрок ["..plr.Name.." ("..plr.UserId..")] кикнут по причине ["..reason.."]")
			else
				if show then
					plr:Kick("Вас Кикнул Администратор ["..mainplr.Name.." ("..mainplr.UserId..")]")
				else
					plr:Kick()
				end
				print("S-Admin: Игрок ["..plr.Name.." ("..plr.UserId..")] кикнут")
			end
		end
		local result = "Игроки кикнуты!"
		if #plrs == 1 then
			result = "Игрок кикнут!"
		end
		return result
	end
	
	if id == "shakelab" then
		local power = tonumber(values["power"])
		if power == nil then
			return "Получено не число!"
		end
		power = math.min(power,100)
		power = math.max(0,power)
		lab.ShakeLab(power)
		print("S-Admin: Лаборатория трясётся с силой ["..tostring(power).."]")
		return "Лаборатория трясётся!"
	end
	
	if id == "siren" then
		lab.ChangeSirenType(values["id"])
		print("S-Admin: Тревога изменена на ["..values["id"].."]")
		local result = "Тревога изменена!"
		if values["id"] == "empty" then
			result = "Тревога отключена!"
		end
		return result
	end
	
	if id == "shakecamera" then
		values["power"] = math.min(math.abs(values["power"]),500)
		basa.ShakeCamera(Vector3.zero,values["power"],math.huge,math.abs(values["time"]),values["faststart"])
		print("S-Admin: Камеры трясутся с силой ["..values["power"].."] и на ["..values["time"].."] секунд")
		return "Камеры трясутся!"
	end
	
	if id == "stopshake" then
		for _, part in pairs(game.Workspace.CameraShake:GetChildren()) do
			part:Destroy()
		end
		print("S-Admin: Вся тряска остановлена")
		return "Вся тряска остановлена!"
	end
	
	if id == "explode" then
		local power = math.abs(  math.max(5 ,math.min( tonumber(values["power"])::number or 10 , 50)))
		for _, plr in pairs(plrs) do
			local chr = plr.Character or plr.CharacterAdded:Wait()
			local pos = values["position"]
			if not values["worldposition"] then
				pos += chr:WaitForChild("HumanoidRootPart",60).Position
			end
			basa.Explosion(pos,power)
		end
		print("S-Admin: Создан взрыв на позиции игрока ["..plrs[1].Name.." ("..plrs[1].UserId..")] с силой ["..power.."]")
		return "Взрыв создан!"
	end
	
	if id == "createparticle" then
		for _, plr in pairs(plrs) do
			local chr = plr.Character or plr.CharacterAdded:Wait()
			local pos = values["position"]
			if not values["worldposition"] then
				pos += chr:WaitForChild("HumanoidRootPart",60).Position
			end
			
			local size = math.min(math.max(0.1,tonumber(values["size"]) or 1),30)
			size = Vector3.new(size,size,size)
			
			basa.PlaceParticle(pos,values["particle"],math.max(math.min(tonumber(values["time"])::number or 1,30),0.1 ),size)
		end
		return "Эффект создан!"
	end
	
	if id == "prefab" then
		for _, plr in pairs(plrs) do
			local chr = plr.Character or plr.CharacterAdded:Wait()
			local rot = values["rotation"]
			local pos = values["position"]
			if not values["worldposition"] then
				pos += chr:WaitForChild("HumanoidRootPart",60).Position
			end
			rs.SpawnPrefab:Fire(CFrame.new(pos) * CFrame.Angles(math.rad(rot.X),math.rad(rot.Y),math.rad(rot.Z)),values["prefab"],true)
			print("S-Admin: Создан префаб ["..values["prefab"].."] в позиции игрока ["..plr.Name.." ("..plr.UserId..")]")
		end
		return "Префаб заспавнен!"
	end
	
	if id == "createobject" then
		if values["texture"] ~= "" then
			if tonumber(values["texture"]) == nil then
				return "Айди текстуры неверен!"
			end
		end
		for _, plr in pairs(plrs) do
			local chr = plr.Character or plr.CharacterAdded:Wait()
			local rot = values["rotation"]
			local pos = values["position"]
			if not values["worldposition"] then
				pos += chr:WaitForChild("HumanoidRootPart").Position
			end
			local cframe = CFrame.new(pos) * CFrame.Angles(math.rad(rot.X),math.rad(rot.Y),math.rad(rot.Z))
			
			local part = Instance.new("Part",game.Workspace.CreatedObjects)
			local shapes = {
				["block"] = Enum.PartType.Block,
				["sphere"] = Enum.PartType.Ball,
				["wedge"] = Enum.PartType.Wedge,
				["wedgecorner"] = Enum.PartType.CornerWedge,
				["cylinder"] = Enum.PartType.Cylinder
			}
			part.Name = "Part Created Admin ["..mainplr.Name.."("..mainplr.UserId..")]"
			part.Shape = shapes[values["shape"]]
			part.Anchored = values["anchored"]
			part.Size = Vector3.new( math.max(0.01,math.abs(values["size"].X)),math.max(0.01,math.abs(values["size"].Y)),math.max(0.01,math.abs(values["size"].Z)))
			part.CFrame = cframe
			part.CanCollide = values["collision"]
			part.Transparency = math.min(math.max( math.abs( tonumber(values["transparency"])::number/100 ) ,0),100)
			part.Material = materials[values["material"]]
			part.Color = values["color"]
			part.CastShadow = values["castshadow"]
			
			if values["drag"] then
				local drag = ss.SCRIPTS.DragDetector:Clone()
				drag.Parent = part
			end
			
			if values["texture"] ~= "" then
				local function createtexture(face)
					local texture = Instance.new("Texture",part)
					texture.Face = face
					texture.StudsPerTileU = 4
					texture.StudsPerTileV = 4
					texture.Texture = "rbxthumb://type=Asset&w=768&h=432&id="..tonumber(values["texture"])::number
				end
				createtexture(Enum.NormalId.Bottom)
				createtexture(Enum.NormalId.Top)
				createtexture(Enum.NormalId.Left)
				createtexture(Enum.NormalId.Right)
				createtexture(Enum.NormalId.Front)
				createtexture(Enum.NormalId.Back)
			end

			print("S-Admin: Создан объект ["..values["shape"].."] в позиции игрока ["..plr.Name.." ("..plr.UserId..")]")
		end
		return "Объект заспавнен!"
	end
	
	if id == "playsound" then
		for _, plr in pairs(plrs) do
			if tonumber(values["id"]) == nil then
				return "Айди звука неверен!"
			end
			local chr = plr.Character or plr.CharacterAdded:Wait()
			local pos = chr:WaitForChild("HumanoidRootPart",60).Position
			values["volume"] = math.min(math.abs(tonumber(values["volume"])::number)/100,10)
			local sound = basa.PlaySound(tostring(values["id"]),pos, values["volume"],math.abs(tonumber(values["distance"])::number),math.abs(tonumber(values["speed"])::number)/100,values["loop"])
			if sound == nil then return "Айди звука не работает!" end
			print("S-Admin: Проигран звук ["..values["id"].."] с громкостью ["..(values["volume"]*100).."] и скоростью ["..values["speed"].."] и дистанцией ["..values["distance"].."] и зациклено ["..tostring(values["loop"]).."]")
		end
		return "Звук проигран!"
	end
	
	if id == "stopsounds" then
		for _, part in pairs(game.Workspace.PhysicSounds:GetChildren()) do
			if part.Name == "PhysicSound" then
				part:Destroy()
			end
		end
		return "Звуки остановлены!"
	end
	
	if id == "destroycorpses" then
		for _, part in pairs(game.Workspace.Corpses:GetChildren()) do
			part:Destroy()
		end
		return "Трупы уничтожены!"
	end
	
	if id == "destroyprefabs" then
		for _, part in pairs(game.Workspace.CreatedObjects:GetChildren()) do
			part:Destroy()
		end
		return "Префабы уничтожены!"
	end
	
	if id == "destroydecals" then
		for _, part in pairs(game.Workspace:GetDescendants()) do
			if part.Name == "SmartDecal" or part.Name == "SmartDecalHD" then
				part:Destroy()
			end
		end
		return "Все декали уничтожены!"
	end
	
	if id == "dummy" then
		for _, plr in pairs(plrs) do
			local ursid = nil
			if values["skin"] ~= "" then
				
				local s,e = pcall(function()
					return plrservice:GetUserIdFromNameAsync(values["skin"])
				end)
				if s then
					ursid = e
				else
					return "Скина игрока не существует!"
				end
			end
			local description = nil
			if ursid ~= nil then
				local s,e = pcall(function()
					return plrservice:GetHumanoidDescriptionFromUserId(ursid)
				end)
				if s then
					description = e
				else
					return "Не получилось поставить скин игрока!"
				end
			end
			
			local chr = plr.Character or plr.CharacterAdded:Wait()
			local dummy = ss.Dummy:Clone()
			dummy.Parent = game.Workspace.CreatedObjects
			dummy.PrimaryPart.CFrame = chr:WaitForChild("HumanoidRootPart",60).CFrame
			dummy.LoadDummy.Enabled = true
			if ursid and description then
				dummy.Humanoid:ApplyDescription(description)
			end
			basa.MakeDummyCrashable(dummy)
			dummy:WaitForChild("HumanoidRootPart",60).Anchored = false
			if values["dead"] then
				basa.HitBodyPart(dummy.Head,nil,math.huge)
			end
		end
		local result = "Кукла создана!"
		return result
	end
	
	if id == "teleport" then
		for _, plr in pairs(plrs) do
			local tothisplr = GetPlayers(mainplr,values["player"])[1]
			local chr = tothisplr.Character or tothisplr.CharacterAdded:Wait()
			if chr then
				if chr:WaitForChild("HumanoidRootPart",60) then
					local pos = CFrame.new(values["position"])
					if not values["useposition"] then
						pos = chr:WaitForChild("HumanoidRootPart",60).CFrame
					end
					local chr2 = plr.Character or plr.CharacterAdded:Wait()
					chr2:WaitForChild("HumanoidRootPart",60).CFrame = pos
					print("S-Admin: Игрок ["..plr.Name.." ("..plr.UserId..")] телепортирован к ["..tothisplr.Name.." ("..tothisplr.UserId..")]")
				else
					return "Игрок не найден на карте!"
				end
			else
				return "Игрок не найден на карте!"
			end
		end
		return "Игрок телепортирован!"
	end
	
	if id == "restart" then
		if values["accept"] then
			local holiday = values["holiday"]
			local ts = game:GetService("TeleportService")
			local mainadmins = ""
			for _, adm in pairs(ss.ADMINS:GetChildren()) do
				if adm.Value == false then
					mainadmins = mainadmins..","..adm.Name
				end
			end
			mainadmins = mainadmins.."/"
			for _, adm in pairs(ss.ADMINS:GetChildren()) do
				if adm.Value == true then
					mainadmins = mainadmins..","..adm.Name
				end
			end
			ts:TeleportToPublicServer(14962866339,ts:ReserveServer(14962866339),plrservice:GetPlayers(),nil,{mainadmins,holiday})
			return "Сервер перезапускается..."
		else
			return "Вы не подтвердили!"
		end
	end
	
	if id == "hurt" then
		local all = (values["part"] == "All")
		values["power"] = math.abs(tonumber(math.min(math.max(values["power"],0.01) ,1000))::number)
		
		if values["dummys"] then
			for _, dummy in pairs(game.Workspace.CreatedObjects:GetChildren()) do
				if dummy:FindFirstChildOfClass("Humanoid") then
					if all then
						values["power"] = math.abs(tonumber(math.min(math.max(values["power"],0.01) ,1000))::number)
						basa.HitBodyPart(dummy:WaitForChild("Head",60),values["type"],values["power"])
						basa.HitBodyPart(dummy:WaitForChild("Torso",60),values["type"],values["power"])
						basa.HitBodyPart(dummy:WaitForChild("Right Arm",60),values["type"],values["power"])
						basa.HitBodyPart(dummy:WaitForChild("Left Arm",60),values["type"],values["power"])
						basa.HitBodyPart(dummy:WaitForChild("Right Leg",60),values["type"],values["power"])
						basa.HitBodyPart(dummy:WaitForChild("Left Leg",60),values["type"],values["power"])
					else
						local part_d = dummy:WaitForChild(values["part"],60)
						basa.HitBodyPart(part_d,values["type"],values["power"])
					end
				end
			end
		else
			for _, plr in pairs(plrs) do
				local chr = plr.Character or plr.CharacterAdded:Wait()

				if all then
					basa.HitBodyPart(chr:WaitForChild("Head",60),values["type"],values["power"])
					basa.HitBodyPart(chr:WaitForChild("Torso",60),values["type"],values["power"])
					basa.HitBodyPart(chr:WaitForChild("Right Arm",60),values["type"],values["power"])
					basa.HitBodyPart(chr:WaitForChild("Left Arm",60),values["type"],values["power"])
					basa.HitBodyPart(chr:WaitForChild("Right Leg",60),values["type"],values["power"])
					basa.HitBodyPart(chr:WaitForChild("Left Leg",60),values["type"],values["power"])
				else
					local part = chr:WaitForChild(values["part"],60)
					basa.HitBodyPart(part,values["type"],values["power"])
				end

				print("S-Admin: Нанесён урон игроку ["..plr.Name.." ("..plr.UserId..")] типа ["..values["type"].."] с силой ["..values["power"].."] в ["..values["part"].."]")
			end
		end
		
		return "Урон нанесён!"
	end
	
	if id == "turnlight" then
		local bool = values["turn"]

		for _, switch in pairs(game.Workspace:GetDescendants()) do
			if switch.Name == "LightSwitch" then
				switch.Turn:Fire(bool)
				basa.Switch(switch.LightID.Value,bool)
			end
		end

		local result = "Свет везде выключен!"
		if bool then
			result = "Свет везде включен!"
			print("S-Admin: Свет во всём комплексе включен!")
		else
			print("S-Admin: Свет во всём комплексе выключен!")
		end
		return result
	end
	
	if id == "emergency" then
		local bool = values["turn"]

		lab.ChangeEmergency(bool)

		local result = "Аварийная ситуация выключена!"
		if bool then
			result = "Аварийная ситуация включена!"
		end
		return result
	end
	
	if id == "randsceneskin" then
		rs.RandScene:Fire(values["random"])
		return "Окраска комплекса изменена!"
	end

	if id == "getposition" then
		local plr = plrs[1]
		local chr = plr.Character or plr.CharacterAdded:Wait()
		local humbase = chr:WaitForChild("HumanoidRootPart",60).Position
		local function f(i)
			i *= 10
			i = math.round(i)
			return i/10
		end
		return "Позиция ("..f(humbase.x)..","..f(humbase.y)..","..f(humbase.z)..")"
	end
	
	if id == "setliquid" then
		local liquid = values["liquid"]
		local plr = plrs[1]
		local chr = plr.Character or plr.CharacterAdded:Wait()
		if chr:FindFirstChildOfClass("Tool") then
			local tool = chr:FindFirstChildOfClass("Tool")
			if tool:FindFirstChild("LiquidInsert") then
				if tool:FindFirstChild("LiquidInsert").Value == liquid then return "Такая жидкость уже налита!" end
				tool:FindFirstChild("LiquidInsert").Value = liquid
				print("S-Admin: Жидкость ["..liquid.."] налита игроку ["..plr.Name.." ("..plr.UserId..")] в ["..tool.Name.."]")
				return "Жидкость налита!"
			else
				return "Нельзя налить жидкость в этот предмет!"
			end
		else
			return "Отсутствует контейнер для жидкости!"
		end
	end
	
	if id == "setplayerdata" then
		local name = values["name"]
		local val = values["value"]
		val = tonumber(val)
		if val == nil then
			return "Внесено не число!"
		end
		val = math.clamp(val,0,100)
		
		for _, plr in pairs(plrs) do
			local chr = plr.Character or plr.CharacterAdded:Wait()
			
			if name == "Здоровье" then
				sethealth(chr:WaitForChild("Torso",60),chr:WaitForChild("Torso",60):WaitForChild("HealthMax",60).Value*(val/100))
				sethealth(chr:WaitForChild("Head",60),chr:WaitForChild("Head",60):WaitForChild("HealthMax",60).Value)
				sethealth(chr:WaitForChild("Left Arm",60),chr:WaitForChild("Left Arm",60):WaitForChild("HealthMax",60).Value)
				sethealth(chr:WaitForChild("Right Arm",60),chr:WaitForChild("Right Arm",60):WaitForChild("HealthMax",60).Value)
				sethealth(chr:WaitForChild("Left Leg",60),chr:WaitForChild("Left Leg",60):WaitForChild("HealthMax",60).Value)
				sethealth(chr:WaitForChild("Right Leg",60),chr:WaitForChild("Right Leg",60):WaitForChild("HealthMax",60).Value)
			elseif name == "Стамина" then
				rs.Player.SetValue:FireClient(plr,"Stamina",val)
			elseif name == "Отравление" then
				rs.Player.SetValue:FireClient(plr,"Poison",val)
			elseif name == "Опьянение" then
				rs.Player.SetValue:FireClient(plr,"Drunk",val)
			elseif name == "Паралич" then
				rs.Player.SetValue:FireClient(plr,"Drinks.Paralize",val)
			end
			
			print("S-Admin: Установлено ["..name.."] на ["..val.."] у игрока ["..plr.Name.." ("..plr.UserId..")]!")
		end
		return "Данные изменены!"
	end
end

rs.PlayCommand.OnServerInvoke = function(plr,selectedplr,id,values)
	if basa.CheckAdmin(plr.UserId) == false then print("S-Admin: Игрок ["..plr.Name.." ("..plr.UserId..")] Использует Админ Панель без Админки! Возможно Эксплойт!") return "" end  
	
	if #selectedplr == 0 then
		print("S-Admin: Админ ["..plr.Name.." ("..plr.UserId..")] Активирует Комманду ["..id.."]")
	elseif #selectedplr == 1 then
		print("S-Admin: Админ ["..plr.Name.." ("..plr.UserId..")] Активирует Комманду ["..id.."] для Игрока ["..selectedplr[1].Name.." ("..selectedplr[1].UserId..")]")
	elseif #selectedplr == #plrservice:GetPlayers()-1 then
		print("S-Admin: Админ ["..plr.Name.." ("..plr.UserId..")] Активирует Комманду ["..id.."] для ВСЕХ кроме вызывающего")
	else
		print("S-Admin: Админ ["..plr.Name.." ("..plr.UserId..")] Активирует Комманду ["..id.."] для ВСЕХ")
	end
	local date = os.date("!*t")
	local hour = tostring((date.hour+3)%24)
	local minute = tostring(date.min)
	local second = tostring(date.sec)
	if string.len(minute) == 1 then
		minute = "0"..minute
	end
	if string.len(second) == 1 then
		second = "0"..second
	end
	return hour..":"..minute..":"..second.." >"..Command(plr,selectedplr,id,values)
	
end