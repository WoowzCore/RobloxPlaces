--[[Read line 24 of the script. Just edit the word "D4Tide" to whatever the gun name you want. The gun must be in the lighting for this to work. I'd reccomend you add a regen.]]

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
local wep = game.Lighting:FindFirstChild(script.Name):Clone()
wep.Parent = player.Backpack

wait(5)
debounce = false
end
end


script.Parent.Touched:connect(onTouch)