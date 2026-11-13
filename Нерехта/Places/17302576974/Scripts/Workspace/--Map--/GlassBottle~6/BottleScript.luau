local colorsbottles = {Color3.new(0.137255, 0.309804, 0.105882),Color3.fromRGB(113, 90, 44),Color3.new(0.34902, 0.290196, 0.235294),Color3.new(0.243137, 0.415686, 0.376471)}
local colorstops = {Color3.fromRGB(225, 64, 64),Color3.fromRGB(225, 153, 111),Color3.fromRGB(43, 113, 225)}

script.Parent.GlassBottle.Color = colorsbottles[math.random(1,#colorsbottles)]
script.Parent.Part.Color = colorstops[math.random(1,#colorstops)]
script:Destroy()