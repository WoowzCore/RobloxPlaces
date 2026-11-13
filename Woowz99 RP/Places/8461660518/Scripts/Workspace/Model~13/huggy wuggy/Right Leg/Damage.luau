--[[ Damage Brick made by Zipper01 (This is a practice model to test what I can script). 
	Created 10/28/2013 at 8:46PM
	--]]

function touch(hit)
	hit.Parent:FindFirstChild("Humanoid").Health = hit.Parent:FindFirstChild("Humanoid").Health -50
	
end

script.Parent.Touched:connect(touch)