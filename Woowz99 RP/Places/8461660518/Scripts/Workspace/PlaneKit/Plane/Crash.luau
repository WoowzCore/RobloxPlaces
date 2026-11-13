-- This script handles crash detection

while (not script.Parent.Cloned.Value) do wait() end
wait(5)

if (not script.Parent.EDIT_THESE.CanCrash.Value) then script:remove() return end
local maxImpact = script.Parent.EDIT_THESE.CanCrash.Force.Value

local crashT,explode = 0,false

function goBoom()	-- lol
	explode = true
	script.Parent.Dead.Stop.Value = true
	local x = Instance.new("Explosion")
	x.BlastPressure = 5e5
	x.BlastRadius = script.Parent:GetModelSize().magnitude
	x.Position = script.Parent.MainParts.Main.Position
	script.Parent.MainParts.Main.Gyro:remove()
	x.Parent = game.Workspace
end

function getParts(parent)
	for _,v in pairs(parent:GetChildren()) do
		if ((v:IsA("BasePart")) and (not v:IsDescendantOf(script.Parent.MainParts.LandingGear))) then
			v.Touched:connect(function(obj)
				if (not obj.Parent) then return end
				if ((not obj.CanCollide) or (not v.CanCollide)) then return end
				if (obj:IsDescendantOf(script.Parent)) then return end
				if (game.Players:GetPlayerFromCharacter(obj.Parent)) then return end
				if (
					v.Velocity.x >= maxImpact
				or
					v.Velocity.x <= -(maxImpact)
				or
					v.Velocity.y >= maxImpact
				or
					v.Velocity.y <= -(maxImpact)
				or
					v.Velocity.z >= maxImpact
				or
					v.Velocity.z <= -(maxImpact)
				)
				then
					if (not script.Parent.Dead.Value) then
						crashT = time()
						script.Parent.Dead.Value = true
						game:GetService("Debris"):AddItem(script.Parent,8)
						delay(6,function()
							pcall(function() script.Parent.MainParts.MainSeat.SeatWeld:remove() end)
							if (not explode) then
								goBoom()
							end
						end)
					end
				end
				if ((script.Parent.Dead.Value) and ((time()-crashT) > 0.5) and (not explode)) then
					goBoom()
				end
			end)
		end
		getParts(v)
	end
end

getParts(script.Parent)

script.Parent.AutoCrash.Changed:connect(function()
	if (not script.Parent.AutoCrash.Value) then return end
	if ((not explode) and (not script.Parent.Dead.Value)) then
		crashT = time()
		script.Parent.Dead.Value = true
		game:GetService("Debris"):AddItem(script.Parent,8)
		goBoom()
	end
end)