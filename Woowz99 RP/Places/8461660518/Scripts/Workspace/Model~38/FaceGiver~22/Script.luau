function getDecal()
	decals = {}
	for i,child in pairs(script.Parent:getChildren()) do
		if child.className == "Decal" then
			table.insert(decals, child)
		end
	end
	if #decals ~= 0 then
		return decals[math.random(1, #decals)]
	end
	return nil
end

function onTouch(hit)
	if hit.Parent:findFirstChild("Humanoid") ~= nil then
		local head = hit.Parent:findFirstChild("Head")
		if head ~= nil then
			local face = head:findFirstChild("face")
			if face.Texture ~= getDecal().Texture then
				face.Texture = getDecal().Texture
			end
		end
	end
end

script.Parent.Touched:connect(onTouch)