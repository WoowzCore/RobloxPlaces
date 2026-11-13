local tool = script.Parent
local base = require(game:GetService("ServerScriptService").Base)
local plrs = game:GetService("Players")

local data = {}
local function SetColorTool()
	local colors = {Color3.fromRGB(154, 48, 48),Color3.fromRGB(99, 154, 48),Color3.fromRGB(43, 119, 154),Color3.fromRGB(154, 39, 154),Color3.fromRGB(197, 197, 197)}
	local color = colors[math.random(1,#colors)]
	tool.BasePart.Color = color
	tool.Rychka.Color = color
	data["toolcolor"] = Color3.fromRGB(math.min(255,color.R*255+20),math.min(255,color.G*255+20),math.min(255,color.B*255+20))
end
SetColorTool()
local plr = nil

local function SetLight(lid)
	local lightpart = tool.LightPart
	local light = lightpart.PointLight
	local color = Color3.fromRGB(68, 68, 68)
	if lid == "off" then
		lightpart.Material = Enum.Material.Glass
		light.Enabled = false
	else
		lightpart.Material = Enum.Material.Neon
		light.Enabled = true
	end
	
	if lid ~= "random" then
		local colors = {
			["white"] = Color3.fromRGB(255, 255, 255),
			["red"] = Color3.fromRGB(255, 0, 0),
			["green"] = Color3.fromRGB(0, 255, 0),
			["blue"] = Color3.fromRGB(0, 0, 255),
			["yellow"] = Color3.fromRGB(255, 255, 0),
			["off"] = Color3.fromRGB(68, 68, 68)
 		}
		color = colors[lid]
	else
		color = base.RandomColor()
	end
	
	lightpart.Color = color
	light.Color = color
end

local flashed = false
local function Flash()
	if not flashed then
		flashed = true
		tool.LightPart2.Material = Enum.Material.Neon
		tool.LightPart2.Color = Color3.new(1,1,1)
		tool.LightPart2.PointLight.Enabled = true
		wait(0.01)
		tool.LightPart2.Material = Enum.Material.Glass
		tool.LightPart2.Color = Color3.fromRGB(68, 68, 68)
		tool.LightPart2.PointLight.Enabled = false
		flashed = false
	end
end

local smoked = false
local function Smoke()
	if not smoked then
		smoked = true
		tool.Smoke.Smoke.Enabled = true
		wait(0.5)
		tool.Smoke.Smoke.Enabled = false
		smoked = false
	end
end

tool.GetData.OnServerInvoke = function(plr)
	return data
end

local positions = {}
tool.SetData.OnServerEvent:Connect(function(plr,d)
	data = d
end)

local timer = 0
tool.GetSoundsPositions.OnServerInvoke = function(plr)
	return {positions,timer}
end

local function PlayChar(ld,pos)
	local ThatSounds = false
	local sounds = {
		["a"] = {"2658454327"},
		["b"] = {"7752575071"},
		["c"] = {"2440525645"},
		["d"] = {"9118687679"},
		["e"] = {"1055287191"},
		["f"] = {"9120895045"},
		["g"] = {"6933266457"},
		["h"] = {"8723334712"},
		["i"] = {"4288784832"},
		["j"] = {"9114469781"},
		["k"] = {"9112911365"},
		["l"] = {"9117014309"},
		["m"] = {"7842440241"},
		["n"] = {"3199239518"},
		["o"] = {"9117664496"},
		["p"] = {"717313726"},
		["q"] = {"5850239411"},
		["r"] = {"9083627113"},
		["s"] = {"678738087"},
		["t"] = {"3748780065"},
		["u"] = {"9126085225"},
		["v"] = {"9126162696"},
		["w"] = {"9120177978"},
		["x"] = {"9114667180"},
		["y"] = {"9120917794"},
		["z"] = {"390913541"},
		
		["A"] = {"383548205"},
		["B"] = {"7741943775"},
		["C"] = {"5710435455"},
		["D"] = {"7149516994"},
		["E"] = {"5587657808"},
		["F"] = {"8059880878"},
		["G"] = {"453872246"},
		["H"] = {"5448503499"},
		["I"] = {"8779118553"},
		["J"] = {"9119144076"},
		["K"] = {"9058201255"},
		["L"] = {"4599659730"},
		["M"] = {"9126125524"},
		["N"] = {"344167846"},
		["O"] = {"1566260295"},
		["P"] = {"9117355465"},
		["Q"] = {"9119147696"},
		["R"] = {"1748666759"},
		["S"] = {"146163493"},
		["T"] = {"621550413"},
		["U"] = {"1323739650"},
		["V"] = {"7251381246"},
		["W"] = {"5226834046"},
		["X"] = {"7140152893"},
		["Y"] = {"9117688022"},
		["Z"] = {"9119740460"},
		
		["_"] = {""},
		
		["0"] = {"584691395"},
		["1"] = {"4582790360"},
		["2"] = {"7714439701"},
		["3"] = {"3727724569"},
		["4"] = {"9120472743"},
		["5"] = {"3466988045"},
		["6"] = {"6568398699"},
		["7"] = {"9113891284"},
		["8"] = {"8864905994"},
		["9"] = {"1836360908"},
		
		["#"] = {function() SetLight("red") end},
		["$"] = {function() SetLight("green") end},
		[","] = {function() SetLight("blue") end},
		["^"] = {function() SetLight("yellow") end},
		["&"] = {function() SetLight("white") end},
		["<"] = {function() SetLight("random") end},
		[":"] = {function() SetLight("off") end},
		["!"] = {function() Flash() end},
		[">"] = {function() Smoke() end},
		["\\"] = {function()
			if tool.Handle.Sound.SoundId ~= "" then
				if tool.Handle.Sound.Playing then
					tool.Handle.Sound:Stop()
				else
					tool.Handle.Sound:Play()
				end
			end
		end},
	}
	
	local volumeadd = 1
	local speedadd = 1
	
	local pos_ = 0
	while sounds[string.sub(ld,pos+pos_,pos+pos_)] == nil do
		pos_ += 1
		local c = string.sub(ld,pos+pos_,pos+pos_)
		if c == "*" then
			speedadd*=1.1
		elseif c == "/" then
			speedadd/=1.1
		elseif c == "+" then
			volumeadd*=1.1
		elseif c == "-" then
			volumeadd/=1.1
		end
		if (pos+pos_)>utf8.len(ld) then
			return "error"
		end
	end
	if string.sub(ld,pos+pos_,pos+pos_) == "" or string.sub(ld,pos+pos_,pos+pos_) == nil then return "error" end
	local sound = sounds[string.sub(ld,pos+pos_,pos+pos_)]
	volumeadd = math.min(volumeadd,5)
	speedadd = math.max(speedadd,0.01)
	if data["play"] then
		if typeof(sound[1]) == "string" then
			if sound[1] ~= "" then
				base.PlaySound(sound[1],tool.Handle.Position,volumeadd,volumeadd*12,speedadd)
			end
		else
			sound[1]()
			wait()
			local addthis_ = pos+1
			if addthis_>=utf8.len(ld) then
				addthis_ = 1
			end
			local addthis = PlayChar(ld,addthis_)
			if addthis == "error" then
				return "error"
			else
				if addthis_ == 1 then
					return "start"
				else
					if addthis == "start" then
						return "start"
					else
						return addthis+1
					end
				end
			end
		end
	end
	
	return pos_+1
end

local function PlayMusic()
	for id, ld in pairs(data["linesdata"]) do
		if ld ~= "" then
			if positions[id] == nil then positions[id] = 0 end
			local addthis = PlayChar(ld,positions[id]+1)
			if addthis ~= "error" then
				if addthis == "start" then
					positions[id] = 0
				else
					local newpos = positions[id] + addthis
					if newpos >= utf8.len(ld) then
						newpos = 0
					end
					positions[id] = newpos
				end
			else
				positions[id] = -1
			end
		else
			positions[id] = 0
		end
	end
end

local function PlayOnce()
	local id = data["musicid"]
	if id ~= nil then
		id = "rbxassetid://"..id
	end
	tool.Handle.Sound.SoundId = id or ""
	if tool.Handle.Sound.SoundId ~= "" then
		local volume = data["volume"]
		if volume then
			volume = volume/100
		end
		local speed = data["mspeed"]
		if speed then
			speed = speed/100
		end
		tool.Handle.Sound.Volume = volume or 1
		tool.Handle.Sound.PlaybackSpeed = speed or 1
		tool.Handle.Sound:Play()
	end
end

local function StopOnce()
	positions = {}
	timer = 0
	
	tool.Handle.Sound:Stop()
end

local randcolors = {"red","green","blue","yellow","white","off"}
SetLight(randcolors[math.random(1,#randcolors)])

local onceplay = false
while true do
	if tool.Parent.Name == "Backpack" then
		plr = tool.Parent.Parent
		local chr = plr.Character or plr.CharacterAdded:Wait()
		local root = chr:FindFirstChild("HumanoidRootPart")
		tool.Handle.CFrame = CFrame.new(root.Position)
	else
		if tool.Parent:FindFirstChildOfClass("Humanoid") then
			plr = plrs:GetPlayerFromCharacter(tool.Parent)
		else
			plr = nil
		end
	end
	if data["play"] then
		if data["play"] == true then
			if data["linesdata"] then
				PlayMusic()
			end
			
			if not onceplay then
				onceplay = true
				PlayOnce()
			end
			
			timer+=1
			local timerend = data["timeend"] or 0
			if timerend ~= 0 then
				if timer > timerend then
					if plr then
						tool.StopMusic:FireClient(plr)
					else
						data["play"] = false
					end
				end
			end
			
		else
			if onceplay then
				onceplay = false
				StopOnce()
			end
		end
	else
		if onceplay then
			onceplay = false
			StopOnce()
		end
	end
	wait((data["speed"] or 0)/200)
end