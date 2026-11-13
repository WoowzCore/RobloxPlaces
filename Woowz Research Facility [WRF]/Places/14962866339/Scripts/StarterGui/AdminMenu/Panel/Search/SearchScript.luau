local search = script.Parent
local list = search.Parent.Values

local function Lower(str)
	str = string.lower(str)
	
	local changesymbol = {
		["А"] = "а",
		["Б"] = "б",
		["В"] = "в",
		["Г"] = "г",
		["Д"] = "д",
		["Е"] = "е",
		["Ё"] = "ё",
		["Ж"] = "ж",
		["З"] = "з",
		["И"] = "и",
		["Й"] = "й",
		["К"] = "к",
		["Л"] = "л",
		["М"] = "м",
		["Н"] = "н",
		["О"] = "о",
		["П"] = "п",
		["Р"] = "р",
		["С"] = "с",
		["Т"] = "т",
		["У"] = "у",
		["Ф"] = "ф",
		["Х"] = "х",
		["Ц"] = "ц",
		["Ч"] = "ч",
		["Ш"] = "ш",
		["Щ"] = "щ",
		["Ъ"] = "ъ",
		["Ы"] = "ы",
		["Ь"] = "ь",
		["Э"] = "э",
		["Ю"] = "ю",
		["Я"] = "я"
	}
	
	local result = ""
	for _, codepoint in utf8.codes(str) do
		local char = utf8.char(codepoint)
		if changesymbol[char] ~= nil then
			char = changesymbol[char]
		end
		result = result .. char
	end
	
	str = result
	
	return str
end

local function Search(ser)
	list.CanvasPosition = Vector2.zero
	for _, command in pairs(search.Parent.Values.UIList:GetChildren()) do
		if command:IsA("Frame") then
			if string.find(Lower(command.Name.." "..command.CommandID.Value),Lower(ser)) then
				command.Visible = true
			else
				command.Visible = false
			end
		end
	end
end

script.Parent.Parent.Parent:GetPropertyChangedSignal("Enabled"):Connect(function()
	if script.Parent.Parent.Parent.Enabled == false then
		search.Text = ""
		Search("")
	end
end)

search:GetPropertyChangedSignal("Text"):Connect(function()
	Search(search.Text)
end)