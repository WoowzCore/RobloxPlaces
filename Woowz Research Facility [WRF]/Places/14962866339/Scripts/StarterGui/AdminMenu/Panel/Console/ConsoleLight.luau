local text = script.Parent

local bool = false
while wait() do
	if text.Parent.Parent.Enabled then
		bool = not bool
		if bool then
			text.TextTransparency = 0
		else
			text.TextTransparency = 0.2
		end
	end
end