function onTouched(hit) 
	local h = hit.Parent:findFirstChild("Humanoid")
	if h~=nil then
		h.Parent.Head.face.Transparency = 1
	end
	
end 

script.Parent.Touched:connect(onTouched) 