local part = script.Parent
local sss = game:GetService("ServerScriptService")
local players = game:GetService("Players")

local MaterialList = {
	[Enum.Material.Asphalt      ] = 500,
	[Enum.Material.Basalt       ] = 500,
	[Enum.Material.Brick        ] = 250,
	[Enum.Material.Cobblestone  ] = 250,
	[Enum.Material.Concrete     ] = 500,
	[Enum.Material.CorrodedMetal] = 250,
	[Enum.Material.CrackedLava  ] = 250,
	[Enum.Material.DiamondPlate ] = 2000,
	[Enum.Material.Fabric       ] = 50,
	[Enum.Material.Foil         ] = 50,
	[Enum.Material.ForceField   ] = math.huge,
	[Enum.Material.Glacier      ] = 250,
	[Enum.Material.Glass        ] = 5,
	[Enum.Material.Granite      ] = 1000,
	[Enum.Material.Grass        ] = 250,
	[Enum.Material.Ground       ] = 250,
	[Enum.Material.Ice          ] = 5,
	[Enum.Material.LeafyGrass   ] = 250,
	[Enum.Material.Limestone    ] = 250,
	[Enum.Material.Marble       ] = 500,
	[Enum.Material.Metal        ] = 750,
	[Enum.Material.Mud          ] = 100,
	[Enum.Material.Neon         ] = 5,
	[Enum.Material.Pavement     ] = 250,
	[Enum.Material.Pebble       ] = 250,
	[Enum.Material.Plastic      ] = 25,
	[Enum.Material.Rock         ] = 500,
	[Enum.Material.Salt         ] = 250,
	[Enum.Material.Sand         ] = 250,
	[Enum.Material.Sandstone    ] = 100,
	[Enum.Material.Slate        ] = 250,
	[Enum.Material.SmoothPlastic] = 25,
	[Enum.Material.Snow         ] = 50,
	[Enum.Material.Wood         ] = 50,
	[Enum.Material.WoodPlanks   ] = 50,
}

part.Touched:Connect(function(p)
	if part:FindFirstChild("WoowzPhysic") then
		local power = (part.AssemblyLinearVelocity.Magnitude*part:GetMass())
		
		if p:FindFirstChild("WoowzPhysic") then
			local needpower = (MaterialList[p.Material])*(math.min(p.Size.Magnitude,3)/3)
			if p:FindFirstChild("Strength") then
				needpower = p:FindFirstChild("Strength").Value
			end
			if part:FindFirstChild("Damage") then
				power = power*part:FindFirstChild("Damage").Value
			end
			if power > needpower then
				local networkowner = part:GetNetworkOwner()
				if p.Anchored then p.Anchored = false p.AssemblyLinearVelocity = part.AssemblyLinearVelocity if p:CanSetNetworkOwnership() then p:SetNetworkOwner(networkowner) end end
				for _, weld in pairs(p:GetJoints()) do
					weld:Destroy()
				end
			
				p.Parent = workspace["--Map--"]
			
				if (p.Material == Enum.Material.Glass or p.Material == Enum.Material.Neon or p.Material == Enum.Material.Ice) and p.Name ~= "GlassShape" then
					local glasscolor = p.Color
					local glasstransparency = p.Transparency
					local glasssize = p.Size.Magnitude/6
				
					for i=1, math.round(math.random(6,12)) do
						local shape = Instance.new("Part")
						shape.Name = "GlassShape"
						shape.Shape = Enum.PartType.Wedge
						shape.Transparency = glasstransparency
						shape.Material = Enum.Material.Glass
						shape.Color = glasscolor
						shape.Size = Vector3.new(0.1*glasssize, glasssize, glasssize)
						shape.Parent = workspace["--Map--"]
						shape.CFrame = CFrame.new(p.Position.X+math.random(-10,10)/10,p.Position.Y+math.random(-10,10)/10,p.Position.Z+math.random(-10,10)/10) * CFrame.fromEulerAngles(math.rad(math.random(0,180)), math.rad(math.random(0,180)), math.rad(math.random(0,180)))
						local despawnscript = sss.LoadMap.DespawnScript:Clone()
						despawnscript.Parent = shape
						despawnscript.Enabled = true
						shape:SetNetworkOwner(networkowner)
					end
				
					p:Destroy()
				end
			end
		else
			if p.Parent ~= nil then
				if p.Parent:FindFirstChildOfClass("Humanoid") then
					if p:CanSetNetworkOwnership() then p:SetNetworkOwner(players:GetPlayerFromCharacter(p.Parent)) end
					local Humanoid = p.Parent:FindFirstChildOfClass("Humanoid")
					local damage = 0
					if power > 10 then
						damage = (power/10)
					end
					if damage>0 then
						Humanoid.Health = math.clamp(Humanoid.Health-damage,0,Humanoid.MaxHealth)
					end
				end
			end
		end
	end
end)