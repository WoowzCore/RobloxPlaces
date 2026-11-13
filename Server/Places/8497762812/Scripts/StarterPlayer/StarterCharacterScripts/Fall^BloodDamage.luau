fallTime = 0
while true do
	x = wait()
	if script.Parent.UpperTorso.Velocity.Y <= -10 then --Finds whether or not the player has begun falling and starts a timer
		fallTime = fallTime + x
	end
	if script.Parent.UpperTorso.Velocity.Y > -10 then --Finds when the player has stopped falling
		if fallTime >= 0.4 then --Finds whether or not the player has been falling long enough to take damage
			script.Parent.Humanoid:TakeDamage(fallTime * 30) --Deals damage directly proportional to falling time; can simply change the 50 to another factor balance it differently
			script.Parent.UpperTorso.Blood.Enabled = true
			script.Parent.UpperTorso.Damage:Play()
			wait(0.5)
			script.Parent.UpperTorso.Blood.Enabled = false
		end
		fallTime = 0
	end
end