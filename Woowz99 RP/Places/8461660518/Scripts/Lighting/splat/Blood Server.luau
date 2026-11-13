script.Parent.Velocity = Vector3.new(0,0,0)
script.Parent.Orientation = Vector3.new(0,0,0)
script.Parent.splash:Play()
script.Parent.Anchored = false
script.Parent.CanCollide = false
for i = 1,math.random(30,60) do
	wait(0.001)
	script.Parent.Size = script.Parent.Size + Vector3.new(0.05,-0.02,0.05)
end
wait(60)
script.Parent:Destroy()