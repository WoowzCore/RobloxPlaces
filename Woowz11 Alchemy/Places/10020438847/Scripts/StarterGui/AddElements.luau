local PlayerGui = game:GetService('Players').LocalPlayer:WaitForChild('PlayerGui')
local ScreenGui = PlayerGui:WaitForChild("ScreenGui")

local Presents = PlayerGui:WaitForChild("Presets")
local Element_blank = Presents:WaitForChild("Element_blank")

local Gui = ScreenGui:WaitForChild("Background")
local Elements = Gui:WaitForChild("Elements")

local AllElements = workspace.Elements
local AllCrafts = workspace.Crafts

local Player_elements = script.ElementsPlayer

local AddElement_RE = game:GetService("ReplicatedStorage"):WaitForChild("AddElement")

local ElementsCount = 0

local StartElementsGenerated = false

local Values = PlayerGui.Values
local InPhone = Values.Player_in_Phone.Value

function AddPlayerIDEL(id)
	local ID = Instance.new("StringValue")
	ID.Name = id
	ID.Value = id
	ID.Parent = Player_elements
	
	local Have = false
	for _, ids in pairs(PlayerGui.Parent:FindFirstChild("Saved_Elements"):GetChildren()) do
		if id == ids.Name then
			Have = true
		end
	end
	if Have == false then
		AddElement_RE:FireServer(id)
	end
end

function AddPlayerElement(element)
	local folder = nil
	for _, f in pairs(AllElements:GetChildren()) do
		if f.Name == element then
			folder = f
		end
	end
	if folder ~= nil then
		local NewElement = Element_blank:Clone()
		NewElement.Name = folder.Name
		NewElement.Button.Image = folder.image.Value
		NewElement.Parent = Elements
		NewElement.Button.id.Value = folder.Name
		ElementsCount = ElementsCount + 1
	else
		print("Не найден элемент!!! "..element)
	end
end

function StartCreateIDs()
	local CheckFolder = PlayerGui.Parent:FindFirstChild("Saved_Elements")
	if CheckFolder == nil then
		local f = Instance.new("Folder",PlayerGui.Parent)
		f.Name = "Saved_Elements"
	end
	
	
	local children_count = {}
	
	for _, child in pairs(PlayerGui.Parent:FindFirstChild("Saved_Elements"):GetChildren()) do
		print(child.Name)
		table.insert(children_count,child.Name)
	end
	local Start_elements = {}
	
	for _, child in pairs(workspace.Resulting.StartElements:GetChildren()) do
		table.insert(Start_elements,child.Name)
	end
	
	local Create_this_elements = Start_elements
	
	if #children_count > 0 then
		Create_this_elements = children_count
	end
	
	
	
	
	for _, id in pairs(Create_this_elements) do
		AddPlayerIDEL(id)
	end
	for _, element in pairs(Create_this_elements) do
		AddPlayerElement(element)
	end
	script.Count.Value = ElementsCount
	StartElementsGenerated = true
end
StartCreateIDs()

function CheckElements()
	local OldIds = {}
	local NewIds = {}
	for _, id in pairs(Player_elements:GetChildren()) do
		table.insert(OldIds,id.Name)
	end
	for _, element in pairs(Elements:GetChildren()) do
		if element.Name ~= "UIGridLayout" then
			table.insert(NewIds,element.Name)
		end
	end
	
	for _, new_id in pairs(NewIds) do
		table.remove(OldIds,table.find(OldIds,new_id))
	end
	
	for _, create_el in pairs(OldIds) do
		AddPlayerElement(create_el)
	end
end

while wait() do
	if StartElementsGenerated then
		if ElementsCount < script.Count.Value then
			CheckElements()
		end
	end
end