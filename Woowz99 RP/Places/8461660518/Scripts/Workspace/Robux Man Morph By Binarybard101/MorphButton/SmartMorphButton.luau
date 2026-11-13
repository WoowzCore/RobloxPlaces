-- Smart Morph script by Binarybard101

while (script:findFirstChild("InfoRemover") == nil) do wait(0.1) end

local g = Instance.new("ScreenGui")
g.Name = "InfoBox"

local t = Instance.new("TextLabel")
t.Name = "Info"
t.Text = "Smart Morph Script By Binarybard101"
t.BackgroundTransparency = 0
t.BackgroundColor3 = Color3.new(0, 0, 0)
t.BorderSizePixel = 0
t.TextColor3 = Color3.new(1, 1, 1)
t.Position = UDim2.new(0, 0, 0.95, 0)
t.Size = UDim2.new(1, 0, 0.05, 0)
t.Parent = g

local CanMorph = nil
local Lock = nil

local s = script.InfoRemover:Clone()
s.Parent = g
s.Disabled = false

script.Parent.BrickColor = BrickColor.new("Bright yellow")

function onTouch(hit)
	if (Lock == nil) then
		Lock = true
		script.Parent.BrickColor = BrickColor.new("Medium stone grey")

		CanMorph = nil
		BodyParts = hit.Parent:GetChildren()
		for i,b in pairs(BodyParts) do
			if (b.className == "Humanoid") then
				CanMorph = true
			end
			wait(0.1)
		end
		if (CanMorph == nil) then
			script.Parent.BrickColor = BrickColor.new("Bright yellow")
			Lock = nil
			return
		end

		script.Parent.BrickColor = BrickColor.new("Black")
		g.Parent = game.Players:findFirstChild(hit.Parent.Name).PlayerGui

		BodyParts = hit.Parent:GetChildren()
		for i,b in pairs(BodyParts) do
			if (b.className == "Hat") or (b.className == "CharacterMesh") or (b.className == "Shirt") or (b.className == "Pants") or (b.className == "ShirtGraphic") then
				b:Remove()
			end
			if (b.className == "Part") then
				if (b.Name == "Torso") then
					if (b:findFirstChild("roblox") ~= nil) then
						b.roblox:Remove()
					elseif (b:findFirstChild("Decal") ~= nil) then
						b.Decal:Remove()
					end
				end
				if (b.Name == "Head") then
					if (b:findFirstChild("Mesh") ~= nil) then
						b.Mesh:Remove()
					end
				end
			end
			wait(0.1)
		end

		BodyParts = script.Parent.Parent:GetChildren()
		for i,b in pairs(BodyParts) do
			if (b.className == "CharacterMesh") or (b.className == "Shirt") or (b.className == "Pants") or (b.className == "ShirtGraphic") then
				b:Clone().Parent = hit.Parent
			end
			if (b.className == "BodyColors") and (hit.Parent:findFirstChild("Body Colors") ~= nil) then
				hit.Parent:findFirstChild("Body Colors").HeadColor= b.HeadColor
				hit.Parent:findFirstChild("Body Colors").LeftArmColor= b.LeftArmColor
				hit.Parent:findFirstChild("Body Colors").LeftLegColor= b.LeftLegColor
				hit.Parent:findFirstChild("Body Colors").RightArmColor= b.RightArmColor
				hit.Parent:findFirstChild("Body Colors").RightLegColor= b.RightLegColor
				hit.Parent:findFirstChild("Body Colors").TorsoColor= b.TorsoColor
			end
			if (b.className == "Part") then
				if (b.Name == "Torso") then
					if (b:findFirstChild("roblox") ~= nil) then
						b.roblox:Clone().Parent = hit.Parent.Torso
					elseif (script.Parent.Parent.Torso:findFirstChild("Decal") ~= nil) then
						b.Decal:Clone().Parent = hit.Parent.Torso
					end
				end
				if (b.Name == "Head") then
					if (b:findFirstChild("face") ~= nil) then
						hit.Parent.Head.face.Texture = b.face.Texture
					elseif (script.Parent.Parent.Head:findFirstChild("Decal") ~= nil) then
						hit.Parent.Head.face.Texture = b.Decal.Texture
					end
					if (b:findFirstChild("Mesh") ~= nil) then
						b.Mesh:Clone().Parent = hit.Parent.Head
					end
				end
			end
			if (b.className == "Hat") then
				local h = Instance.new("Hat")
				h.Name = b.Name
				h.AttachmentPos = b.AttachmentPos
				b.Handle:Clone().Parent = h
				h.Parent = hit.Parent
			end
			wait(0.1)
		end

		g.Parent = nil
		script.Parent.BrickColor = BrickColor.new("Bright yellow")
		Lock = nil
	end
end

script.Parent.Touched:connect(onTouch)
