--asimo3089
--[[
Just place this door. This door is fully setup and ready to do. Feel free to build your own door and throw it in the door model.
Make sure your door lines up with those red hinges, which will be invisible once it's running in your game.

Thanks
--]]

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

local force = 700 --Set this higher if your door swings back and forth too much. Set lower if your door is too hard to push.

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

wait(.1)
local people = script.Parent:GetChildren()
for i = 1,#people do
if people[i].className == "Part" then
people[i].TopSurface = "Weld"
people[i].BottomSurface = "Weld"
people[i].LeftSurface = "Weld"
people[i].RightSurface = "Weld"
people[i].FrontSurface = "Weld"
people[i].BackSurface = "Weld"
end end

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --  

local prev
local parts = script.Parent:GetChildren()
for i = 1,#parts do
	if ((parts[i].className == "Part") or (parts[i].className == "Handle") or (parts[i].className == "TrussPart") or (parts[i].className == "VehicleSeat") or (parts[i].className == "SkateboardPlatform")) then
		if (prev ~= nil) then
			local weld = Instance.new("Weld")
			weld.Part0 = prev
			weld.Part1 = parts[i]
			weld.C0 = prev.CFrame:inverse(Engine)
			weld.C1 = parts[i].CFrame:inverse(Part)
			weld.Parent = prev
			parts[i].Anchored = false
		end
		prev = parts[i]
	end
end


local bp = Instance.new("BodyPosition")
bp.Parent = script.Parent.middle
bp.maxForce = Vector3.new(force,math.huge,force)
bp.position = script.Parent.middle.Position
wait()

script.Parent.Hinges.Parta.Transparency = 1
script.Parent.Hinges.Partb.Transparency = 1

local people = script.Parent:GetChildren()
for i = 1,#people do
if people[i].className == "Part" then
people[i].TopSurface = "SmoothNoOutlines"
people[i].BottomSurface = "SmoothNoOutlines"
people[i].LeftSurface = "SmoothNoOutlines"
people[i].RightSurface = "SmoothNoOutlines"
people[i].FrontSurface = "SmoothNoOutlines"
people[i].BackSurface = "SmoothNoOutlines"
people[i].Anchored = false
end end
