local sound = script.Parent

script.Parent.CameraShake:GetPropertyChangedSignal("Value"):Connect(function()
	if script.Parent.CameraShake.Value ~= nil then
		script.Parent.Destroying:Connect(function()
			script.Parent.CameraShake.Value:Destroy()
		end)
	end
end)

if sound.PhysicSound.Looped == false then
	sound.PhysicSound.Ended:Connect(function()
		sound:Destroy()
	end)
end

wait(5)

if sound.PhysicSound.IsLoaded == false then
	sound:Destroy()
end