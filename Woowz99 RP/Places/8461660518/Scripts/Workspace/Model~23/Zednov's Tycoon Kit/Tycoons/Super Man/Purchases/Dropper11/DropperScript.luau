wait(2)
workspace:WaitForChild("PartStorage")



meshDrop = false

--------------------
-- Mesh Settings: -- [If you want a mesh drop, set meshDrop to true up on top.]
-- Look at the mesh properties and change the inside of the quotes below to the appropriate
-- full link or the rbxasset:// style, doesnt matter which one you see in the mesh you want

meshID = "rbxasset://fonts/PaintballGun.mesh"  
textureID = "rbxasset://textures/PaintballGunTex128.png"
--------------------


while true do
	wait(1.5) -- How long in between drops
	local part = Instance.new("Part",workspace.PartStorage)
	--part.BrickColor=script.Parent.Parent.Parent.DropColor.Value
	--part.Material=script.Parent.Parent.Parent.MaterialValue.Value
	local cash = Instance.new("IntValue",part)
	cash.Name = "Cash"
	cash.Value = 100 -- How much the drops are worth
	part.CFrame = script.Parent.Drop.CFrame - Vector3.new(0,5,0)
	part.FormFactor = "Custom"
	part.Size=Vector3.new(0.2, 0.2, 0.2) -- Size of the drops
	if meshDrop == true then
	local m = Instance.new("SpecialMesh",part)
	m.MeshId = meshID
	m.TextureId = textureID
	end
	part.TopSurface = "Smooth"
	part.BottomSurface = "Smooth"
	game.Debris:AddItem(part,20) -- How long until the drops expire
end