debouce = false
function onTouched(hit)
if debouce == false then
local h= hit.Parent:findFirstChild("Humanoid")
if h~=nil then
debouce = true
wait(0.1)
script.Parent.BrickColor = BrickColor.new("Light Orange")
local p=hit.Parent:GetChildren() 
for i=1,#p do 
if p[i].className=="Pants" then 
p[i]:remove() 
end 
end
local pz=hit.Parent:GetChildren() 
for i=1,#pz do 
if pz[i].className=="Shirt" then 
pz[i]:remove() 
end 
end
s=Instance.new("Pants")
s.Parent = hit.Parent
s.PantsTemplate = "http://www.roblox.com/asset/?id=20873303"
sa=Instance.new("Shirt")
sa.Parent = hit.Parent
sa.ShirtTemplate = "http://www.roblox.com/asset/?id=20908873"
h.MaxHealth = 100
local ph=hit.Parent:GetChildren() 
for i=1,#ph do 
if ph[i].className=="" then 
ph[i]:remove() 
	end 
		end
wait(2)
script.Parent.BrickColor = BrickColor.new("Light Orange")
debouce = false
end
end
end
script.Parent.Touched:connect(onTouched)