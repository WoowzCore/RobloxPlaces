local Scripts = script.Parent
local AllTools = {}

for _, tool in pairs(workspace:GetChildren()) do
	if tool:IsA("Tool") then
		table.insert(AllTools,tool)
	end
end

for _, tool in pairs(AllTools) do
	local NewScript = Scripts.CreateToolFunctions:Clone()
	NewScript.Parent = tool
	NewScript.Disabled = false
end