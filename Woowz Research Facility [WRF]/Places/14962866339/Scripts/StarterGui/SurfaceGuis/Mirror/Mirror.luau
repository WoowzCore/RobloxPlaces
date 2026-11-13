local vpf = script.Parent.ViewportFrame

local mirror = script.Parent.Adornee

local plr = game:GetService("Players").LocalPlayer
local chr = plr.Character or plr.CharacterAdded:Wait()

local base = require(chr:WaitForChild("PlayerBase"))
local plrsettings = base.Settings
local workmirrors = plrsettings.Optimization.WorkedMirrors

local guif = require(chr:WaitForChild("GuiFunctions"))

local working = false

wait(1)

local function upd()
	local result = false
	for _, c in pairs(mirror.Parent.Trigger:GetTouchingParts()) do
		if c.Parent:FindFirstChildOfClass("Humanoid") and c.Parent.Name ~= "Dummy" then
			result = true
		end
	end
	if result == false then
		working = false
	end
end

mirror.Parent.Trigger.Touched:Connect(function(part) 
	if part.Parent:FindFirstChildOfClass("Humanoid") and part.Parent.Name ~= "Dummy" then
		working = true
	end
end)


local cam = Instance.new("Camera",vpf)
vpf.CurrentCamera = cam

local x,y,z = mirror.CFrame:ToOrientation()
local campos = CFrame.new(mirror.Position * Vector3.new(1,1,1)) * CFrame.Angles(x,y,z)

cam.CFrame = campos + (campos.LookVector/4)


local function updscreen()
	if mirror == nil then script.Parent:Destroy() return end
	if mirror.Parent == nil then script.Parent:Destroy() return end
	if mirror.Parent.Trigger == nil then script.Parent:Destroy() return end
	guif.SetViewportFrame(vpf,mirror.Parent.Trigger:GetTouchingParts(),mirror,true)
end
updscreen()

local i = 0
local j = 0
while wait() do
	workmirrors = plrsettings.Optimization.WorkedMirrors
	
	if not workmirrors then
		vpf:ClearAllChildren()
		vpf.ImageColor3 = Color3.fromRGB(156, 193, 165)
	else
		vpf.ImageColor3 = Color3.fromRGB(255,255,255)
		if working then
			i += 1
			if i >= 10 then
				upd()
				i = 0
			end
			j += 1
			if j > plrsettings.Optimization.MirrorsUpdate then
				updscreen()
				j = 0
			end
		end
	end
end