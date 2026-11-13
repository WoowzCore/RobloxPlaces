local maxammo = script.Parent.MaxAmmo.Value
local ammo = script.Parent.Ammo
local reloading = false









local spread = script.Parent.EDIT.Spread.Value






script.Parent.Shoot.OnServerEvent:Connect(function (plr,Target)
	if plr.Character ~= nil and plr.Character.Humanoid.Health >= .1 and script.Parent.Enabled == true and reloading == false then
	script.Parent.Enabled = false
	local hit = false
	
	if ammo.Value >= 1 then
	ammo.Value = ammo.Value - 1
	script.Parent.Handle.FireSound:Play()
	for i = 1, script.Parent.EDIT.BulletsPerShot.Value do
	local dist = (script.Parent.RPart.Position - Target).Magnitude
	local ray = Ray.new(script.Parent.RPart.CFrame.p, (Target - script.Parent.RPart.CFrame.p + (Vector3.new(math.random(-spread,spread)/1000,math.random(-spread,spread)/1000,math.random(-spread,spread)/1000) * dist)).unit * 2000)
	local part, position = workspace:FindPartOnRay(ray, plr.Character, false, true)
	print(position)
	print(part)
	print(Target)
	local beam = Instance.new("Part")
	beam.Anchored = true
	beam.CanCollide = false
	beam.Material = "Neon"
	if dist >= 60 then
	beam.Size = Vector3.new(.1,.1,60)
	else
    beam.Size = Vector3.new(.1,.1,dist)
    end
	beam.CFrame = CFrame.new(script.Parent.RPart.CFrame.p, position) * CFrame.new(0,0,-beam.Size.Z/2)
	game.Debris:AddItem(beam,10)
	local fx = script.Parent.FX:Clone()
	fx.Dist.Value = dist
	fx.Parent = beam
	fx.Disabled = false
	beam.Parent = workspace
	script.Parent.RPart.FlashGui.Label.Rotation = math.random(1, 360)
	script.Parent.RPart.FlashGui.Enabled = true
	script.Parent.RPart.Flash.Enabled = true
	if part ~= nil then
	if part.Parent:FindFirstChild("Humanoid") then
		part.Parent:FindFirstChild("Humanoid"):TakeDamage(script.Parent.EDIT.Damage.Value)
		hit = true
	end
	end
  local hole = Instance.new("Part")
  hole.Size = Vector3.new(.2,.2,.2)
hole.Material = "Neon"
hole.Anchored = true
hole.BrickColor = BrickColor.new("Black")
hole.Shape = 0
hole.CanCollide = false
  hole.Position = position
	
	game.Debris:AddItem(hole, 1)
	if hit == false then
	hole.Parent = workspace
	end
    wait()
    script.Parent.RPart.FlashGui.Enabled = false
    script.Parent.RPart.Flash.Enabled = false
	end
	elseif ammo.Value <= 0 then
		script.Parent.Handle.NoAmmo:Play()
	end
	wait(script.Parent.EDIT.Firerate.Value)
	
	script.Parent.Enabled = true
	end
end)
script.Parent.Reload.OnServerEvent:Connect(function ()
	if reloading == false then
		reloading = true
		script.Parent.Handle.Reload:Play()
		wait(script.Parent.EDIT.ReloadTime.Value)
		ammo.Value = maxammo
		reloading = false
	end
end)


--imagiraff1234
