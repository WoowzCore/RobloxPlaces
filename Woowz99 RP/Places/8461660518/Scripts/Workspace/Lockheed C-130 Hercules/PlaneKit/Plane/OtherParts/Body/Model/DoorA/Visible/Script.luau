Visible = script.Parent
DoorB = Visible.Parent
while true do
	if Visible.Value == true then
		DoorB.Part1.Transparency = 0
		DoorB.Part1.CanCollide = true
		DoorB.Part2.Transparency = 0
		DoorB.Part2.CanCollide = true
	elseif Visible.Value == false then
		DoorB.Part1.Transparency = 1
		DoorB.Part1.CanCollide = false
		DoorB.Part2.Transparency = 1
		DoorB.Part2.CanCollide = false
	end
wait()
end