-----------------------------------------------------------------------------------------
--[[
Thanks for using My Item 2.0!

Instructions:
1) Find the mesh in you weapon. Generally it should be inside a brick called "Handle"
2) Copy and Paste that mesh into the scenebrick, remove the mesh currently in the scenebrick first.
3) Open up the settings folder in thsi model and edit the following settings:
	- Regen Time: Time it takes for a person to be able to use the giver again.
	- StartColor: Color of the bricks that are currently blue.
	- RegenColor: Color of the current blue bricks will be turned to a different color meaning its currently regenrating.
	- WeaponName: Copy and past the exact name of the weapon into the value of the WeaponName value.	
4) Cut and paste the weapon into ServerStorage
5) Done!	
Original Make Zed_Gaming ... :)
----------------Don't edit below unless you know what you're doing--------------------------
--]]
SColor = script.Parent.Settings:FindFirstChild("StartColor")
RColor = script.Parent.Settings:FindFirstChild("RegenColor")
RTime = script.Parent.Settings:FindFirstChild("RegenTime")
Weapon = script.Parent.Settings:FindFirstChild("WeaponName")
Center = script.Parent.ColoredParts:FindFirstChild("TouchMe")
deb = false


Center.Touched:connect(function(part)
	if part.Parent:FindFirstChild("Humanoid") then
		if part.Parent.Humanoid.Health > 0 then
			if game.Players:FindFirstChild(part.Parent.Name) then
				if game.ServerStorage:FindFirstChild(Weapon.Value) then
					if deb == false then
						deb = true
						for i,v in pairs (script.Parent.ColoredParts:GetChildren()) do
							if v:IsA("Part") then
								v.BrickColor = RColor.Value
							end
						end
						local wep = game.ServerStorage:FindFirstChild(Weapon.Value)
						wep:Clone().Parent = game.Players:FindFirstChild(part.Parent.Name).Backpack
						wait(RTime.Value)
						deb = false
						for i,v in pairs (script.Parent.ColoredParts:GetChildren()) do
							if v:IsA("Part") then
								v.BrickColor = SColor.Value
							end
						end
					end
				else
					print("Error: "..Weapon.Value.." not found in 'ServerStorage'.")
				end
			end
		end
	end
end)