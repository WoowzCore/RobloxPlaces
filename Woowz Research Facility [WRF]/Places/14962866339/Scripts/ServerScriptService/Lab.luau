local base = require(script.Parent.Base)
local scripts = game:GetService("ServerStorage").SCRIPTS
local datas = require(game:GetService("ServerStorage").Datas)
local sss = game:GetService("ServerScriptService")
local serverinfo = script.Parent.ServerInfo

local lab = {}

local tweenlampsirens = {}
function lab.ChangeEmergency(bool)
	if sss.ServerInfo.Data.Emergency.Value == bool then return end
	sss.ServerInfo.Data.Emergency.Value = bool
	lab.OpenDoor("WARNING",not bool)
end

function lab.ChangeSirenType(newsiren)
	if script.Parent.ServerInfo.Data.SirenType.Value == newsiren then return end
	script.Parent.ServerInfo.Data.SirenType.Value = newsiren
	local function stopts()
		if #tweenlampsirens ~= 0 then
			for _, ts in pairs(tweenlampsirens) do
				ts:Destroy()
			end
		end
		tweenlampsirens = {}
	end
	if newsiren == "empty" then
		stopts()
		for _, part in pairs(game.Workspace:GetDescendants()) do
			if part.Name == "SirenLamp" then
				part.light1.Material = Enum.Material.Glass
				part.light2.Material = Enum.Material.Glass
				part.light1.Color = Color3.fromRGB(64, 63, 65)
				part.light2.Color = Color3.fromRGB(64, 63, 65)
				base.ts(part.light1.SpotLight,TweenInfo.new(2),{Brightness = 0})
				base.ts(part.light2.SpotLight,TweenInfo.new(2),{Brightness = 0})
				task.delay(2,function()
					if script.Parent.ServerInfo.Data.SirenType.Value == "empty" then
						part.light1.SpotLight.Enabled = false
						part.light2.SpotLight.Enabled = false
					end
				end)
			end
		end
		serverinfo.Data.SirenWork.Value = false
	else
		stopts()
		local sirendata = datas.Sirens[newsiren]
		for _, part in pairs(game.Workspace:GetDescendants()) do
			if part.Name == "SirenLamp" then
				local t = sirendata[2][3]
				local ts = base.ts(part.rotatebase.Weld,TweenInfo.new(t/3,Enum.EasingStyle.Linear),{C1 = CFrame.new() * CFrame.Angles(math.rad(120),0,0)})
				local ts1 = base.ts(part.rotatebase.Weld,TweenInfo.new(t/3,Enum.EasingStyle.Linear),{C1 = CFrame.new() * CFrame.Angles(math.rad(240),0,0)},false)
				local ts2 = base.ts(part.rotatebase.Weld,TweenInfo.new(t/3,Enum.EasingStyle.Linear),{C1 = CFrame.new() * CFrame.Angles(math.rad(360),0,0)},false)
				ts.Completed:Connect(function()
					ts1:Play()
				end)
				ts1.Completed:Connect(function()
					ts2:Play()
				end)
				ts2.Completed:Connect(function()
					ts:Play()
				end)
					
				table.insert(tweenlampsirens,ts)
				table.insert(tweenlampsirens,ts1)
				table.insert(tweenlampsirens,ts2)
				part.light1.Material = Enum.Material.Neon
				part.light2.Material = Enum.Material.Neon
				base.ts(part.light1,TweenInfo.new(2),{Color = sirendata[2][1]})
				base.ts(part.light2,TweenInfo.new(2),{Color = sirendata[2][2]})
				part.light1.SpotLight.Enabled = true
				part.light2.SpotLight.Enabled = true
				base.ts(part.light1.SpotLight,TweenInfo.new(2),{Color = sirendata[2][1]})
				base.ts(part.light2.SpotLight,TweenInfo.new(2),{Color = sirendata[2][2]})
				base.ts(part.light1.SpotLight,TweenInfo.new(2),{Brightness = 3})
				base.ts(part.light2.SpotLight,TweenInfo.new(2),{Brightness = 3})
			end
		end
		serverinfo.Data.SirenWork.Value = true
	end
	base.SendSirensToPlayers()
end

function lab.OpenDoor(id,bool)
	for _, doorid in pairs(game.Workspace:GetDescendants()) do
		if doorid.Name == "DoorID" and doorid.Value == id then
			local door = doorid.Parent
			
			door.Active.Value = bool
		end
	end
end

function lab.SwitchLighting(bool)
	base.LabLightingEnabled = bool
	for _, light in pairs(game.Workspace:GetDescendants()) do
		--[[if light:FindFirstChild("Light") then
			if light:FindFirstChild("Light"):IsA("StringValue") then
				local localbool = bool
				if light:FindFirstChild("LightEnabled") ~= nil then
					if light:FindFirstChild("LightEnabled").Value == false then localbool = false end
				end
				base.ChangeLight(light,localbool)
			end
		end]]
		if light.Name == "LightSwitch" then
			local enabled = light.Enabled.Value
			if enabled ~= bool then
				light.Turn:Fire()
			end
		end
	end
end

function lab.ShakeLab(power) -- power -> 0-100
	lab.SwitchLighting(false)
	local function physiccelingtile(tile)
		local scr = scripts.DropTile:Clone()
		scr.Parent = tile
		scr.Enabled = true
	end
	local physicobjs = {}
	for _, obj in pairs(game.Workspace:GetDescendants()) do
		if obj:IsA("Part") or obj:IsA("UnionOperation") or obj:IsA("MeshPart") then
			table.insert(physicobjs,obj)
			if obj.Name == "CEILING_TILE" then
				if math.random(0,100) <= power and math.random(0,100) > 5 then
					physiccelingtile(obj)
				end
			end
		end
	end
	base.ShakeCamera(Vector3.zero,power,math.huge,power/10,false)
	task.wait(0.05)
	local function impls()
		for _, obj in pairs(physicobjs) do
			base.TryPhysicateObject(obj,power)
			if obj.Anchored == false then
				obj:ApplyImpulse(Vector3.new(math.random(-power*2,power*2),math.random(-power*2,power*2),math.random(-power*2,power*2)))
				obj.AssemblyAngularVelocity = Vector3.new(math.random(-power,power),math.random(-power,power),math.random(-power,power))
			end
		end
	end
	
	local lightrand = (math.random(0,100)>=50)
	
	if lightrand then
		lab.SwitchLighting(true)
	end
	
	impls()
	task.wait(power/10)
	
	if not lightrand then
		lab.SwitchLighting(true)
	end
end

return lab
