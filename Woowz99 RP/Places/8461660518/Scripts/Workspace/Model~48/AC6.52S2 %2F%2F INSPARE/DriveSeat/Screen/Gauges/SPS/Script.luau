local player=game.Players.LocalPlayer
script.Parent.Parent.Parent:WaitForChild("CarSeat")
local carSeat=script.Parent.Parent.Parent.CarSeat.Value
local numbers={346331739,346331783,346331807,346331844,346331884,346332019,346332124,346332168,346332220,346332232,0,346331765}


while true do
	wait()
	local value=(carSeat.Velocity.magnitude)/1.6  -- add .6 to convert it into MPH (pacifico memes)
	if value<10000 then
		local nnnn=math.floor(value/1000)
		local nnn=(math.floor(value/100))-(nnnn*10)
		local nn=(math.floor(value/10)-(nnn*10))-(nnnn*100)
		local n=(math.floor(value)-(nn*10)-(nnn*100))-(nnnn*1000)
		    script.Parent.A.Image="http://www.roblox.com/asset/?id="..numbers[n+1]
		if value>=10 then
			script.Parent.B.Image="http://www.roblox.com/asset/?id="..numbers[nn+1]
		else
			script.Parent.B.Image="http://www.roblox.com/asset/?id="..numbers[12]
		end
		if value>=100 then
			script.Parent.C.Image="http://www.roblox.com/asset/?id="..numbers[nnn+1]
		else
			script.Parent.C.Image="http://www.roblox.com/asset/?id="..numbers[12]
		end
		if value>=1000 then
			script.Parent.D.Image="http://www.roblox.com/asset/?id="..numbers[nnnn+1]
		else
			script.Parent.D.Image="http://www.roblox.com/asset/?id="..numbers[12]
		end
	else
		script.Parent.A.Image="http://www.roblox.com/asset/?id="..numbers[10]
		script.Parent.B.Image="http://www.roblox.com/asset/?id="..numbers[10]	
		script.Parent.C.Image="http://www.roblox.com/asset/?id="..numbers[10]
		script.Parent.D.Image="http://www.roblox.com/asset/?id="..numbers[10]
	end
	

end
