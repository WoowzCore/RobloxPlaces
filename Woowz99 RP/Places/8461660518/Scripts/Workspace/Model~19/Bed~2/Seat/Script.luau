while true do

local animation = Instance.new("Animation")
animation.AnimationId = "http://www.roblox.com/Asset?ID=485761039"
local animTrack = nil
local canPlay = true

script.Parent.ChildAdded:connect(function(child)
	if child.Name=="SeatWeld" and child:IsA("Weld") and game.Players:GetPlayerFromCharacter(child.Part1.Parent)~=nil then
		local p=game.Players:GetPlayerFromCharacter(child.Part1.Parent)
			if canPlay then
				local player = game.Players.LocalPlayer.Character
				canPlay = false
				animTrack = player.Humanoid:LoadAnimation(animation) -- Load animation into Humanoid
				animTrack.KeyframeReached:connect(function(keyframeName) -- Bind function to KeyframeReached event
					if keyframeName == "ElectrocuteEnd" then
						canPlay = true
					end
				end)	
				animTrack:Play() -- Start the animation
			end
		
	end
end)
script.Parent.ChildRemoved:connect(function(child)
	animTrack:Stop()
end)
wait()
end