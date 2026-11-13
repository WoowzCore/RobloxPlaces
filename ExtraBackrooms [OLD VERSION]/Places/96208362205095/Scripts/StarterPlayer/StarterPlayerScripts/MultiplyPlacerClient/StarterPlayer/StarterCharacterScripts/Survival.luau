local EBL = require(script.Parent:WaitForChild("EBLibbary"))
local Data = require(script.Parent.Data)

local plr = game.Players.LocalPlayer
local chr = plr.Character or plr.CharacterAdded:Wait()
local humrootpart = chr:WaitForChild("HumanoidRootPart")
local hum = chr:WaitForChild("Humanoid")
local gui = plr.PlayerGui:WaitForChild("Base")

local function Survival(dt)
	if hum.Health <= 0 then return end
	
	local w = EBL.GetStats("Water")
	local f = EBL.GetStats("Food")
	local s = EBL.GetStats("Stamina")
	local m = EBL.GetStats("Mental")
	
	--EBL.ChangeSurvivalStats("Water",false,-0.03*dt)
	--EBL.ChangeSurvivalStats("Food",false,(-0.01 - ((1-m/1000)/10) )*dt)
	EBL.ChangeSurvivalStats("Oxygen",false,1*dt)
	EBL.ChangeSurvivalStats("Stamina",false,0.2*dt)
	
	if s <= 10 then
		--EBL.ChangeSurvivalStats("Water",false,-1*dt)
		--EBL.ChangeSurvivalStats("Food",false,-1*dt)
		if w <= 10 and f <= 10 then
			EBL.DetectHurt(humrootpart,0.01*dt,"nil")
			EBL.ChangeSurvivalStats("Mental",false,-0.15*dt)
			if hum.MoveDirection.Magnitude>0 then
				EBL.DetectHurt(humrootpart,(hum.MoveDirection.Magnitude/10)*dt,"nil")
			end
		end
	end
	
	if w <= 0 or f <= 0 then
		EBL.ChangeSurvivalStats("Stamina",false,-1*dt)
	end
	
	if EBL.GetStats("Oxygen") <= 0 then
		EBL.DetectHurt(humrootpart,0.1*dt,"nil")
		EBL.ChangeSurvivalStats("Stamina",false,0*dt)
	end
	
	if hum.Health >= 0.1 then
		hum.Health += ((s/1000 * f/1000 * w/1000 * m/1000)/8)*dt
	end
end

local savedfallvelocity = 0

local function FallDamage()
	
	if hum.Health <= 0 then savedfallvelocity = 0 return end
	
	local newfallvelocity = humrootpart.AssemblyLinearVelocity.Y
	if savedfallvelocity < -20 and newfallvelocity >= -10 then
		local damageSFV = math.abs(savedfallvelocity+20)
		EBL.DetectHurt(humrootpart,hum.MaxHealth*(damageSFV/60),"fall")
	end
	savedfallvelocity = newfallvelocity
	wait(0.01)
end

game:GetService("RunService").RenderStepped:Connect(function(dt)
	Survival(dt*50)
end)

game:GetService("RunService").RenderStepped:Connect(function(dt)
	FallDamage()
end)