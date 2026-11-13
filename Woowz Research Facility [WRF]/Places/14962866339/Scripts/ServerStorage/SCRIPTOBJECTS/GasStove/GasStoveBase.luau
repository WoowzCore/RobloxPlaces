local base = require(game:GetService("ServerScriptService").Base)
local kamforka_enable = {}
local kamforka_wait = {}
local kamforka_fire = {}
local allkamforka = {1,2,3,4,5,6,7,8}

local EXPLODED = false

local firethis = {}

function addtriggerzone(kamforkaid)
	local trigger = script.Parent:FindFirstChild("TRIGGER"..kamforkaid)
	trigger.Touched:Connect(function(hit)
		if kamforka_fire["Kamforka"..kamforkaid] then
			table.insert(firethis,hit)
		end
	end)
	trigger.TouchEnded:Connect(function(hit)
		for _, part in pairs(firethis) do
			if part==hit then
				table.remove(firethis,_)
			end
		end
	end)
end

local i = 1
while i <= 8 do
	local krytilka = script.Parent["Krytilka"..i]
	kamforka_enable[krytilka.Name] = false
	kamforka_wait[krytilka.Name] = false
	krytilka.Krytilka.ClickDetector.ClickDetectorScript.Event.Event:Connect(function()
		if kamforka_wait[krytilka.Name] then return end
		kamforka_wait[krytilka.Name] = true
		kamforka_enable[krytilka.Name] = not kamforka_enable[krytilka.Name]
		local rot = 0
		if kamforka_enable[krytilka.Name] then
			rot = 90
		end
		base.ts(krytilka.Weld.Weld,TweenInfo.new(0.2),{C0 = CFrame.new(0.145, 0, 0) * CFrame.Angles(math.rad(rot),0,0)})
		wait(0.2)
		kamforka_wait[krytilka.Name] = false
	end)
	
	addtriggerzone(i)
	
	i +=1 
end

local kanforka_changed = {}

local function Fire(kamforka)
	if kamforka_fire[kamforka.Name] == true then return end
	kamforka_fire[kamforka.Name] = true
	kamforka.center.gas:Stop()
	kamforka.center.fire:Play()
	kamforka.center.gasparticle.Enabled = false
	kamforka.center.PointLight.Enabled = true
	for _, j in pairs({1,2,3,4,5,6,7,8,9,10,11,12}) do
		kamforka["fire"..j].gasstovefireparticle.Enabled = true
	end
end

local buttoncframe = script.Parent.FIRE.Button.CFrame
local buttonwait = false
script.Parent.FIRE.Button.ClickDetector.ClickDetectorScript.Event.Event:Connect(function()
	if buttonwait then return end
	buttonwait = true
	base.ts(script.Parent.FIRE.Button,TweenInfo.new(0.1),{CFrame = script.Parent.FIRE.ButtonPos.CFrame})
	wait(0.1)
	if math.random(0,100) >= 30 then
		for _, k in pairs(allkamforka) do
			if kanforka_changed["Kamforka"..k] then
				Fire(script.Parent["Kamforka"..k])
			end
		end
	end
	base.ts(script.Parent.FIRE.Button,TweenInfo.new(0.1),{CFrame = buttoncframe})
	wait(0.1)
	buttonwait = false
end)

local function ChangeActive(kamforka,bool)
	if kanforka_changed[kamforka.Name] == bool then 
		if bool then
			kamforka.center.PointLight.Brightness = math.random(200,250)/10
		end
	return end
	
	kamforka.center.gasparticle.Enabled = bool
	
	if bool then
		kamforka.center.gas:Play()
	else
		kamforka_fire[kamforka.Name] = false
		kamforka.center.gas:Stop()
		kamforka.center.fire:Stop()
		kamforka.center.PointLight.Enabled = false
		for _, j in pairs({1,2,3,4,5,6,7,8,9,10,11,12}) do
			kamforka["fire"..j].gasstovefireparticle.Enabled = false
		end
	end
	
	kanforka_changed[kamforka.Name] = bool
end

local function Explosive()
	if EXPLODED then return end
	EXPLODED = true

	for _, k in pairs(allkamforka) do
		ChangeActive(script.Parent["Kamforka"..k],false)
	end
	
	for _, part in pairs(script.Parent:GetDescendants()) do
		if part:IsA("ParticleEmitter") or part:IsA("ClickDetector") or part.Name == "MouseOver" then
			part:Destroy()
		end
	end
	
	local d1,d2 = script.Parent.DoorL.Position,script.Parent.DoorR.Position
	if math.random(0,100) >= 50 then
		local d = d2
		d2 = d1
		d1 = d
	end
	
	if script.Parent:FindFirstChild("explosiondecal") then
		script.Parent:FindFirstChild("explosiondecal").Decal.Transparency = 0
	end
	
	base.Explosion(d1,math.random(8,12))
	wait(math.random(0,200)/100)
	base.Explosion(d2,math.random(8,12))
end

script.Parent.Exploded.Event:Connect(function()
	Explosive()
end)


local waitexplosive = {}

local explosivestis = math.random(10000,25000)

local infire = 1

while wait() do
	if not EXPLODED then
		for _, k in pairs(allkamforka) do
			ChangeActive(script.Parent["Kamforka"..k],kamforka_enable["Krytilka"..k])
			
			if kanforka_changed["Kamforka"..k] == true and kamforka_fire["Kamforka"..k] == false then
				if waitexplosive["Kamforka"..k] == nil then waitexplosive["Kamforka"..k] = 0 end
				waitexplosive["Kamforka"..k] = waitexplosive["Kamforka"..k] + 1
			
			else
				waitexplosive["Kamforka"..k] = 0
			end
		end
		
		if (kamforka_fire["Kamforka1"] == true or kamforka_fire["Kamforka2"] == true or kamforka_fire["Kamforka3"] == true or kamforka_fire["Kamforka4"] == true or kamforka_fire["Kamforka5"] == true or kamforka_fire["Kamforka6"] == true or kamforka_fire["Kamforka7"] == true or kamforka_fire["Kamforka8"] == true) then
			infire = 10
		else
			infire = 1
		end
		
		local j = 0
		for _, k in pairs(waitexplosive) do
			j += k		
		end
		if j >= (explosivestis/infire) then
			Explosive()
		end
		
		for _, part in pairs(firethis) do
			if part ~= nil then
				if part.Parent ~= nil then
					if part.Parent:FindFirstChildWhichIsA("Humanoid") then
						if math.random(0,100)>=50 then
							base.HitBodyPart(part,"burn",1)
						end
					end
				end
			end
		end
	end
end