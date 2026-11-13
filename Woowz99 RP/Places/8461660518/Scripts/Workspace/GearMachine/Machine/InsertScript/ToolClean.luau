script.Parent.ChildRemoved:connect(function()
	wait(5)
	script.Parent:Remove()
end)

wait(10)
script.Parent:Remove()