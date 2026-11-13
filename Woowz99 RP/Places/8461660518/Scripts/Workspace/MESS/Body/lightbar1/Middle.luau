grp1 = script.Parent.G1:GetChildren()
grp2 = script.Parent.G2:GetChildren()

while true do
wait(0)
if script.Parent.on.Value == true then
	for i = 1,#grp1 do
	grp1[i].Lighto.Enabled = true
	end
	
	wait(0.1)
	
	for i = 1,#grp1 do
	grp1[i].Lighto.Enabled = false
	end
	
	wait(0.1)
	
	for i = 1,#grp1 do
	grp1[i].Lighto.Enabled = true
	end
	
	wait(0.1)
	
	for i = 1,#grp1 do
	grp1[i].Lighto.Enabled = false
	end
	
	wait(0.1)
	
	for i = 1,#grp2 do
	grp2[i].Lighto.Enabled = true
	end
	
	wait(0.1)
	
	for i = 1,#grp2 do
	grp2[i].Lighto.Enabled = false
	end
	
	wait(0.1)
	
	for i = 1,#grp2 do
	grp2[i].Lighto.Enabled = true
	end
	
	wait(0.1)
	
	for i = 1,#grp2 do
	grp2[i].Lighto.Enabled = false
	end
	
	wait(0.1)



else
	for i = 1,#grp1 do
	grp1[i].Lighto.Enabled = false
	end
	
	for i = 1,#grp2 do
	grp2[i].Lighto.Enabled = false
	end


end
end