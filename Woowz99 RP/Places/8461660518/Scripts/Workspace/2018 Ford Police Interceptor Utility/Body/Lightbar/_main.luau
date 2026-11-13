grp1 = script.Parent.G1:GetChildren()
grp2 = script.Parent.G2:GetChildren()
grp3 = script.Parent.G3:GetChildren()
grp4 = script.Parent.G4:GetChildren()
while true do
wait(0)
if script.Parent.on.Value == true then
	for i = 1,#grp1 do
	grp1[i].Transparency = 0
	grp1[i].Light.Enabled = true
	end
	for i = 1,#grp2 do
	grp2[i].Transparency = 1
	grp2[i].Light.Enabled = false
	end
	for i = 1,#grp3 do
	grp3[i].Lighto.Enabled = true
	end
	for i = 1,#grp4 do
	grp4[i].Lighto.Enabled = false
	end
	wait(0.05)
	for i = 1,#grp1 do
	grp1[i].Transparency = 1
	grp1[i].Light.Enabled = false
	end
	for i = 1,#grp2 do
	grp2[i].Transparency = 1
	grp2[i].Light.Enabled = false
	end
	for i = 1,#grp3 do
	grp3[i].Lighto.Enabled = false
	end
	for i = 1,#grp4 do
	grp4[i].Lighto.Enabled = false
	end
	wait(0.05)
	for i = 1,#grp1 do
	grp1[i].Transparency = 0
	grp1[i].Light.Enabled = true
	end
	for i = 1,#grp2 do
	grp2[i].Transparency = 1
	grp2[i].Light.Enabled = false
	end
	for i = 1,#grp3 do
	grp3[i].Lighto.Enabled = true
	end
	for i = 1,#grp4 do
	grp4[i].Lighto.Enabled = false
	end
	wait(0.05)
	for i = 1,#grp1 do
	grp1[i].Transparency = 1
	grp1[i].Light.Enabled = false
	end
	for i = 1,#grp2 do
	grp2[i].Transparency = 1
	grp2[i].Light.Enabled = false
	end
	for i = 1,#grp3 do
	grp3[i].Lighto.Enabled = false
	end
	for i = 1,#grp4 do
	grp4[i].Lighto.Enabled = false
	end
	wait(0.05)
	
	for i = 1,#grp1 do
	grp1[i].Transparency = 1
	grp1[i].Light.Enabled = false
	end
	for i = 1,#grp2 do
	grp2[i].Transparency = 0
	grp2[i].Light.Enabled = false
	end
	for i = 1,#grp3 do
	grp3[i].Lighto.Enabled = false
	end
	for i = 1,#grp4 do
	grp4[i].Lighto.Enabled = true
	end
	wait(0.05)
	for i = 1,#grp1 do
	grp1[i].Transparency = 1
	grp1[i].Light.Enabled = false
	end
	for i = 1,#grp2 do
	grp2[i].Transparency = 1
	grp2[i].Light.Enabled = false
	end
	for i = 1,#grp3 do
	grp3[i].Lighto.Enabled = false
	end
	for i = 1,#grp4 do
	grp4[i].Lighto.Enabled = false
	end
	wait(0.05)
	for i = 1,#grp1 do
	grp1[i].Transparency = 1
	grp1[i].Light.Enabled = false
	end
	for i = 1,#grp2 do
	grp2[i].Transparency = 0
	grp2[i].Light.Enabled = true
	end
	for i = 1,#grp3 do
	grp3[i].Lighto.Enabled = false
	end
	for i = 1,#grp4 do
	grp4[i].Lighto.Enabled = true
	end
	wait(0.05)
	for i = 1,#grp1 do
	grp1[i].Transparency = 1
	grp1[i].Light.Enabled = false
	end
	for i = 1,#grp2 do
	grp2[i].Transparency = 1
	grp2[i].Light.Enabled = false
	end
	for i = 1,#grp3 do
	grp3[i].Lighto.Enabled = false
	end
	for i = 1,#grp4 do
	grp4[i].Lighto.Enabled = false
	end
	wait(0.05)
else
	for i = 1,#grp1 do
	grp1[i].Transparency = 1
	grp1[i].Light.Enabled = false
	end
	for i = 1,#grp2 do
	grp2[i].Transparency = 1
	grp2[i].Light.Enabled = false
	end
		for i = 1,#grp3 do
	grp3[i].Lighto.Enabled = false
	end
	for i = 1,#grp4 do
	grp4[i].Lighto.Enabled = false
	end
end
end