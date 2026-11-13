game.StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Health,false) -- This Will Disable the Roblox Health GUI

--Variables
local player = game.Players.LocalPlayer
local char = player.Character
local gui = script.Parent
local frame = gui.HealthFrame
local bar = frame.Bar
local text = frame.HealthText

while wait() do
--Update text
text.Text = "HP: "..math.floor(char:WaitForChild("Humanoid").Health).."/"..char:WaitForChild("Humanoid").MaxHealth
-- Update bar
bar.Size = UDim2.new(0,(char:WaitForChild("Humanoid").Health / char:WaitForChild("Humanoid").MaxHealth * 200),1,0)
end