local rs = game:GetService("ReplicatedStorage")
local base = require(script.Parent:WaitForChild("PlayerBase"))
local plrscript = require(script.Parent:WaitForChild("PlayerScript"))

local drink_list = {
	["melted"] = function()
		local i = 0
		local rand = math.random(10,40)
		while i < rand do
			i += 1
			local part = base.Parts.Head
			if math.random(0,100)>50 then
				part = base.Parts.Torso
			end
			rs.Hurt:FireServer(part,"burn",math.random(10,40))
			if math.random(0,100)>30 then
				wait(0.01)
			end
		end
	end,
	["acid"] = function()
		local i = 0
		local rand = math.random(50,100)
		while i < rand do
			i += 1
			local part = base.Parts.Head
			if math.random(0,100)>50 then
				part = base.Parts.Torso
			end
			rs.Hurt:FireServer(part,"acid",math.random(3,10))
			if math.random(0,100)>30 then
				wait(0.01)
			end
		end
	end,
	["fullstamina"] = function()
		base.Stamina = 100
	end,
	["energy"] = function()
		base.Stamina = 100
		base.Drinks.StaminaRecovery[2] = math.min(base.Drinks.StaminaRecovery[2]+25,100)
		base.Drinks.StaminaRecovery[1] = 2.5
	end,
	["power"] = function()
		base.Stamina = 100
		base.Drinks.StaminaSpending[2] = math.min(base.Drinks.StaminaSpending[2]+25,100)
		base.Drinks.StaminaSpending[1] = 2.5
	end,
	["recoverbones"] = function()
		base.Stamina = 100
		for name, died in pairs(base.PartsDead) do
			if died then
				rs.SetHealth:FireServer(base.Parts[name],5)
			end
		end
	end,
	["explode"] = function()
		local rand = math.random()*5
		wait(rand)
		local pos = base.Parts.Root.Position
		rs.Hurt:FireServer(base.Parts.Head,"inside",math.huge)
		rs.Explode:FireServer(pos,math.random(1,3))
	end,
	["paralize"] = function()
		local rand = math.random()*5
		wait(rand)
		base.Drinks.Paralize = base.Drinks.Paralize+35
	end,
	["poison"] = function()
		local i = 0
		local rand = math.random(50,1000)
		while i < rand do
			i += 1
			local part = base.Parts.Head
			if math.random(0,100)>50 then
				part = base.Parts.Torso
			end
			rs.Hurt:FireServer(part,"none",math.random(1,3))
			local r = math.random()*3
			wait(r)
		end
	end,
	["speedup"] = function()
		base.Stamina = 100
		base.Drinks.Speed[2] = math.min(base.Drinks.Speed[2]+25,100)
		base.Drinks.Speed[1] = 1.5
	end,
	["vinegar"] = function()
		base.Drinks.Paralize = base.Drinks.Paralize+35
		
		local i = 0
		local rand = math.random(50,100)
		while i < rand do
			i += 1
			local part = base.Parts.Head
			if math.random(0,100)>50 then
				part = base.Parts.Torso
			end
			rs.Hurt:FireServer(part,"acid",math.random(1,5))
			if math.random(0,100)>30 then
				wait(0.01)
			end
		end
	end,
	["toxic1"] = function()
		base.Poison = base.Poison+math.random(1,15)
	end,
	["toxic2"] = function()
		base.Poison = base.Poison+math.random(10,30)
	end,
	["toxic3"] = function()
		base.Poison = base.Poison+math.random(30,100)
	end,
	["alchocol"] = function()
		base.Drunk = base.Drunk+15
		if base.Drunk > 100 then
			base.Drunk = 100
			base.Poison = base.Poison+math.random(1,30)
		end
	end,
}

rs.Player.Drink.OnClientEvent:Connect(function(id,liquiddata,name)
	local drinktext = liquiddata["Texts"][1]
	local text = base.t.g("liquid.drink")
	if drinktext ~= "" then
		text = base.t.g("liquid.drink."..drinktext)
	end
	plrscript.Splash(text)
	if id == nil then
		warn("Отсутствует эффект для жидкости ["..name.."]!")
	else
		if id ~= "none" then
			drink_list[id]()
		end
	end
end)