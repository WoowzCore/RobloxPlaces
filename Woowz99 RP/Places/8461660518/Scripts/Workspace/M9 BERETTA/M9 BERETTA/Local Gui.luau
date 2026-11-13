local Tool = script.Parent;

local stillEquipped = true
function onEquippedLocal(mouse)
	stillEquipped = true
	if mouse == nil then
		print("Mouse not found")
		return
	end
	

		print("Setting Mouse to Go")
		mouse.Icon = "rbxassetid://950896037"

		
	
		

	
end

function onUnequippedLocal()
	stillEquipped = false
end


Tool.Equipped:connect(onEquippedLocal)
Tool.Unequipped:connect(onUnequippedLocal)

--imagiraff1234