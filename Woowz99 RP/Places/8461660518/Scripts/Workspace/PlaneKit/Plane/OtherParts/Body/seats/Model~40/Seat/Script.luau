script.Parent.ChildAdded:connect(function(obj)
	if ((not obj:IsA("Weld")) or (obj.Name ~= "SeatWeld")) then return end
	local p = game.Players:GetPlayerFromCharacter(obj.Part1.Parent)
	if (not p) then return end
	if script.Parent.SeatNumber.Value == "1D" or script.Parent.SeatNumber.Value == "2D" or script.Parent.SeatNumber.Value == "3D" or script.Parent.SeatNumber.Value == "4D" or script.Parent.SeatNumber.Value == "5D" or script.Parent.SeatNumber.Value == "6D" or script.Parent.SeatNumber.Value == "7D" or script.Parent.SeatNumber.Value == "8D" or script.Parent.SeatNumber.Value == "9D" or script.Parent.SeatNumber.Value == "10D" or script.Parent.SeatNumber.Value == "11D" or script.Parent.SeatNumber.Value == "12D" or script.Parent.SeatNumber.Value == "13D" or script.Parent.SeatNumber.Value == "14D" or script.Parent.SeatNumber.Value == "15D" or script.Parent.SeatNumber.Value == "16D" or script.Parent.SeatNumber.Value == "1C" or script.Parent.SeatNumber.Value == "2C" or script.Parent.SeatNumber.Value == "3C" or script.Parent.SeatNumber.Value == "4C" or script.Parent.SeatNumber.Value == "5C" or script.Parent.SeatNumber.Value == "6C" or script.Parent.SeatNumber.Value == "7C" or script.Parent.SeatNumber.Value == "8C" or script.Parent.SeatNumber.Value == "9C" or script.Parent.SeatNumber.Value == "10C" or script.Parent.SeatNumber.Value == "11C" or script.Parent.SeatNumber.Value == "12C" or script.Parent.SeatNumber.Value == "13C" or script.Parent.SeatNumber.Value == "14C" or script.Parent.SeatNumber.Value == "15C" or script.Parent.SeatNumber.Value == "16C" then
		if p.Name == script.Parent.Parent.Parent.Parent.Parent.Parent.MainParts.CD.SurfaceGui[script.Parent.SeatNumber.Value].Player.Value or script.Parent.Parent.Parent.Parent.Parent.Parent.MainParts.CD.SurfaceGui[script.Parent.SeatNumber.Value].Player.Value == "" then
			print("Allowed")
		else
			if script.Parent:FindFirstChild("SeatWeld") then
				wait()
				script.Parent.SeatWeld.Parent = nil
				print("Jumped")
				local newgui = script.Error_SeatBooked:clone()
				newgui.Parent = p.PlayerGui
				newgui.Script.Disabled = false
			end
		end
	else
		if p.Name == script.Parent.Parent.Parent.Parent.Parent.Parent.MainParts.AB.SurfaceGui[script.Parent.SeatNumber.Value].Player.Value or script.Parent.Parent.Parent.Parent.Parent.Parent.MainParts.AB.SurfaceGui[script.Parent.SeatNumber.Value].Player.Value == "" then
			print("Allowed")
		else
			if script.Parent:FindFirstChild("SeatWeld") then
				wait()
				script.Parent.SeatWeld.Parent = nil
				print("Jumped")
				local newgui = script.Error_SeatBooked:clone()
				newgui.Parent = p.PlayerGui
				newgui.Script.Disabled = false
			end
		end
	end
end)