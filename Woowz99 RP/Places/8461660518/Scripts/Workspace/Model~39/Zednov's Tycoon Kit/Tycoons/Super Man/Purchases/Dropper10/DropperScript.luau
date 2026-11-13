wait(2)
workspace:WaitForChild("PartStorage")

while true do
	wait(0.5) -- How long in between drops
	local part = Instance.new("Part",workspace.PartStorage)
	part.BrickColor=BrickColor.new("Lime green")
	part.Material="Fabric"
	local cash = Instance.new("IntValue",part)
	cash.Name = "Cash"
	cash.Value = 100 -- How much the drops are worth
	part.CFrame = script.Parent.Drop.CFrame - Vector3.new(0,1.4,0)
	part.FormFactor = "Custom"
	part.Size=Vector3.new(1, 1, 1) -- Size of the drops
	part.TopSurface = "Smooth"
	part.BottomSurface = "Smooth"
	game.Debris:AddItem(part,2000) -- How long until the drops expire
end