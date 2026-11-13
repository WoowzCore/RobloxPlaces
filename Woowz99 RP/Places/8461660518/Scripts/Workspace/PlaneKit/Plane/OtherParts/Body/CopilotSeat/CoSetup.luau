function giveTool(weldchild)
	local findhuman = weldchild.Part1.Parent:FindFirstChild("Humanoid")
	if (findhuman ~= nil) then
		local player = game.Players:GetPlayerFromCharacter(findhuman.Parent)
		if (player ~=nil) then
			gui = script.Parent["System"]:Clone() -- Change toolname to what tool you want to be given
			gui.Parent = player.PlayerGui
			gui.Seat.Value = script.Parent
		end
	end
end

function removeTool()
	if (gui ~= nil) then
		gui:Remove()
	end
end

script.Parent.ChildAdded:connect(giveTool)
script.Parent.ChildRemoved:connect(removeTool)