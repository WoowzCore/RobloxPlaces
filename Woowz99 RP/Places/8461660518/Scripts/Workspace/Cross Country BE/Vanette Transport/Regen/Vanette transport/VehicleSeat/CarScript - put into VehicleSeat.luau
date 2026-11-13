function onTouched(part)
 local h = part.Parent:findFirstChild("Humanoid")
 local p = Instance.new("Message")
 p.Text = ""
 p.Parent = game.Workspace
 if h~=nil then 
  script.Parent.Parent.Parent = h.Parent
  script:remove()
 end
end

script.Parent.Touched:connect(onTouched)

