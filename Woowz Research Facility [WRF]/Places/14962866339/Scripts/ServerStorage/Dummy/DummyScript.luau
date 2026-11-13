local base = require(game:GetService("ServerScriptService").Base)
local dummy = script.Parent
local head = dummy:WaitForChild("Head")

local screamtimermax = 75 local screamtimer = screamtimermax
function Scream()
	if screamtimer >= screamtimermax then
		local screams = {"6108570476","6929506713","6108569850","5169623821","5546573724"}
		base.PlaySound(screams[math.random(1,#screams)],head.Position,math.random(80,110)/100,nil,math.random(95,105)/100)
		screamtimer = 0
	end
end
dummy.Scream.Event:Connect(Scream)