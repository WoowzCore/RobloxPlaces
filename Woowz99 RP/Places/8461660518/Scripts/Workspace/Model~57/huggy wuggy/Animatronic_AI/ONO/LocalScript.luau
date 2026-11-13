local Loleris = script.Parent:WaitForChild("ImageLabel")
  oldpos = Loleris.Position
local Frame = script.Parent:WaitForChild("Frame")

local scream = script.Parent:WaitForChild("XSCREAM")
local boom = script.Parent:WaitForChild("Boom")



if game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("Humanoid") then
 scream:Play()
 Spawn(function() 
  wait(.7) boom:Play()
  wait(.1) scream:Stop()
  Frame.ZIndex = 9
  game.Players.LocalPlayer.Character.Humanoid.Health = 0
 end)
 game:GetService("RunService").RenderStepped:connect(function()
  Loleris.Position = oldpos + UDim2.new(0,math.random(-10,10),0,math.random(-10,10))
 end)
end