b = script.Parent
c = script.Parent.Parent.Parent:findFirstChild("Turret").Connector

	local weld = Instance.new("Weld")

	weld.Part0 = c
	weld.Part1 = b

	weld.C0 = CFrame.new(0, 0, 0)

	weld.Parent = c

script.Parent.Parent.WER.Value = weld