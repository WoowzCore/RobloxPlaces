local clock = script.Parent
local data = game:GetService("ServerScriptService").ServerInfo.Data
local active = true
local base = require(game:GetService("ServerScriptService").Base)
local datas = require(game:GetService("ServerStorage").Datas)
local light = script.Parent.light.SurfaceLight
local light2 = script.Parent.light2.SurfaceLight

local gui = clock.gui

local randsymbols = {
	"a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z",
	"A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z",
	"0","1","2","3","4","5","6","7","8","9",
	"!","?","<",">","+","-","=",".","/","\\","%","$","#","№","@","&","*","(",")","|","[","]","~"
}

local function GetLocalId()
	local result = ""
	local symbols = math.random(4,7)
	local i = 0
	while i < symbols do
		i += 1
		result = result..randsymbols[math.random(1,#randsymbols)]
	end
	return result
end

gui.SurfaceGui.localid.Text = "LOCAL ID: "..GetLocalId()

local number = {
	["0"] = {true,true,true,true,true,true,false},
	["1"] = {false,true,true,false,false,false,false},
	["2"] = {true,false,true,true,false,true,true},
	["3"] = {true,true,true,true,false,false,true},
	["4"] = {false,true,true,false,true,false,true},
	["5"] = {true,true,false,true,true,false,true},
	["6"] = {true,true,false,true,true,true,true},
	["7"] = {false,true,true,true,false,false,false},
	["8"] = {true,true,true,true,true,true,true},
	["9"] = {true,true,true,true,true,false,true},
	["empty"] = {false,false,false,false,false,false,false}
}

local colors = {
	["red"] = Color3.fromRGB(161, 0, 0),
	["green"] = Color3.fromRGB(0, 161, 5),
	["blue"] = Color3.fromRGB(0, 70, 161),
	["yellow"] = Color3.fromRGB(158, 145, 0)
}
local color = script.Parent.NumbersColor

local function ChangeGlow(obj,bool)
	if bool then
		obj.Material = Enum.Material.Neon
		obj.Color = colors[color.Value]
		obj.Transparency = 0
	else
		obj.Transparency = 1
	end
end

local function ChangeNumber(num,tothis)
	local numdata = tothis
	if numdata ~= nil then
		local i = 1
		while i <= 11 do
			if num:FindFirstChild("P"..tostring(i)) ~= nil then
				ChangeGlow(num:FindFirstChild("P"..tostring(i)),numdata[i] or false)
			end
			i += 1
		end
	else
		print("ERROR ["..tostring(tothis).."] not found")
	end
end

local numday1, numday2 = clock.Number1,clock.Number2
local nummou1, nummou2 = clock.Number3, clock.Number4
local numyear1,numyear2,numyear3,numyear4 = clock.Number5,clock.Number6,clock.Number7,clock.Number8
local nummouword1,nummouword2,nummouword3 = clock.Number9, clock.Number10,clock.Number11
local numhour1,numhour2 = clock.Number12,clock.Number13
local nummin1, nummin2 = clock.Number14,clock.Number15

local dot_DAYMOUT = clock.DOT1
local dot_MOUTYEAR = clock.DOT2
local dot_TIME1,dot_TIME2 = clock.DOT3,clock.DOT4

local alphabet = {
	["J"] = {true,true,true,false,false,false},
	["A"] = {false,true,true,true,true,true,true},
	["N"] = {false,true,true,false,true,true,false,false,true},
	["F"] = {false,false,false,true,true,true,true},
	["E"] = {true,false,false,true,true,true,true},
	["B"] = {true,false,false,false,true,true,true,true,true},
	["M"] = {false,true,true,true,true,true,false,false,false,true},
	["R"] = {false,false,true,true,true,true,true,true},
	["P"] = {false,false,true,true,true,true,true},
	["Y"] = {true,true,true,false,true,false,true},
	["U"] = {true,true,true,false,true,true},
	["L"] = {true,false,false,false,true,true,false},
	["G"] = {true,true,false,true,true,true,false},
	["S"] = {true,true,false,true,true,false,true},
	["O"] = number["0"],
	["C"] = {true,false,false,true,true,true,false},
	["T"] = {false,false,false,true,false,false,false,false,false,true,true},
	["V"] = {false,true,true,false,true,false,false,true},
	["D"] = {true,true,true,false,false,true,true}
}

local monts = {
	["0"] = {number["empty"],number["empty"],number["empty"]},
	["1"] = {
		alphabet["J"],alphabet["A"],alphabet["N"]
	},
	["2"] = {
		alphabet["F"],alphabet["E"],alphabet["B"]
	},
	["3"] = {
		alphabet["M"],alphabet["A"],alphabet["R"]
	},
	["4"] = {
		alphabet["A"],alphabet["P"],alphabet["R"]
	},
	["5"] = {
		alphabet["M"],alphabet["A"],alphabet["Y"]
	},
	["6"] = {
		alphabet["J"],alphabet["U"],alphabet["N"]
	},
	["7"] = {
		alphabet["J"],alphabet["U"],alphabet["L"]
	},
	["8"] = {
		alphabet["A"],alphabet["U"],alphabet["G"]
	},
	["9"] = {
		alphabet["S"],alphabet["E"],alphabet["P"]
	},
	["10"] = {
		alphabet["O"],alphabet["C"],alphabet["T"]
	},
	["11"] = {
		alphabet["N"],alphabet["O"],alphabet["V"]
	},
	["12"] = {
		alphabet["D"],alphabet["E"],alphabet["C"]
	}
}

local function UpdateScreen()
	if active then
		ChangeNumber(nummouword1,monts[tostring(data.Month.Value)][1])
		ChangeNumber(nummouword2,monts[tostring(data.Month.Value)][2])
		ChangeNumber(nummouword3,monts[tostring(data.Month.Value)][3])
		ChangeGlow(dot_DAYMOUT,true)
		ChangeGlow(dot_MOUTYEAR,true)
		
		local numday = "0"..tostring(data.Day.Value)
		ChangeNumber(numday1,number[base.GetSymbolFromString(numday,-2)])
		ChangeNumber(numday2,number[base.GetSymbolFromString(numday,-1)])
		local nummou = "0"..tostring(data.Month.Value)
		ChangeNumber(nummou1,number[base.GetSymbolFromString(nummou,-2)])
		ChangeNumber(nummou2,number[base.GetSymbolFromString(nummou,-1)])
		local numyear = tostring(data.Year.Value)
		ChangeNumber(numyear1,number[base.GetSymbolFromString(numyear,1)])
		ChangeNumber(numyear2,number[base.GetSymbolFromString(numyear,2)])
		ChangeNumber(numyear3,number[base.GetSymbolFromString(numyear,3)])
		ChangeNumber(numyear4,number[base.GetSymbolFromString(numyear,4)])
		local numhour = "0"..tostring(data.Hour.Value)
		ChangeNumber(numhour1,number[base.GetSymbolFromString(numhour,-2)])
		ChangeNumber(numhour2,number[base.GetSymbolFromString(numhour,-1)])
		local nummin = "0"..tostring(data.Minute.Value)
		ChangeNumber(nummin1,number[base.GetSymbolFromString(nummin,-2)])
		ChangeNumber(nummin2,number[base.GetSymbolFromString(nummin,-1)])
	end
end

local function EnabledScreen(bool)
	active = bool
	
	if active then
		UpdateScreen()
		light.Color = colors[color.Value]
		light.Enabled = true
		light2.Color = colors[color.Value]
		light2.Enabled = true
	else
		local i = 1
		while i <= 15  do
			ChangeNumber(clock["Number"..tostring(i)],number["empty"])
			i += 1
		end
		ChangeGlow(dot_TIME1,false)
		ChangeGlow(dot_TIME2,false)
		ChangeGlow(dot_DAYMOUT,false)
		ChangeGlow(dot_MOUTYEAR,false)
		light.Enabled = false
		light2.Enabled = false
	end
end

color:GetPropertyChangedSignal("Value"):Connect(function()
	light.Color = colors[color.Value]
	light2.Color = colors[color.Value]
end)

EnabledScreen(true)

local function ChangeGlowDisplayIcon(icon,bool)
	if bool then
		icon.ImageColor3 = Color3.fromRGB(255, 191, 0)
	else
		icon.ImageColor3 = Color3.fromRGB(80, 59, 0)
	end
end

local texti = 0
local dotglow = true
while wait(0.5) do
	if active and datas.Sirens~=nil then
		UpdateScreen()
		
		dotglow = not dotglow
		ChangeGlow(dot_TIME1,dotglow)
		ChangeGlow(dot_TIME2,dotglow)
		
		ChangeGlowDisplayIcon(gui.SurfaceGui.icon1,data.Emergency.Value)
		ChangeGlowDisplayIcon(gui.SurfaceGui.icon2,data.SirenType.Value ~= "empty")
		local warningtext = "Всё в норме!ㅤ"
		if data.SirenType.Value~="empty" then
			warningtext = datas.Sirens[data.SirenType.Value][3][1].."!ㅤ"
		end
		
		texti -= 0.05
		if texti < -1 then
			texti = 0
		end
		gui.SurfaceGui.warningtext.Text = warningtext
		gui.SurfaceGui.warningtext1.Text = warningtext
		gui.SurfaceGui.warningtext2.Text = warningtext
		if texti ~= 0 then
			if texti >= -0.07 then
				gui.SurfaceGui.warningtext.Position = UDim2.new(0,0,0.25,0)
				gui.SurfaceGui.warningtext1.Position = UDim2.new(-1,0,0.25,0)
				gui.SurfaceGui.warningtext2.Position = UDim2.new(1,0,0.25,0)
			end
			base.ts(gui.SurfaceGui.warningtext,TweenInfo.new(0.5,Enum.EasingStyle.Linear),{Position = UDim2.new(texti,0,0.25,0)})
			base.ts(gui.SurfaceGui.warningtext1,TweenInfo.new(0.5,Enum.EasingStyle.Linear),{Position = UDim2.new(texti-1,0,0.25,0)})
			base.ts(gui.SurfaceGui.warningtext2,TweenInfo.new(0.5,Enum.EasingStyle.Linear),{Position = UDim2.new(texti+1,0,0.25,0)})
		else
			base.ts(gui.SurfaceGui.warningtext,TweenInfo.new(0.5,Enum.EasingStyle.Linear),{Position = UDim2.new(texti-1,0,0.25,0)})
			base.ts(gui.SurfaceGui.warningtext1,TweenInfo.new(0.5,Enum.EasingStyle.Linear),{Position = UDim2.new(texti-1-1,0,0.25,0)})
			base.ts(gui.SurfaceGui.warningtext2,TweenInfo.new(0.5,Enum.EasingStyle.Linear),{Position = UDim2.new(texti+1-1,0,0.25,0)})
		end
	end	
end