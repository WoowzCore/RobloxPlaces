local PlayerGui = game:GetService('Players').LocalPlayer:WaitForChild('PlayerGui')
local ScreenGui = PlayerGui:WaitForChild("ScreenGui")

local Presents = PlayerGui:WaitForChild("Presets")
local Element_blank = Presents:WaitForChild("Element_blank")

local Gui = ScreenGui:WaitForChild("Background")
local Elements = Gui:WaitForChild("Elements")

local AllElements = workspace.Elements
local AllCrafts = workspace.Crafts

local Values = PlayerGui:WaitForChild("Values")

local Creator = ScreenGui:WaitForChild("Creator")

local Com1Pos = Creator.com_1
local Com2Pos = Creator.com_2

local Result1 = Creator.result_1
local Result2 = Creator.result_2
local Result3 = Creator.result_3
local Result4 = Creator.result_4

local Com1Have = false
local Com2Have = false

local Result1Have = false
local Result2Have = false
local Result3Have = false
local Result4Have = false

function CreateVisualCom(number,id,ComPos,typ)
	wait(0.05)
	local Element_Original = nil
	for i, element in pairs(Elements:GetChildren()) do
		if element.Name == id then
			Element_Original = element
		end
	end
	local Visual_element = Element_Original.Button:Clone()
	Visual_element.Result.Value = true
	Visual_element.Parent = ComPos
	Visual_element.Name = "Element_com_"..number
	if number ~= "result" then
		local VS = Presents.VisualElementButton:Clone()
		VS.Parent = Visual_element
		VS.Disabled = false
	end
	if typ == "alredy_have" then

	end
end

function CraftElement(ThisCraft, result)
	local PlayerElements = PlayerGui.AddElements
	local HaveResult = false
	local HaveResultEmpty = false

	local RESULTFINISH = nil
	if result == 1 then
		RESULTFINISH = Result1
	else if result == 2 then
			RESULTFINISH = Result2
		else if result == 3 then
				RESULTFINISH = Result3
			else if result == 4 then
					RESULTFINISH = Result4

				end
			end
		end
	end
	local RESULT = ThisCraft:WaitForChild("result_"..result)

	if RESULT.Value ~= "empty" then
		for _, id in pairs(PlayerElements.ElementsPlayer:GetChildren()) do
			if id.Name == RESULT.Value then
				HaveResult = true
			end
		end
	else
		HaveResultEmpty = true
	end

	if HaveResultEmpty == false then
		if HaveResult == false then
			local new_id = Instance.new("StringValue")
			new_id.Value = RESULT.Value
			new_id.Name = RESULT.Value
			new_id.Parent = PlayerElements.ElementsPlayer
			
			local Have = false
			for _, ids in pairs(PlayerGui.Parent:FindFirstChild("Saved_Elements"):GetChildren()) do
				if RESULT.Value == ids.Name then
					Have = true
				end
			end
			if Have == false then
				game:GetService("ReplicatedStorage").AddElement:FireServer(RESULT.Value)
			end
			
			PlayerElements.Count.Value = PlayerElements.Count.Value + 1
			CreateVisualCom("result",RESULT.Value,RESULTFINISH)
			if result == 1 then
				Result1Have = true
			else if result == 2 then
					Result2Have = true
				else if result == 3 then
						Result3Have = true
					else if result == 4 then
							Result4Have = true

						end
					end
				end
			end
		else
			CreateVisualCom("result",RESULT.Value,RESULTFINISH,"alredy_have")
			if result == 1 then
				Result1Have = true
			else if result == 2 then
					Result2Have = true
				else if result == 3 then
						Result3Have = true
					else if result == 4 then
							Result4Have = true

						end
					end
				end
			end
		end
	end

end

function Craft(com1,com2)
	if Values.com_1.Value ~= "empty" then
		if Values.com_2.Value ~= "empty" then
			local ThisCraft = nil
			for _, craft in pairs(AllCrafts:GetChildren()) do
				if craft.com_1.Value == com1 then
					if craft.com_2.Value == com2 then
						ThisCraft = craft
					end
				else
					if craft.com_1.Value == com2 then
						if craft.com_2.Value == com1 then
							ThisCraft = craft
							CraftElement(ThisCraft,1)
						end
					end
				end
			end
			if ThisCraft ~= nil then

				CraftElement(ThisCraft, 1)
				CraftElement(ThisCraft, 2)
				CraftElement(ThisCraft, 3)
				CraftElement(ThisCraft, 4)

			end
		end 
	end
end

function SetCom(bool,number,id)
	if bool then
		local ComPos = nil
		if number == 1 then
			if Com1Have == false then
				ComPos = Com1Pos
				Com1Have = true
				CreateVisualCom(number,id,ComPos)
				Craft(id,Values.com_2.Value)
			end
		else
			if Com2Have == false then
				ComPos = Com2Pos
				Com2Have = true
				CreateVisualCom(number,id,ComPos)
				Craft(Values.com_1.Value,id)
			end
		end
	else
		if number == 1 then
			if Com1Have then
				Com1Pos:WaitForChild("Element_com_1"):Remove()
				Com1Pos.ImageColor3 = Values.Decoration.Element_background.Value
				Com1Have = false
				Values.com_1.Value = "empty"
			end
		else
			if Com2Have then
				Com2Pos:WaitForChild("Element_com_2"):Remove()
				Com2Pos.ImageColor3 = Values.Decoration.Element_background.Value
				Com2Have = false
				Values.com_2.Value = "empty"
			end
		end

	end
end

function ClearCom()
	SetCom(false,1,Values.com_1.Value)
	SetCom(false,2,Values.com_2.Value)
end

function UpdateCom()
	if Values.com_1.Value ~= "empty" then
		SetCom(true,1,Values.com_1.Value)
	else
		SetCom(false,1,Values.com_2.Value)
	end

	if Values.com_2.Value ~= "empty" then

		SetCom(true,2,Values.com_2.Value)
	else
		SetCom(false,2,Values.com_2.Value)
	end

	if Values.com_1.Value == "empty" or Values.com_2.Value == "empty" then
		local r = Result1:FindFirstChild("Element_com_result")
		if r ~= nil then
			Result1.Element_com_result:Remove()
			Result1.ImageColor3 = Values.Decoration.Element_background.Value
			Result1Have = false
		end
		local r2 = Result2:FindFirstChild("Element_com_result")
		if r2 ~= nil then
			Result2.Element_com_result:Remove()
			Result2.ImageColor3 = Values.Decoration.Element_background.Value
			Result2Have = false
		end
		local r3 = Result3:FindFirstChild("Element_com_result")
		if r3 ~= nil then
			Result3.Element_com_result:Remove()
			Result3.ImageColor3 = Values.Decoration.Element_background.Value
			Result3Have = false
		end
		local r4 = Result4:FindFirstChild("Element_com_result")
		if r4 ~= nil then
			Result4.Element_com_result:Remove()
			Result4.ImageColor3 = Values.Decoration.Element_background.Value
			Result4Have = false
		end

	end


end

while wait() do
	UpdateCom()
end