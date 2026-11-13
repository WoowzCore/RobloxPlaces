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
	
	EBL.ChangeSurvivalStats("Water",false,-0.005*dt)
	EBL.ChangeSurvivalStats("Food",false,(-0.0001 - ((1-m/1000)/10) )*dt)
	EBL.ChangeSurvivalStats("Oxygen",false,1*dt)
	EBL.ChangeSurvivalStats("Stamina",false,0.2*dt)
	
	if s <= 10 then
		EBL.ChangeSurvivalStats("Water",false,-1*dt)
		EBL.ChangeSurvivalStats("Food",false,-1*dt)
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
	end
	
	if hum.Health >= 0.1 then
		hum.Health += ((s/1000 * f/1000 * w/1000 * m/1000)/8)*dt
	end
end

local h = 0
local falldamageheight = 5
hum.FreeFalling:Connect(function(stnd)
	if stnd then
		h = humrootpart.Position.Y
	else
		local fh = h - humrootpart.Position.Y
		
		if fh > falldamageheight then
			EBL.DetectHurt(humrootpart,fh-falldamageheight,"fall")
		end
	end
end)

game:GetService("RunService").RenderStepped:Connect(function(dt)
	Survival(dt*50)
end)