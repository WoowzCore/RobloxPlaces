local t = script.Parent.TextTransparency

local function updt()
	if UserSettings().GameSettings.SavedQualityLevel.Value < 7 then
		script.Parent.TextTransparency = t
	else
		script.Parent.TextTransparency = 1
	end
end
updt()

UserSettings().GameSettings:GetPropertyChangedSignal("SavedQualityLevel"):Connect(function()
	updt()
end)