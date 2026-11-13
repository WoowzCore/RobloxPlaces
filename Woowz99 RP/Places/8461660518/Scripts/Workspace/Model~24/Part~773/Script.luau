--Made by toxicfrozen
--This doesn't include teh thing where you put a VIP shirt

print("VIP Door Script loaded") 

permission = {} --Put your name here and/or other people you like.

function checkOkToLetIn(name) 
	for i = 1,#permission do 
		if (string.upper(name) == string.upper(permission[i])) then return true end 
	end 
	return false 
end 

local Door = script.Parent

function onTouched(hit) 
	print("Door Hit") 
	local human = hit.Parent:findFirstChild("Humanoid") 
	if (human ~= nil ) then 
		-- A human has touched teh door
		print("Human touched door") 
		-- Test the human's name against the permission list 
		if (checkOkToLetIn(human.Parent.Name)) then 
			print("Human passed test") 
			Door.Transparency = 0 
			Door.CanCollide = false 
			wait(1) -- This is how long the door is open 
			Door.CanCollide = true 
			Door.Transparency = 0 
		 
		end 
	end 
end 

script.Parent.Touched:connect(onTouched)

