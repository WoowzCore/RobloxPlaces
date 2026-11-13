
local part = script.Parent

local debounce = false

part.Touched:Connect(function(hit)
	if not debounce then
		debounce = true
		
		local humanoid = hit.Parent:FindFirstChild("Humanoid")
		if humanoid then
			for _,child in pairs (humanoid.Parent:GetChildren()) do
				if child:IsA("Accoutrement") then
					child:Destroy()
				end
			end
		end
		
		wait(0.3)
		
		debounce = false
	end
end)