local P			= script.Parent
local mainPart	= P.MainParts.Main
----- NO EDITING BELOW -----
local weldedParts = {}
table.insert(weldedParts,mainPart)

function Weld(x, y)
	weld = Instance.new("Weld") 
	weld.Part0 = x
	weld.Part1 = y
	local CJ = CFrame.new(x.Position) 
	weld.C0 = x.CFrame:inverse() * CJ  
	weld.C1 = y.CFrame:inverse() * CJ  
	weld.Parent = x	
	table.insert(weldedParts,y)
end

function WeldRec(instance)
	local childs = instance:GetChildren()
	for _,v in pairs(childs) do
		if  v:IsA("BasePart") or v:IsA("MeshPart") then
			if v.Name ~= "WeldPart" and v.Name ~= "A" and v.Name ~= "B" then
				Weld(mainPart, v)
			end
		end
		if v.Name ~= "AnimationParts" then
			WeldRec(v)
		end
	end	
end
wait(1)

WeldRec(P)
--WeldRec(P.Parent.Lights)

for _,v in pairs(weldedParts) do
	if v:IsA("BasePart") then
		v.Anchored = false
		script.Parent.Welded.Value = true
	end
end

script:Destroy()