local clouds = game.Workspace.Terrain.Clouds

local limints = Vector2.new(0.101, 0.75)

local t = 0

while wait() do
	t += 0.0001
	clouds.Density = limints.X+(math.sin(t)*(limints.Y-limints.X))
end