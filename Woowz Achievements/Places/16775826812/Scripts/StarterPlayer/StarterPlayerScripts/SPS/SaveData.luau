local saved = {}

saved.Achievements = {}
for id in pairs(game:GetService("ReplicatedStorage").RS.GetVisualData:InvokeServer()["Achievements"]) do
	saved.Achievements[id] = false
end

saved.OtherData = {
	DistanceTraveled = 0
}

function saved.LoadSavedData(data)
	if data == nil then return end
	
	for id, completed in pairs(data["Achievements"] or {}) do
		saved.Achievements[id] = completed
	end
	for name, value in pairs(data["OtherData"] or {}) do
		saved.OtherData[name] = value
	end
end

return saved
