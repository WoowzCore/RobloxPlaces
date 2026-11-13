wait(0.5)

hullMain = script.Parent.Parts.Engine				--Main Part of Hull
turretMain = script.Parent.Parts.TurretRing1		--Main Part of Turret
gunMain = script.Parent.Parts.GunBase			--Main Part of Gun
turretGunBase = script.Parent.Parts.MantletBase	--Attaches Turret to Gun
hullTurretBase = script.Parent.Parts.TurretRing2	--Attaches Hull to Turret
barrelMain = script.Parent.Gun.BarrelMain

Vseat = script.Parent.Parts.VehicleSeat	

function Weld(x,y,name)
	local W = Instance.new("Weld")
	W.Name = name
	W.Part0 = x
	W.Part1 = y
	W.C0 = CFrame.new()
	W.C1 = y.CFrame:inverse() * x.CFrame
	W.Parent = x
end

function look(target)
	local list = target:GetChildren()
	for i = 1, #list do
		
 if (list[i].className == "Part" or list[i].className == "MeshPart" or list[i].className == "WedgePart" or list[i].className == "UnionOperation") then --If its a brick
							
			if list[i].Parent.Name == "Gun" then	--If its part of the gun
				if list[i].Name == "Barrel" or list[i].Name == "Muzzle" or list[i].Name == "Flash" then	--If its the recoiling gun
					Weld(barrelMain, list[i], "BarrelWeld")		--Weld it to the recoil tube
					
				elseif list[i] == barrelMain then								--If its the recoil tube
					Weld(gunMain, list[i], "RecoilTubeWeld")	--Weld it to the gun base
					
				elseif list[i] ~= gunMain then									--If its part of the gun
					Weld(gunMain, list[i], "GunWeld")			--Weld it to the main part of gun
				end
				
			elseif list[i] == gunMain then								--If its the base of the gun
				Weld(turretGunBase, list[i], "MainGunWeld")		--Weld it to the gun attachment point
			elseif list[i] == turretMain then							--If its the main part of the turret
				Weld(hullTurretBase, list[i], "TurretRingWeld")	--Weld it to the lower part of the turret ring
			elseif list[i] == hullTurretBase then						--If its the lower part of the turret ring
				Weld(hullMain, list[i], "TurretRingWeld")		--Weld it to the main part of hull
			elseif list[i] == turretGunBase then						--If its the base of the gun
				Weld(turretMain,list[i], "TurretRingWeld")		--Weld it to the main part of the turret
				
			elseif list[i].Parent.Name == "Turret" then					--If its any part of the turret						
				Weld(turretMain,list[i], "TurretWeld")
				Weld(turretMain,Vseat,"SeatTurretWeld")			--Weld it to the main part of the turret				
				Vseat.Anchored = false
			elseif list[i] ~= hullMain then									--If its any part of the hull			
				Weld(hullMain, list[i], "HullWeld")		--Weld it to the main part of the turret
			end
			list[i].Anchored = false
			
		elseif list[i].className == "Model" then --weld other models, except the gun
			look(list[i])
		end
	end
end



look(script.Parent)