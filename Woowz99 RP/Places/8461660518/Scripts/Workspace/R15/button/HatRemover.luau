function onTouched(hit) 
	local d = hit.Parent:GetChildren() 
	for i=1, #d do 
		if (d[i].className == "Accessory") then 
			d[i].Handle.Transparency = 1
		end 
	end
end 

script.Parent.Touched:connect(onTouched) 