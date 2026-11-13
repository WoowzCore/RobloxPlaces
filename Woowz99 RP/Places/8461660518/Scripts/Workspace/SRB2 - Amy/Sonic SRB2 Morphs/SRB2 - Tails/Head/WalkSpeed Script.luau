local debounce = false 

function onTouch(part) 

local human = part.Parent:findFirstChild("Humanoid") 
if (human ~= nil) and debounce == false then 

debounce = true 

human.WalkSpeed = 50-- or whatever number 

wait(2) 
debounce = false 
end 
end 


script.Parent.Touched:connect(onTouch) 
