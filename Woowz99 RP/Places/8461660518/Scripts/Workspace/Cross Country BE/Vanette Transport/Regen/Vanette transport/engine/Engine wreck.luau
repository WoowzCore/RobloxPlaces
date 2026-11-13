function onTouched(hit)if hit.Name == "bodypart" thenscript.Parent.Parent.engine.Smoke.Enabled = true
script.Parent.Parent.engine.Fire.Enabled = truescript.Parent.Parent.VehicleSeat.MaxSpeed = 0
wait(1)
script.Parent.Parent.engine.Fire.Size = 8
wait(1)
script.Parent.Parent.engine.Fire.Size = 9
wait(1)
script.Parent.Parent.engine.Fire.Size = 10
wait(1)
message = Instance.new("Explosion")
message.Position = script.Parent.Parent.engine.Position
message.Parent = game.Workspace
message.BlastPressure = 50000
wait(1)
local Human = script.Parent.Parent.Parent:FindFirstChild("Humanoid") 
if Human ~= nil then
Human.Health = 0


end
end
end
connection = script.Parent.Touched:connect(onTouched)
