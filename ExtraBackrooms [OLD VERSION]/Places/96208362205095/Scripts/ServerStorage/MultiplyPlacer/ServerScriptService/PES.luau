--Если вы это читаете, то вы чертила!!!

local plrs = game:GetService("Players"):GetPlayers()

local TS = {
	["SG"] = 0,
	["PG"] = 0,
	["PS"] = 0,
	["CH"] = 0
}

local TSloaded = false

local function FisrtPlayerTS(plr)
	if TS["SG"] == 0 or TS["PG"] == 0 or TS["PS"] == 0 or TS["CH"] == 0 then
		local char = plr.Character or plr.CharacterAdded:Wait()
		if not TSloaded then 
			TS["SG"] = #plr.StarterGear:GetChildren()
			TS["PG"] = #plr.PlayerGui:GetChildren()
			TS["PS"] = game:GetService("ReplicatedStorage").GetGraphic:InvokeClient(plr)
			for _,part in pairs(char:GetDescendants()) do
				if part:IsA("LocalScript") then
					TS["CH"] += 1
				end
			end
			TSloaded = true
		end
	end
end

local function CheckCHEATS(plr)
	local cheater = false
	local char = plr.Character or plr.CharacterAdded:Wait()
	
	if TS["SG"] ~= #plr.StarterGear:GetChildren() then
		cheater = true
	end
	if TS["PG"] ~= #plr.PlayerGui:GetChildren() then
		cheater = true
	end
	if TS["PS"] ~= game:GetService("ReplicatedStorage").GetGraphic:InvokeClient(plr) then
		cheater = true
	end
	
	local ch = 0
	for _,part in pairs(char:GetDescendants()) do
		if part:IsA("LocalScript") then
			ch += 1
		end
	end
	
	if TS["CH"] ~= ch then
		cheater = true
	end
	
	if cheater then
		print("Player ["..plr.Name.."] Kicked Off the Server Because of Exploits")
		--plr:Kick("Lol")
	end
end

local function ACC()
	for _, plr in pairs(plrs) do
		CheckCHEATS(plr)
	end
end

game:GetService("Players").PlayerAdded:Connect(FisrtPlayerTS)

while wait(5) do
	if TSloaded then
		ACC()
	end
end