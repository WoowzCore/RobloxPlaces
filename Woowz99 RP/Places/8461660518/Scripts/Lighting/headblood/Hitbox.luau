local p = script.Parent
local e = require(game.ReplicatedStorage.RaycastHitboxV3)
local int = e:Initialize(p,{workspace.ignore,script.Parent.owner.Value,script.Parent})
int:PartMode(true)
int.OnHit:Connect(function(h,_,result)
	local pa = result.Position
	local na = result.Normal
	if h then

		local splat = game.Lighting.splat:Clone()
		splat.Parent = workspace.ignore
		splat.CFrame = CFrame.new(pa,pa-na)*CFrame.Angles(math.rad(-90),0,0)
		splat.Anchored = true
		p.Anchored = true
		int:HitStop()

	end
end)
int:HitStart()
delay(5,function()
int:HitStop()
end)