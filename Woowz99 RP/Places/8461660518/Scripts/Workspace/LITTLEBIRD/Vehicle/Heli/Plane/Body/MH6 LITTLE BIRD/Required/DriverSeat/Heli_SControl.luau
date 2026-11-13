--// Variables
local L_1_ = script.Parent
local L_2_ = L_1_.Parent.Parent
local L_3_ = L_2_:WaitForChild('Required')
local L_4_ = L_2_:WaitForChild('BodyKit')

local L_5_ = L_2_:WaitForChild('Networking')
local L_6_ = L_2_:WaitForChild('Vals')
local L_7_ = L_6_:WaitForChild('Owner')

local L_8_ = require(L_2_:WaitForChild('Modules'):WaitForChild('Config_Module'))

local L_9_ = L_3_:WaitForChild('Rotor')
local L_10_
if L_3_:FindFirstChild('Rotor2') then
	L_10_ = L_3_.Rotor2
end
local L_11_ = L_9_:WaitForChild('Top'):WaitForChild('Rotor')
local L_12_ = L_9_:WaitForChild('Bottom'):WaitForChild('Rotor')
local L_13_
local L_14_
if L_10_ then
	L_13_ = L_10_:WaitForChild('Top'):WaitForChild('Rotor')
	L_14_ = L_10_:WaitForChild('Bottom'):WaitForChild('Rotor')
end

local L_15_
local L_16_, L_17_

local L_18_ = false
local L_19_ = L_2_:WaitForChild('FX')

local L_20_ = game.ReplicatedStorage:FindFirstChild('[WB] Leaderstat Network') or nil

local L_21_ = {
	L_2_
}

--// Events
local L_22_ = L_5_:WaitForChild('TurnOff')
local L_23_ = L_5_:WaitForChild('TurnOn')
local L_24_ = L_5_:WaitForChild('DustEvent')
local L_25_ = L_5_:WaitForChild('FXEvent')
local L_26_ = L_5_:WaitForChild('HitEvent')
local L_27_ = L_5_:WaitForChild('DamageEvent')
local L_28_ = L_5_:WaitForChild('CreateOwner')

--// Functions
function Weld(L_31_arg1, L_32_arg2)
	local L_33_ = Instance.new("WeldConstraint", L_31_arg1)
	L_33_.Part0 = L_31_arg1
	L_33_.Part1 = L_32_arg2
	L_33_.Name = L_31_arg1.Name
end

--// Weld Connection
wait(0.5)

local L_29_ = L_2_:GetDescendants()

for L_34_forvar1, L_35_forvar2 in pairs(L_29_) do
	if L_35_forvar2:IsA('BasePart') then
		if L_35_forvar2.Name ~= 'Engine' and L_35_forvar2.Parent ~= L_2_.RegenButton then
			Weld(L_35_forvar2, L_2_.Required.Engine)
		end
	end
end

for L_36_forvar1, L_37_forvar2 in pairs(L_29_) do
	if L_37_forvar2:IsA('BasePart') then
		if L_37_forvar2.Parent ~= L_2_.RegenButton then
			L_37_forvar2.Anchored = false
		end
	end
end

--// Connections
L_1_.ChildAdded:connect(function(L_38_arg1)
	if L_38_arg1:IsA('Weld') then
		local L_39_ = L_38_arg1.Part1.Parent
		local L_40_ = game.Players:GetPlayerFromCharacter(L_39_)
		if not L_8_.isGroupOnly or L_8_.isGroupOnly and L_40_:GetRankInGroup(L_8_.GroupID) >= L_8_.GroupRank then
			L_7_.Value = L_40_
			
			L_2_:WaitForChild('RegenButton'):WaitForChild('Regen'):WaitForChild('CanRegen').Value = false
			
			local L_41_ = L_1_.Parent.Engine:FindFirstChild('BodyGyro') or Instance.new('BodyGyro', L_1_.Parent:WaitForChild('Engine'))
			L_41_.CFrame = L_1_.Parent:WaitForChild('Engine').CFrame
			L_41_.D = 500
			L_41_.P = 3000
			L_41_.MaxTorque = Vector3.new(math.huge, math.huge, math.huge)
			
			local L_42_ = L_1_.Parent.Engine:FindFirstChild('BodyPosition') or Instance.new('BodyPosition', L_1_.Parent:WaitForChild('Engine'))
			L_42_.D = 1250
			L_42_.P = 10000
			L_42_.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
			L_42_.Position = L_1_.Parent:WaitForChild('Engine').Position
			
			if L_40_ then
				local L_43_ = script:WaitForChild('Heli_Control'):clone()
				L_43_.Parent = L_40_.PlayerGui
				L_43_:WaitForChild('EnginePart').Value = L_1_.Parent:WaitForChild('Engine')
				L_43_.Disabled = false
			end
		end;
	end
end)

L_1_.ChildRemoved:connect(function(L_44_arg1)
	if L_44_arg1:IsA('Weld') then
		L_2_:WaitForChild('RegenButton'):WaitForChild('Regen'):WaitForChild('CanRegen').Value = true
	end
end)

--// Event Connections
L_22_.OnServerEvent:connect(function(L_45_arg1)
	if L_45_arg1 == L_7_.Value then
		L_18_ = false
		L_3_:WaitForChild('Engine'):WaitForChild('BodyGyro'):Destroy()
		L_3_:WaitForChild('Engine'):WaitForChild('BodyPosition'):Destroy()
		
		for L_46_forvar1, L_47_forvar2 in pairs(L_3_:WaitForChild('Engine'):GetChildren()) do
			if L_47_forvar2:IsA('Sound') then
				L_47_forvar2:Stop()
			end
		end
		
		for L_48_forvar1, L_49_forvar2 in pairs(L_3_:GetChildren()) do
			if L_49_forvar2.Name == 'Vents' then
				if L_49_forvar2:FindFirstChild('Smoke') then
					L_49_forvar2.Smoke.EmissionDirection = 'Back'
					L_49_forvar2.Smoke.Enabled = false
				end
			end
		end
		
		if L_15_ then
			L_15_:Destroy()
		end
	elseif L_45_arg1 ~= L_7_.Value then
		L_45_arg1:Kick('Stop Exploiting')
	end
end)

L_23_.OnServerEvent:connect(function(L_50_arg1)
	if L_50_arg1 == L_7_.Value then
		for L_51_forvar1, L_52_forvar2 in pairs(L_3_:GetChildren()) do
			if L_52_forvar2.Name == 'Vents' then
				if L_52_forvar2:FindFirstChild('Smoke') then
					L_52_forvar2.Smoke.EmissionDirection = 'Back'
					L_52_forvar2.Smoke.Enabled = true
				end
			end
		end
		L_18_ = true
	elseif L_50_arg1 ~= L_7_.Value then
		L_50_arg1:Kick('Stop Exploiting')
	end
end)

L_26_.OnServerInvoke = function(L_53_arg1, L_54_arg2, L_55_arg3, L_56_arg4, L_57_arg5, L_58_arg6, L_59_arg7, L_60_arg8)
	local L_61_
	if not L_61_ then
		L_61_ = Instance.new("Part", workspace)
		L_61_.Name = 'Crack'
		L_61_.FormFactor = "Custom"
		L_61_.TopSurface = 0
		L_61_.BottomSurface = 0
		L_61_.Transparency = 1
		L_61_.Anchored = true
		L_61_.CanCollide = false
		L_61_.Size = Vector3.new(0.5, 0, 0.5)
		L_61_.CFrame = CFrame.new(L_54_arg2) * CFrame.fromAxisAngle(L_55_arg3.magnitude == 0 and Vector3.new(1) or L_55_arg3.unit, L_56_arg4)
		L_61_.BrickColor = BrickColor.new("Really black")
		L_61_.Material = "SmoothPlastic"
	
		if L_60_arg8 == 'NonExplosive' then
			local L_62_ = Instance.new("Decal", L_61_)
			L_62_.Texture = "rbxassetid://64291977"
			L_62_.Face = "Top"
			game.Debris:AddItem(L_62_, 3)
			
			local L_63_ = Instance.new("PointLight", L_61_)
			L_63_.Color = Color3.new(0, 0, 0)
			L_63_.Range = 0
			L_63_.Shadows = true
			
			game.Debris:AddItem(L_61_, 3)
			
			local L_64_
			local L_65_
				
			if L_58_arg6 == "Part" then
				L_64_ = L_19_:WaitForChild("Spark"):clone()
				L_64_.Parent = L_61_
				L_64_.EmissionDirection = "Top"
				
				L_65_ = L_19_:WaitForChild("Smoke"):clone()
				L_65_.Parent = L_61_
				L_65_.EmissionDirection = "Top"
				
				L_64_.Enabled = true
				L_65_.Enabled = true
				
				game.Debris:AddItem(L_64_, 1)
				game.Debris:AddItem(L_65_, 1)
				
				delay(0.1, function()
					L_64_.Enabled = false
					L_65_.Enabled = false
				end)
			elseif L_58_arg6 == "Human" then		
				L_64_ = L_19_:WaitForChild("Blood"):clone()
				L_64_.Parent = L_61_
				L_64_.EmissionDirection = "Top"
				L_64_.Enabled = true
				
				game.Debris:AddItem(L_64_, 1)
				
				delay(0.1, function()
					L_64_.Enabled = false
				end)
			end
		elseif L_60_arg8 == 'Explosive' then
			local L_66_ = L_19_:WaitForChild('ExplosionSound'):clone()
			L_66_.Parent = L_61_
			L_66_:Play()	
			game.Debris:AddItem(L_61_, 3)
			local L_67_ = Instance.new('Explosion')
			L_67_.Parent = L_61_
			L_67_.DestroyJointRadiusPercent = 10
			L_67_.ExplosionType = Enum.ExplosionType.NoCraters
			L_67_.Position = L_61_.Position
		end;
	end
end;
	
L_25_.OnServerEvent:connect(function(L_68_arg1, L_69_arg2)
	for L_70_forvar1, L_71_forvar2 in pairs(game.Players:GetChildren()) do
		if L_71_forvar2:IsA('Player') and L_71_forvar2.PlayerGui:FindFirstChild('MainGui') and L_71_forvar2.PlayerGui.MainGui:FindFirstChild('Shading') then
			for L_72_forvar1, L_73_forvar2 in pairs(L_71_forvar2.Character:GetChildren()) do
				if L_73_forvar2:IsA('Tool') and L_73_forvar2:FindFirstChild('Resource') and L_73_forvar2.Resource:FindFirstChild('Events') and L_73_forvar2.Resource.Events:FindFirstChild('ServerFXEvent') then
					L_73_forvar2.Resource.Events.ServerFXEvent:FireClient(L_71_forvar2, L_69_arg2, L_68_arg1)
				end	
			end
		end
	end
end)

local L_30_
L_27_.OnServerEvent:connect(function(L_74_arg1, L_75_arg2, L_76_arg3)
	L_75_arg2:TakeDamage(L_76_arg3)
	if L_75_arg2.Health <= 0 and L_75_arg2 ~= L_30_ then
		if L_20_ and L_20_:FindFirstChild(L_74_arg1.Name) then
			local L_77_ = L_20_[L_74_arg1.Name]
			L_77_.Value = not L_77_.Value
		end
		L_30_ = L_75_arg2
	end
end)

L_28_.OnServerEvent:connect(function(L_78_arg1, L_79_arg2)
	local L_80_ = Instance.new("ObjectValue")
	L_80_.Name = "creator"
	L_80_.Value = L_78_arg1
	L_80_.Parent = L_79_arg2
	game.Debris:AddItem(L_80_, 3)
end)

--// Renders
game:GetService('RunService').Heartbeat:connect(function()
	if L_18_ then
		L_11_.Rotation = L_11_.Rotation + 5000
		L_12_.Rotation = L_11_.Rotation + 5000
		if L_10_ then
			L_13_.Rotation = L_13_.Rotation + 5000
			L_14_.Rotation = L_13_.Rotation + 5000
		end
		
		local L_81_, L_82_, L_83_ = workspace:FindPartOnRayWithIgnoreList(Ray.new(L_3_:WaitForChild('Engine').CFrame.p, (L_3_:WaitForChild('Engine').CFrame.upVector).unit * -20), L_21_)
				
		if L_81_ then
			local L_84_ = Vector3.new(0, 1, 0):Cross(L_83_)
			local L_85_ = math.asin(L_84_.magnitude)
			if not L_15_ then
				L_15_ = Instance.new('Part', workspace)
				table.insert(L_21_, L_15_)
				--newPart.Position = position
				L_15_.Anchored = true
				L_15_.CanCollide = false
				L_15_.Transparency = 1
				L_15_.CFrame = CFrame.new(L_82_) * CFrame.fromAxisAngle(L_84_.magnitude == 0 and Vector3.new(1) or L_84_.unit, L_85_)
			elseif L_15_ then
				--newPart.Position = position
				L_15_.Anchored = true
				L_15_.CanCollide = false
				L_15_.Transparency = 1
				L_15_.CFrame = CFrame.new(L_82_) * CFrame.fromAxisAngle(L_84_.magnitude == 0 and Vector3.new(1) or L_84_.unit, L_85_)
			end
			if not L_16_ and not L_17_ then
				L_16_ = L_19_:WaitForChild('Debris'):clone()
				L_16_.Parent = L_15_
				L_16_.Enabled = true
				L_17_ = L_19_:WaitForChild('DustUp'):clone()
				L_17_.Parent = L_15_
				L_17_.Enabled = true
			end	
			
			if L_17_ then
				L_17_.Color = ColorSequence.new(L_81_.BrickColor.Color)
			end
		end
		
		if not L_81_ then
			if L_15_ then
				L_16_.Enabled = false
				L_17_.Enabled = false
			end
		elseif L_81_ then
			if L_15_ then
				L_16_.Enabled = true
				L_17_.Enabled = true
			end
		end
	end
end)