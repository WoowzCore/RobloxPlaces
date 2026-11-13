----------------

Speed = 16				-- This is the character's speed! 16 is normal walkspeed.

----------------

debounce = false
function onTouch(hit)

if game.Players:FindFirstChild(hit.Parent.Name) ~= nil and debounce == false then

local player = game.Players:FindFirstChild(hit.Parent.Name)
local c = player.Character:GetChildren()

debounce = true

	for i=1, #c do 
		if (c[i].className == "Hat") or c[i].Name == "Character" then 
			c[i]:Destroy()
		end 
	end


player.Character.Torso.Transparency = 1
player.Character:FindFirstChild("Left Arm").Transparency = 1
player.Character:FindFirstChild("Left Leg").Transparency = 1
player.Character:FindFirstChild("Right Arm").Transparency = 1
player.Character:FindFirstChild("Right Leg").Transparency = 1

player.Character.Humanoid.WalkSpeed = (Speed)		-- You can change how fast players walk as this character!

local hide = Instance.new("SpecialMesh")

hide.MeshType = "FileMesh"
MeshId = ""
hide.Parent = player.Character.Head

local p = script.Parent.Parent:FindFirstChild("Character"):clone()
p.Parent = player.Character
p.CFrame = CFrame.new(player.Character.Torso.Position)
p.Anchored = false

local Y = Instance.new("Weld")
Y.Part0 = player.Character.Torso
Y.Part1 = p
Y.Parent = Y.Part0


itemlist = script.Parent:FindFirstChild("StartTools"):GetChildren()

if #itemlist ~= 0 then
for i= 1, #itemlist do
local itemc = itemlist[i]:clone()
itemc.Parent = player.Backpack
end
end

wait(1)
debounce = false

end
end

script.Parent.Touched:connect(onTouch)




