wait(3)

local telephone = script.Parent

local trybka = telephone.Telephone
local base = telephone.Telephone_Base

local _,_,z = base.CFrame:ToOrientation()
z = math.deg(z)

local visit = (math.round(z) == -90)

local trybkaphysic = false

local function makephysic()
	if trybkaphysic == true then return end
	trybkaphysic = true
	trybka.Anchored = false
end

local played = false
trybka.DragDetector.DragStart:Connect(function()
	makephysic()
	if not played then
		played = true
		script.Parent.Telephone.Sound:Play()
	end
end)

if not visit then
	makephysic()
	base.Anchored = false
else
	base.DragDetector:Destroy()
end