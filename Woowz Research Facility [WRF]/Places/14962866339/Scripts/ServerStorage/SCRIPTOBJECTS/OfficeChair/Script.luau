local data = require(game:GetService("ServerStorage").PLAYERSDATA)
local base = require(game:GetService("ServerScriptService").Base)

local p = game:GetService("Players")

local keykodeD,keykodeA,keykodeW,keykodeS = false,false,false,false

while wait(0.1) do
	if script.Parent.friction.AssemblyLinearVelocity.Magnitude + script.Parent.friction.AssemblyAngularVelocity.Magnitude > 0.1 then
		if math.random(0,100)>=80 then
			local sounds = {9117143508,9117143754,9117143757,9117143500,9117143509}
			base.PlaySound(sounds[math.random(1,#sounds)],script.Parent.friction.Position,math.random(5,10)/10,math.random(8,15),math.random(90,110)/100)
		end
	end
end