wait(.1)
local carSeat = script.Parent.CarSeat.Value
local Player = game.Players.LocalPlayer
local Mouse = Player:GetMouse()
local handler = carSeat.FE_Lights
local Debounce = false
local lights = carSeat.Lights
Mouse.KeyDown:connect(function(key)
    local k = key:lower()
    if k == 's' then
        handler:FireServer('updateLights', 'brake', true)
	elseif k == 'l' then
        if lights.Value == false then
			lights.Value = true
			handler:FireServer('updateLights', 'beam', true)
		else lights.Value = false
			handler:FireServer('updateLights', 'beam', false)
		end
    elseif k == 'z' then -- left
        if not Debounce then
            Debounce = true
            handler:FireServer('blinkers', 'Left')
            wait(1/3)
            Debounce = false
        end
    elseif k == 'c' then -- right
        if not Debounce then
            Debounce = true
            handler:FireServer('blinkers', 'Right')
            wait(1/3)
            Debounce = false
        end
    elseif k == 'x' then -- hazards
        if not Debounce then
            Debounce = true
            handler:FireServer('blinkers', 'Hazards')
            wait(1/3)
            Debounce = false
        end
    end
end)

Mouse.KeyUp:connect(function(key)
    local k = key:lower()
    if k == 's' then
        handler:FireServer('updateLights', 'brake', false)
    end
end)

handler.OnClientEvent:connect(function(...)
    local Args = {...}
    if Args[1] then
        if Args[1] == 'blink' then
            if Args[2] then
                local P = Args[2]
                if Args[3] then
                    local Play = Args[3]
                    script.Parent.Blink.Pitch = P
                    if Play == true then
                        script.Parent.Blink:Play()
                    elseif Play == false then
                        script.Parent.Blink:Stop()
                    end
                end
            end
        end
    end
end)