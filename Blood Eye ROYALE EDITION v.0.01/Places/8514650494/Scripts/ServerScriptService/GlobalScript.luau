local RS = game.ReplicatedStorage

local function SetValue(player,name,value)
	local v = player.PlayerStarter.Values
	local v2 = v:FindFirstChild(name)
	if value == nil then
		warn("Value ["..name.."] got nil value!")
	end
	v2.Value = value
end

local function SetGlobalValue(name,value)
	local v = game.Workspace.Files.GlobalValue
	local v2 = v:FindFirstChild(name)
	if value == nil then
		warn("Value ["..name.."] got nil value!")
	end
	v2.Value = value
end

local function LoadValue(player,name)
	local v = player.PlayerStarter.Values
	return v:FindFirstChild(name).Value
end

local function LoadScript(player,name)
	local s = player.PlayerStarter.Values.Scripts
	local scr = s:FindFirstChild(name)
	scr.Value = true
	
end
local function ClearAllScripts(player)
	local scripts = player.PlayerStarter.Values.Scripts--player:WaitForChild('PlayerGui').Game--PlayerStarter.InPlayerScripts
	for i, s in pairs(scripts:GetChildren()) do
		if s then
			--s:Destroy()
			s.Value = false
			--s.Disabled = true
		end
	end
end

local GetMusicStartR = 8
local function GetMusicStart(music)
	local id = ""
	local volume = 0.5
	print("Load Music [Start] : "..music)
	
	if music == 0 then
		id = "280839464"--Terraria Ocen
		volume = 0.5
	else if music == 1 then
			id = "7645036006" --Cheshyre Anamnesis
			volume = 0.5
		else if music == 2 then--mrkitty entwine
				id = "6436499360"
				volume = 0.5
			else if music == 3 then--mrkitty mother
					id = "5191357367"
					volume = 0.5
				else if music == 4 then--lukhash code veronica
						id = "6412545630"
						volume = 0.3
					else if music == 5 then--jack stauber al dente
							id = "3188232315"
							volume = 1
						else if music == 6 then--c418 intro
								id = "6893247505"
								volume = 1
							else if music == 7 then--spore space music
									id = "6172687338"
									volume = 2
								else if music == 8 then--spore main menu
										id = "174057384"
										volume = 3
									end
								end
							end
						end
					end
				end
			end
		end
	end
	
	return id, volume
end
local GetMusicEndR = 5
local function GetMusicEnd(music)
	local id = ""
	local volume = 0.5
	print("Load Music [End] : "..music)
	if music == 0 then
		id = "1251551135"--Cheshyre The Legend
		volume = 0.5
	else if music == 1 then
			id = "7214462265"--Cheshyre Madness Train
			volume = 0.5
		else if music == 2 then--Mareux Summertime
				id = "8457617029"
				volume = 1
			else if music == 3 then--mrkitty tt
					id = "5345460751" 
					volume = 0.3
				else if music == 4 then--super meat boy (idk)
						id = "1401893582"
						volume = 0.5
						else if music == 5 then--lukhash spy vs spy c64 live remix
								id = "493205674"
								volume = 0.3
								
						end
					end
				end
			end
		end
	end
	
	return id, volume
end

local function GetRobuxLink(id)
	return "rbxassetid://"..id
end
local function StartMusicPlay(typ,loop,stop)
	local id = ""
	local volume = 0.5--должно быть норм на громкости 20 у компа
	if typ == "Start" then
		id, volume = GetMusicStart(math.random(0,GetMusicStartR))
	else
		id, volume = GetMusicEnd(math.random(0,GetMusicEndR))
	end
	
	
	local musicObj = game.Workspace.Files.GameMusic
	local SoundId = GetRobuxLink(id)
	musicObj.SoundId = SoundId
	musicObj.Volume = volume
	if id == "" or id == nil then
		musicObj.Playing = false
	else
		musicObj.Playing = true
	end
	
	if loop and not stop then
		musicObj.Looped = true
	end
	
	if not stop then
		musicObj.Ended:Connect(function()
			StartMusicPlay(typ,loop,stop)
		end)
	end
	
end

local function StopMusicPlayer()
	local musicObj = game.Workspace.Files.GameMusic
	musicObj.Playing = false
	musicObj.Looped = false
end

local WalkSpeed = 16
local JumpPower = 50
local JumpHeight = 7
local MaxHealth = 100


local GetRandomVariationR = 0
local MapNow = "Map1"
local GameStart = false

local GameType = ""
local GameVariant = ""

---------------------------------------------------

local function R()
	return math.random(0,100)/100
end
local function R2()
	return math.random(-100,100)/100
end

local GetRandomPlayerEventR = 8
local function GetRandomPlayerEvent(i)
	local s = "Nil"

	if i == 0 then
		s = "Nil"--Нету эвента
	else if i == 1 then
			s = "Death"--Смерть
		else if i == 2 then
				s = "Restart"--Полный рестарт игрока
			else if i == 3 then
					s = "Random"--Рандомизация
				else if i == 4 then
						s = "Unknown"--Рандомный эвент
					else if i == 5 then
							s = "FullHP"
						else if i == 6 then
								s = "Damage"
							else if i == 7 then
									s = "Health Up"
								else if i == 8 then
										s = "Jump"
									else if i == 9 then
											s = "Damage_Little"
										else if i == 10 then
												s = "Damage_Middle"
											else if i == 11 then
													s = "Damage_Large"
												else if i == 12 then
														s = "Health Up_Little"
													else if i == 13 then
															s = "Health Up_Middle"
														else if i == 14 then
																s = "Health Up_Large"
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
		end
	end

	return s
end

--(Тип)-(Название)-Описание
--{(Название)-Описание
--(Название)-Описание
--}(Название)-Описание

--(String)-(RunType)-Тип ходьбы
--{(Original)-Обычная ходьба
--(Limit)-Ходьба но с лимитом шагов
--()
--
--
--
--
--
--}
--(String)-(RunExtras)-Допольнительный тип ходьбы
--(Nil)-Отсутствует допольнительный тип ходьбы
--(Run)-Есть возможность быстро бежать
--(Fly)-Есть возможность летать
--
--
--
--
--}
local SetPlayerWalkTypeR = 2
local function SetPlayerWalkType(i)

	local s = "Original"
	if i == 0 then
		s = "Original"
	else if i == 1 then
			s = "Limit"
		else if i == 2 then
				s = "NoMaterial"--Игроку нельзя вставать на материал, иначе евент
			end


		end
	end

	return s

	--1) Просто ходьба
	--2) Просто хобьда но на какую-то клавишу бег (с стаминой и без)
	--3) Ходьба но с лимитом [По истечению шагов что-то происходит]
	--4) Полёт
	--5) [все вар] но с лимитным полётом на клавишу
	--6) 

end

local SetPlayerWalkExtrasTypeR = 3
local function SetPlayerWalkExtrasType(i)
	local s = "Nil"
	if i == 0 then
		s = "Nil"
	else if i == 1 then
			s = "Run"
		else if i == 2 then
				s = "Fly"
			else if i == 3 then
					s = "FlyMore"
				end
			end
		end
	end
	
	return s

end

local function FullRandom(player,max)
	local c = player.Character
	if not c or not c.Parent then
		c = player.CharacterAdded:Wait()
	end
	local hum = c:FindFirstChild("Humanoid")
	
	if R() > max then
		hum.AutoRotate = false
	else
		hum.AutoRotate = true
	end
end

local function MadnessRandom(player,max)
	local c = player.Character
	if not c or not c.Parent then
		c = player.CharacterAdded:Wait()
	end
	local hum = c:FindFirstChild("Humanoid")
	
	
	if R() > 0.5 then
		FullRandom(player,R())
	else
		if R() > max then
			hum.JumpHeight = 0
			hum.JumpPower = 0
		end
	end
end

local function GetRandomMaterial(without)
	local r = math.random(0,34)
	local m = "Grass"
	if r == 0 then
		m = "Plastic"
	else if r == 1 then
			m = "Wood"
		else if r == 2 then
				m = "Slate"
			else if r == 3 then
					m= "Concrete"
				else if r == 4 then
						m = "CorrodedMetal"

					else if r == 5 then
							m = "DiamondPlate"
						else if r == 6 then
								m = "Foil"
							else if r == 7 then
									m = "Grass"
								else if r == 8 then
										m = "Ice"
									else if r == 9 then
											m = "Marble"
										else if r == 10 then
												m = "Granite"
											else if r == 11 then
													m = "Brick"
												else if r == 12 then
														m = "Pebble"
													else if r == 13 then
															m = "Sand"
														else if r == 14 then
																m = "Fabric"
															else if r == 15 then
																	m = "SmoothPlastic"
																else if r == 16 then
																		m = "Metal"
																	else if r == 17 then
																			m = "WoodPlanks"
																		else if r == 18 then
																				m = "Cobblestone"
																			else if r == 19 then
																					m = "Air"
																				else if r == 20 then
																						m = "Rock"
																					else if r == 21 then
																							m = "Glacier"
																						else if r == 22 then
																								m = "Snow"
																							else if r == 23 then
																									m = "Sandstone"
																								else if r == 24 then
																										m = "Mud"
																									else if r == 25 then
																											m = "Basalt"
																										else if r == 26 then
																												m = "Ground"
																											else if r == 27 then
																													m = "CrackedLava"
																												else if r == 28 then
																														m = "Neon"
																													else if r == 29 then
																															m = "Glass"
																														else if r == 30 then
																																m = "Asphalt"
																															else if r == 31 then
																																	m = "LeafyGrass"
																																else if r == 32 then
																																		m = "Salt"
																																	else if r == 33 then
																																			m = "Limestone"
																																		else if r == 34 then
																																				m = "Pavement"
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
									end
								end
							end
						end
					end
				end
			end
		end
	end
	
	if m == without then
		m = GetRandomMaterial(without)
	end
	print(m)
	return m

end

local function SetPlayerDefault(player)
	local c = player.Character or player.CharacterAdded:Wait()
	local hum = c:FindFirstChild("Humanoid")
	
	hum.AutoRotate = true
	hum.WalkSpeed = WalkSpeed
	hum.JumpHeight = JumpHeight
	hum.JumpPower = JumpPower
	hum.MaxHealth = MaxHealth
end

local function SetPlayerStart(player)
	SetPlayerDefault(player)
	local runtype = "Original"
	local runex = "Nil"
	local c = player.Character
	if not c or not c.Parent then
		c = player.CharacterAdded:Wait()
	end
	local hum = c:FindFirstChild("Humanoid")
	hum.AutoRotate = true
	
	
	if GameType == "Real" then
		SetPlayerDefault(player)
		runex = "Run"
		hum.WalkSpeed = 15
		hum.JumpHeight = JumpHeight /2
		hum.JumpPower = JumpPower /2
	end
	
	if GameType == "Nil" then
		SetPlayerDefault(player)

	end
	
	GameType= "Full_Random"
	GameVariant = "Chaos"

	if GameType == "Full_Random" then

		if GameVariant == "Little" then
			hum.WalkSpeed = WalkSpeed + R2()*2
			hum.JumpHeight = JumpHeight + R2()*2
			hum.JumpPower = JumpPower + R2()*2

		else if GameVariant == "Small" then
				hum.WalkSpeed = WalkSpeed + R2()*5
				hum.JumpHeight = JumpHeight + R2()*3
				hum.JumpPower = JumpPower + R2()*3

			else if GameVariant == "Medium" then
					hum.WalkSpeed = WalkSpeed + R2()*5
					hum.JumpHeight = JumpHeight + R2()*3
					hum.JumpPower = JumpPower + R2()*3
					SetValue(player,"MaxStamina",100+R2()*10)
					runex = SetPlayerWalkExtrasType(math.random(0,SetPlayerWalkExtrasTypeR))
				else if GameVariant == "Large" then
						hum.WalkSpeed = WalkSpeed + R2()*5
						hum.JumpHeight = JumpHeight + R2()*5
						hum.JumpPower = JumpPower + R2()*5
						SetValue(player,"MaxStamina",100+R2()*30)
						runex = SetPlayerWalkExtrasType(math.random(0,SetPlayerWalkExtrasTypeR))
						runtype = SetPlayerWalkType(math.random(0,SetPlayerWalkTypeR))
					else if GameVariant == "Madness" then
							FullRandom(player,0.9)
							hum.JumpHeight = JumpHeight + R2()*5
							hum.JumpPower = JumpPower + R2()*5
							hum.WalkSpeed = WalkSpeed + R2()*10
							SetValue(player,"MaxStamina",100+R2()*50)
							runex = SetPlayerWalkExtrasType(math.random(0,SetPlayerWalkExtrasTypeR))
							runtype = SetPlayerWalkType(math.random(0,SetPlayerWalkTypeR))
						else if GameVariant == "Chaos" then
								FullRandom(player,0.5)
								MadnessRandom(player,0.9)
								hum.JumpHeight = JumpHeight + R2()*10
								hum.JumpPower = JumpPower + R2()*10
								hum.WalkSpeed = WalkSpeed + R2()*15
								SetValue(player,"MaxStamina",100+R2()*100)
								runex = SetPlayerWalkExtrasType(math.random(0,SetPlayerWalkExtrasTypeR))
								runtype = SetPlayerWalkType(math.random(0,SetPlayerWalkTypeR))

							else if GameVariant == "Nil" then
									SetPlayerDefault(player)
								end
							end
						end
					end
				end
			end
		end
	end
	if runtype == nil then
		warn("runtype nil")
		runtype = "Original"
	end
	if runex == nil then
		warn("runex nil")
		runex = "Nil"
	end

	
	print(runtype)
	print(runex)
	print(hum.WalkSpeed)
	print(hum.JumpPower)
	print(hum.JumpHeight)
	print(LoadValue(player,"MaxStamina"))
	SetValue(player,"RunType",runtype)
	SetValue(player,"RunExtras",runex)
	SetValue(player,"Stamina",LoadValue(player,"MaxStamina"))
	
	
	if runex == "Fly" or runex == "FlyMore" then
		LoadScript(player,"CanFly")
		SetValue(player,"CanMoreFly",false)
		if runex == "FlyMore" then
			SetValue(player,"CanMoreFly",true)
		end
	end
	
	if runex == "Run" then
		LoadScript(player,"HaveRun")
		if GameType == "Real" then
			SetValue(player,"ShiftSpeedBoost",1.5)
		else
			SetValue(player,"ShiftSpeedBoost",R()*20)
			end
	end
	
	
	if runtype == "NoMaterial" then
		SetValue(player,"CantRunThisMaterial",GetRandomMaterial())
		SetValue(player,"EventPlayerStepMaterial",GetRandomPlayerEvent(math.random(0,GetRandomPlayerEventR)))
		print(LoadValue(player,"EventPlayerStepMaterial"))
		LoadScript(player,"WalkNoMaterial")
	end

end

local function StartRandomPlayerEvent(player,event)
	print(event)
	local c = player.Character or player.CharacterAdded:Wait()
	local hum = c:FindFirstChild("Humanoid")
	local base = c.HumanoidRootPart

	if event == "Death" then
		SetValue(player,"DeathMessange","test")
		hum.Health = 0
	else if event == "Unknown" then
			StartRandomPlayerEvent(player,GetRandomPlayerEvent(math.random(0,GetRandomPlayerEventR)))
		else if event == "Restart" then
				SetPlayerStart(player)
			else if event == "Random" then
					MadnessRandom(player,0.9)
				else if event == "FullHP" then
						hum.Health = hum.MaxHealth
					else if event == "Damage" then
							hum.Health = hum.Health - R()*10
						else if event == "Health Up" then
								hum.Health = hum.Health + R()*10
							else if event == "Jump" then
									hum.Jump = true
								else if event == "Damage_Little" then
										hum.Health = hum.Health - R()*1
									else if event == "Damage_Middle" then
											hum.Health = hum.Health - (R()*5+2)
										else if event == "Damage_Large" then
												hum.Health = hum.Health - (R()*5+5)
											else if event == "Health Up_Little" then
													hum.Health = hum.Health + R()*1
												else if event == "Health Up_Middle" then
														hum.Health = hum.Health + (R()*5+2)
													else if event == "Health Up_Large" then
															hum.Health = hum.Health + (R()*5+5)
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
	end
end
local RS = game.ReplicatedStorage
RS.StartRandomPlayerEvent.OnServerEvent:Connect(StartRandomPlayerEvent)

---------------------------------------------------

local GetRandomTypeR = 2
local function GetRandomType(i)
	local s = "Full_Random"
	if i == 0 then
		s = "Full_Random"
		GetRandomVariationR = 6
	else if i == 1 then
			s = "Nil"
			GetRandomVariationR = 0
		else if i == 2 then
				s = "Real"
				GetRandomVariationR = 0
			end
		end
	end

	GameType = s
	return s
end
local function GetRandomVariation(i,typ)
	local s = ""
	
	if typ == "Nil" then
		if i == 0 then
			s = "Nil"
		end
	end
	
	if typ == "Real" then
		if i == 0 then
			s = "Nil"
		end
	end
	
	
	if typ == "Full_Random" then

		if i == 0 then
			s = "Little"
		else if i == 1 then
				s = "Small"
			else if i == 2 then
					s = "Medium"
				else if i == 3 then
						s = "Large"
					else if i == 4 then
							s = "Madness"
						else if i == 5 then
								s = "Chaos"
							else if i == 6 then
									s = "Nil"
								end
							end
						end
					end
				end
			end
		end

	end

	GameVariant = s
	return s
end

local function SetPlayerSpawn(player)
	local AllSpawners = game.Workspace:FindFirstChild(MapNow).Spawners
	print(AllSpawners.Parent.Name)
	for i, spawner in pairs(AllSpawners:GetChildren()) do
		local haveP = spawner:FindFirstChild("HavePlayer")
		if not haveP then
			if not LoadValue(player,"PlayerHaveSpawner") then

				local HP = Instance.new("IntValue",spawner)
				HP.Name = "HavePlayer"
				HP.Value = player.UserId

				local Sp = spawner
				local Sp2 = Sp.SpawnLocate

				Sp.Material = Enum.Material.Neon
				Sp2.Material = Enum.Material.Neon
				Sp.BrickColor = BrickColor.new(255,0,0)
				Sp2.BrickColor = BrickColor.new(255,0,0)

				SetValue(player,"PlayerHaveSpawner",true)

				local c = player.Character or player.CharacterAdded:Wait()
				local hum = c:FindFirstChild("Humanoid")
				hum.WalkSpeed = 0
				hum.JumpHeight = 0
				hum.JumpPower = 0

				c.HumanoidRootPart.Position = Sp.Position+Vector3.new(0,1,0)
				c.HumanoidRootPart.Orientation = Vector3.new(0,math.random(0,360),0)

				hum.AutoRotate = false
				
				
				
				print("spawn "..player.Name)
			end
		end
	end
end

local function ClearSpawns()
	local spawners = game.Workspace:FindFirstChild(MapNow).Spawners
	for i, spawner in pairs(spawners:GetChildren()) do
		local haveP = spawner:FindFirstChild("HavePlayer")
		if haveP then
			haveP:Destroy()
		end
		local Sp = spawner
		local Sp2 = Sp.SpawnLocate

		Sp.Material = Enum.Material.Neon
		Sp2.Material = Enum.Material.Neon
		Sp.BrickColor = BrickColor.new(0,255,0)
		Sp2.BrickColor = BrickColor.new(0,255,0)

	end
end

local function SetDefaultPlayer(player)
	local c = player.Character or player.CharacterAdded:Wait()
	local hum = c:FindFirstChild("Humanoid")
	SetValue(player,"PlayerPlaying",false)
	SetValue(player,"PlayerHaveSpawner",false)
	ClearAllScripts(player)
	SetValue(player,"DeathMessange","")
	SetValue(player,"ShiftSpeedBoost",1)
	
	SetValue(player,"MaxStamina",100)
	SetValue(player,"Stamina",100)

	SetPlayerDefault(player)

end

local function StopGame()
	GameStart = false
	ClearSpawns()
	for i, player in pairs(game.Players:GetChildren()) do
		SetDefaultPlayer(player)
	end
	StopMusicPlayer()
end

local function LoadGame(typ,var)
	local AllSpawners = game.Workspace:FindFirstChild(MapNow).Spawners
	for i, spawner in pairs(AllSpawners:GetChildren()) do

		local Sp = spawner
		local Sp2 = Sp.SpawnLocate

		Sp.Material = Enum.Material.Plastic
		Sp2.Material = Enum.Material.Plastic
		Sp.BrickColor = BrickColor.DarkGray()
		Sp2.BrickColor = BrickColor.DarkGray()

	end
	
	local musictype = "Start"
	if R() > 0.5 then
		musictype = "End"
	end
	
	StartMusicPlay(musictype,false,false)

	for i, player in pairs(game.Players:GetChildren()) do
		if LoadValue(player,"PlayerPlaying") then
			print(player.Name.." Playing!")
			SetValue(player,"ShowGameInfo",false)
			SetPlayerStart(player)


		end
		print("that all players")


	end


	wait(60)
	StopGame()
end

game:GetService('Players').PlayerAdded:Connect(function(player)
	player.CharacterAdded:Connect(function(character)
		character:WaitForChild("Humanoid").Died:Connect(function()
			print(player.Name)
			SetDefaultPlayer(player)
		end)
	end)
end)

local function StartGame()
	local Type = GetRandomType(math.random(0,GetRandomTypeR))

	local Variation = GetRandomVariation(math.random(0,GetRandomVariationR),Type)
	
	SetGlobalValue("GameType",Type)
	SetGlobalValue("GameVariant",Variation)
	
	for i, player in pairs(game.Players:GetChildren()) do
		SetValue(player,"PlayerPlaying",true)
		SetValue(player,"ShowGameInfo",true)
		SetPlayerSpawn(player)

	end

	print(Type)
	print(Variation)

	wait(10)
	LoadGame(Type,Variation)
end


local PlayerStarter = game.Workspace.Files.PlayerStarter
local function PlayerJoin(player)
	local PS = PlayerStarter:Clone()
	PS.Parent = player
	wait(0.2)
	SetDefaultPlayer(player)
end

game.Players.PlayerAdded:Connect(PlayerJoin)

local function SetPlayingPlayer(player)
	local c = player.Character or player.CharacterAdded:Wait()
	local hum = c:FindFirstChild("Humanoid")
	SetValue(player,"PlayerPlaying",true)
end

local function SetPlayerPlaying(player,bool)
	if bool then
		SetPlayingPlayer(player)
	else
		SetDefaultPlayer(player)
	end
end

while true do
	wait()
	if not GameStart then
		GameStart = true
		wait(20)
		StartGame()
	end
end
