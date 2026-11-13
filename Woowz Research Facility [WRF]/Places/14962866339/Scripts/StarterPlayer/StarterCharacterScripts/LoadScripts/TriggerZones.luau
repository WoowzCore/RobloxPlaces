local base = require(script.Parent:WaitForChild("PlayerBase"))
wait(3)
local connections = {}

local function getid(obj)
	local result = obj:GetFullName()
	result = result..tostring(obj.Parent.Parent.Parent.Parent.Parent.CFrame)
	return result
end

local function Active(obj,bool)
	if obj == nil then return end
	if obj:IsA("Light") or obj:IsA("ParticleEmitter") or obj:IsA("Beam") then
		obj.Enabled = bool
	elseif obj:IsA("VideoFrame") then
		if connections[getid(obj)] == nil then
			local c = obj.Parent.Parent.Parent.Parent.Parent.Parent.Playing:GetPropertyChangedSignal("Value"):Connect(function()
				local enabled = obj.Parent.Parent.Parent.Parent.Parent.Parent.Playing.Value
				if enabled then
					obj:Play()
				else
					obj:Pause()
				end
			end)
			connections[getid(obj)] = c
		end
		if bool then
			local enabled = obj.Parent.Parent.Parent.Parent.Parent.Parent.Playing.Value
			if enabled then
				obj:Play()
			else
				obj:Pause()
			end
		else
			obj:Pause()
		end
	else
		if bool then
			obj.Transparency = 0
		else
			obj.Transparency = 1
		end
	end
end

for i, obj in pairs(base.Triggers.EnabledObjects) do
	Active(obj[1],not obj[2])
	base.Triggers.EnabledObjects[i] = nil
end

for _, trigger in pairs(game.Workspace:GetDescendants()) do
	if trigger.Name == "TRIGGER_EnableObj" then
		local objs = {}
		for _1, part in pairs(trigger:GetChildren()) do
			if part.Name == "EnableThis" then
				table.insert(objs,{part.Value,true})
			end
			if part.Name == "DisableThis" then
				table.insert(objs,{part.Value,false})
			end
		end
		
		for _1, obj in pairs(objs) do
			Active(obj[1],not obj[2])
		end
		trigger.Touched:Connect(function(p)
			if base.Parts.Root then
				if p == base.Parts.Root then
					for _1, obj in pairs(objs) do
						Active(obj[1],obj[2])
						table.insert(base.Triggers.EnabledObjects,{obj[1],obj[2]})
					end
				end
			end
		end)
		
		trigger.TouchEnded:Connect(function(p)
			if base.Parts.Root then
				if p == base.Parts.Root then
					for _1, obj in pairs(objs) do
						Active(obj[1],not obj[2])
						for i, obj_ in pairs(base.Triggers.EnabledObjects) do
							if obj_[1] == obj[1] then
								base.Triggers.EnabledObjects[i] = nil
							end
						end
					end
				end
			end
		end)
	end
end