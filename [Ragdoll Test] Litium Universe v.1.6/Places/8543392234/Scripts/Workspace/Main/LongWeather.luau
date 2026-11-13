local HereGlobalValues = game.Scene.Main.GlobalValue

local function SetValue(name,value)
	local Value = HereGlobalValues:WaitForChild(name)
	Value.Value = value
end

local function GetValue(name)
	local Value = HereGlobalValues:WaitForChild(name)
	return Value.Value
end

local function GetPValue(player,name)
	local Value = player:WaitForChild("PlayerFiles").Values:WaitForChild(name)
	return Value.Value
end

local function SetPValue(player,name, value)
	local Value = player.PlayerFiles.Values:WaitForChild(name)
	Value.Value = value

end

local MakeWaterColor = Color3.fromRGB(96,116,105)
local MakeWaterAlpha = 0.55
local MakeWaterRef = 1

local WaterColors = {
	DirtySalt = { color = Color3.fromRGB(116,101,80); alpha = 0.35; ref = 0.25;};
	SaltWater = { color = Color3.fromRGB(62,85,116); alpha = 0.3; ref = 0.15;};
	LightSea = { color = Color3.fromRGB(96,116,105); alpha = 0.55; ref = 1;};
	ClearGreen = { color = Color3.fromRGB(92,116,88); alpha = 0.95; ref = 0;};
	DeepSea = { color = Color3.fromRGB(0,75,141); alpha = 0.35; ref = 0.6;};
	Mud = { color = Color3.fromRGB(86,71,57); alpha = 0.2; ref = 0;};
	WhiteWater = { color = Color3.fromRGB(125,255,255); alpha = 0.75; ref = 0.85;};
	Vine = { color = Color3.fromRGB(157,0,2); alpha = 0.4; ref = 0.25;};
	Clear = { color = Color3.fromRGB(146,171,189); alpha = 1; ref = 0;};
}
local function SetRandomWater()
	local rand = math.random(0,7)
	print("WATER RAND "..rand)
	local color
	local alpha
	local ref

	if rand == 0 then
		color = WaterColors.DirtySalt.color
		alpha = WaterColors.DirtySalt.alpha
		ref = WaterColors.DirtySalt.ref
	else if rand == 1 then
			color = WaterColors.SaltWater.color
			alpha = WaterColors.SaltWater.alpha
			ref = WaterColors.SaltWater.ref
		else if rand == 2 then
				color = WaterColors.LightSea.color
				alpha = WaterColors.LightSea.alpha
				ref = WaterColors.LightSea.ref
			else if rand == 3 then
					color = WaterColors.ClearGreen.color
					alpha = WaterColors.ClearGreen.alpha
					ref = WaterColors.ClearGreen.ref
				else if rand == 4 then
						color = WaterColors.DeepSea.color
						alpha = WaterColors.DeepSea.alpha
						ref = WaterColors.DeepSea.ref
					else if rand == 5 then
							color = WaterColors.Mud.color
							alpha = WaterColors.Mud.alpha
							ref = WaterColors.Mud.ref
						else if rand == 6 then
								color = WaterColors.WhiteWater.color
								alpha = WaterColors.WhiteWater.alpha
								ref = WaterColors.WhiteWater.ref
							--[[else if rand == 7 then
									color = WaterColors.Vine.color
									alpha = WaterColors.Vine.alpha
									ref = WaterColors.Vine.ref]]
								else if rand == 7 then
										color = WaterColors.Clear.color
										alpha = WaterColors.Clear.alpha
										ref = WaterColors.Clear.ref
									end
								end
							end
						end
					end
				end
			end
	--	end
	end
	SetValue("WaterColor",color)
	SetValue("WaterAlpha",alpha)
	SetValue("WaterRef",ref)
	print("WATER "..tostring(color).." "..tostring(alpha).." "..tostring(ref))

end
SetValue("WindPower",math.random(0,10)/10)
local function WindPower()
	local rand = math.random(0,10)/10
	game.Scene.Terrain.WaterWaveSize = GetValue("WindPower")/3
	if GetValue("WindPower") > 10 then
		SetValue("WindPower",GetValue("WindPower")-rand)
	else if GetValue("WindPower") < -10 then
			SetValue("WindPower",GetValue("WindPower")+rand)
		else
			SetValue("WindPower",GetValue("WindPower")+math.random(-10,10)/10)
		end

	end 
end
SetRandomWater()
local water = game.Scene.Terrain
water.WaterColor = GetValue("WaterColor")
SetValue("WaterAlphaNew",GetValue("WaterAlpha"))
water.WaterTransparency = GetValue("WaterAlphaNew")
water.WaterReflectance = GetValue("WaterRef")

while true do
	SetRandomWater()
	WindPower()
	SetValue("CloudsPower",math.random(0,100)/100)
	SetValue("CloudsDensity",math.random(0,100)/100)
	wait(math.random(60,300))
end