-- By     =     Really312


local screen = script.Parent.Parent.Screen
local light = screen.SurfaceLight

function TvOof()
	screen.Sound:Stop()
	screen.Decal.Transparency = 1
	screen.BrickColor = BrickColor.Black()
	screen.Material = Enum.Material.SmoothPlastic
	light.Enabled = false
end


script.Parent.ClickDetector.MouseClick:Connect(TvOof)