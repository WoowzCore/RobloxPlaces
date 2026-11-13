-- Using the FindPartsInRegion3 API, this regen is "smart" and will NOT regenerate if something is in the way.
-- If something IS in the way, the script will wait for the area to be clear.

local plane = script.Parent.Plane:clone()
script.Parent.Plane.Cloned.Value,plane.Cloned.Value = true,true
script.Parent.Plane.Origin.Value = script.Parent
local regen = script.Parent.Regen
local active = false
local downtime = 5	-- This is the only thing you should edit in any script in this plane kit. Every other piece of code should be left alone

plane.PrimaryPart = plane.MainParts.Main
local planeSize = plane:GetModelSize()
local planePos = plane:GetModelCFrame().p
local v0 = (planePos-(planeSize/2))
local v1 = (planePos+(planeSize/2))
local region = Region3.new(v0,v1)	-- Creates a 3D space using two Vector3s

local gui = Instance.new("ScreenGui")
gui.Name = "RegenGui"
local f = Instance.new("Frame",gui)
f.Name = "Message"
f.Style = Enum.FrameStyle.RobloxRound
f.Position = UDim2.new(0.5,-150,0.25,-15)
f.Size = UDim2.new(0,300,0,30)
local t = Instance.new("TextLabel",f)
t.Name = "Msg"
t.Text = "Awaiting area to be clear for regeneration to continue"
t.TextColor3 = Color3.new(1,1,1)
t.Font = Enum.Font.ArialBold
t.FontSize = Enum.FontSize.Size12
t.Position = UDim2.new(0.5,0,0.5,0)

function getPassengers(pln)	-- Checks for other players in seats on the plane. If no one is on board, the plane will be marked as "inactive" and removed
	local plrs = {}
	local function scan(parent)
		for _,v in pairs(parent:GetChildren()) do
			if ((v:IsA("Seat")) or (v:IsA("VehicleSeat"))) then
				if ((v:findFirstChild("SeatWeld")) and (v.SeatWeld.Part1)) then
					local plr = game.Players:GetPlayerFromCharacter(v.SeatWeld.Part1.Parent)
					if (plr) then table.insert(plrs,plr) end
				end
			end
			scan(v)
		end
	end
	scan(pln)
	return plrs
end

function deleteInactivePlanes()
	for _,v in pairs(script.Parent:GetChildren()) do
		if (v.Name == plane.Name) then
			local passengers = getPassengers(v)
			if (#passengers == 0) then
				v:remove()
			end
		end
	end
end

function regionIsClear()
	local parts = game.Workspace:findPartsInRegion3(region,regen,100)
	return (#parts == 0)
end

function regenMain()
	local p = plane:clone()
	p.Parent = script.Parent
	p:MakeJoints()
end

regen.Touched:connect(function(obj)
	if (active) then return end
	local plr = game.Players:GetPlayerFromCharacter(obj.Parent)
	if (not plr) then return end
	active = true
	deleteInactivePlanes()
	for i = 0,0.5,0.1 do
		regen.Transparency = i
		wait()
	end
	regen.Transparency = 0.5
	while (not regionIsClear()) do
		wait(0.5)
		if ((plr) and (plr.Parent) and (plr:findFirstChild("PlayerGui"))) then
			gui.Parent = plr.PlayerGui
		end
	end
	gui.Parent = nil
	regenMain()
	wait(downtime)
	for i = 0.5,0,-0.1 do
		regen.Transparency = i
		wait()
	end
	regen.Transparency = 0
	active = false
end)