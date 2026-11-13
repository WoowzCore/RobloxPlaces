local liquidmodule = require(game:GetService("ServerStorage").LIQUIDS)
local rs = game:GetService("ReplicatedStorage")
local base = require(game:GetService("ServerScriptService").Base)
local plrs = game:GetService("Players")
local plrdatas = require(game:GetService("ServerStorage").PLAYERSDATA)

local data = nil

script.Parent.LiquidInsert:GetPropertyChangedSignal("Value"):Connect(function()
	local liquid = script.Parent.LiquidInsert.Value
	local liquiddata = liquidmodule.list[liquid]
	data = liquiddata
	local part = script.Parent.Liquid
	if liquiddata == nil then
		part.Transparency = 1
		part.Smoke.Enabled = false
	else
		part.Material = liquiddata["Style"][1]
		part.Transparency = liquiddata["Style"][2]
		part.Color = liquiddata["Style"][3]
		if liquiddata["Style"][4] ~= "" then
			local gas = liquidmodule.gases[liquiddata["Style"][4]]
			part.Smoke.Color = ColorSequence.new(gas[1])
			part.Smoke.EmissionDirection = (gas[2]) and Enum.NormalId.Left or Enum.NormalId.Right
			part.Smoke.Enabled = true
		else
			part.Smoke.Enabled = false
		end
	end
end)

local using = false
script.Parent.Use.Event:Connect(function(plr)
	if script.Parent.LiquidInsert.Value ~= "" and not using and data ~= nil then
		using = true
		rs.Player.PlayAnimationOnce:FireClient(plr,"Tool_Drink")
		wait(0.275)
		base.PlaySound("1481574895",script.Parent.Handle.Position,1,5,1)
		if data["Function"] then
			data["Function"](plr)
		end
		liquidmodule.Drink(plr,script.Parent.LiquidInsert.Value)
		script.Parent.LiquidInsert.Value = ""
		wait(0.025)
		using = false
	end
end)

while wait(0.01) do
	local showtop = 1
	
	local desc = ""
	if script.Parent.LiquidInsert.Value ~= "" then
		if script.Parent.Parent:FindFirstChildOfClass("Humanoid") then
			local plrbase = plrdatas.Data[tostring(plrs:GetPlayerFromCharacter(script.Parent.Parent).UserId)]
			if plrbase.MovingData.Crawl or plrbase.Ragdoll or plrbase.ThrowPower>0 or plrbase.AttackMode then showtop = 0 end
		else
			if not script.Parent.Handle:FindFirstChild("WeldForCup") then
				showtop = 0
			end
		end
		script.Parent.Animation.Value = "Tool_Cup"
		if liquidmodule.list[script.Parent.LiquidInsert.Value]["Texts"][2] ~= "" then
			desc = "liquid.desc."..liquidmodule.list[script.Parent.LiquidInsert.Value]["Texts"][2]
		else
			desc = "liquid.desc"
		end
	else
		script.Parent.Animation.Value = "Tool"
	end
	
	script.Parent.Top.Transparency = showtop
	script.Parent.Description.Value = desc
end