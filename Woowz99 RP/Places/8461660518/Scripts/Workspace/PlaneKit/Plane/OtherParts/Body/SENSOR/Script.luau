b = script.Parent.Position.Y

while wait(0.4) do
	if script.Parent.Position.Y > 2490 and script.Parent.Position.Y < 2510 and script.Parent.Velocity.Y < 5 then -- 2,500 feet
		script.Parent.FT2500:Play()
		wait(1)
	end
	if script.Parent.Position.Y > 990 and script.Parent.Position.Y < 1010 and script.Parent.Velocity.Y < 5 then -- 1,000 feet
		script.Parent.FT1000:Play()
		wait(1)
	end
	if script.Parent.Position.Y > b+490 and script.Parent.Position.Y < b+510 and script.Parent.Velocity.Y < 5 then -- 500 feet
		script.Parent.FT500:Play()
		wait(1)
	end
	if script.Parent.Position.Y > b+390 and script.Parent.Position.Y < b+410 and script.Parent.Velocity.Y < 5 then -- 400 feet
		script.Parent.FT400:Play()
		wait(1)
	end
	if script.Parent.Position.Y > b+290 and script.Parent.Position.Y < b+310 and script.Parent.Velocity.Y < 5 then -- 300 feet
		script.Parent.FT300:Play()
		wait(1)
	end
	if script.Parent.Position.Y > b+190 and script.Parent.Position.Y < b+210 and script.Parent.Velocity.Y < 5 then -- 200 feet
		script.Parent.FT200:Play()
		wait(1)
	end
	if script.Parent.Position.Y > b+90 and script.Parent.Position.Y < b+110 and script.Parent.Velocity.Y < 5 then -- 100 feet
		script.Parent.FT100:Play()
		wait(1)
	end
	if script.Parent.Position.Y > b+45 and script.Parent.Position.Y < b+45 and script.Parent.Velocity.Y < 5 then -- 50 feet
		script.Parent.FT50:Play()
		wait(0.5)
	end
	if script.Parent.Position.Y > b+35 and script.Parent.Position.Y < b+35 and script.Parent.Velocity.Y < 5 then -- 40 feet
		script.Parent.FT40:Play()
		wait(0.5)
	end
	if script.Parent.Position.Y > b+25 and script.Parent.Position.Y < b+25 and script.Parent.Velocity.Y < 5 then -- 30 feet
		script.Parent.FT30:Play()
		wait(0.5)
	end
	if script.Parent.Position.Y > b+15 and script.Parent.Position.Y < b+15 and script.Parent.Velocity.Y < 5 then -- 20 feet
		script.Parent.FT20:Play()
		wait(0.5)
	end
	if script.Parent.Position.Y > b+10 and script.Parent.Position.Y < b+10 and script.Parent.Velocity.Y < 5 then -- 10 feet
		script.Parent.FT10:Play()
		wait(0.5)
	end
end
