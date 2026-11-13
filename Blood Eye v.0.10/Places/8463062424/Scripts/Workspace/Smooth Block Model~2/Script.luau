function ontouch(hit)
local pl = hit.Parent:findFirstChild("Humanoid")
if pl~=nil then
pl.Health = pl.Health = 0
end
end
script.Parent.Touched:connect(ontouch)