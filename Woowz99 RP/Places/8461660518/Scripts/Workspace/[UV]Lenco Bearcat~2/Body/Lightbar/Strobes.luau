model = script.Parent
wait(0.5)
currentP = "Off"
script.Parent.RemoteEvent.OnServerEvent:Connect( function(player, pattern)
	if script.Parent.On.Value == true then
		script.Parent.On.Value = false
	else
		script.Parent.On.Value = true
	end
end)