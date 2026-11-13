local Vehicle = script.Parent.Vehicle:Clone()

function AbleAll(vehicle, able)
	for i, v in pairs(vehicle:GetChildren()) do
		if v:IsA("Script") and v.Parent.Name ~= "Missile" then
			v.Disabled = able
		else
			AbleAll(v, able)
		end
	end
end

AbleAll(Vehicle, true)

local CurrentVehicle = script.Parent.Vehicle

local Regen = script.Parent.Regen
local ClickDetector = Regen.ClickDetector
local Display = Regen.Display.Label

local InUse = false
local Debounce = false

function UpdateUse()
	Display.Text = Debounce and "REGENERATING" or InUse and "VEHICLE IS IN USE" or "REGEN"
end

function HandleVehicle(vehicle)
	InUse = false
	local seats = {}
	
	local function CheckUse()
		local used = false
		for i, v in pairs(seats) do
			if v then
				used = true
			end
		end
		InUse = used
		UpdateUse()
	end
	
	local function GetAllSeats(vehicle)
		for i, v in pairs(vehicle:GetChildren()) do
			if v:IsA("VehicleSeat") or v:IsA("Seat") then
				table.insert(seats, false)
				local id = #seats
				v.ChildAdded:connect(function(child)
					if child.Name == "SeatWeld" then
						seats[id] = true
						CheckUse()
					end
				end)
				v.ChildRemoved:connect(function(child)
					if child.Name == "SeatWeld" then
						seats[id] = false
						CheckUse()
					end
				end)
			elseif v:IsA("Model") then
				GetAllSeats(v)
			end
		end
	end
	GetAllSeats(vehicle)
end

HandleVehicle(script.Parent.Vehicle)

ClickDetector.MouseClick:connect(function()
	if not InUse and not Debounce then
		Debounce = true
		UpdateUse()
		CurrentVehicle:Destroy()
		CurrentVehicle = Vehicle:Clone()
		CurrentVehicle.Parent = Workspace
		CurrentVehicle:MakeJoints()
		Delay(0.5,
			function() AbleAll(CurrentVehicle, false)
		end)
		HandleVehicle(CurrentVehicle)
		wait(5)		
		Debounce = false
		UpdateUse()
	end
end)