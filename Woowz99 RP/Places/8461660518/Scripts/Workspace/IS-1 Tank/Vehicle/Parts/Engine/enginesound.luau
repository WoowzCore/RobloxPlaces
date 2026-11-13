while true do
wait(0.1)
if script.Parent.Velocity.Magnitude > 10 then
script.Parent.Idle.Pitch = 0.18 + script.Parent.Velocity.Magnitude/14
script.Parent.Moving.Pitch = 0.0 + script.Parent.Velocity.Magnitude/20
end
end
