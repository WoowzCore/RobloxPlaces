local rs = game:GetService("ReplicatedStorage")
local base = require(game:GetService("ServerScriptService").Base)
local grenade = script.Parent
local otorvano_kolco = false
local activated_grenade = false
local exploded = false
local waitotorvatkolco = 0
local dontwork = (math.random(0,100)>=97)

local function Otorvat_Kolco(bool,playsound)
	if playsound==nil then playsound = true end
	otorvano_kolco = bool
	if playsound then grenade.Handle.Sound:Play() end
	grenade.Handle.WeldConstraintKolco.Enabled = not bool
	grenade.GrenadePartKolco.CanCollide = bool
end

local function Active_Grenade()
	activated_grenade = true
	local dragdetector = game:GetService("ServerStorage").SCRIPTS.DragDetector:Clone()
	dragdetector.Parent = grenade.Handle
	grenade.Handle.ClickDetector:Destroy()
	grenade.Handle.MouseOver:Destroy()
	grenade.Handle.WeldConstraintRycoiat.Enabled = false
	grenade.GrenadePartRycoiat.CanCollide = true
end

local function Explode()
	exploded = true
	if not dontwork then
		grenade.Handle.Anchored = true
		grenade.Handle.CanCollide = false
		grenade.Handle.WeldConstraint:Destroy()
		grenade.GrenadePart:Destroy()
		base.Explosion(grenade.Handle.Position,10)
		wait(120)
		grenade:Destroy()
	end
end

local function ExplodeEvent()
	wait(math.random(0,10)/10)
	base.Explosion(grenade.Handle.Position,10)
	grenade:Destroy()
end
grenade.Exploded.Event:Connect(ExplodeEvent)

grenade.Use.Event:Connect(function()
	if not exploded then
		if not activated_grenade and waitotorvatkolco>5 then
			waitotorvatkolco = 0
			Otorvat_Kolco(not otorvano_kolco)
		end
	end
end)

local timer = 0
local backpack = false
while wait() do
	if not exploded then
		waitotorvatkolco += 1
		if grenade.Parent.Name ~= backpack then
			backpack = grenade.Parent.Name
			if backpack == "Backpack" then
				Otorvat_Kolco(false,false)
			else
				if otorvano_kolco then
					Active_Grenade()
				end
			end
		end
		
		if activated_grenade then
			timer += 1
			if timer >= 125 then
				Explode()
			end
		end
	end
end