local players = game:GetService("Players") 
local playerboi = players.LocalPlayer 
for ab,cd in pairs(script:GetChildren()) do 
cd.Disabled = true
end
repeat wait() until script:FindFirstAncestorOfClass("Model") == playerboi.Character 

for ab,cd in pairs(script:GetChildren()) do 
cd.Parent = playerboi.PlayerScripts 
cd.Disabled = false
end