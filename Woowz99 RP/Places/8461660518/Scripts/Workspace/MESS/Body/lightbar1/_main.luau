grp1 = script.Parent.G7:GetChildren()
grp2 = script.Parent.G8:GetChildren()
while true do
wait(0)
if script.Parent.on.Value == true then
	
	for i = 1,#grp1 do
	grp1[i].Lighto.Enabled = true
	end
	
	for i = 1,#grp2 do
	grp2[i].Lighto.Enabled = false
	end
	wait (0.2)
	
	for i = 1,#grp1 do
	grp1[i].Lighto.Enabled = false
	end
	for i = 1,#grp2 do
	grp2[i].Lighto.Enabled = true
	end
	wait (0.2)
	
else
	for i = 1,#grp1 do
	grp1[i].Lighto.Enabled = false
	end
	for i = 1,#grp2 do
	grp2[i].Lighto.Enabled = false
	end
end
end