function onTouched(hit) 
	local d = hit.Parent:GetChildren() 
	for i=1, #d do 
		if (d[i].className == "ShirtGraphic") then 
			wait(1)
			d[i]:remove() 
		end 
	end
end 

script.Parent.Touched:connect(onTouched) 