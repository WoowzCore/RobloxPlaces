local Description_obj = script.Parent
local PlayerGui = game:GetService('Players').LocalPlayer:WaitForChild('PlayerGui')
local Values = PlayerGui:WaitForChild("Values")
local AllElements = workspace.Elements
local Element = nil

function SetDesc(e)
	if Values.Rus.Value then
		Description_obj.Desc.Name_s.Text = e.name_rus.Value
		Description_obj.Desc.Desc.Description.Text = e.desc_rus.Value
	else
		Description_obj.Desc.Name_s.Text = e.name_eng.Value
		Description_obj.Desc.Desc.Description.Text = e.desc_eng.Value
	end
end

function ReloadDesc()
	if Values.Select_Element.Value == "empty" then
		Description_obj.Desc.Visible = false
		Description_obj.Buttons.Visible = true
		Element = nil
	else
		Description_obj.Desc.Visible = true
		Description_obj.Buttons.Visible = false
			for i, element in pairs(AllElements:GetChildren()) do
				if element.Name == Values.Select_Element.Value then
					Element = element
					SetDesc(element)
				end
			end
	end
end

while wait() do
	ReloadDesc()
end