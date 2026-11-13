grp5 = script.Parent.G5:GetChildren()
grp6 = script.Parent.G6:GetChildren()

while true do
wait(0)
if script.Parent.on.Value == true then
	for i = 1,#grp5 do
	grp5[i].Lighto.Enabled = true
	end
	
	wait(0.07)
	
	for i = 1,#grp5 do
	grp5[i].Lighto.Enabled = false
	end
	
	wait(0.07)
	
	for i = 1,#grp5 do
	grp5[i].Lighto.Enabled = true
	end
	
	wait(0.07)
	
	for i = 1,#grp5 do
	grp5[i].Lighto.Enabled = false
	end
	
	wait(0.07)
	
	for i = 1,#grp6 do
	grp6[i].Lighto.Enabled = true
	end
	
	wait(0.07)
	
	for i = 1,#grp6 do
	grp6[i].Lighto.Enabled = false
	end
	
	wait(0.07)
	
	for i = 1,#grp6 do
	grp6[i].Lighto.Enabled = true
	end
	
	wait(0.07)
	
	for i = 1,#grp6 do
	grp6[i].Lighto.Enabled = false
	end
	
	wait(0.07)



else
	for i = 1,#grp5 do
	grp5[i].Lighto.Enabled = false
	end
	
	for i = 1,#grp6 do
	grp6[i].Lighto.Enabled = false
	end


end
end