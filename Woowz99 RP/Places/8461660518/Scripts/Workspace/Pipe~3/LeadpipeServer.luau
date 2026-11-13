--By Rufus14, inspired by leadpipe melee from R2DA
--[[
	Featuring:
	NPC Concussion
	Melee immunity (u cant be damaged while attacking and your humanoid changes name)
	--
	Each hit makes player's screen 90% whiter,
	Stuns characters
]]--
canattack = true
cananimate = true
attackanim = 0
sine = 0
range = 3
tool = script.Parent
ball = tool.Ball
handle = tool.Handle
swooshsound = handle.Swoosh
metalhit = handle.MetalHit
swooshsound2 = handle.Swoosh2
metalhit2 = handle.MetalHit2
hitsound = handle.Hit
step = game:GetService("RunService").Stepped
owner = nil
function equip()
	tool = script.Parent
	owner = tool.Parent
	local leftarm = Instance.new("Weld", owner.Torso)
	leftarm.Part0 = owner.Torso
	leftarm.Part1 = owner["Left Arm"]
	leftarm.C0 = CFrame.new(-1.5,0.5,0)
	leftarm.C1 = CFrame.new(0,0.5,0)
	leftarm.Name = "LeftArmWelde"
	local rightarm = Instance.new("Weld", owner.Torso)
	rightarm.Part0 = owner.Torso
	rightarm.Part1 = owner["Right Arm"]
	rightarm.C0 = CFrame.new(1.5,0.5,0)
	rightarm.C1 = CFrame.new(0,0.5,0)
	rightarm.Name = "RightArmWelde"
	local head = Instance.new("Weld", owner.Torso)
	head.Part0 = owner.Torso
	head.Part1 = owner.Head
	head.C0 = CFrame.new(0,1,0)
	head.C1 = CFrame.new(0,-0.5,0)
	head.Name = "HeadWelde"
	local humanoidrootpart = Instance.new("Weld", owner.HumanoidRootPart)
	humanoidrootpart.Part0 = owner.HumanoidRootPart
	humanoidrootpart.Part1 = owner.Torso
	humanoidrootpart.Name = "HumanoidRootPartWelde"
	local pipeweld = owner["Right Arm"]:WaitForChild("RightGrip")
	pipeweld.C0 = CFrame.new(-1.33580685, -1.09495306, -0.391068697, 0.96628654, 0.230114311, -0.115489528, 0.127946258, -0.0399156809, 0.990977526, 0.223428279, -0.972344756, -0.0680122375)
	local function checkanim()
		while tool.Parent.ClassName ~= "Backpack" and tool.Parent.ClassName ~= "Workspace" and tool.Parent ~= nil and step:wait() do
			sine = sine + 1
			if cananimate then
				pipeweld.C0 = pipeweld.C0:lerp(CFrame.new(-1.33580685, -1.09495306, -0.391068697, 0.96628654, 0.230114311, -0.115489528, 0.127946258, -0.0399156809, 0.990977526, 0.223428279, -0.972344756, -0.0680122375),0.2)
				humanoidrootpart.C0 = humanoidrootpart.C0:lerp(CFrame.new(0,0,0),0.2)
				rightarm.C0 = rightarm.C0:lerp(CFrame.new(1.5,0.5,0) * CFrame.fromEulerAnglesXYZ(math.rad(45 + (3*math.sin(sine/60))),math.rad(-2.5)+math.sin(sine/60)/15,math.rad(-10) + math.rad(math.sin(sine/60))),0.2)
				leftarm.C0 = leftarm.C0:lerp(CFrame.new(-1.5,0.5,0) * CFrame.fromEulerAnglesXYZ(math.rad(55 + (3*math.sin(sine/60))),0,math.rad(10) + math.rad(-math.sin(sine/60))),0.2)
				head.C0 = head.C0:lerp(CFrame.new(0,1,0) * CFrame.fromEulerAnglesXYZ(math.rad(math.sin(sine/60)),0,0),0.2)
			end
		end
	end
	spawn(checkanim)
end
attacknumber = 0
function swing()
	if canattack then
		cananimate = false
		canattack = false
		owner:findFirstChildOfClass("Humanoid").Name = "Immunity"
		local hp = owner:findFirstChildOfClass("Humanoid").Health
		local function immunity()
			while not cananimate do
				owner:findFirstChildOfClass("Humanoid").Health = hp
				step:wait()
			end
			for i = 1,100 do
				owner:findFirstChildOfClass("Humanoid").Health = hp
				step:wait()
			end
			if cananimate then
				owner:findFirstChildOfClass("Humanoid").Name = "Humanoid"
			end
		end
		spawn(immunity)
		if attacknumber == 0 then
			attacknumber = 1
			local swingrand = math.random(-50,50)
			for i = 0,1 , 0.14 do
				if owner:findFirstChild("HumanoidRootPart") then
					if owner.HumanoidRootPart:findFirstChild("HumanoidRootPartWelde") then
						local humweld = owner.HumanoidRootPart:findFirstChild("HumanoidRootPartWelde")
						humweld.C0 = humweld.C0:lerp(CFrame.new(0, 0, 0, 0.33682403, 0.0593911596, -0.939692616, -0.173648149, 0.98480773, 0, 0.925416529, 0.163175896, 0.342020094),i)
					end
				end
				if owner:findFirstChild("Right Arm") then
					if owner["Right Arm"]:findFirstChild("RightGrip") then
						if owner["Right Arm"].RightGrip.Part1 == handle then
							owner["Right Arm"].RightGrip.C0 = owner["Right Arm"].RightGrip.C0:lerp(CFrame.new(-0.0920391083, -1.25493407, -1.08148742, 0.0278200079, 0.997889102, 0.0586810894, 0.0716719925, -0.0605439581, 0.995588958, 0.997040212, -0.0234915055, -0.0732050538),i)
						end
					end
				end
				if owner:findFirstChild("Torso") then
					if owner.Torso:findFirstChild("RightArmWelde") then
						owner.Torso:findFirstChild("RightArmWelde").C0 = owner.Torso:findFirstChild("RightArmWelde").C0:lerp(CFrame.new(0,-0.1,0) * CFrame.new(1.43301249, 0.884340763, -0.405934334, 0.866025448, 7.4505806e-09, -0.499999762, -0.171009988, -0.939692438, -0.296198189, -0.469846129, 0.342020154, -0.813797832) * CFrame.fromEulerAnglesXYZ(0,math.rad(swingrand),0),i)
					end
					if owner.Torso:findFirstChild("LeftArmWelde") then
						owner.Torso:findFirstChild("LeftArmWelde").C0 = owner.Torso:findFirstChild("LeftArmWelde").C0:lerp(CFrame.new(0.5,0.5,0) * CFrame.new(-1.96153116, 0.131953716, 0, 0.766044378, 0.642787516, -2.98023224e-08, -0.642787516, 0.766044378, 0, -2.98023224e-08, 1.49011612e-08, 0.99999994),i)
					end
					if owner.Torso:findFirstChild("HeadWelde") then
						owner.Torso:findFirstChild("HeadWelde").C0 = owner.Torso:findFirstChild("HeadWelde").C0:lerp(CFrame.new(0,-0.5,0) * CFrame.new(-0.0815877914, 1.49240351, -0.0296964645, 0.342020094, -0.163175687, 0.92541647, -1.45519152e-09, 0.98480773, 0.17364797, -0.939692557, -0.0593911, 0.336824089),i)
					end
				end
				step:wait()
			end
			swooshsound2.Pitch = 1 + math.random(-2,2)/10
			swooshsound2:Play()
			swooshsound.Pitch = 1 + math.random(-2,2)/10
			swooshsound:Play()
			for i = 0,1 , 0.1 do
				if owner:findFirstChild("HumanoidRootPart") then
					if owner.HumanoidRootPart:findFirstChild("HumanoidRootPartWelde") then
						local humweld = owner.HumanoidRootPart:findFirstChild("HumanoidRootPartWelde")
						humweld.C0 = humweld.C0:lerp(CFrame.new(0, 0, 0, 0.645385742, -0.0593911596, 0.761544466, -0.0868240744, 0.98480767, 0.150383741, -0.758906364, -0.163175881, 0.630424261),i)
					end
				end
				if owner:findFirstChild("Right Arm") then
					if owner["Right Arm"]:findFirstChild("RightGrip") then
						if owner["Right Arm"].RightGrip.Part1 == handle then
							owner["Right Arm"].RightGrip.C0 = owner["Right Arm"].RightGrip.C0:lerp(CFrame.new(-0.0920391083, -1.25493407, -1.08148742, 0.0278200079, 0.997889102, 0.0586810894, 0.0716719925, -0.0605439581, 0.995588958, 0.997040212, -0.0234915055, -0.0732050538),i)
						end
					end
				end
				if owner:findFirstChild("Torso") then
					if owner.Torso:findFirstChild("RightArmWelde") then
						owner.Torso:findFirstChild("RightArmWelde").C0 = owner.Torso:findFirstChild("RightArmWelde").C0:lerp(CFrame.new(0,0.4,0.3) * CFrame.new(1.88293552, 0.2333498, -0.433140755, 0.859446883, -0.503111184, -0.0907213986, 0.308427513, 0.651808023, -0.692833483, 0.407705337, 0.567472816, 0.715367913) * CFrame.fromEulerAnglesXYZ(0,math.rad(swingrand),0),i)
					end
					if owner.Torso:findFirstChild("LeftArmWelde") then
						owner.Torso:findFirstChild("LeftArmWelde").C0 = owner.Torso:findFirstChild("LeftArmWelde").C0:lerp(CFrame.new(0.5,0.5,0) * CFrame.new(-1.96153116, 0.131953716, 0, 0.766044378, 0.642787516, -2.98023224e-08, -0.642787516, 0.766044378, 0, -2.98023224e-08, 1.49011612e-08, 0.99999994),i)
					end
					if owner.Torso:findFirstChild("HeadWelde") then
						owner.Torso:findFirstChild("HeadWelde").C0 = owner.Torso:findFirstChild("HeadWelde").C0:lerp(CFrame.new(0,-0.5,0) * CFrame.new(-0.0406684875, 1.4979527, 0.0197181702, 0.649181902, -0.0813359022, -0.756272018, 0.0229108427, 0.995905817, -0.0874414966, 0.76028806, 0.0394386649, 0.648387671),i)
					end
				end
				step:wait()
			end
			for i,v in pairs(workspace:GetChildren()) do
				if v.ClassName == "Model" and v ~= owner then
					local headdd = v:findFirstChild("Head")
					local humanoiddd = v:findFirstChildOfClass("Humanoid")
					if humanoiddd and headdd then
						if (headdd.Position - ball.Position).magnitude <= range then
							humanoiddd.Health = humanoiddd.Health - math.random(20,25)
							hitsound.Pitch = 1 + math.random(-2,2)/10
							hitsound:Play()
							metalhit2.Pitch = 1 + math.random(-2,2)/10
							metalhit2:Play()
							metalhit.Pitch = 1 + math.random(-2,2)/10
							metalhit.TimePosition = 1
							metalhit:Play()
							headdd.CFrame = CFrame.new(headdd.Position, owner.Head.Position)
							headdd.CFrame = headdd.CFrame * CFrame.fromEulerAnglesXYZ(0.3,0,0)
							humanoiddd.PlatformStand = true
							local velocity = Instance.new("BodyVelocity", headdd)
							velocity.MaxForce = Vector3.new(math.huge,0,math.huge)
							velocity.Velocity = owner.HumanoidRootPart.CFrame.lookVector * 10
							game.Debris:AddItem(velocity,0.3)
							local function gothit()
								if not game:GetService("Players"):findFirstChild(humanoiddd.Parent.Name) then
									local boolvalue = Instance.new("BoolValue", humanoiddd.Parent)
									boolvalue.Name = "owieConcussed"
									if not headdd:findFirstChild("Textr") then
										-- Farewell Infortality.
										-- Version: 2.82
										-- Instances:
										local Text = Instance.new("BillboardGui")
										local Name = Instance.new("TextLabel")
										--Properties:
										Text.Name = "Textr"
										Text.Parent = headdd
										Text.Size = UDim2.new(2, 0, 2, 0)
										Text.StudsOffset = Vector3.new(-4, 3, 0)
										
										Name.Name = "Name"
										Name.Parent = Text
										Name.BackgroundTransparency = 1
										Name.Size = UDim2.new(5, 0, 1, 0)
										Name.Font = Enum.Font.Cartoon
										Name.Text = "(Concussed)"
										Name.TextColor3 = Color3.new(1, 1, 1)
										Name.TextScaled = true
										Name.TextWrapped = true
									end
									local function walkaround()
										while v:findFirstChild("owieConcussed") do
											local therandom1 = math.random(-15,15)
											local therandom2 = math.random(-15,15)
											local randomstop = math.random(80,140)
											for i = 1,randomstop do
												humanoiddd.WalkToPoint = Vector3.new(headdd.Position.x + therandom1,0,headdd.Position.z + therandom2)
												step:wait()
											end
										end
										if headdd:findFirstChild("Textr") then
											headdd:findFirstChild("Textr"):destroy()
										end
									end
									spawn(walkaround)
									game.Debris:AddItem(boolvalue, 15)
								else
									local flashedplr = game:GetService("Players"):findFirstChild(humanoiddd.Parent.Name)
									if v == flashedplr.Character then
										local dead = Instance.new("ScreenGui")
										local ringing = Instance.new("Sound", dead)
										local Frame = Instance.new("Frame")
										game.Debris:AddItem(dead,10)
										--Properties:
										dead.Name = "dead"
										dead.Parent = flashedplr:findFirstChildOfClass("PlayerGui")
										dead.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
										
										Frame.Parent = dead
										Frame.BackgroundColor3 = Color3.new(255,255,255)
										Frame.Size = UDim2.new(1, 0, 1, 36)
										Frame.BackgroundTransparency = 0.1
										Frame.Position = Frame.Position + UDim2.new(0,0,0,-36)
										
										ringing.SoundId = "rbxassetid://152736435"
										ringing.Volume = 0.05
										ringing.Looped = true
										ringing:Play()
										local function waitfordisapear()
											wait(7)
											for i = 1,150 do
												ringing.Volume = ringing.Volume - 0.001
												Frame.BackgroundTransparency = Frame.BackgroundTransparency + 0.02
												wait()
											end
											dead:destroy()
										end
										spawn(waitfordisapear)
									else
										local boolvalue = Instance.new("BoolValue", humanoiddd.Parent)
										boolvalue.Name = "owieConcussed"
										if not headdd:findFirstChild("Textr") then
											-- Farewell Infortality.
											-- Version: 2.82
											-- Instances:
											local Text = Instance.new("BillboardGui")
											local Name = Instance.new("TextLabel")
											--Properties:
											Text.Name = "Textr"
											Text.Parent = headdd
											Text.Size = UDim2.new(2, 0, 2, 0)
											Text.StudsOffset = Vector3.new(-4, 3, 0)
											
											Name.Name = "Name"
											Name.Parent = Text
											Name.BackgroundTransparency = 1
											Name.Size = UDim2.new(5, 0, 1, 0)
											Name.Font = Enum.Font.Cartoon
											Name.Text = "(Concussed)"
											Name.TextColor3 = Color3.new(1, 1, 1)
											Name.TextScaled = true
											Name.TextWrapped = true
										end
										local function walkaround()
											while v:findFirstChild("owieConcussed") do
												local therandom1 = math.random(-15,15)
												local therandom2 = math.random(-15,15)
												local randomstop = math.random(80,140)
												for i = 1,randomstop do
													humanoiddd.WalkToPoint = Vector3.new(headdd.Position.x + therandom1,0,headdd.Position.z + therandom2)
													step:wait()
												end
											end
											if headdd:findFirstChild("Textr") then
												headdd:findFirstChild("Textr"):destroy()
											end
										end
										spawn(walkaround)
										game.Debris:AddItem(boolvalue, 15)
									end
								end
								wait(1.2)
								humanoiddd.PlatformStand = false
							end
							spawn(gothit)
						end
					end
				end
			end
		elseif attacknumber == 1 then
			attacknumber = 0
			local swingrand = math.random(-20,20)
			for i = 0,1 , 0.14 do
				if owner:findFirstChild("HumanoidRootPart") then
					if owner.HumanoidRootPart:findFirstChild("HumanoidRootPartWelde") then
						local humweld = owner.HumanoidRootPart:findFirstChild("HumanoidRootPartWelde")
						humweld.C0 = humweld.C0:lerp(CFrame.new(0, 0, 0, 0.342020303, 0.163175672, 0.925416589, 4.47034836e-08, 0.98480773, -0.17364797, -0.939692557, 0.0593911409, 0.336824268),i)
					end
				end
				if owner:findFirstChild("Right Arm") then
					if owner["Right Arm"]:findFirstChild("RightGrip") then
						if owner["Right Arm"].RightGrip.Part1 == handle then
							owner["Right Arm"].RightGrip.C0 = owner["Right Arm"].RightGrip.C0:lerp(CFrame.new(-0.0920391083, -1.25493407, -1.08148742, 0.0278200079, 0.997889102, 0.0586810894, 0.0716719925, -0.0605439581, 0.995588958, 0.997040212, -0.0234915055, -0.0732050538),i)
						end
					end
				end
				if owner:findFirstChild("Torso") then
					if owner.Torso:findFirstChild("RightArmWelde") then
						owner.Torso:findFirstChild("RightArmWelde").C0 = owner.Torso:findFirstChild("RightArmWelde").C0:lerp(CFrame.new(0,0,0.5) * CFrame.new(1.11058283, 0.534516811, -1.14242649, 0.133022264, 0.395739019, 0.908677936, 0.991084576, -0.0600325875, -0.118940994, 0.00748064928, 0.916398764, -0.400196671) * CFrame.fromEulerAnglesXYZ(0,math.rad(swingrand),0),i)
					end
					if owner.Torso:findFirstChild("LeftArmWelde") then
						owner.Torso:findFirstChild("LeftArmWelde").C0 = owner.Torso:findFirstChild("LeftArmWelde").C0:lerp(CFrame.new(0.5,0.5,0) * CFrame.new(-1.96153116, 0.131953716, 0, 0.766044378, 0.642787516, -2.98023224e-08, -0.642787516, 0.766044378, 0, -2.98023224e-08, 1.49011612e-08, 0.99999994),i)
					end
					if owner.Torso:findFirstChild("HeadWelde") then
						owner.Torso:findFirstChild("HeadWelde").C0 = owner.Torso:findFirstChild("HeadWelde").C0:lerp(CFrame.new(0,-0.5,0) * CFrame.new(-2.38418579e-07, 1.49999952, 9.53674316e-07, 0.49999994, 2.60770321e-08, -0.866025388, -1.02445483e-08, 0.999999821, -3.35276127e-08, 0.866025567, -1.49011612e-08, 0.49999994),i)
					end
				end
				step:wait()
			end
			swooshsound2.Pitch = 1 + math.random(-2,2)/10
			swooshsound2:Play()
			swooshsound.Pitch = 1 + math.random(-2,2)/10
			swooshsound:Play()
			local canhitaaaaaaaaa = true
			for i = 0,1 , 0.1 do
				if i >= 0.5 and canhitaaaaaaaaa then
					canhitaaaaaaaaa = false
					for i,v in pairs(workspace:GetChildren()) do
						if v.ClassName == "Model" and v ~= owner then
							local headdd = v:findFirstChild("Head")
							local humanoiddd = v:findFirstChildOfClass("Humanoid")
							if humanoiddd and headdd then
								if (headdd.Position - ball.Position).magnitude <= range then
									humanoiddd.Health = humanoiddd.Health - math.random(20,25)
									hitsound.Pitch = 1 + math.random(-2,2)/10
									hitsound:Play()
									metalhit2.Pitch = 1 + math.random(-2,2)/10
									metalhit2:Play()
									metalhit.Pitch = 1 + math.random(-2,2)/10
									metalhit.TimePosition = 1
									metalhit:Play()
									headdd.CFrame = CFrame.new(headdd.Position, owner.Head.Position)
									headdd.CFrame = headdd.CFrame * CFrame.fromEulerAnglesXYZ(0.3,0,0)
									humanoiddd.PlatformStand = true
									local velocity = Instance.new("BodyVelocity", headdd)
									velocity.MaxForce = Vector3.new(math.huge,0,math.huge)
									velocity.Velocity = owner.HumanoidRootPart.CFrame.lookVector * 10
									game.Debris:AddItem(velocity,0.3)
									local function gothit()
										if not game:GetService("Players"):findFirstChild(humanoiddd.Parent.Name) then
											local boolvalue = Instance.new("BoolValue", humanoiddd.Parent)
											boolvalue.Name = "owieConcussed"
											if not headdd:findFirstChild("Textr") then
												-- Farewell Infortality.
												-- Version: 2.82
												-- Instances:
												local Text = Instance.new("BillboardGui")
												local Name = Instance.new("TextLabel")
												--Properties:
												Text.Name = "Textr"
												Text.Parent = headdd
												Text.Size = UDim2.new(2, 0, 2, 0)
												Text.StudsOffset = Vector3.new(-4, 3, 0)
												
												Name.Name = "Name"
												Name.Parent = Text
												Name.BackgroundTransparency = 1
												Name.Size = UDim2.new(5, 0, 1, 0)
												Name.Font = Enum.Font.Cartoon
												Name.Text = "(Concussed)"
												Name.TextColor3 = Color3.new(1, 1, 1)
												Name.TextScaled = true
												Name.TextWrapped = true
											end
											local function walkaround()
												while v:findFirstChild("owieConcussed") do
													local therandom1 = math.random(-15,15)
													local therandom2 = math.random(-15,15)
													local randomstop = math.random(80,140)
													for i = 1,randomstop do
														humanoiddd.WalkToPoint = Vector3.new(headdd.Position.x + therandom1,0,headdd.Position.z + therandom2)
														step:wait()
													end
												end
												if headdd:findFirstChild("Textr") then
													headdd:findFirstChild("Textr"):destroy()
												end
											end
											spawn(walkaround)
											game.Debris:AddItem(boolvalue, 15)
										else
											local flashedplr = game:GetService("Players"):findFirstChild(humanoiddd.Parent.Name)
											if v == flashedplr.Character then
												local dead = Instance.new("ScreenGui")
												local ringing = Instance.new("Sound", dead)
												local Frame = Instance.new("Frame")
												game.Debris:AddItem(dead,10)
												--Properties:
												dead.Name = "dead"
												dead.Parent = flashedplr:findFirstChildOfClass("PlayerGui")
												dead.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
												
												Frame.Parent = dead
												Frame.BackgroundColor3 = Color3.new(255,255,255)
												Frame.Size = UDim2.new(1, 0, 1, 36)
												Frame.BackgroundTransparency = 0.1
												Frame.Position = Frame.Position + UDim2.new(0,0,0,-36)
												
												ringing.SoundId = "rbxassetid://152736435"
												ringing.Volume = 0.05
												ringing.Looped = true
												ringing:Play()
												local function waitfordisapear()
													wait(7)
													for i = 1,150 do
														ringing.Volume = ringing.Volume - 0.001
														Frame.BackgroundTransparency = Frame.BackgroundTransparency + 0.02
														wait()
													end
													dead:destroy()
												end
												spawn(waitfordisapear)
											else
												local boolvalue = Instance.new("BoolValue", humanoiddd.Parent)
												boolvalue.Name = "owieConcussed"
												if not headdd:findFirstChild("Textr") then
													-- Farewell Infortality.
													-- Version: 2.82
													-- Instances:
													local Text = Instance.new("BillboardGui")
													local Name = Instance.new("TextLabel")
													--Properties:
													Text.Name = "Textr"
													Text.Parent = headdd
													Text.Size = UDim2.new(2, 0, 2, 0)
													Text.StudsOffset = Vector3.new(-4, 3, 0)
													
													Name.Name = "Name"
													Name.Parent = Text
													Name.BackgroundTransparency = 1
													Name.Size = UDim2.new(5, 0, 1, 0)
													Name.Font = Enum.Font.Cartoon
													Name.Text = "(Concussed)"
													Name.TextColor3 = Color3.new(1, 1, 1)
													Name.TextScaled = true
													Name.TextWrapped = true
												end
												local function walkaround()
													while v:findFirstChild("owieConcussed") do
														local therandom1 = math.random(-15,15)
														local therandom2 = math.random(-15,15)
														local randomstop = math.random(80,140)
														for i = 1,randomstop do
															humanoiddd.WalkToPoint = Vector3.new(headdd.Position.x + therandom1,0,headdd.Position.z + therandom2)
															step:wait()
														end
													end
													if headdd:findFirstChild("Textr") then
														headdd:findFirstChild("Textr"):destroy()
													end
												end
												spawn(walkaround)
												game.Debris:AddItem(boolvalue, 15)
											end
										end
										wait(1.2)
										humanoiddd.PlatformStand = false
									end
									spawn(gothit)
								end
							end
						end
					end
				end
				if owner:findFirstChild("HumanoidRootPart") then
					if owner.HumanoidRootPart:findFirstChild("HumanoidRootPartWelde") then
						local humweld = owner.HumanoidRootPart:findFirstChild("HumanoidRootPartWelde")
						humweld.C0 = humweld.C0:lerp(CFrame.new(0, 0, 0, 0.356122136, 0.10289897, -0.928756654, 0.0610870048, 0.989228606, 0.133022025, 0.932440579, -0.104107097, 0.346000373),i)
					end
				end
				if owner:findFirstChild("Right Arm") then
					if owner["Right Arm"]:findFirstChild("RightGrip") then
						if owner["Right Arm"].RightGrip.Part1 == handle then
							owner["Right Arm"].RightGrip.C0 = owner["Right Arm"].RightGrip.C0:lerp(CFrame.new(-0.0920391083, -1.25493407, -1.08148742, 0.0278200079, 0.997889102, 0.0586810894, 0.0716719925, -0.0605439581, 0.995588958, 0.997040212, -0.0234915055, -0.0732050538),i)
						end
					end
				end
				if owner:findFirstChild("Torso") then
					if owner.Torso:findFirstChild("RightArmWelde") then
						owner.Torso:findFirstChild("RightArmWelde").C0 = owner.Torso:findFirstChild("RightArmWelde").C0:lerp(CFrame.new(0,0.7,0.3) * CFrame.new(1.94078016, 0.420045853, -0.739268303, 0.133022189, -0.718527198, 0.682659388, 0.991084456, 0.0912356675, -0.0970924273, 0.00748063065, 0.689488888, 0.724257588) * CFrame.fromEulerAnglesXYZ(0,math.rad(swingrand),0),i)
					end
					if owner.Torso:findFirstChild("LeftArmWelde") then
						owner.Torso:findFirstChild("LeftArmWelde").C0 = owner.Torso:findFirstChild("LeftArmWelde").C0:lerp(CFrame.new(0.7,0,0) * CFrame.new(-2.05798006, 0.156598568, 9.53674316e-07, 0.50000006, 0.866025329, -5.96046448e-08, -0.86602509, 0.499999821, -1.11758709e-08, -4.47034836e-08, -8.94069672e-08, 1),i)
					end
					if owner.Torso:findFirstChild("HeadWelde") then
						owner.Torso:findFirstChild("HeadWelde").C0 = owner.Torso:findFirstChild("HeadWelde").C0:lerp(CFrame.new(0,-0.5,0) * CFrame.new(0, 1.49999905, 0, 0.342020094, -6.70552254e-08, 0.939692616, -1.10594556e-08, 0.999999702, -6.70552254e-08, -0.939692676, -1.11758709e-08, 0.342019945),i)
					end
				end
				step:wait()
			end
		end
		cananimate = true
		canattack = true
	end
end
tool.Activated:connect(swing)
function unequip()
	if owner.Torso:findFirstChild("LeftArmWelde") then
		owner.Torso:findFirstChild("LeftArmWelde"):destroy()
	end
	if owner.Torso:findFirstChild("RightArmWelde") then
		owner.Torso:findFirstChild("RightArmWelde"):destroy()
	end
	if owner.Torso:findFirstChild("HeadWelde") then
		owner.Torso:findFirstChild("HeadWelde"):destroy()
	end
	if owner["Right Arm"]:findFirstChild("pipeweld") then
		owner["Right Arm"]:findFirstChild("pipeweld"):destroy()
	end
	if owner:findFirstChild("HumanoidRootPart") then
		if owner.HumanoidRootPart:findFirstChild("HumanoidRootPartWelde") then
			owner.HumanoidRootPart:findFirstChild("HumanoidRootPartWelde"):destroy()
		end
	end
end
tool.Unequipped:connect(unequip)
tool.Equipped:connect(equip)