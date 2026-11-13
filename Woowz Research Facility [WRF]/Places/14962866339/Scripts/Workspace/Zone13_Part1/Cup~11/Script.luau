local colors = {Color3.fromRGB(214, 213, 217),Color3.fromRGB(217, 212, 157),Color3.fromRGB(184, 174, 96),Color3.fromRGB(145, 159, 184),Color3.fromRGB(89, 184, 89)}
script.Parent.cup.Color = colors[math.random(1,#colors)]
if math.random(0,100)>75 then
	script.Parent.cup.Transparency = 0.4
end
script.Parent.cup.CFrame = script.Parent.cup.CFrame * CFrame.Angles(0,math.rad(math.random(-180,180)),0)
script:Destroy()