player = nil

function onChng()
	if script.Parent.Visible == true then
		player = game.Players.LocalPlayer
		player.Character.Plane.MainParts.Main.Value = true
	else 
		player.Character.Plane.MainParts.Main.Value = false
	end
end

script.Parent.Changed:connect(onChanged)