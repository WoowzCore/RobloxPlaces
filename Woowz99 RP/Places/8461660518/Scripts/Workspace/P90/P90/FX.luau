if script.Dist.Value >= 60 then
for i = 1, math.floor(script.Dist.Value/60) do
	wait()
	script.Parent.CFrame = script.Parent.CFrame * CFrame.new(0,0,-60)
end
else
	wait(.2)
end
script.Parent:Destroy()
