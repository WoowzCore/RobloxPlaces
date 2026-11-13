local player = game.Players.LocalPlayer
local mouse = player:GetMouse()
local tool = script.Parent
local config = tool:WaitForChild("Configurations")

local canThrow = true

tool.Equipped:connect(function()
	mouse.Icon = "rbxasset://textures/GunCursor.png"
end)

tool.Unequipped:connect(function()
	mouse.Icon = ""
end)

tool.Activated:connect(function()
	if canThrow then
		canThrow = false
		local throwAnimation = player.Character.Humanoid:LoadAnimation(tool.ThrowAnimation)
		throwAnimation:Play() -- Load and play the throwing animation
		throwAnimation.KeyframeReached:connect(function(keyframe) -- Wait 'til we reach a keyframe
			if keyframe == "tick" then -- if the keyframe is 'tick' then play the pin sound
				tool.Handle.Pin:Play()
			elseif keyframe == "throw" then -- otherwise, if it's 'throw,' tell the serverscript to throw our grenade
				tool.Throw:FireServer(mouse.Hit.p)
				throwAnimation:Stop()
				mouse.Icon = "rbxasset://textures/GunWaitCursor.png"
			end
		end)
		wait(config.Cooldown.Value)
		mouse.Icon = "rbxasset://textures/GunCursor.png"
		canThrow = true
	end
end)