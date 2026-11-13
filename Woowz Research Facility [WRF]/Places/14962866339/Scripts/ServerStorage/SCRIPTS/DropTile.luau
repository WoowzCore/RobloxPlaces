local tile = script.Parent

tile.Name = tile.Name.."_DROPPED"
tile.CanCollide = false
tile.Anchored = false
wait()
tile.CanCollide = true
local drag = game:GetService("ServerStorage").SCRIPTS.DragDetector:Clone()
drag.Parent = tile
drag.MaxForce = 1000
drag.MaxTorque = 1000
script:Destroy()