p= script.Parent:GetChildren() 
for i= 1, #p do 
if p[i].className == "Part" then 
p[i].Locked = true
end 
end 
