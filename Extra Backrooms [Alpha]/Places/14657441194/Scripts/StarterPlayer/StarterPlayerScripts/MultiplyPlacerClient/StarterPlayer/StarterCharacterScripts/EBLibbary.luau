local module = {}
local Survival = require(script.Parent:WaitForChild("Data"))

local plr = game.Players.LocalPlayer
local chr = plr.Character or plr.CharacterAdded:Wait()
local humrootpart = chr:WaitForChild("HumanoidRootPart")
local hum = chr:WaitForChild("Humanoid")

function module.DetectHurt(part : Instance, power : number, hurttype : string)
	game:GetService("ReplicatedStorage").DetectHurt:FireServer(part,power,hurttype)
end

module.FootStepsData = {
	["default"] = {
		"rbxassetid://9126748907",
		"rbxassetid://9126748813",
		"rbxassetid://9126748580",
		"rbxassetid://9126748691",
		"rbxassetid://9126748431",
		"rbxassetid://9126748324",
		"rbxassetid://9126748239",
		"rbxassetid://9126748185",
		"rbxassetid://9126748045",
		"rbxassetid://9126747958"
	},
	["concrete"] = {
		"rbxassetid://9126746167",
		"rbxassetid://9126746098",
		"rbxassetid://9126745995",
		"rbxassetid://9126745877",
		"rbxassetid://9126745774",
		"rbxassetid://9126745574",
		"rbxassetid://9126745336",
		"rbxassetid://9126745241",
		"rbxassetid://9126745445",
		"rbxassetid://9126745052",
		"rbxassetid://9126745141",
		"rbxassetid://9126745676",
		"rbxassetid://9126744969",
		"rbxassetid://9126744894",
		"rbxassetid://9126744639",
		"rbxassetid://9126744789",
		"rbxassetid://9126744481"
	},
	["rock"] = {
		"rbxassetid://9126746167",
		"rbxassetid://9126746098",
		"rbxassetid://9126745995",
		"rbxassetid://9126745877",
		"rbxassetid://9126745774",
		"rbxassetid://9126745574",
		"rbxassetid://9126745336",
		"rbxassetid://9126745241",
		"rbxassetid://9126745445",
		"rbxassetid://9126745052",
		"rbxassetid://9126745141",
		"rbxassetid://9126745676",
		"rbxassetid://9126744969",
		"rbxassetid://9126744894",
		"rbxassetid://9126744639",
		"rbxassetid://9126744789",
		"rbxassetid://9126744481"
	},
	["gravel"] = {
		"rbxassetid://9126741273",
		"rbxassetid://9126740393",
		"rbxassetid://9126741200",
		"rbxassetid://9126741051",
		"rbxassetid://9126741128",
		"rbxassetid://9126740951",
		"rbxassetid://9126740802",
		"rbxassetid://9126740724",
		"rbxassetid://9126740524",
		"rbxassetid://9126740623"
	},

	["sand"] = {
		"rbxassetid://9126733118",
		"rbxassetid://9126733408",
		"rbxassetid://9126733225",
		"rbxassetid://9126732675",
		"rbxassetid://9126732571",
		"rbxassetid://9126732962",
		"rbxassetid://9126732962",
		"rbxassetid://9126732457",
		"rbxassetid://9126732862",
		"rbxassetid://9126732776",
		"rbxassetid://9126732334",
		"rbxassetid://9126732253"
	},
	["ground"] = {
		"rbxassetid://9126744390",
		"rbxassetid://9126744718",
		"rbxassetid://9126744263",
		"rbxassetid://9126744157",
		"rbxassetid://9126744066",
		"rbxassetid://9126744009",
		"rbxassetid://9126743796",
		"rbxassetid://9126743938",
		"rbxassetid://9126743711",
		"rbxassetid://9126743879",
		"rbxassetid://9126743613",
		"rbxassetid://9126743481",
		"rbxassetid://9126743338",
		"rbxassetid://9126743086"
	},
	["mud"] = {
		"rbxassetid://9126734842",
		"rbxassetid://9126734314",
		"rbxassetid://9126734778",
		"rbxassetid://9126734710",
		"rbxassetid://9126734613",
		"rbxassetid://9126734499",
		"rbxassetid://9126734365",
		"rbxassetid://9126734432",
		"rbxassetid://9126734244"
	},
	["metal"] = {
		"rbxassetid://9126736470",
		"rbxassetid://9126734921",
		"rbxassetid://9126736274",
		"rbxassetid://9126736354",
		"rbxassetid://9126736186",
		"rbxassetid://9126736049",
		"rbxassetid://9126735913",
		"rbxassetid://9126735734",
		"rbxassetid://9126735546",
		"rbxassetid://9126735474",
		"rbxassetid://9126735265",
		"rbxassetid://9126735374",
		"rbxassetid://9126735161",
		"rbxassetid://9126735028",
		"rbxassetid://9126735089",
		"rbxassetid://9126734972"
	},
	["glass"] = {
		"rbxassetid://9126742971",
		"rbxassetid://9126742461",
		"rbxassetid://9126742875",
		"rbxassetid://9126742786",
		"rbxassetid://9126743193",
		"rbxassetid://9126742680",
		"rbxassetid://9126742582",
		"rbxassetid://9126742510"
	},
	["fabric"] = {
		"rbxassetid://9126748130",
		"rbxassetid://9126747861",
		"rbxassetid://9126747720",
		"rbxassetid://9126747529",
		"rbxassetid://9126747412",
		"rbxassetid://9126747283",
		"rbxassetid://9126746732",
		"rbxassetid://9126746837",
		"rbxassetid://9126747132",
		"rbxassetid://9126746984",
		"rbxassetid://9126746598",
		"rbxassetid://9126746481",
		"rbxassetid://9126746371",
		"rbxassetid://9126746291"
	},
	["snow"] = {
		"rbxassetid://9126732128",
		"rbxassetid://9126731099",
		"rbxassetid://9126732016",
		"rbxassetid://9126731951",
		"rbxassetid://9126731877",
		"rbxassetid://9126731632",
		"rbxassetid://9126731493",
		"rbxassetid://9126731343",
		"rbxassetid://9126731790",
		"rbxassetid://9126731243",
		"rbxassetid://9126731169",
		"rbxassetid://9126730861"
	},
	["ice"] = {
		"rbxassetid://9126742971",
		"rbxassetid://9126742461",
		"rbxassetid://9126742875",
		"rbxassetid://9126742786",
		"rbxassetid://9126743193",
		"rbxassetid://9126742680",
		"rbxassetid://9126742582",
		"rbxassetid://9126742510"
	},
	["wood"] = {
		"rbxassetid://9126931624",
		"rbxassetid://9126931515",
		"rbxassetid://9126931417",
		"rbxassetid://9126931322",
		"rbxassetid://9126931699",
		"rbxassetid://9126931235",
		"rbxassetid://9126931169",
		"rbxassetid://9126931026",
		"rbxassetid://9126930953",
		"rbxassetid://9126930885",
		"rbxassetid://9126930789",
		"rbxassetid://9126930647",
		"rbxassetid://9126930516",
		"rbxassetid://9126930598",
		"rbxassetid://9126930718"
	},
	["grass"] = {
		"rbxassetid://9126742396",
		"rbxassetid://9126741427",
		"rbxassetid://9126742333",
		"rbxassetid://9126742215",
		"rbxassetid://9126742271",
		"rbxassetid://9126742031",
		"rbxassetid://9126741934",
		"rbxassetid://9126742105",
		"rbxassetid://9126741826",
		"rbxassetid://9126741594",
		"rbxassetid://9126741512",
		"rbxassetid://9126741741",
		"rbxassetid://9126741674"
	},
	["water"] = {
		"rbxassetid://9126173454",
		"rbxassetid://9126173489",
		"rbxassetid://9126173160",
		"rbxassetid://9126173487"
	}
}

module.FootSteps = {
	["plastic"] =       "default",
	["smoothplastic"] = "default",
	["ice"] =           "ice",
	["glacier"] =       "ice",
	["snow"] =          "snow",
	["sand"] =          "sand",
	["salt"] =          "sand",
	["wood"] =          "wood",
	["woodplanks"] =    "wood",
	["sandstone"] =     "rock",
	["slate"] =         "concrete",
	["rock"] =          "rock",
	["granite"] =       "concrete",
	["marble"] =        "concrete",
	["basalt"] =        "rock",
	["asphalt"] =       "concrete",
	["pavement"] =      "concrete",
	["cobblestone"] =   "gravel",
	["pebble"] =        "concrete",
	["concrete"] =      "concrete",
	["limestone"] =     "rock",
	["ground"] =        "ground",
	["mud"] =           "mud",
	["grass"] =         "grass",
	["leafygrass"] =    "grass",
	["crackedlava"] =   "rock",
	["brick"] =         "concrete",
	["glass"] =         "glass",
	["fabric"] =        "fabric",
	["foil"] =          "metal",
	["metal"] =         "metal",
	["corrodedmetal"] = "metal",
	["diamondplate"] =  "metal",
	["forcefield"] =    "default",
	["neon"] =          "default",
	["water"] =         "water"
}

function module.GetFootStepSound(mat)
	mat = tostring(mat):gsub("Enum.Material.",""):gsub(" ",""):lower()
	local sounds = module.FootSteps[mat]
	if sounds == nil then
		sounds = "default"
	end
	local datasounds = module.FootStepsData[sounds]
	return datasounds[math.random(1,#datasounds)]
end

function module.ChangeSurvivalStats(stat, SetNum, num)
	local stat = stat:lower()
	local stat = stat:sub(1,1):upper()..stat:sub(2)
	if Survival.SurvivalStats[stat] ~= nil then
		if num >= -1000 and num <= 1000 then
			if SetNum then
				if num > 0 then
					Survival.SurvivalStats[stat] = math.min(num,1000)
				else
					Survival.SurvivalStats[stat] = 0
				end
			else
				if (Survival.SurvivalStats[stat] + num) < 0 then
					Survival.SurvivalStats[stat] = 0
				elseif (Survival.SurvivalStats[stat] + num) > 1000 then
					Survival.SurvivalStats[stat] = 1000
				else
					Survival.SurvivalStats[stat] += num
				end
			end
		else
			print(num.." TOO BIG OR TOO SMALL!")
		end
	else
		print(stat.." DOES NOT EXIST!")
	end
end

function module.ConvertStringToTable(s,alt)
	local ravno = "="
	local zapataia = ","
	if alt then
		ravno = "*"
		zapataia = "`"
	end

	local objs = string.split(s,zapataia)
	local tabl = {}
	for _,i in pairs(objs) do
		local j = string.split(i,ravno)
		tabl[j[1]] = j[2]
	end
	return tabl
end

function module.ConvertTableToString(tab, alt)
	local result = ""
	local t = "="
	local t2 = ","
	if alt then
		t = "*"
		t2 = "`"
	end
	for stat,i in pairs(tab) do
		result = result .. stat .. t .. tostring(i) .. t2
	end
	return result
end

function module.ConvertToolToString(tool)
	local result = ""
	local values = {}
	for i,part in pairs(tool:GetDescendants()) do
		
		if part:IsA("StringValue") or part:IsA("BoolValue") or part:IsA("BrickColorValue") or part:IsA("CFrameValue") or part:IsA("Color3Value") or part:IsA("IntValue") or part:IsA("NumberValue") or part:IsA("ObjectValue") or part:IsA("RayValue") or part:IsA("Vector3Value") then
			values[part.Name] = tostring(part.Value) .. "|" .. part.className
		end
	end
	result = module.ConvertTableToString(values,true)
	return result
end

function module.ConvertStringToBoolean(s)
	if s == "true" then return true else return false end
end

function module.GetActiveGui(set,tab)
	if set then
		local newtab = module.ConvertStringToTable(tab,true)
		for _, gui in pairs(game.Players.LocalPlayer:WaitForChild("PlayerGui"):GetChildren()) do
			gui.Enabled = module.ConvertStringToBoolean(newtab[gui.Name])
		end
	else
		local activiesguies = {}
		for _, gui in pairs(game.Players.LocalPlayer:WaitForChild("PlayerGui"):GetChildren()) do
			activiesguies[gui.Name] = tostring(gui.Enabled)
		end
		return module.ConvertTableToString(activiesguies,true)
	end
end

function module.GetInventory()
	local tools = {}
	local ply = game.Players.LocalPlayer
	for i,tool in pairs(ply:WaitForChild("Backpack"):GetChildren()) do
		table.insert(tools,tool)
	end
	local char = ply.Character or ply.CharacterAdded:Wait()
	if char:FindFirstChildOfClass("Tool") then
		table.insert(tools,char:FindFirstChildOfClass("Tool"))
	end
	if #tools == 0 then return "" end
	local toolsnew = ""
	for i,tool in pairs(tools) do
		toolsnew = toolsnew..tool.Name.."$"..module.ConvertToolToString(tool).."%"
	end
	return toolsnew
end

function module.GetStats(stat)
	local stat = stat:lower()
	
	if stat == "health" then
		return hum.Health
	end
	
	local stat = stat:sub(1,1):upper()..stat:sub(2)
	if Survival.SurvivalStats[stat] ~= nil then
		return Survival.SurvivalStats[stat]
	else
		print(stat.." DOES NOT EXIST!")
		return nil
	end
end

game:GetService("ReplicatedStorage"):WaitForChild("GetSurvivalStat").OnClientInvoke  = function()
	return module.ConvertTableToString(Survival.SurvivalStats)
end
	
game:GetService("ReplicatedStorage"):WaitForChild("GetInventory").OnClientInvoke  = function()
	return module.GetInventory()
end

game:GetService("ReplicatedStorage"):WaitForChild("GetGui").OnClientInvoke  = function(x,y)
	return module.GetActiveGui(x,y)
end

game:GetService("ReplicatedStorage"):WaitForChild("SetSurvivalStat").OnClientEvent:Connect(function(stati)
	for stat, i in pairs(stati) do
		module.ChangeSurvivalStats(stat,true,tonumber(i))
	end
end)


game.ReplicatedStorage.ChangeStat.OnClientEvent:Connect(module.ChangeSurvivalStats)

return module
