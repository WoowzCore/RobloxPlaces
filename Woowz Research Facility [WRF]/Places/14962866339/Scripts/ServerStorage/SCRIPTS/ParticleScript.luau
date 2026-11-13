local particle = script.Parent

wait(script:GetAttribute("time"))

for _, p in pairs(particle:GetChildren()) do
	p.Enabled = false
end

wait(10)
particle:Destroy()