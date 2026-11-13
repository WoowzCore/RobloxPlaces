script.Parent.ChildAdded:connect(function(w)
print("ChildAdded")
if w.className=="Weld" then
print("IsAWeld")
if w.Name=="SeatWeld" then
print("IsASeatWeld")
if w.Part1.Parent:findFirstChild("Humanoid")~=nil then
print("IsAHumanoid")
pl=game.Players:GetPlayerFromCharacter(w.Part1.Parent)
if pl~=nil then
print("IsAPlayer")
if pl.PlayerGui:findFirstChild("VehicleGui")~=nil then
print("found vehicle gui - deleting")
pl.PlayerGui:findFirstChild("VehicleGui").Parent=nil
print("deleted")
else
print("no gui found - adding")
newgui=script.Parent.VehicleGui:clone()
newgui.Parent=pl.PlayerGui
newgui.Vehicle.Value=script.Parent.Parent

print("added")
end
end
end
end
end
end)

script.Parent.ChildRemoved:connect(function(w)
print("ChildRemoved")
if w.className=="Weld" then
print("IsAWeld")
if w.Name=="SeatWeld" then
print("IsASeatWeld")
if w.Part1.Parent:findFirstChild("Humanoid")~=nil then
print("IsAHumanoid")
pl=game.Players:GetPlayerFromCharacter(w.Part1.Parent)
if pl~=nil then
print("IsAPlayer")
if pl.PlayerGui:findFirstChild("VehicleGui")~=nil then
print("found vehicle gui - deleting")
pl.PlayerGui:findFirstChild("VehicleGui").Parent=nil
print("deleted")
else
print("no gui found - wierd...")
end
end
end
end
end
end)

