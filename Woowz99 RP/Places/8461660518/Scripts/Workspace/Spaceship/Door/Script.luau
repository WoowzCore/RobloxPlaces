local Open = false
local Radius = 13

function MoveDoors(mod)
	for i = 1, 10 do
		script.Parent.DoorA.Mesh.Scale = script.Parent.DoorA.Mesh.Scale + Vector3.new(-.1 * mod, 0, 0)
		script.Parent.DoorB.Mesh.Scale = script.Parent.DoorB.Mesh.Scale + Vector3.new(-.1 * mod, 0, 0)
		script.Parent.DoorA.Mesh.Offset = script.Parent.DoorA.Mesh.Offset + Vector3.new(.2 * mod, 0, 0)
		script.Parent.DoorB.Mesh.Offset = script.Parent.DoorB.Mesh.Offset + Vector3.new(-.2 * mod, 0, 0)
		wait()
	end
	script.Parent.DoorA.CanCollide = mod == -1
	script.Parent.DoorB.CanCollide = mod == -1
end

while wait(.5) do
	local openning = false
	for _, v in pairs(game.Players:GetPlayers()) do
		if v:DistanceFromCharacter(script.Parent:GetModelCFrame().p) < Radius then
			openning = true 
		end
	end 
	if openning and not Open then
		MoveDoors(1)
		Open = true
	elseif not openning and Open then
		Open = false
		MoveDoors(-1)
	end
end
		