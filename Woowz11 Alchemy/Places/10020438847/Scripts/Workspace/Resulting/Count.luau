local Resulting = script.Parent

local Values = Resulting.Value

local AllElements = 0
for _, element in pairs(Resulting.Parent.Elements:GetChildren()) do
	AllElements = AllElements + 1
end
Values.AllElements.Value = AllElements

local AllCrafts = 0
for _, craft in pairs(Resulting.Parent.Crafts:GetChildren()) do
	AllCrafts = AllCrafts + 1
end
Values.AllCrafts.Value = AllCrafts