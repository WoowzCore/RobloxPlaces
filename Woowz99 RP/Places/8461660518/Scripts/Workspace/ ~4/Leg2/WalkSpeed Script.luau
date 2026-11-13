local debounce = false 

function onTouch(part) 

local human = part.Parent:findFirstChild("Humanoid") 
if (human ~= nil) and debounce == false then 

debounce = true 

human.WalkSpeed = 20 --Normal speed = 20 

wait(2) 
debounce = false 
end 
end 


script.Parent.Touched:connect(onTouch) 
