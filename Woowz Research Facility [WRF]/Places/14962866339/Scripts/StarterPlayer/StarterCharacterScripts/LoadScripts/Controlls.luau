local plrbase = require(script.Parent:WaitForChild("PlayerBase"))
local uis = game:GetService("UserInputService")

local player = game:GetService("Players").LocalPlayer
local char = player.Character or player.CharacterAdded:Wait()
local mod = require(player.PlayerScripts:WaitForChild("PlayerModule"))
local controls = mod:GetControls()

controls:Disable()

local w,s,a,d = false,false,false,false

while wait() do
	uis.MouseDeltaSensitivity = plrbase.Sensitivity
	w = plrbase.KeyboradIGNORECHAT[tostring(plrbase.Settings.Keys.MoveFront)] or false
	s = plrbase.KeyboradIGNORECHAT[tostring(plrbase.Settings.Keys.MoveBack)] or false
	d = plrbase.KeyboradIGNORECHAT[tostring(plrbase.Settings.Keys.MoveRight)] or false
	a = plrbase.KeyboradIGNORECHAT[tostring(plrbase.Settings.Keys.MoveLeft)] or false
	if plrbase.Typing or plrbase.Data.Camera.FreeCamera then
		player:Move(Vector3.zero, true)
	else
		plrbase.Humanoid.Jump = plrbase.KeyboradIGNORECHAT[tostring(plrbase.Settings.Keys.Jump)]
		if (w or s or d or a) and not plrbase.SettingsChangeKeyCodethen then
			local move = Vector3.zero
			local drunk = plrbase.Drunk/100
			local sin = math.sin(plrbase.Drunk*10)*drunk
			local cos = math.cos(plrbase.Drunk*10)*drunk
			if w then
				move -= Vector3.new(cos,sin,1)
			end
			if s then
				move += Vector3.new(sin,cos,1)
			end
			if d then
				move += Vector3.new(1,sin,cos)
			end
			if a then
				move -= Vector3.new(1,cos,sin)
			end
			player:Move(move, true)
		else
			player:Move(Vector3.zero, true)
		end
	end
end