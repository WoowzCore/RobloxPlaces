
repeat
	wait()
until game.Players.LocalPlayer.Character

--// Variables
local L_1_ = game.Players.LocalPlayer
local L_2_ = L_1_.Character
local L_3_ = L_1_:GetMouse()
local L_4_ = script:WaitForChild('EnginePart').Value.Parent.Parent

local L_5_ = L_4_:WaitForChild('Networking')
local L_6_ = L_4_:WaitForChild('Modules')
local L_7_ = require(L_6_:WaitForChild('Config_Module'))

local L_8_ = game:GetService("UserInputService")
local L_9_ = game:GetService("RunService").RenderStepped

local L_10_ = script:WaitForChild('EnginePart').Value
local L_11_ = L_10_:WaitForChild('BodyPosition')
local L_12_ = L_10_:WaitForChild('BodyGyro')
local L_13_ = L_4_:WaitForChild('Required')

local L_14_ = false
local L_15_ = true
local L_16_ = false
local L_17_ = false

local L_18_ = L_7_.RocketAmmo

local L_19_ = false
local L_20_ = false
local L_21_ = false
local L_22_ = false
local L_23_ = false
local L_24_ = false
local L_25_ = true
local L_26_ = true

local L_27_ = true

local L_28_ = L_10_.Position
local L_29_ = L_10_.CFrame
local L_30_

local L_31_ = script:WaitForChild('HeliUI')
local L_32_ = L_31_:WaitForChild('Frame')
local L_33_ = L_32_:WaitForChild('Frame')
local L_34_ = L_33_:WaitForChild('AltDisp')
local L_35_ = L_33_:WaitForChild('StatusDisp')
local L_36_ = L_32_:WaitForChild('Title')
local L_37_ = L_33_:WaitForChild('RocketAmmo')
L_37_.Text = 'ATGs: ' .. L_18_

local L_38_ = workspace:FindFirstChild('BulletModel') or Instance.new('Folder')
L_38_.Parent = workspace

local L_39_ = {
	L_2_,
	L_4_,
	L_38_
}

--// Events
local L_40_ = L_5_:WaitForChild('TurnOff')
local L_41_ = L_5_:WaitForChild('TurnOn')
local L_42_ = L_5_:WaitForChild('DustEvent')
local L_43_ = L_5_:WaitForChild('FXEvent')
local L_44_ = L_5_:WaitForChild('HitEvent')
local L_45_ = L_5_:WaitForChild('DamageEvent')
local L_46_ = L_5_:WaitForChild('CreateOwner')

--// Renders
L_9_:connect(function()
	if not L_15_ then
		L_2_:WaitForChild('Humanoid').Jump = false
	end	
	
	if L_14_ then
		L_34_.Text = 'ALTITUDE: ' .. math.ceil(L_2_:WaitForChild('Torso').Position.Y)		
		
		L_11_.Position = L_28_
		
		if L_27_ then
			L_12_.CFrame = L_3_.Hit * L_29_
			L_30_ = L_3_.Hit
		else
			L_12_.CFrame = L_30_ * L_29_
		end
	end
end)

--// Functions
function TurnOff()
	L_27_ = false
	L_25_ = false
	L_14_ = false
	L_40_:FireServer()
end

function CheckForHumanoid(L_47_arg1)
	local L_48_ = false
	local L_49_ = nil
	if L_47_arg1 then
		if (L_47_arg1.Parent:FindFirstChild("Humanoid") or L_47_arg1.Parent.Parent:FindFirstChild("Humanoid")) then
			L_48_ = true
			if L_47_arg1.Parent:FindFirstChild('Humanoid') then
				L_49_ = L_47_arg1.Parent.Humanoid
			elseif L_47_arg1.Parent.Parent:FindFirstChild('Humanoid') then
				L_49_ = L_47_arg1.Parent.Parent.Humanoid
			end
		else
			L_48_ = false
		end	
	end
	return L_48_, L_49_
end

function Fire(L_50_arg1)
	for L_61_forvar1, L_62_forvar2 in pairs(L_50_arg1:GetChildren()) do
		if L_62_forvar2.Name:sub(1, 7) == 'FlashFX' then
			L_62_forvar2.Enabled = true
		end
	end
	
	delay(1 / 30, function()
		for L_63_forvar1, L_64_forvar2 in pairs(L_50_arg1:GetChildren()) do
			if L_64_forvar2.Name:sub(1, 7) == 'FlashFX' then
				L_64_forvar2.Enabled = false
			end
		end
	end)

	local L_51_ = L_50_arg1.Position
	local L_52_ = L_50_arg1.CFrame.lookVector.unit
	local L_53_ = CFrame.new(L_51_, L_51_ + L_52_)
	
	local L_54_ = Instance.new("Part")
	L_54_.Parent = L_38_
	game.Debris:AddItem(L_54_, 3)
	L_54_.Shape = Enum.PartType.Block
	L_54_.Size = L_7_.BulletSize
	L_54_.Name = "Bullet"
	L_54_.TopSurface = "Smooth"
	L_54_.BottomSurface = "Smooth"
	L_54_.BrickColor = BrickColor.new("Bright green")
	L_54_.Material = "Neon"
	L_54_.CanCollide = false
	L_54_.CFrame = L_50_arg1.CFrame + (L_50_arg1.CFrame.p - L_50_arg1.CFrame.p)
	L_54_.CFrame = CFrame.new(L_50_arg1.CFrame.p, L_50_arg1.CFrame.p + L_52_)
	
	local L_55_ = Instance.new('BodyVelocity', L_54_)
	L_55_.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
	L_55_.P = 10

	L_55_.Velocity = L_52_ * L_7_.BulletSpeed
	
	local L_56_, L_57_, L_58_ = workspace:FindPartOnRayWithIgnoreList(Ray.new(L_50_arg1.Position, L_50_arg1.CFrame.lookVector * L_7_.CastDist), L_39_);
	local L_59_ = Vector3.new(0, 1, 0):Cross(L_58_)
	local L_60_ = math.asin(L_59_.magnitude)
	
	if L_56_ and (L_56_ and L_56_.Transparency >= 1 or L_56_.CanCollide == false) and L_56_.Name ~= 'Right Arm' and L_56_.Name ~= 'Left Arm' and L_56_.Name ~= 'Right Leg' and L_56_.Name ~= 'Left Leg' and L_56_.Name ~= 'Armor' then
		table.insert(L_39_, L_56_)
	end
	
	if L_56_ then
		L_59_ = Vector3.new(0, 1, 0):Cross(L_58_)
		L_60_ = math.asin(L_59_.magnitude) -- division by 1 is redundant
		
		L_43_:FireServer(L_57_)
		
		local L_65_, L_66_ = CheckForHumanoid(L_56_)
		if L_65_ == false then
			local L_67_ = L_44_:InvokeServer(L_57_, L_59_, L_60_, L_58_, "Part", L_56_, 'NonExplosive')
		elseif L_65_ == true then
			local L_68_ = L_44_:InvokeServer(L_57_, L_59_, L_60_, L_58_, "Human", L_56_, 'NonExplosive')
			L_46_:FireServer(L_66_)
			L_45_:FireServer(L_66_, L_7_.BulletDamage)
		end
	end
end

function FireATG(L_69_arg1)
	if L_18_ > 0 then
		L_18_ = L_18_ - 1
		if L_18_ < 0 then
			L_18_ = 0
		end
		
		L_37_.Text = 'ATGs: ' .. L_18_
		
		for L_84_forvar1, L_85_forvar2 in pairs(L_69_arg1:GetChildren()) do
			if L_85_forvar2.Name:sub(1, 7) == 'FlashFX' then
				L_85_forvar2.Enabled = true
			end
		end
		
		delay(1 / 30, function()
			for L_86_forvar1, L_87_forvar2 in pairs(L_69_arg1:GetChildren()) do
				if L_87_forvar2.Name:sub(1, 7) == 'FlashFX' then
					L_87_forvar2.Enabled = false
				end
			end
		end)
	
		local L_70_ = L_69_arg1.Position
		local L_71_ = L_69_arg1.CFrame.lookVector.unit
		local L_72_ = CFrame.new(L_70_, L_70_ + L_71_)
		
		local L_73_ = Instance.new("Part")
		L_73_.Parent = L_38_
		game.Debris:AddItem(L_73_, 10)
		L_73_.Shape = Enum.PartType.Block
		L_73_.Size = L_7_.BulletSize
		L_73_.Name = "Bullet"
		L_73_.TopSurface = "Smooth"
		L_73_.BottomSurface = "Smooth"
		L_73_.BrickColor = BrickColor.new("Bright green")
		L_73_.Material = "Neon"
		L_73_.CanCollide = false
		L_73_.CFrame = L_69_arg1.CFrame + (L_69_arg1.CFrame.p - L_69_arg1.CFrame.p)
		L_73_.CFrame = CFrame.new(L_69_arg1.CFrame.p, L_69_arg1.CFrame.p + L_71_)
		local L_74_ = L_4_:WaitForChild('FX'):WaitForChild('RocketTrail'):clone()
		L_74_.Parent = L_73_
		L_74_.Enabled = true
		
		local L_75_ = Instance.new('BodyVelocity', L_73_)
		L_75_.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
		L_75_.P = 10
	
		L_75_.Velocity = L_71_ * L_7_.BulletSpeed
		
		local L_76_ = L_69_arg1.Position;
		local L_77_ = L_73_.Position;
		local L_78_ = 0
		local L_79_, L_80_, L_81_
		local L_82_
		local L_83_
		
		while true do
			L_9_:wait()
			L_77_ = L_73_.Position;
			L_78_ = L_78_ + (L_77_ - L_76_).magnitude
			L_79_, L_80_, L_81_ = workspace:FindPartOnRayWithIgnoreList(Ray.new(L_76_, (L_77_ - L_76_)), L_39_);
			L_82_ = Vector3.new(0, 1, 0):Cross(L_81_)
			L_83_ = math.asin(L_82_.magnitude) -- division by 1 is redundant
			
			--[[if distance >= config.CastDist then
				Bullet:Destroy()
				break
			end]]--
			
			if L_79_ and (L_79_ and L_79_.Transparency >= 1 or L_79_.CanCollide == false) and L_79_.Name ~= 'Right Arm' and L_79_.Name ~= 'Left Arm' and L_79_.Name ~= 'Right Leg' and L_79_.Name ~= 'Left Leg' and L_79_.Name ~= 'Armor' then
				table.insert(L_39_, L_79_)
			end
			
			if L_79_ then
				L_82_ = Vector3.new(0, 1, 0):Cross(L_81_)
				L_83_ = math.asin(L_82_.magnitude) -- division by 1 is redundant
				
				L_43_:FireServer(L_80_)
				local L_88_ = L_44_:InvokeServer(L_80_, L_82_, L_83_, L_81_, "Part", L_79_, 'Explosive')
				L_73_:Destroy()
				break
			end
		end
	end
end	

--// Connections
L_8_.InputBegan:connect(function(L_89_arg1, L_90_arg2)
	if not L_90_arg2 then
		if L_89_arg1.KeyCode == L_7_.StartupKey then
			if not L_14_ and L_15_ then
				L_15_ = false
				L_35_.Text = 'STATUS: ' .. 'STARTING UP'
				L_41_:FireServer()
				L_10_:WaitForChild('StartUp'):Play()
				wait(L_7_.StartupTime) -- 26.13
				L_10_:WaitForChild('Spin'):Play()
				L_10_:WaitForChild('StartUp'):Stop()
				L_35_.Text = 'STATUS: ' .. 'ONLINE'
				L_14_ = true
				L_36_.Text = L_4_.Name
			else
				TurnOff()
				L_31_:Destroy()
				L_15_ = true
				script:Destroy()
			end	
		end		
		
		if L_14_ then
			if L_89_arg1.KeyCode == L_7_.UpKey and not L_19_ then
				L_19_ = true
				while L_19_ do
					L_9_:wait()				
					L_28_ = L_28_ + L_10_.CFrame.upVector.unit * L_7_.UpSpeed
				end
			end;
			
			if L_89_arg1.KeyCode == L_7_.DownKey and not L_20_ then
				L_20_ = true
				while L_20_ do
					L_9_:wait()				
					L_28_ = L_28_ + L_10_.CFrame.upVector.unit * -L_7_.DownSpeed
				end
			end;
			
			if L_89_arg1.KeyCode == L_7_.ForwardKey and not L_21_ then
				L_21_ = true
				while L_21_ do
					L_9_:wait()
					L_28_ = L_28_ + L_10_.CFrame.lookVector.unit * L_7_.ForwardSpeed
					L_29_ = CFrame.Angles(math.rad(-L_7_.FrontRotation), 0, 0)
				end
				L_29_ = CFrame.Angles(0, 0, 0)
			end;
			
			if L_89_arg1.KeyCode == L_7_.BackwardKey and not L_22_ then
				L_22_ = true
				while L_22_ do
					L_9_:wait()
					L_28_ = L_28_ + L_10_.CFrame.lookVector.unit * -L_7_.BackwardSpeed
					L_29_ = CFrame.Angles(math.rad(L_7_.BackRotation), 0, 0)
				end
				L_29_ = CFrame.Angles(0, 0, 0)
			end;
			
			if L_89_arg1.KeyCode == L_7_.RightKey and not L_23_ then
				L_23_ = true
				while L_23_ do
					L_9_:wait()
					L_28_ = L_28_ + L_10_.CFrame.rightVector.unit * L_7_.RightSpeed
					L_29_ = CFrame.Angles(0, 0, math.rad(-L_7_.RightRotation))
				end
				L_29_ = CFrame.Angles(0, 0, 0)
			end;
			
			if L_89_arg1.KeyCode == L_7_.LeftKey and not L_24_ then
				L_24_ = true
				while L_24_ do
					L_9_:wait()
					L_28_ = L_28_ + L_10_.CFrame.rightVector.unit * -L_7_.LeftSpeed
					L_29_ = CFrame.Angles(0, 0, math.rad(L_7_.LeftRotation))
				end
				L_29_ = CFrame.Angles(0, 0, 0)
			end;
			
			if L_89_arg1.UserInputType == L_7_.MouseToggleKey and L_25_ then
				if not L_27_ then
					L_27_ = true
				else
					L_27_ = false
				end
			end;
			
			if L_89_arg1.KeyCode == Enum.KeyCode.C and not L_16_ then
				L_16_ = true
				while L_16_ do
					for L_91_forvar1, L_92_forvar2 in pairs(L_4_:WaitForChild('Weaponry'):GetChildren()) do
						if L_92_forvar2:IsA('BasePart') and L_92_forvar2.Name == 'MG' then
							L_92_forvar2.Fire:Play()
							spawn(function ()
								Fire(L_92_forvar2)
							end)
						end
					end
					wait(60 / L_7_.FireRate)
				end
			end;
			
			if L_89_arg1.KeyCode == Enum.KeyCode.F and not L_17_ and L_26_ and L_18_ > 0 then
				L_17_ = true
				while L_17_ and L_26_ and L_18_ > 0 do
					for L_93_forvar1, L_94_forvar2 in pairs(L_4_:WaitForChild('Weaponry'):GetChildren()) do
						if L_94_forvar2:IsA('BasePart') and L_94_forvar2.Name == 'ATG' then
							L_94_forvar2.Fire:Play()
							spawn(function ()
								FireATG(L_94_forvar2)
							end)
						end
					end
					L_26_ = false
					wait(60 / L_7_.RocketFireRate)
					L_26_ = true
				end
			end;
		end
	end;
end)

L_8_.InputEnded:connect(function(L_95_arg1, L_96_arg2)
	if not L_96_arg2 then
		if L_95_arg1.KeyCode == L_7_.UpKey and L_19_ then
			L_19_ = false
		end;
		
		if L_95_arg1.KeyCode == L_7_.DownKey and L_20_ then
			L_20_ = false
		end;
		
		if L_95_arg1.KeyCode == L_7_.ForwardKey and L_21_ then
			L_21_ = false
		end;
		
		if L_95_arg1.KeyCode == L_7_.BackwardKey and L_22_ then
			L_22_ = false
		end;
		
		if L_95_arg1.KeyCode == L_7_.RightKey and L_23_ then
			L_23_ = false
		end;
		
		if L_95_arg1.KeyCode == L_7_.LeftKey and L_24_ then
			L_24_ = false
		end;
		
		if L_95_arg1.KeyCode == Enum.KeyCode.C and L_16_ then
			L_16_ = false
			for L_97_forvar1, L_98_forvar2 in pairs(L_4_:WaitForChild('Weaponry'):GetChildren()) do
				if L_98_forvar2:IsA('BasePart') and L_98_forvar2.Name == 'MG' then
					L_98_forvar2.Fire:Stop()
				end
			end
		end;
		
		if L_95_arg1.KeyCode == Enum.KeyCode.F and L_17_ then
			L_17_ = false
		end;
	end
end)

L_2_:WaitForChild('Humanoid').Died:connect(function()
	TurnOff()
	L_31_:Destroy()
	L_15_ = true
	script:Destroy()
end)

L_8_.JumpRequest:connect(function()
	if L_15_ then
		if L_1_.PlayerGui:FindFirstChild('Heli_Control') then
			L_1_.PlayerGui['Heli_Control']:Destroy()
		end
	end
end)