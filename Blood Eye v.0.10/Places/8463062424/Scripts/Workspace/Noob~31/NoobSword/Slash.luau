while true do 
wait(0.5)
Tool = script.Parent
if Tool.Parent.Name == "Noob" and Tool.Parent.Attack.Value == true then 
	local anim = Instance.new("StringValue")
	anim.Name = "toolanim"
	anim.Value = "Slash"
	anim.Parent = Tool
	Tool.Handle.Slash:play()
end 
end 