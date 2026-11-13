
local btn = script.Parent

local plr = game.Players.LocalPlayer

local char = plr.Character or plr.CharacterAdded:Wait()

local hum = char:WaitForChild("Humanoid",10)

local CanEmote = true

local CoolDown = 1



btn.MouseButton1Click:connect(function()

 if CanEmote == true then

  

  

  CanEmote = false 

  local dance = hum:LoadAnimation(script:FindFirstChild("Anim1"))

  dance:Play()

  

  wait(CoolDown + dance.Length)

  

  CanEmote = true

 end

end)