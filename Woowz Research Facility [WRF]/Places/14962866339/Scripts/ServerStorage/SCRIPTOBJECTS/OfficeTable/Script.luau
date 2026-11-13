local obj = script.Parent
local base = require(game:GetService("ServerScriptService").Base)
local loottable = game:GetService("ServerStorage").LOOTTABLE.Zone13.Value:split(",")

local cartoteg = {obj.Iashik1,obj.Iashik2}
local cartoteg_startpos = {cartoteg[1].PrimaryPart.CFrame,cartoteg[2].PrimaryPart.CFrame}
local cartoteg_pos = {obj.lashik1_pos,obj.lashik2_pos}
local cartoteg_bool = {false,false}

local item = {"",""}
local firstopen = {false,false}
local function GenerateItem(id)
	if math.random(0,100)>25 then
		item[id] = loottable[math.random(1,#loottable)]
	end
end

local function OpenCartoteg(id)
	cartoteg_bool[id] = not cartoteg_bool[id]
	if firstopen[id]==false then
		firstopen[id] = true
		if item[id] ~= "" then local item_ = base.CreateItem(item[id],cartoteg[id].Base.Position)
			local weld = Instance.new("WeldConstraint",cartoteg[id])
			weld.Name = "WeldItem"
			weld.Part0 = cartoteg[id].Union
			weld.Part1 = item_.Handle
			local e = item_.Handle.ClickDetector.ClickDetectorScript.Event.Event:Connect(function()
				weld:Destroy()
			end)
		end
	end
	if cartoteg_bool[id] then
		base.ts(cartoteg[id].PrimaryPart,TweenInfo.new(1),{CFrame = cartoteg_pos[id].CFrame})
	else
		base.ts(cartoteg[id].PrimaryPart,TweenInfo.new(1),{CFrame = cartoteg_startpos[id]})
	end
end

for i=1,2 do
	GenerateItem(i)
	cartoteg[i].Part_Mebel_office1.ClickDetector.ClickDetectorScript.Event.Event:Connect(function()
		OpenCartoteg(i)
	end)
end