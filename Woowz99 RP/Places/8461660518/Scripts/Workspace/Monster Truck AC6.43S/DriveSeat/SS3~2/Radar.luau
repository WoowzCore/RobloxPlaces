-- INSTRUCTIONS:
--	There are four dot colors. Green, Red, Blue, and Yellow. Green for allies, Red for enemies, Blue for neutral (Basically AI), and Yellow for objectives\objects.
--	
--					To build an objective\object (yellow dot) it must (at least) have this skeleton.
--						<model name>			Class: Model
--							Torso				Class: Part, Truss, Seat, or Veichle seat.
--	
--
--					To build a Neutral object (red dot) it must (at least) have this skeleton.
--						<model name>			Class: Model
--							<Humanoid name>		Class: Humanoid
--							Torso				Class: Part, Truss, Seat, or Veichle seat.
--
-- This only works for team games. The radar could possible break in FFA games.
--		Credit to nickcool9999 for the original radar. Dots, Neutral script, as well as team-check scripts by Havear.
wait(0.1)
local Center = UDim2.new(0.5, 0, 0.5, 0)
local Pl = script.Parent.Parent.Parent
local tab = {}
local c = script.Parent.Full.DotP:Clone()
local n = script.Parent.Full.DotO:Clone()
local g = script.Parent.Full.DotG:Clone()
local blue = script.Parent.Full.DotB:Clone()
local Distance = script.Parent.Dist -- Radar Distance.Value ( How far the radar sees in studs )

function CanfindHumanoid(place)
	local listt = place:GetChildren()
	for i = 1, #listt do
		if listt[i].className == "Humanoid" then
			return listt[i]
		end
	end
end

function D(v1, v2)
	return v1-v2
end


function PositionOnRadar(item)
	if CanfindHumanoid(item.Parent) ~= nil and Distance.Value > (item.Position - Pl.Character.Torso.Position).magnitude and item ~= Pl.Character.Torso then
		local aag = game.Players:GetPlayerFromCharacter(item.Parent)
		if aag ~= nil then
			local d = g:Clone()
			d.Parent = script.Parent.Frame
			if script.Parent.Names.Value == true then
				d.nam.Text = item.Parent.Name
			else
				d.nam.Text = ""
			end
			d.Position = UDim2.new(Center.X.Scale + (D(item.Position.x, Pl.Character.Torso.Position.x)/Distance.Value)/2, 0, Center.Y.Scale + (D(item.Position.z, Pl.Character.Torso.Position.z)/Distance.Value)/2, 0)
			d.Rotation = -(script.Parent.Frame.Rotation)
			coroutine.resume(coroutine.create(function()
				wait()
				d:remove()
			end))
		else
			local d = blue:Clone()
			d.Parent = script.Parent.Frame
			if script.Parent.Names.Value == true then
				d.nam.Text = item.Parent.Name
			else
				d.nam.Text = ""
			end
			d.Position = UDim2.new(Center.X.Scale + (D(item.Position.x, Pl.Character.Torso.Position.x)/Distance.Value)/2, 0, Center.Y.Scale + (D(item.Position.z, Pl.Character.Torso.Position.z)/Distance.Value)/2, 0)
			d.Rotation = -(script.Parent.Frame.Rotation)
			coroutine.resume(coroutine.create(function()
				wait()
				d:remove()
			end))
		end
	elseif CanfindHumanoid(item.Parent) == nil and Distance.Value > (item.Position - Pl.Character.Torso.Position).magnitude and item ~= Pl.Character.Torso then
		local d = n:Clone()
			d.Parent = script.Parent.Frame
			if script.Parent.Names.Value == true then
				d.nam.Text = item.Parent.Name
			else
				d.nam.Text = ""
			end
			d.Position = UDim2.new(Center.X.Scale + (D(item.Position.x, Pl.Character.Torso.Position.x)/Distance.Value)/2, 0, Center.Y.Scale + (D(item.Position.z, Pl.Character.Torso.Position.z)/Distance.Value)/2, 0)
			d.Rotation = -(script.Parent.Frame.Rotation)
		coroutine.resume(coroutine.create(function()
			wait()
			d:remove()
		end))
	end
end

function GetTorsos()
	tab = {}
	if Pl.Character:findFirstChild("HumanoidRootPart") then
		local list = workspace:GetChildren()
		for i = 1, #list do
			if list[i].className == "Model" and list[i]:findFirstChild("HumanoidRootPart") ~= nil then
				local listx = list[i]:GetChildren()
				for x = 1, #listx do
					if listx[x].Name == "HumanoidRootPart" then
						table.insert(tab, listx[x])
					end
				end
			end
		end
	end
	return tab
end
cam = workspace.CurrentCamera
slurAngle = 0
previousDesiredAngle = 0
spinSpeed = 1 --ratio per second
rotationOffset = 90 --in degrees
rotationOffset = math.rad(rotationOffset)
carSeat = script.Parent.CarSeat.Value
function Rotate()
	local vec = cam.CFrame.lookVector
	local desiredAngle = math.atan2(vec.z, vec.x)
	if desiredAngle < -1.57 and previousDesiredAngle > 1.57 then
		slurAngle = slurAngle - math.pi*2
	elseif desiredAngle > 1.57 and previousDesiredAngle < -1.57 then
		slurAngle = slurAngle + math.pi*2
	end
	slurAngle = slurAngle*(1-spinSpeed) + desiredAngle*spinSpeed
	local a = slurAngle + rotationOffset
	previousDesiredAngle = desiredAngle
	script.Parent.Frame.Rotation = -math.deg(a)
end

while true do
	wait()
	Rotate()
	local t = GetTorsos()
	for i = 1, #t do
		PositionOnRadar(t[i])
	end
end
--Edits made by Itzt