--Rappel script
--By: lordrex12345
--August 3, 2017

local RappelPart = script.Parent
local ExperationTime = 15
local Now = 0
local Later = 0
local WinchBusy = false

RappelPart.ClickDetector.MouseClick:connect(function(PlayerWhoClicked)--Attach a rope constraint from the player to the RappelPart
	Now = tick()
	
	if PlayerWhoClicked and not WinchBusy then
		
		WinchBusy = true
		
		local Attachment0 = Instance.new('Attachment')
		Attachment0.Parent = RappelPart
		game:GetService("Debris"):AddItem(Attachment0,20)
		
		local Attachment1 = Instance.new('Attachment')
		Attachment1.Parent = PlayerWhoClicked.Character.Torso
		game:GetService("Debris"):AddItem(Attachment1,20)

		local RopeConstraint = Instance.new('RopeConstraint')
		RopeConstraint.Parent = script.Parent
		RopeConstraint.Length = 8
		RopeConstraint.Attachment0 = RappelPart.Attachment
		RopeConstraint.Attachment1 = PlayerWhoClicked.Character.Torso.Attachment
		RopeConstraint.Visible = true
		game:GetService("Debris"):AddItem(RopeConstraint,20)
		
		PlayerWhoClicked.Character.Humanoid.Jump = true
		wait(.2)
		
		while not PlayerWhoClicked.Character.Humanoid.Jump do--Gradually lengthen rope till the player jumps
			if Later - Now < ExperationTime then --Check to see if experation time will last
				RopeConstraint.Length = RopeConstraint.Length +.3
				Later = tick()
				wait()
			else
				break
			end
		end
			Attachment0:Destroy()
			Attachment1:Destroy()
			RopeConstraint:Destroy()
			WinchBusy = false
	end
end)