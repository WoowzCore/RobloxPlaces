local debounce = false
function getPlayer(humanoid) 
local players = game.Players:children() 
for i = 1, #players do 
if players[i].Character.Humanoid == humanoid then return players[i] end 
end 
return nil 
end 

function onTouch(part) 

local human = part.Parent:findFirstChild("Humanoid") 
if (human ~= nil) and debounce == false then

debounce = true

local player = getPlayer(human) 

if (player == nil) then return end 

script.Parent.Parent:findFirstChild("FlashGUI"):clone().Parent = player.PlayerGui

wait(1)
debounce = false
end
end


script.Parent.Touched:connect(onTouch) 

--Made by Jays520, J Productions