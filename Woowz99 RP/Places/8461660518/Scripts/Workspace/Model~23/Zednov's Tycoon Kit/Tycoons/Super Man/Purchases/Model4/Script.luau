wep = script.Parent.WeaponName.Value
deb = true
giv = script.Parent.Giver
function touch(part)
	local hum = part.Parent:FindFirstChild("Humanoid")
	if hum then
		local plr = game.Players:FindFirstChild(part.Parent.Name)
		if plr then
			if deb == true then
			deb = false
				giv.BrickColor = BrickColor.new("Really red")
				local weapon = game.Lighting:FindFirstChild(wep)
				local w2 = weapon:Clone()
				w2.Parent = plr.Backpack
				wait(script.Parent.RegenTime.Value)
				giv.BrickColor = BrickColor.new("Bright violet")
			deb = true
			end
		end
	end
end
script.Parent.Giver.Touched:connect(touch)