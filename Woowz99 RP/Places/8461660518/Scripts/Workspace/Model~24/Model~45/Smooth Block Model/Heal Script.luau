-- Dignity

power = 10 -- This is the limit of power in which you want to heal people. I recommend from 5, to 10.
function onTouched(part)
   local h = part.Parent:FindFirstChild("Humanoid") -- finds humanoid. makes sure you ARE a humanoid, and not just a foreign object.
   if h~=nil then
      h.Health = h.Health + power -- dont change this aspect
   end
end -- ends.

script.Parent.Touched:connect(onTouched) --If touched; script will become active.