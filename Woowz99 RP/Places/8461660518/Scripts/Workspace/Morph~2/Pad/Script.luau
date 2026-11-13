
local pad = script.Parent
local characterName = "Pickle"
local character = pad.Parent:WaitForChild(characterName)
 
local debounce = true
pad.Touched:Connect(function(obj)
    local plr = game.Players:GetPlayerFromCharacter(obj.Parent)
    if plr and debounce == true then
        debounce = false
       
        pad.BrickColor = BrickColor.new("Really red")
       
        local charClone = character:Clone()
        charClone.Name = plr.Name
        plr.Character = charClone
       
        local rootPart = charClone:FindFirstChild("HumanoidRootPart") or charClone:FindFirstChild("Torso")
        local plrRoot = obj.Parent:FindFirstChild("HumanoidRootPart") or obj.Parent:FindFirstChild("Torso")
       
        if rootPart and plrRoot then
            rootPart.CFrame = plrRoot.CFrame
        end
       
        charClone.Parent = workspace
       
        wait(.5)
       
        pad.BrickColor = BrickColor.new("Lime green")
        debounce = true
    end
end)