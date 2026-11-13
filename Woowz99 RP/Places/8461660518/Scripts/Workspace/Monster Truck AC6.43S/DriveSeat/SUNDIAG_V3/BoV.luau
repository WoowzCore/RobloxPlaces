--Thanks to Zephyred for this little piece here. Edited by Jcool, for AlexStuff. Originally used in the "Hypernova GT"
 
local player = game.Players.LocalPlayer
local carSeat = script.Parent.CarSeat.Value
local mouse = game.Players.LocalPlayer:GetMouse()



 
mouse.KeyUp:connect(function (key)
    key = string.lower(key)
    if key == "f" then
	carSeat.BoV:Play()
end
end)
		