local image = script.Parent

local icons = {
	["admin"] = "rbxassetid://15148824516",
	["mainadmin"] = "rbxassetid://15148823152",
	["dev"] = "rbxassetid://15148822170"
}

local player = game:GetService("Players").LocalPlayer
local chr = player.Character or player.CharacterAdded:Wait()
local data = require(chr:WaitForChild("PlayerBase"))

while wait() do

	admin_result = "nope"
	if data["Admin"] then
		admin_result = "admin"
	end
	if data["MainAdmin"]  then
		admin_result = "mainadmin"
	end
	if data["Dev"] then
		admin_result = "dev"
	end

	if admin_result ~= "nope" then
		image.Image = icons[admin_result]
		image.Visible = true
	else
		image.Visible = false
	end
end