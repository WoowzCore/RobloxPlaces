function onTouched(hit)if hit.Parent.Name == "wheel" thenhit:BreakJoints()
elseif hit.Name == "bodypart" then
hit:BreakJoints()

elseif hit.Name == "engine" then
hit:BreakJoints()end
end

connection = script.Parent.Touched:connect(onTouched)
