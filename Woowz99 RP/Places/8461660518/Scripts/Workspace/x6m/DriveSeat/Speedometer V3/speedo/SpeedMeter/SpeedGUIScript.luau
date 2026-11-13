P = script.Parent
Player = game.Players.LocalPlayer
Human = Player.Character
Head = Human.Head


while true do
	wait(.3)
	local intSpeed = math.floor((Head.Velocity.magnitude)/1.6)
	P.SpeedLabel.Text = intSpeed.." MPH"
end
