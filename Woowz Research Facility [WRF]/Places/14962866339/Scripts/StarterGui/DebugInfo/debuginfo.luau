local panel = script.Parent

local enabled = panel.Enabled

local function upd(bool)
	for _, scripts in pairs(panel:GetDescendants()) do
		if scripts:IsA("LocalScript") and scripts ~= script then
			scripts.Enabled = bool
		end
	end
end

script.Parent:GetPropertyChangedSignal("Enabled"):Connect(function()
	upd(script.Parent.Enabled)
end)