local rs = game:GetService("ReplicatedStorage")
wait(10)
local guies = {}

for _, gui in pairs(script.Parent.SurfaceGuis:GetChildren()) do
	guies[gui.Name] = gui
end

for _, part in pairs(rs.GetWorkspace:InvokeServer()) do
	if part.Name == "GuiID" then
		local gui = part.Parent
		local loadgui = guies[gui.Name]:Clone()
		loadgui.Parent = script.Parent
		loadgui.gID.Value = part.Value
		
		for _, part2 in pairs(part.Parent:GetDescendants()) do
			if part2.Name == loadgui.AdorneePart.Value then
				loadgui.Adornee = part2
			end
		end
		
		for _, guipart in pairs(loadgui:GetDescendants()) do
			if guipart.Name == "PublicText" then
				if gui:FindFirstChild(guipart.Parent.Name) ~= nil then
					local line = guipart.Parent
					line.Text = gui:FindFirstChild(guipart.Parent.Name).Value
				end

				guipart.Enabled = true
			end

			if guipart:IsA("ValueBase") and guipart.Name ~= "AdorneePart" and guipart.Name ~= "gID" then
				for _, p in pairs(gui:GetDescendants()) do
					if p.Name == guipart.Name then
						guipart.Value = p.Value
					end
				end
			end

			if guipart.Name == "EnableThis" and guipart.Parent:IsA("LocalScript") then
				guipart.Parent.Enabled = guipart.Value
			end
		end
	end
end