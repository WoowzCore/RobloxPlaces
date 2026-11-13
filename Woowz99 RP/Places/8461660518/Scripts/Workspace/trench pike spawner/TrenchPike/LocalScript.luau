local Tool = script.Parent;

enabled = true
function onButton1Down(mouse)
	if not enabled then
		return
	end

	enabled = false
	mouse.Icon = "rbxasset://textures\\GunWaitCursor.png"

	wait(.05)
	mouse.Icon = "rbxasset://textures\\GunCursor.png"
	enabled = true

end

function onEquippedLocal(mouse)

	if mouse == nil then
		print("Mouse not found")
		return 
	end

	mouse.Icon = "rbxasset://textures\\GunCursor.png"
	mouse.Button1Down:connect(function() onButton1Down(mouse) end)

	local g = script.Parent:GetChildren()
	for i=1, #g do
		if g[i].className == "Part" then
			g[i].CanCollide = false
		end
	end
end


Tool.Equipped:connect(onEquippedLocal)

function onUnequippedLocal(mouse)
	local g = script.Parent:GetChildren()
	for i=1, #g do
		if g[i].className == "Part" then
			g[i].CanCollide = true
		end
	end
end

Tool.Unequipped:connect(onUnequippedLocal)