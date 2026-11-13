-- HoverSeatGUI script by TankLeadfoot

local Lock = nil

while (script.Parent:findFirstChild("CanFly") == nil) do wait(0.1) end
while (script.Parent:findFirstChild("VMode") == nil) do wait(0.1) end

script.Parent.CanFly.Value = "Yes"
script.Parent.VMode.Value = "Hover"

function SelectedButton(hit)
	game.Players:findFirstChild(hit.Parent.Name).PlayerGui.HoverSeat.Buttons.UpButton.BackgroundColor3 = Color3.new(0.5,0.5,0.5)
	game.Players:findFirstChild(hit.Parent.Name).PlayerGui.HoverSeat.Buttons.DownButton.BackgroundColor3 = Color3.new(0.5,0.5,0.5)
	game.Players:findFirstChild(hit.Parent.Name).PlayerGui.HoverSeat.Buttons.HoverButton.BackgroundColor3 = Color3.new(0.5,0.5,0.5)
	game.Players:findFirstChild(hit.Parent.Name).PlayerGui.HoverSeat.Buttons.AllStopButton.BackgroundColor3 = Color3.new(0.5,0.5,0.5)

	if (script.Parent.VMode.Value == "Up") then
		game.Players:findFirstChild(hit.Parent.Name).PlayerGui.HoverSeat.Buttons.UpButton.BackgroundColor3 = Color3.new(1,1,0.8)
	elseif (script.Parent.VMode.Value == "Down") then
		game.Players:findFirstChild(hit.Parent.Name).PlayerGui.HoverSeat.Buttons.DownButton.BackgroundColor3 = Color3.new(1,1,0.8)
	elseif (script.Parent.VMode.Value == "Hover") then
		game.Players:findFirstChild(hit.Parent.Name).PlayerGui.HoverSeat.Buttons.HoverButton.BackgroundColor3 = Color3.new(1,1,0.8)
	elseif (script.Parent.VMode.Value == "AllStop") then
		game.Players:findFirstChild(hit.Parent.Name).PlayerGui.HoverSeat.Buttons.AllStopButton.BackgroundColor3 = Color3.new(1,1,0.8)
	end
end

function Pilot(hit)
	if (Lock == nil) then
		Lock = true

		if (hit == nil) then Lock = nil; return end
		if (hit.Parent:findFirstChild("Humanoid") == nil) then Lock = nil;  return end
		if (game.Players:findFirstChild(hit.Parent.Name) == nil) then  Lock = nil; return end
		wait(2)
		if (script.Parent:findFirstChild("CanFly") ~= nil) then
			script.Parent.CanFly.Value = "Yes"
		end
		if (script.Parent:findFirstChild("VMode") ~= nil) then
			script.Parent.VMode.Value = "Hover"
		end

		if (game.Players:findFirstChild(hit.Parent.Name).PlayerGui:findFirstChild("HoverSeat") == nil) then
			script.HoverSeat:Clone().Parent = game.Players:findFirstChild(hit.Parent.Name).PlayerGui
			SelectedButton(hit)
		end

		game.Players:findFirstChild(hit.Parent.Name).PlayerGui.HoverSeat.Buttons.UpButton.MouseButton1Click:connect(function()
			if (script.Parent:findFirstChild("VMode") ~= nil) and (script.Parent:findFirstChild("CanFly") ~= nil) then	
				if (script.Parent.CanFly.Value == "Yes") then
					script.Parent.VMode.Value = "Up"
					SelectedButton(hit)
				end
			end
		end)
		game.Players:findFirstChild(hit.Parent.Name).PlayerGui.HoverSeat.Buttons.DownButton.MouseButton1Click:connect(function()
			if (script.Parent:findFirstChild("VMode") ~= nil) and (script.Parent:findFirstChild("CanFly") ~= nil) then
				if (script.Parent.CanFly.Value == "Yes") then
					script.Parent.VMode.Value = "Down"
					SelectedButton(hit)
				end
			end
		end)
		game.Players:findFirstChild(hit.Parent.Name).PlayerGui.HoverSeat.Buttons.HoverButton.MouseButton1Click:connect(function()
			if (script.Parent:findFirstChild("VMode") ~= nil) and (script.Parent:findFirstChild("CanFly") ~= nil) then
				script.Parent.VMode.Value = "Hover"
				script.Parent.CanFly.Value = "Yes"
				SelectedButton(hit)
			end
		end)
		game.Players:findFirstChild(hit.Parent.Name).PlayerGui.HoverSeat.Buttons.AllStopButton.MouseButton1Click:connect(function()
			if (script.Parent:findFirstChild("VMode") ~= nil) and (script.Parent:findFirstChild("CanFly") ~= nil) then
				script.Parent.VMode.Value = "AllStop"
				script.Parent.CanFly.Value = "No"
				SelectedButton(hit)
			end
		end)

		while (hit.Parent.Humanoid.Health > 0) and (hit.Parent.Humanoid.Sit == true) do wait(0.1) end
		if (game.Players:findFirstChild(hit.Parent.Name).PlayerGui:findFirstChild("HoverSeat") ~= nil) then
			game.Players:findFirstChild(hit.Parent.Name).PlayerGui.HoverSeat:Remove()
		end

		if (script.Parent:findFirstChild("CanFly") ~= nil) then
			script.Parent.CanFly.Value = "No"
		end
		Lock = nil
	end
end

script.Parent.Touched:connect(Pilot)
