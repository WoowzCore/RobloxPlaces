--Script Creator {Woowz11 (In ROBLOX "Woowz14")}
wait(0.1)
local objName = script.Parent.SpawnThis.Value
local OrigObjPos = game.Workspace.SavedObjects
local obj = OrigObjPos:WaitForChild(objName)
local objCopy = obj:Clone()
objCopy.Parent = game.Workspace
objCopy.Position = script.Parent.Position
objCopy.Orientation = script.Parent.Orientation
script.Parent:Destroy()