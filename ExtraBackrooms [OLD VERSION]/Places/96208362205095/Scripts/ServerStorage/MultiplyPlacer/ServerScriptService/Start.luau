local Light = game.Lighting

Light.Ambient = Color3.fromRGB(0,0,0)

if Light:FindFirstChildOfClass("DepthOfFieldEffect") then
	Light:FindFirstChildOfClass("DepthOfFieldEffect").Enabled = true
end
if Light:FindFirstChildOfClass("ColorCorrectionEffect") then
	Light:FindFirstChildOfClass("ColorCorrectionEffect").Enabled = true
end
if Light:FindFirstChildOfClass("BloomEffect") then
	Light:FindFirstChildOfClass("BloomEffect").Enabled = true
end

print("ExtraBackrooms Loaded!")