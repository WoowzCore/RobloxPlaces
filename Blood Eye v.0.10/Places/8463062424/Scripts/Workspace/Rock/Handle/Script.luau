-- // Written by AsetCreator_ii 2.4.2020 \\
local CoolDown = 17 -- The amount of time the same palyer has to wait to get the sword again.

local PlrCoolDowns = {}
local Players = game:GetService("Players")
local Deps = script:WaitForChild("ClassicSword")
local ClickDetector, ProximityPrompt = script.Parent:WaitForChild("ClickDetector"), script.Parent:WaitForChild("ProximityPrompt")

local function OnClicked(Plr)
	if PlrCoolDowns[Plr.UserId] ~= true then
		PlrCoolDowns[Plr.UserId] = true
		if Plr.Character and Plr:DistanceFromCharacter(script.Parent.Position) < math.max(ClickDetector.MaxActivationDistance, ProximityPrompt.MaxActivationDistance) * 1.75 then
			local Backpack, Char = Plr:FindFirstChildWhichIsA("Backpack") or Plr:WaitForChild("Backpack", 10) or Instance.new("Backpack", Plr), Plr.Character

			if Backpack:FindFirstChild("ClassicSword") == nil and not (Char and Char:FindFirstChild("ClassicSword")) then
				local Sword = Instance.new("Tool")
				Sword.Archivable = false
				Sword.Name = "ClassicSword"
				Sword.TextureId = "rbxasset://Textures/Sword128.png"
				Sword.GripForward = Vector3.new(-1, 0, 0)
				Sword.GripPos = Vector3.new(0, 0, -1.5)
				Sword.GripRight = Vector3.new(0, 1, 0)
				Sword.GripUp = Vector3.new(0, 0, 1)

				for _, v in ipairs(Deps:GetChildren()) do
					v:Clone().Parent = Sword
				end
				Sword:WaitForChild("Handle").Anchored = false
				Sword.Parent = Backpack
			end
		end

		task.wait(CoolDown)
		PlrCoolDowns[Plr.UserId] = false
	end
end

ClickDetector.MouseClick:Connect(OnClicked)
ProximityPrompt.Triggered:Connect(OnClicked)