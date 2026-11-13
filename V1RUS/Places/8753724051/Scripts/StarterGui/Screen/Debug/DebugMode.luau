--[[========================================================]]
local function GetValue(name)
	local value = game.Scene.Main.GlobalValues:WaitForChild(name)
	return value.Value
end
local function SetValue(name,val)
	local value = game.Scene.Main.GlobalValues:WaitForChild(name)
	value.Value = val
end
local function GetPlayerValue(name)
	local value = game:GetService("Players").LocalPlayer:WaitForChild("PlayerValues"):WaitForChild(name)
	return value.Value
end
local function SetPlayerValue(name,val)
	game.RStorage.SetPlayerValue:FireServer(name,val)
	wait()
end
--[[========================================================]]

local Debug = script.Parent

local DebugUI = Debug.Background

local function GetAllObjects(obj)
	local tablet = {}

	for i,part in pairs(obj:GetChildren()) do
		table.insert(tablet,part)
		for i,part2 in pairs(part:GetChildren()) do
			table.insert(tablet,part2)
			for i,part3 in pairs(part2:GetChildren()) do
				table.insert(tablet,part3)
				for i,part4 in pairs(part3:GetChildren()) do
					table.insert(tablet,part4)
					for i,part5 in pairs(part4:GetChildren()) do
						table.insert(tablet,part5)
						for i,part6 in pairs(part5:GetChildren()) do
							table.insert(tablet,part6)
							for i,part7 in pairs(part6:GetChildren()) do
								table.insert(tablet,part7)
								for i,part8 in pairs(part7:GetChildren()) do
									table.insert(tablet,part8)
									for i,part9 in pairs(part8:GetChildren()) do
										table.insert(tablet,part9)
										for i,part10 in pairs(part9:GetChildren()) do
											table.insert(tablet,part10)
											for i,part11 in pairs(part10:GetChildren()) do
												table.insert(tablet,part11)
												for i,part12 in pairs(part11:GetChildren()) do
													table.insert(tablet,part12)

												end
											end
										end
									end
								end
							end
						end
					end
				end
			end
		end
	end

	return tablet
end

local function GetAllFullObjects()
	local Here_Inventorys = game.Scene.Main.Inventorys
	local Here_Saved = game.Scene.Map.Saved.Pickable
	local Here_Saved2 = Here_Saved.Parent.World
	local Here_Map = game.Scene.Map
	
	local Table = {}
	
	for _,obj in ipairs(Here_Inventorys:GetChildren()) do
		table.insert(Table,obj)
	end
	for _,obj in ipairs(Here_Saved:GetChildren()) do
		table.insert(Table,obj)
	end
	for _,obj in ipairs(Here_Map:GetChildren()) do
		table.insert(Table,obj)
	end
	
	for _,obj in ipairs(Here_Saved2:GetChildren()) do
		table.insert(Table,obj)
	end
	
	local Yshas = {}
	
	for _,obj in ipairs(Table) do
		if obj.Name == "Object" then
			for _,objs in ipairs(GetAllObjects(obj)) do
				table.insert(Yshas,objs)
			end
		end
	end
	
	return Yshas
end

local function SetVievDebugObjects(bool)
	for _,obj in ipairs(GetAllFullObjects()) do
		local debugObj = obj:FindFirstChild("DEBUG")
		if debugObj then
			if debugObj.Value == true then
				
				
				if obj.Name == "HandLookPosition" then
					local number = 1
					if bool == true then
						number = 0
					end
					obj.Transparency = number
					obj.Ray.Enabled = bool
				end
				if obj.Name == "PickPosition" or obj.Name == "PickPositionLeft" then
					local number = 1
					if bool == true then
						number = 0.5
					end
					obj.Transparency = number
				end
				
			end
		end
	end
end

local function UpdateDebug()
	SetVievDebugObjects(GetPlayerValue("ShowDebug"))
end

local function SetDebug(bool)
	SetPlayerValue("ShowDebug",bool)
	SetVievDebugObjects(bool)
end
wait()
SetDebug(false)
game.RStorage.SetDebug.OnClientEvent:Connect(SetDebug)
game.RStorage.UpdateDebug.OnClientEvent:Connect(UpdateDebug)

while wait() do
	DebugUI.Visible = GetPlayerValue("ShowDebug")
end