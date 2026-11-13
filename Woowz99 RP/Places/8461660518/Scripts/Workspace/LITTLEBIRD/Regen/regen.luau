---Model By: Midnight Productions

location = script.Parent.Parent.Parent
regen = script.Parent.Parent
save = regen:clone()

function onClicked()
	regen:remove()
	local back = save:clone()
	back.Parent = location
	back:MakeJoints()
end 

script.Parent.ClickDetector.MouseClick:connect(onClicked)