function onTouched(hit) 
	local h = hit.Parent:findFirstChild("Humanoid")
	if h~=nil then
		
local d = h.Parent:GetChildren() 

	for i=1, #d do 
		if (d[i].className == "Part" or d[i].className == "MeshPart") then 
			d[i].Transparency = 1
		end 
	end

	end
	
end 

script.Parent.Touched:connect(onTouched) 