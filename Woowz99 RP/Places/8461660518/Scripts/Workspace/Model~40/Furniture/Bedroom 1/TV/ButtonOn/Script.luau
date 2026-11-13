
-- By     =     Really312



local screen = script.Parent.Parent.Screen
local img = screen.Decal
local light = screen.SurfaceLight

function TvOn()
	
	local k = math.random(1,3)
		if k == 1 then
		img.Texture = "rbxassetid://1365494765"
		screen.Sound.SoundId = "rbxassetid://1837889876"
		screen.Sound:Play()
	else
	if k == 2 then
		img.Texture = "rbxassetid://1408842771"
		screen.Sound.SoundId = "rbxassetid://588711502"
		screen.Sound:Play()
	else
	if k == 3 then
		img.Texture = "rbxassetid://1458693744"
		screen.Sound.SoundId = "rbxassetid://1846537079"
		screen.Sound:Play()
			end
		end
	end
	screen.Decal.Transparency = 0.1
	screen.BrickColor = BrickColor.White()
	screen.Material = Enum.Material.Neon
	light.Enabled = true
	
end


script.Parent.ClickDetector.MouseClick:Connect(TvOn)











-- nice