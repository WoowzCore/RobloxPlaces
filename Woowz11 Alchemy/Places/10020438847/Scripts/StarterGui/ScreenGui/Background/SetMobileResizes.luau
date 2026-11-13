local Background = script.Parent

local Elements = Background.Elements

local Values = Background.Parent.Parent.Values
local InPhone = Values.Player_in_Phone.Value

if InPhone then
	Elements.ScrollBarThickness = 0
	Elements.UIGridLayout.CellSize = UDim2.new(0,50,0,50)
	Elements.UIGridLayout.CellPadding = UDim2.new(0,5,0,5)
end