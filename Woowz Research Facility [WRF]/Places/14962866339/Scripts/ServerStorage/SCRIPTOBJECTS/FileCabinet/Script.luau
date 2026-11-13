local obj = script.Parent
local base = require(game:GetService("ServerScriptService").Base)
local loottable = game:GetService("ServerStorage").LOOTTABLE.Zone13.Value:split(",")

local cartoteg = {obj.Cartoteg1,obj.Cartoteg2,obj.Cartoteg3}
local cartoteg_startpos = {cartoteg[1].PrimaryPart.CFrame,cartoteg[2].PrimaryPart.CFrame,cartoteg[3].PrimaryPart.CFrame}
local cartoteg_pos = {obj.Cartoteg1Pos,obj.Cartoteg2Pos,obj.Cartoteg3Pos}
local cartoteg_bool = {false,false,false}

local item = {"","",""}
local firstopen = {false,false,false}
local function GenerateItem(id)
	if math.random(0,100)>75 then
		item[id] = loottable[math.random(1,#loottable)]
		cartoteg[id].sign.Decal.Texture = "rbxassetid://16500445803"
	end
end

local function OpenCartoteg(id)
	cartoteg_bool[id] = not cartoteg_bool[id]
	if firstopen[id]==false then
		firstopen[id] = true
		if item[id] ~= "" then local item_ = base.CreateItem(item[id],cartoteg[id].Trash1.Position)
			local weld = Instance.new("WeldConstraint",cartoteg[id])
			weld.Name = "WeldItem"
			weld.Part0 = cartoteg[id].Union
			weld.Part1 = item_.Handle
			local e = item_.Handle.ClickDetector.ClickDetectorScript.Event.Event:Connect(function()
				weld:Destroy()
			end)
		cartoteg[id].Trash1:Destroy() cartoteg[id].Trash2:Destroy() cartoteg[id].Trash3:Destroy() end
	end
	if cartoteg_bool[id] then
		base.ts(cartoteg[id].PrimaryPart,TweenInfo.new(2),{CFrame = cartoteg_pos[id].CFrame})
	else
		base.ts(cartoteg[id].PrimaryPart,TweenInfo.new(2),{CFrame = cartoteg_startpos[id]})
	end
end

for i=1,3 do
	GenerateItem(i)
	cartoteg[i].Union.ClickDetector.ClickDetectorScript.Event.Event:Connect(function()
		OpenCartoteg(i)
	end)
end