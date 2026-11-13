--None of this is mine...

Tool = script.Parent;
local arms = nil
local torso = nil
local welds = {}

script.act.OnServerEvent:Connect(function()
wait(0.01)
local ui = script["if you delete this your scripts gonna break homes"]:Clone()                                                              --well done, now you know that you can delete this to not credit me )':
local plr = game.Players:GetPlayerFromCharacter(Tool.Parent)
ui.Parent = plr.PlayerGui
arms = {Tool.Parent:FindFirstChild("Left Arm"), Tool.Parent:FindFirstChild("Right Arm")}
torso = Tool.Parent:FindFirstChild("Torso")
if arms ~= nil and torso ~= nil then
local sh = {torso:FindFirstChild("Left Shoulder"), torso:FindFirstChild("Right Shoulder")}
if sh ~= nil then
local yes = true
if yes then
yes = false
sh[1].Part1 = nil
sh[2].Part1 = nil
local weld1 = Instance.new("Weld")
weld1.Part0 = torso
weld1.Parent = torso
weld1.Part1 = arms[1]
weld1.C1 = CFrame.new(0.9, 0.6, 0.4) * CFrame.fromEulerAnglesXYZ(math.rad(270), math.rad(25), math.rad(0)) ---The first set of numbers changes where the arms move to the second set changes their angles
welds[1] = weld1
weld1.Name = "weld1"
local weld2 = Instance.new("Weld")
weld2.Part0 = torso
weld2.Parent = torso
weld2.Part1 = arms[2]
weld2.C1 = CFrame.new(-1, 0.6, 0.5) * CFrame.fromEulerAnglesXYZ(math.rad(-90), math.rad(-20), 0) --- Same as top
welds[2] = weld2
weld2.Name = "weld2"
end
else
print("sh")
end
else
print("arms")
end
end)
arms = {Tool.Parent:FindFirstChild("Left Arm"), Tool.Parent:FindFirstChild("Right Arm")}
torso = Tool.Parent:FindFirstChild("Torso")
if arms ~= nil and torso ~= nil then
local sh = {torso:FindFirstChild("Left Shoulder"), torso:FindFirstChild("Right Shoulder")}
if sh ~= nil then
local yes = true
if yes then
yes = false
sh[1].Part1 = nil
sh[2].Part1 = nil
local weld1 = Instance.new("Weld")
weld1.Part0 = torso
weld1.Parent = torso
weld1.Part1 = arms[1]
weld1.C1 = CFrame.new(0.9, 0.6, 0.4) * CFrame.fromEulerAnglesXYZ(math.rad(270), math.rad(25), math.rad(0)) ---The first set of numbers changes where the arms move to the second set changes their angles
welds[1] = weld1
weld1.Name = "weld1"
local weld2 = Instance.new("Weld")
weld2.Part0 = torso
weld2.Parent = torso
weld2.Part1 = arms[2]
weld2.C1 = CFrame.new(-1, 0.6, 0.5) * CFrame.fromEulerAnglesXYZ(math.rad(-90), math.rad(-20), 0) --- Same as top
welds[2] = weld2
weld2.Name = "weld2"
end
else
print("sh")
end
else
print("arms")
end;
script.dct.OnServerEvent:Connect(function()
	local ui = script.Parent.Parent.Parent.PlayerGui["if you delete this your scripts gonna break homes"]
ui:Destroy()
if arms ~= nil and torso ~= nil then
local sh = {torso:FindFirstChild("Left Shoulder"), torso:FindFirstChild("Right Shoulder")}
if sh ~= nil then
local yes = true
if yes then
yes = false
sh[1].Part1 = arms[1]
sh[2].Part1 = arms[2]
welds[1].Parent = nil
welds[2].Parent = nil
end
else
print("sh")
end
else
print("arms")
end
end)