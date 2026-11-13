-- DONT TOUCH ANYTHING

function ChangeMe(hit)
	if hit.Parent == nil then return end
	if (hit.Parent:findFirstChild("Humanoid") == nil) then return end
	local human = hit.Parent:findFirstChild("Humanoid") 
	local char = hit.Parent
	local player = game.Players:GetPlayerFromCharacter(hit.Parent)
	if (human ~= nil) and debounce == false then
		debounce = true
		originals = char:getChildren()
		for w = 1, #originals do
			if originals[w].className == "CharacterMesh" then
				originals[w]:remove()
			end
		end
		meshes = script:getChildren()
		for y = 1, #meshes do
			copy = meshes[y]:clone()
			copy.Parent = char
		end
	end
	wait(0)
	debounce = false
end

script.Parent.Touched:connect(ChangeMe)
