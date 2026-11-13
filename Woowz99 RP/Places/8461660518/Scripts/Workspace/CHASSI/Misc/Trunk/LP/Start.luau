--made by Bertox
--lul

 script.Parent.Parent.Parent.Parent.Electrics.Changed:connect(function()
	if script.Parent.Parent.Parent.Parent.Electrics.Value == true then
		script.Parent.Material = Enum.Material.Neon
	else
		script.Parent.Material = Enum.Material.SmoothPlastic
	end
end)