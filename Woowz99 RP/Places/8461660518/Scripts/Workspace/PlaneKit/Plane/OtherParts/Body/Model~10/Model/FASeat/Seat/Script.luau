function onHit(hit)
script.Parent.Parent.Script.Disabled = false
end

script.Parent.Touched:connect(onHit)