local stapler = script.Parent.stapler
local textures = {stapler.SurfaceAppearance1,stapler.SurfaceAppearance2,stapler.SurfaceAppearance3,stapler.SurfaceAppearance4,stapler.SurfaceAppearance5}
local winner = textures[math.random(1,#textures)]
for _, p in pairs(stapler:GetChildren()) do
	if p:IsA("SurfaceAppearance") and p ~= winner then
		p:Destroy()
	end
end
script:Destroy()