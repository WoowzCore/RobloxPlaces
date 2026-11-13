local HereGlobalValues = game.Scene.Main.GlobalValue
local function GetValue(name)
	local Value = HereGlobalValues:WaitForChild(name)
	return Value.Value
end

local Atmosphere = game.Weather.Atmosphere

local player = game.Players.LocalPlayer

local character = player.Character
if not character or not character.Parent then
	character = player.CharacterAdded:wait()
end

local humanoid = character:WaitForChild("Humanoid")

local Parts = {
	Head = character:WaitForChild("Head");
	Base = character:WaitForChild("HumanoidRootPart");
	Torso = {
		Upper = character:WaitForChild("UpperTorso");
		Lower = character:WaitForChild("LowerTorso");
	};
	Arms = {
		Left = {
			Upper = character:WaitForChild("LeftUpperArm");
			Lower = character:WaitForChild("LeftLowerArm");
			Hand = character:WaitForChild("LeftHand");
		};
		Right = {
			Upper = character:WaitForChild("RightUpperArm");
			Lower = character:WaitForChild("RightLowerArm");
			Hand = character:WaitForChild("RightHand");
		};

	};
	Legs = {
		Left = {
			Upper = character:WaitForChild("LeftUpperLeg");
			Lower = character:WaitForChild("LeftLowerLeg");
			Foot = character:WaitForChild("LeftFoot");
		};
		Right = {
			Upper = character:WaitForChild("RightUpperLeg");
			Lower = character:WaitForChild("RightLowerLeg");
			Foot = character:WaitForChild("RightFoot");
		};

	};
}

local function SetPValue(name,value)
	local Value = player.PlayerFiles.Values:WaitForChild(name)
	Value.Value = value
end

local function GetPValue(name)
	local Value = player.PlayerFiles.Values:WaitForChild(name)
	return Value.Value
end

local Weather = game.Scene:WaitForChild(player.UserId.." Additionally"):WaitForChild("PlayerCharacter").Weather


local snowRain = Weather.Precipitation.Snow
local Rain = Weather.Precipitation.Rain
local AcidRain = Weather.Precipitation.AcidRain
local Ashes = Weather.Precipitation.Ashes
local Glow = Weather.Precipitation.Glow
local Birds = Weather.Precipitation.Birds

local WindSound = Weather.WindSound
WindSound.Playing = true

local UnderwaterSound = Weather.UnderwaterSound

local CaveSound = Weather.CaveSound
CaveSound.Playing = true

local function DeleteEffects()
	local c = workspace.CurrentCamera
	local effect1 = c:FindFirstChild("WaterBlur")
	if effect1 then
		effect1:Destroy()
	end	
	local effect2 = c:FindFirstChild("WaterCorrection")
	if effect2 then
		effect2:Destroy()
	end	
	local effect3 = c:FindFirstChild("OxygenCorrection")
	if effect3 then
		effect3:Destroy()
	end	
	local effect4 = c:FindFirstChild("DeepCorrection")
	if effect4 then
		effect4:Destroy()
	end	
	local effect5 = c:FindFirstChild("DamageCorrection")
	if effect5 then
		effect5:Destroy()
	end	
	local effect6 = c:FindFirstChild("DamageBlur")
	if effect6 then
		effect6:Destroy()
	end	
end
DeleteEffects()

local WaterBlur = Instance.new("BlurEffect")
WaterBlur.Name = "WaterBlur"
WaterBlur.Parent = workspace.CurrentCamera

local WaterCorrection = Instance.new("ColorCorrectionEffect")
WaterCorrection.Name = "WaterCorrection"
WaterCorrection.Parent = workspace.CurrentCamera

local OxygenCorrection = Instance.new("ColorCorrectionEffect")
OxygenCorrection.Name = "OxygenCorrection"
OxygenCorrection.Parent = workspace.CurrentCamera

local DeepCorrection = Instance.new("ColorCorrectionEffect")
DeepCorrection.Name = "DeepCorrection"
DeepCorrection.Parent = workspace.CurrentCamera

local DamageBlur = Instance.new("BlurEffect")
DamageBlur.Name = "DamageBlur"
DamageBlur.Parent = workspace.CurrentCamera
local DamageCorrection = Instance.new("ColorCorrectionEffect")
DamageCorrection.Name = "DamageCorrection"
DamageCorrection.Parent = workspace.CurrentCamera



local CricketsSound = Weather.CricketsSound

local HitRoof = nil
local function HaveRoof()
	local ray = Ray.new(Parts.Head.CFrame.Position,Vector3.new(0,900,0))
	local hit, position = game.Workspace:FindPartOnRayWithIgnoreList(ray,{Parts.Head,Parts.Torso.Lower,Parts.Torso.Upper,Parts.Base,Parts.Legs.Left.Upper,Parts.Legs.Left.Lower,Parts.Legs.Right.Upper,Parts.Legs.Right.Lower,Parts.Legs.Left.Foot,Parts.Legs.Right.Foot,Parts.Arms.Left.Hand,Parts.Arms.Left.Lower,Parts.Arms.Left.Upper,Parts.Arms.Right.Hand,Parts.Arms.Right.Lower,Parts.Arms.Right.Upper})
	HitRoof = hit
	if hit then
		SetPValue("HaveRoof",true)
	else
		SetPValue("HaveRoof",false)
	end
end

local function SmoothNumber(first,second,times)
	local first2
	if first < second then
		first2 = first + times
	end
	if first > second then
		first2 = first - times
	end
	return first2
end

local GlowPartMode = true
local GlowPart = 0

local GUI = player.PlayerGui.GUI
local WaterGUI = GUI.InWater

local Damage = 0

local function SmoothVector(x,y,z,x2,y2,z2,times)
	return Vector3.new(SmoothNumber(x,x2,times),SmoothNumber(y,y2,times),SmoothNumber(z,z2,times))
end
local function VectorToColor(vector,rgb)
	local x = vector.x
	local y = vector.y
	local z = vector.z
	if rgb then
		return Color3.fromRGB(math.floor(x*255),math.floor(y*255),math.floor(z*255))
	else
		return Color3.new(x,y,z)
	end

end

local function SmoothColor(colorOne,colorTwo,times)

	local r1 = colorOne.R
	local g1 = colorOne.G
	local b1 = colorOne.B

	local r2 = colorTwo.R
	local g2 = colorTwo.G
	local b2 = colorTwo.B

	local rBool = true
	local gBool = true
	local bBool = true

	if r1 < r2 then
		rBool = false
		r1 = r1 + times
		wait(times)
		rBool = true
	end

	if r1 > r2 then
		rBool = false
		r1 = r1 - times
		wait(times)
		rBool = true
	end

	if g1 < g2 then
		gBool = false
		g1 = g1 + times
		wait(times)
		gBool = true
	end

	if g1 > g2 then
		gBool = false
		g1 = g1 - times
		wait(times)
		gBool = true
	end

	if b1 < b2 then
		bBool = false
		b1 = b1 + times
		wait(times)
		bBool = true
	end

	if b1 > b2 then
		bBool = false
		b1 = b1 - times
		wait(times)
		bBool = true
	end

	return Color3.new(r1,g1,b1)
end

humanoid:GetPropertyChangedSignal("Health"):Connect(function()
	local oldhp = humanoid.Health
	wait()
	if oldhp > humanoid.Health then
		DamageBlur.Size = 25
		DamageCorrection.Contrast = 1
		DamageCorrection.TintColor =  Color3.fromRGB(168,54,56)
	end
end)
local Terrain = game.Scene.Terrain
local lavapowermode = false
local function TerrainMaterials()
	local grassWet
	if GetValue("Weather") == "Rain" then
		grassWet = Color3.fromRGB(39, 71, 37)
	else
		grassWet = Color3.fromRGB(81, 120, 76)
	end

	local lavapower
	if Terrain:GetMaterialColor(Enum.Material.CrackedLava).G >= 0.87 then
		lavapowermode = false
	else
		if Terrain:GetMaterialColor(Enum.Material.CrackedLava).G <= 0.47 then
			lavapowermode = true
		end
	end
	if lavapowermode then
		lavapower = Color3.fromRGB(255, 226, 0)
	else
		lavapower = Color3.fromRGB(255, 119, 0)
	end
	Terrain:SetMaterialColor(Enum.Material.Grass,SmoothColor(Terrain:GetMaterialColor(Enum.Material.Grass),grassWet,0.0001))

	Terrain:SetMaterialColor(Enum.Material.CrackedLava,SmoothColor(Terrain:GetMaterialColor(Enum.Material.CrackedLava),lavapower,0.005))
end

while true do
	wait()
	if character and Weather then
		local hum = character:FindFirstChild("HumanoidRootPart")
		if hum then
			HaveRoof()

			if GlowPartMode then
				if GlowPart >= 3 then
					GlowPartMode = false
				else
					GlowPart = GlowPart + 0.1 
				end
			else
				if GlowPart <= -3 then
					GlowPartMode = true
				else
					GlowPart = GlowPart - 0.1
				end
			end

			DamageBlur.Size = SmoothNumber(DamageBlur.Size,0,1)
			DamageCorrection.Contrast = SmoothNumber(DamageCorrection.Contrast,0,0.1)
			DamageCorrection.TintColor = SmoothColor(DamageCorrection.TintColor,Color3.new(1,1,1),0.003)


			if Parts.Base.Position.Y < 0 then

				DeepCorrection.Saturation = Parts.Base.Position.Y/150
				DeepCorrection.Brightness = (Parts.Base.Position.Y/150)*0.6
				DeepCorrection.Contrast = -(Parts.Base.Position.Y/150)

			end

			if GetPValue("CameraInWaterOld") or GetPValue("CameraInWater") then
				Terrain.WaterTransparency = GetValue("WaterAlphaNew")/4
			else
				Terrain.WaterTransparency = GetValue("WaterAlphaNew")
			end

			if GetPValue("CameraInWater") then
				Weather.PrecipitationWater.Bubbles.Enabled = true
				UnderwaterSound.Playing = true
				UnderwaterSound.Volume = 2-GetPValue("WaterDeepnes")/60
				WaterBlur.Enabled = true
				WaterBlur.Size = (1-game.Scene.Terrain.WaterTransparency)*50 * (GetPValue("WaterDeepnesOne")/20)
				WindSound.Playing = false
				WaterGUI.Visible = true
				WaterCorrection.Enabled = true

				local WCTCR = 1-((1-game.Scene.Terrain.WaterColor.R)* (GetPValue("WaterDeepnesOne")/20))
				local WCTCG = 1-((1-game.Scene.Terrain.WaterColor.G)* (GetPValue("WaterDeepnesOne")/20))
				local WCTCB = 1-((1-game.Scene.Terrain.WaterColor.B)* (GetPValue("WaterDeepnesOne")/20))
				if WCTCR < (game.Scene.Terrain.WaterColor.R)*(1+GetValue("WaterAlphaNew")) then
					if (game.Scene.Terrain.WaterColor.R)*(1+GetValue("WaterAlphaNew")) < 1 then
						WCTCR = (game.Scene.Terrain.WaterColor.R)*(1+GetValue("WaterAlphaNew"))
					end
				end
				if WCTCG < (game.Scene.Terrain.WaterColor.G)*(1+GetValue("WaterAlphaNew")) then
					if (game.Scene.Terrain.WaterColor.G)*(1+GetValue("WaterAlphaNew")) < 1 then
						WCTCG = (game.Scene.Terrain.WaterColor.G)*(1+GetValue("WaterAlphaNew"))
					end
				end
				if WCTCB < (game.Scene.Terrain.WaterColor.B)*(1+GetValue("WaterAlphaNew")) then
					if (game.Scene.Terrain.WaterColor.B)*(1+GetValue("WaterAlphaNew")) < 1 then
						WCTCB = (game.Scene.Terrain.WaterColor.B)*(1+GetValue("WaterAlphaNew"))
					end
				end
				WaterCorrection.TintColor = Color3.new(WCTCR,WCTCG,WCTCB)
				local Contrast = -(game.Scene.Terrain.WaterTransparency*(GetPValue("WaterDeepnesOne")/20))
				if Contrast > -1 then
					WaterCorrection.Contrast = Contrast
				end
				WaterGUI.ImageColor3 = game.Scene.Terrain.WaterColor
				WaterGUI.ImageTransparency = 1-- (1-((GetPValue("WaterDeepnes")/20)))

			else
				Weather.PrecipitationWater.Bubbles.Enabled = false
				UnderwaterSound.Playing = false
				WaterBlur.Enabled = false
				WindSound.Playing = true
				WaterGUI.Visible = false
				WaterCorrection.Enabled = false
			end

			if GetPValue("HeadInWater") then
				OxygenCorrection.TintColor = Color3.new(1-((GetPValue("MaxOxygen")-GetPValue("Oxygen"))/GetPValue("MaxOxygen")),1-((GetPValue("MaxOxygen")-GetPValue("Oxygen"))/GetPValue("MaxOxygen")),1-(((GetPValue("MaxOxygen")-GetPValue("Oxygen"))/GetPValue("MaxOxygen"))/2))

			else
				OxygenCorrection.TintColor = Color3.new(1,1,1)
			end

			Glow.LightEmission = GlowPart

			snowRain.Speed = NumberRange.new((math.abs(GetValue("WindPower")*5)+5))
			snowRain.Rate = math.abs(GetValue("WindPower")*30)+20
			snowRain.Acceleration = Vector3.new(GetValue("WindPower")/10,math.abs(GetValue("WindPower")),0)

			Rain.Speed = NumberRange.new((math.abs(GetValue("WindPower")*10)+100))
			Rain.Rate = math.abs(GetValue("WindPower")*100)+100
			Rain.Acceleration = Vector3.new(GetValue("WindPower")*10,0,0)

			WindSound.Volume = math.abs(GetValue("WindPower"))/9

			--CaveSound.Volume = math.abs(GetValue("WindPower"))/9

			if HitRoof or GetPValue("CameraInWater") then
				Rain.Enabled = false
				snowRain.Enabled = false
				Birds.Enabled = false
			else
				Birds.Enabled = true
				if GetValue("Weather") == "Rain" then
					if GetPValue("MapTempirature") > 0 then
						Rain.Enabled = true
						snowRain.Enabled = false
					else if GetPValue("MapTempirature") > -2 then
							Rain.Enabled = true
							snowRain.Enabled = true
						else
							Rain.Enabled = false
							snowRain.Enabled = true
						end end
				else
					Rain.Enabled = false
					snowRain.Enabled = false
				end
			end
			Weather.Position = character.HumanoidRootPart.Position
			Weather.Precipitation.Position = character.HumanoidRootPart.Position+Vector3.new(0,80,0)
			Weather.PrecipitationWater.Position = character.HumanoidRootPart.Position+Vector3.new(0,-30,0)
			
			Birds.Acceleration = Vector3.new(math.random(-20,20),0,math.random(-20,20))

			if GetValue("NowNight") and not GetPValue("InWater") then
				CricketsSound.Playing = true
			else
				CricketsSound.Playing = false
			end
		end
		TerrainMaterials()
	end
end