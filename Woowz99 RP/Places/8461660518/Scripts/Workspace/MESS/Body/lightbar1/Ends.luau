grp3 = script.Parent.G3:GetChildren()
grp4 = script.Parent.G4:GetChildren()

while true do
wait(0)
if script.Parent.on.Value == true then
	for i = 1,#grp3 do
	grp3[i].Lighto.Enabled = true
	end
	
	wait(0.05)
	
	for i = 1,#grp3 do
	grp3[i].Lighto.Enabled = false
	end
	
	wait(0.05)
	
	for i = 1,#grp3 do
	grp3[i].Lighto.Enabled = true
	end
	
	wait(0.05)
	
	for i = 1,#grp3 do
	grp3[i].Lighto.Enabled = false
	end
	
	wait(0.05)
	
	for i = 1,#grp4 do
	grp4[i].Lighto.Enabled = true
	end
	
	wait(0.05)
	
	for i = 1,#grp4 do
	grp4[i].Lighto.Enabled = false
	end
	
	wait(0.05)
	
	for i = 1,#grp4 do
	grp4[i].Lighto.Enabled = true
	end
	
	wait(0.05)
	
	for i = 1,#grp4 do
	grp4[i].Lighto.Enabled = false
	end
	
	wait(0.05)



else
	for i = 1,#grp3 do
	grp3[i].Lighto.Enabled = false
	end
	
	for i = 1,#grp4 do
	grp4[i].Lighto.Enabled = false
	end


end
end