local Search = script.Parent
local Search_text = Search.search

local Elements = Search.Parent.Elements

local Search_empty = "Empty"
Search_text.Text = Search_empty

function RusTextUpper(text)
	local NewText = text
	NewText = string.gsub(NewText,"а","А")
	NewText = string.gsub(NewText,"б","Б")
	NewText = string.gsub(NewText,"в","В")
	NewText = string.gsub(NewText,"г","Г")
	NewText = string.gsub(NewText,"д","Д")
	NewText = string.gsub(NewText,"е","Е")
	NewText = string.gsub(NewText,"ё","Ё")
	NewText = string.gsub(NewText,"ж","Ж")
	NewText = string.gsub(NewText,"з","З")
	NewText = string.gsub(NewText,"и","И")
	NewText = string.gsub(NewText,"й","Й")
	NewText = string.gsub(NewText,"к","К")
	NewText = string.gsub(NewText,"л","Л")
	NewText = string.gsub(NewText,"м","М")
	NewText = string.gsub(NewText,"н","Н")
	NewText = string.gsub(NewText,"о","О")
	NewText = string.gsub(NewText,"п","П")
	NewText = string.gsub(NewText,"р","Р")
	NewText = string.gsub(NewText,"с","С")
	NewText = string.gsub(NewText,"т","Т")
	NewText = string.gsub(NewText,"у","У")
	NewText = string.gsub(NewText,"ф","Ф")
	NewText = string.gsub(NewText,"х","Х")
	NewText = string.gsub(NewText,"ц","Ц")
	NewText = string.gsub(NewText,"ч","Ч")
	NewText = string.gsub(NewText,"ш","Ш")
	NewText = string.gsub(NewText,"щ","Щ")
	NewText = string.gsub(NewText,"ъ","Ъ")
	NewText = string.gsub(NewText,"ы","Ы")
	NewText = string.gsub(NewText,"ь","Ь")
	NewText = string.gsub(NewText,"э","Э")
	NewText = string.gsub(NewText,"ю","Ю")
	NewText = string.gsub(NewText,"я","Я")
	
	NewText = string.upper(NewText)
	
	return NewText
end

function SearchFun()
	Elements.CanvasPosition = Vector2.new(0,0)
	Search.Parent.Parent.Parent.Values.Select_Element.Value = "empty"
	Search.Parent.Parent.Parent.Values.Select_Element_Obj.Value = nil
	for _, element in pairs(Elements:GetChildren()) do
		if element.Name ~= "UIGridLayout" then
			local need_id = nil
			for _2, id in pairs(workspace.Elements:GetChildren()) do
				if id.Name == element.Name then
					need_id = id
				end
			end

			if Search.Parent.Parent.Parent.Values.Rus.Value then
				if string.upper(Search_text.Text)=="" or string.upper(Search_text.Text) ==string.upper(Search_empty) or string.find(RusTextUpper(need_id.name_rus.Value),RusTextUpper(Search_text.Text))~= nil then
					element.Visible = true
				else
					element.Visible = false
				end
			else
				if string.upper(Search_text.Text)=="" or string.upper(Search_text.Text) ==string.upper(Search_empty) or string.find(string.upper(need_id.name_eng.Value),string.upper(Search_text.Text))~= nil then
					element.Visible = true
				else
					element.Visible = false
				end

			end


		end
	end
end

Search_text.Changed:Connect(SearchFun)

function ClearSearch()
	if Search_text.Text == "" and Search_text.CursorPosition == -1 then
		Search_text.Text = Search_empty
	end
end

while wait() do
	ClearSearch()
end