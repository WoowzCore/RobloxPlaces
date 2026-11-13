Jet = script.Parent
	Engine = Jet.MainParts.Main
while (not Jet.Welded) do wait() end
Parts = {}
function Scan(p)
	for _,v in pairs(p:GetChildren()) do
		if (v:IsA("BasePart")) then
			table.insert(Parts,v)
		end
		Scan(v)
	end
end

function WeldTogether(X, Y)
	Weld = Instance.new("Weld") 
	Weld.Part0 = X
	Weld.Part1 = Y
	local HitPos = X.Position
	local CJ = CFrame.new(HitPos) 
	local C0 = X.CFrame:inverse() * CJ 
	local C1 = Y.CFrame:inverse() * CJ 
	Weld.C0 = C0 
	Weld.C1 = C1 
	Weld.Parent = Y
end

function ManageParts()
	Scan(Jet)
	for i,v in pairs(Parts) do
		if v.Name ~= Engine.Name and v:IsA("BasePart") then
			WeldTogether(Engine, v)
		end
		if v:IsA("BasePart") then
			v.Anchored = false
		end
	end
	Jet.Welded.Value = true
end

ManageParts()