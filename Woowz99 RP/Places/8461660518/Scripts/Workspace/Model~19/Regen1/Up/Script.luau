s = script
g = game.Workspace
Car = s.Parent.Parent.Car1
-------------------------
function onClicked()
Car.BodyVelocity.velocity = Vector3.new(0, 5, 0)
end
script.Parent.ClickDetector.MouseClick:connect(onClicked)
