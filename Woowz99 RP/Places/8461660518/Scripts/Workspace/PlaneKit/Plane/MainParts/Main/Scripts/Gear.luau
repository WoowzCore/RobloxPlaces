local FE = script.Parent.Parent.FE.GearFE
local landingGear = script.Parent.Parent.Parent.LandingGear
local gearParts = {}
local gear = true

function getGear(parent)	-- Very common way to scan through every descendant of a model:
	for _,v in pairs(parent:GetChildren()) do
		if (v:IsA("BasePart")) then
			local t,r,c = Instance.new("NumberValue",v),Instance.new("NumberValue",v),Instance.new("BoolValue",v)	-- Saving original properties
			t.Name,r.Name,c.Name = "Trans","Ref","Collide"
			t.Value,r.Value,c.Value = v.Transparency,v.Reflectance,v.CanCollide
			table.insert(gearParts,v)
		end
		getGear(v)
	end
end

getGear(landingGear)

function changeGear()
	gear = (not gear)
	for _,v in pairs(gearParts) do
		v.Transparency,v.Reflectance,v.CanCollide = (gear and v.Trans.Value or 1),(gear and v.Ref.Value or 0),(gear and v.Collide.Value or false)	-- Learning how to code like this is extremely useful
	end
end

FE.OnServerEvent:Connect(changeGear)