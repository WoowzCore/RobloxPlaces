wait(2)
local base = require(script.Parent.PlayerBase)
local plrscr =  require(script.Parent.PlayerScripts)
plrscr.Grant("join")
local g = plrscr.Grant

local function DistanceTraveledGrant()
	local meters = base.SaveData.OtherData.DistanceTraveled*50
	if meters > 10 then
		g("traveled10")
		if meters > 100 then
			g("traveled100")
			if meters > 500 then
				g("traveled500")
				if meters > 1000 then
					g("traveled1000")
					if meters > 3000 then
						g("traveled3000")
						if meters > 10000 then
							g("traveled10000")
							if meters > 20000 then
								g("traveled20000")
								if meters > 50000 then
									g("traveled50000")
								end
							end
						end
					end
				end
			end
		end
	end
end

game:GetService("RunService").RenderStepped:Connect(function(dt)
	if base.Humanoid.MoveDirection.x ~= 0 or base.Humanoid.MoveDirection.z ~= 0 then
		base.SaveData.OtherData.DistanceTraveled += (base.Humanoid.WalkSpeed*dt)/100
		print(math.floor(base.SaveData.OtherData.DistanceTraveled*50))
	end
end)

while wait() do
	DistanceTraveledGrant()
end