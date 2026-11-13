local noise = script.Parent
local textures = {"14589931682","14589941985","14589946753","14589950476"}
local i = 1

while wait() do
	noise.Image = "rbxassetid://"..textures[i]
	noise.TileSize = UDim2.new(math.random(),0,math.random(),0)
	i+=1
	if i > #textures then
		i = 1
	end 
end