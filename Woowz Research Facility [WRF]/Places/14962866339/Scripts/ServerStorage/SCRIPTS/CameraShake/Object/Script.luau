local hasalredy = false

while wait() do
	if script.Parent.Value ~= nil then
		hasalredy = true
		script.Parent.Parent:SetAttribute("Position",script.Parent.Value.Position)
	end
	
	if hasalredy and script.Parent.Value == nil then
		script.Parent.Parent:Destroy()
	end
end