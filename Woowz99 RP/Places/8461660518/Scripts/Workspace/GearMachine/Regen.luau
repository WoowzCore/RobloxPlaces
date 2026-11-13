model = script.Parent.Machine
backup = model:Clone()

while true do
	wait(360)

	model:remove()
        model = backup:clone() 
	model.Parent = script.Parent
end 
