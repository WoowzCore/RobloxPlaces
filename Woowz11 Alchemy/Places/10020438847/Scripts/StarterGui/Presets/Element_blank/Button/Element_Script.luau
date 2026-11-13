local ThisElement = script.Parent
local RealThisElement = ThisElement.Parent
local PlayerGui = game:GetService('Players').LocalPlayer:WaitForChild('PlayerGui')
local Values = PlayerGui:WaitForChild("Values")

local BackgroundElement = ThisElement.Parent

local Result = ThisElement.Result.Value

function SetCom()
	if Values.com_1.Value == "empty" then
		Values.com_1.Value = ThisElement.Parent.Name
	else
		if Values.com_2.Value == "empty" then
			Values.com_2.Value = ThisElement.Parent.Name	
		end
	end
end

function SelectElement(bool)
	if bool then
		if ThisElement.Parent.Name == "com_1" or ThisElement.Parent.Name == "com_2" or ThisElement.Parent.Name == "result_1" or ThisElement.Parent.Name == "result_2" or ThisElement.Parent.Name == "result_3" or ThisElement.Parent.Name == "result_4" then
			Values.Select_Element.Value = ThisElement.id.Value
		else
			Values.Select_Element.Value = ThisElement.Parent.Name
		end
		BackgroundElement.ImageColor3 = Values.Decoration.Element_background_select.Value
		Values.Select_Element_Obj.Value = ThisElement.Parent
	else
		BackgroundElement.ImageColor3 = Values.Decoration.Element_background.Value
		Values.Select_Element.Value = "empty"
		Values.Select_Element_Obj.Value = nil
	end
end

ThisElement.MouseEnter:Connect(function() SelectElement(true) end)

ThisElement.MouseMoved:Connect(function() SelectElement(true) end)

ThisElement.MouseLeave:Connect(function() SelectElement(false) end)

if Result == false then
	ThisElement.MouseButton1Click:Connect(SetCom)
end
