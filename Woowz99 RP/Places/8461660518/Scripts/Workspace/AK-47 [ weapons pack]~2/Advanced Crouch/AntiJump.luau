h = script.Parent.Humanoid

function BLAAARGH()
h.Jump = false
end

h.Changed:connect(BLAAARGH)
