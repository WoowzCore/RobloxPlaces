local base = require(script.Parent.Base)
local config = script.Parent.Parent:FindFirstChild("Configuration")
if config then
	base.Config = config
	
	local function s(name,def)
		local setting = config:FindFirstChild(name)
		if setting then
			return setting.Value
		else
			return def
		end
	end
	
end