local dispancer = script.Parent
local rs = game:GetService("ReplicatedStorage")
local liquids = require(game:GetService("ServerStorage").LIQUIDS)
local base = require(game:GetService("ServerScriptService").Base)

local worken = false
local hascup = false

dispancer.Platform.ClickDetector.ClickDetectorScript.Event.Event:Connect(function(plr)
	if hascup then return end
	local chr = plr.Character or plr.CharacterAdded:Wait()
	local tool = chr:FindFirstChildOfClass("Tool")
	if tool then
		if tool.Name == "PlasticCup" then
			if tool.LiquidInsert.Value == "" then
				rs.DropItemSERVER:Fire(tool,dispancer.Platform.CupPos.CFrame)
				local weld = Instance.new("WeldConstraint")
				weld.Parent = tool.Handle
				weld.Part0 = dispancer.Platform
				weld.Part1 = tool.Handle
				weld.Name = "WeldForCup"
				hascup = tool
				local e = tool.Handle.ClickDetector.ClickDetectorScript.Event.Event:Connect(function()
					if tool.ToolScript.CantTake.Value then return end
					hascup = false
					weld:Destroy()
				end)
			end
		end
	end
end)

local CanWork = false

local acceptsliquids = "фурацилин,уксус,жидкий натрий,кислота,вода,спирт,ртуть,слизь,масло,мыло,отбеливатель,бензин,керосин,нефть,ацетон,реактивное топливо,клей,перекись водорода,йод,хлоргексидин,полироль,антифриз,адреналин,жидкое стекло,лава,жидкое железо"

script.Parent.Liquid:GetPropertyChangedSignal("Value"):Connect(function()
	local liquid = base.lower(script.Parent.Liquid.Value)
	if string.find(acceptsliquids,liquid..",") then
		CanWork = true
	else
		CanWork = false
		script.Parent.Liquid.Value = "error"..math.random()
	end
end)

local function Work()
	if hascup.LiquidInsert.Value ~= "" then return end
	local liqdat = liquids.list[base.lower(script.Parent.Liquid.Value)]
	if liqdat == nil then error("DispenserChemicalLiquid: Liquid ["..script.Parent.Liquid.Value.." -> "..base.lower(script.Parent.Liquid.Value).."] data not found!") return end
	script.Parent.Worked.Value = true
	worken = true
	local part = script.Parent.Particles.ParticleEmitter
	part.Color = ColorSequence.new(liqdat["Style"][3])
	part.Transparency = NumberSequence.new(liqdat["Style"][2]/2)
	if liqdat["Style"][1] == Enum.Material.Neon then
		part.Brightness = 1
		part.LightEmission = 1
		part.LightInfluence = 1
	else
		part.Brightness = 0.4
		part.LightEmission = 0
		part.LightInfluence = 0
	end
	
	part.Enabled = true
	base.ts(script.Parent.Platform.Weld,TweenInfo.new(0.5),{C0 = CFrame.new(0.54,1.1,0)})
	wait(4)
	hascup.LiquidInsert.Value = base.lower(script.Parent.Liquid.Value)
	wait(1)
	part.Enabled = false
	base.ts(script.Parent.Platform.Weld,TweenInfo.new(0.5),{C0 = CFrame.new(0.54,-1.17,0)})
	script.Parent.Worked.Value = false
	worken = false
	hascup.ToolScript.CantTake.Value = false
end

local buttonpressed = false
script.Parent.Button.ClickDetector.ClickDetectorScript.Event.Event:Connect(function()
	if buttonpressed then return end
	if hascup then hascup.ToolScript.CantTake.Value = true end
	buttonpressed = true
	base.ts(script.Parent.Button.Weld,TweenInfo.new(0.5),{C0 = CFrame.new(0,0,0)})
	wait(0.5)
	if CanWork and not worken and hascup then
		Work()	
	end
	base.ts(script.Parent.Button.Weld,TweenInfo.new(0.5),{C0 = CFrame.new(0.1,0,0)})
	wait(0.5)
	buttonpressed = false
end)

local redbutton_ = false
while wait() do
	local redbutton = hascup~=false and CanWork and not worken
	
	if redbutton_ ~= redbutton then
		redbutton_ = redbutton
		if redbutton then
			script.Parent.Button.Material = Enum.Material.Neon
			script.Parent.Button.Color = Color3.fromRGB(206, 33, 33)
			script.Parent.Button.PointLight.Enabled = true
		else
			script.Parent.Button.Material = Enum.Material.Glass
			script.Parent.Button.Color = Color3.fromRGB(103, 36, 36)
			script.Parent.Button.PointLight.Enabled = false
		end
	end
end