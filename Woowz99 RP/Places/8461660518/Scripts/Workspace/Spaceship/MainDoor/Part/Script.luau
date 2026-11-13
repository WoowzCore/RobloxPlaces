door = script.Parent.Parent.Door
door1 = script.Parent.Parent.Door1
ON = script.Parent.Parent.ON

function onClicked(mouse)
if ON.Value == 0 then
door.Transparency = 0
door.CanCollide = true
door1.Transparency = 1
door1.CanCollide = false
ON.Value = 1
else
door1.Transparency = 0
door1.CanCollide = true
door.Transparency = 1
door.CanCollide = false
ON.Value = 0
end
end
script.Parent.ClickDetector.MouseClick:connect(onClicked)