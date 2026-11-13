local tree = script.Parent
local base = require(game:GetService("ServerScriptService").Base)

local l1,l2,l3 = tree.ChristmasTree.Leaves1.PointLight,tree.ChristmasTree.Leaves2.PointLight,tree.ChristmasTree.TreeTrunk.PointLight

local lightypes = {
	"random","sin","fast"
}

local tweens = {
	
}

local lighttype = lightypes[math.random(1,#lightypes)]

local colors = {
	["DarkBlueLight"] = Color3.fromRGB(84, 116, 186),
	["GreenLight"] = Color3.fromRGB(116, 229, 84),
	["LightBlueLight"] = Color3.fromRGB(0, 255, 247),
	["PinkLight"] = Color3.fromRGB(255, 129, 242),
	["RedLight"] = Color3.fromRGB(255, 60, 0),
	["YellowLight"] = Color3.fromRGB(236, 201, 0)
}
local ts1,ts2,ts3 = nil,nil,nil
local function tweencreate(typ)
	if ts1 ~= nil then ts1:Destroy() l1.Brightness = 0.3 end
	if ts2 ~= nil then ts2:Destroy() l2.Brightness = 0.3 end
	if ts3 ~= nil then ts3:Destroy() l3.Brightness = 0.3 end
	
	local tweeninfomain = nil

	if typ == "sin" then
		tweeninfomain = TweenInfo.new(3,Enum.EasingStyle.Linear,Enum.EasingDirection.In,math.huge,true)
	elseif typ == "random" then
		tweeninfomain = TweenInfo.new(math.random(10,30)/10,Enum.EasingStyle.Linear,Enum.EasingDirection.In,math.huge,true)
	elseif typ == "fast" then
		tweeninfomain = TweenInfo.new(0.5,Enum.EasingStyle.Linear,Enum.EasingDirection.In,math.huge,true)
	end	

	ts1 = base.ts(l1,tweeninfomain,{Brightness = 0})
	ts2 = base.ts(l2,tweeninfomain,{Brightness = 0})
	ts3 = base.ts(l3,tweeninfomain,{Brightness = 0})
	
	for _, ts in pairs(tweens) do
		ts:Destroy()
	end
	for _, l in pairs(tree.Lights:GetDescendants()) do		
		if l:IsA("BasePart") then
			local tweeninfo = nil

			if typ == "sin" then
				tweeninfo = TweenInfo.new(3,Enum.EasingStyle.Linear,Enum.EasingDirection.In,math.huge,true)
			elseif typ == "random" then
				tweeninfo = TweenInfo.new(math.random(10,50)/10,Enum.EasingStyle.Linear,Enum.EasingDirection.In,math.huge,true)
			elseif typ == "fast" then
				tweeninfo = TweenInfo.new(0.5,Enum.EasingStyle.Linear,Enum.EasingDirection.In,math.huge,true)
			end
			
			l.Color = colors[l.Name]
			local ts = base.ts(l,tweeninfo,{Color = Color3.new(0.1, 0.1, 0.1)})
			table.insert(tweens,ts)
		end
	end
end
tweencreate(lighttype)

while wait(10) do
	lighttype = lightypes[math.random(1,#lightypes)]
	tweencreate(lighttype)
end
