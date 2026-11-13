human = script.Parent.Humanoid

function Die()
	script.Parent.Name = "X_X"
	wait(3)
	script.Parent:remove() 
end 

script.Parent.Humanoid.Died:connect(Die)