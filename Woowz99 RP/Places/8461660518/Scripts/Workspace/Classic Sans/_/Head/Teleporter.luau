script.Parent.Touched:connect(function(hit) 
 if hit.Parent:FindFirstChild('Humanoid') then 
		hit.Parent.Head.CFrame = CFrame.new(-36, 37.943, -26)
 end
end) 
