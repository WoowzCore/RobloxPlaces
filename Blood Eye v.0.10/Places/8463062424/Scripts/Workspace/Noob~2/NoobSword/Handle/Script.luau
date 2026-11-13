function OnTouched(hit)
	if hit.Parent.Name == "Noob" then 
		script.Parent.Parent.Parent = hit.Parent 
		script:remove() 
	end 
end 

script.Parent.Touched:connect(OnTouched)