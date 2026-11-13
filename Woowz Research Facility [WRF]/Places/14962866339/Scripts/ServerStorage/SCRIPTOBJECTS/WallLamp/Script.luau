local lights = {{Color3.fromRGB(191, 191, 194),Color3.fromRGB(255,255,255)},
{Color3.fromRGB(214, 216, 199),Color3.fromRGB(255, 255, 247)},
{Color3.fromRGB(182, 198, 196),Color3.fromRGB(242, 255, 254)},
{Color3.fromRGB(167, 184, 167),Color3.fromRGB(246, 255, 243)},
{Color3.fromRGB(194, 194, 194),Color3.fromRGB(255,255,255)},
{Color3.fromRGB(185, 185, 185),Color3.fromRGB(255,255,255)}
}

local color = lights[math.random(1,#lights)]
script.Parent.LightPart.Color = color[1]
script.Parent.LightPart.PointLight.Color = color[2]