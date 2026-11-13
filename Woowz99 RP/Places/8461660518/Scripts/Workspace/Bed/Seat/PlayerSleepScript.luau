local seat = script.Parent
local sleepingR15 = seat.SleepingR15
local sleepingR6 = seat.SleepingR6
local sleepAnim


seat.Changed:Connect(function(property)
	
	if property ~= "Occupant" then return end 
	
	local occupant = seat.Occupant
	
	if occupant then 
		local character = occupant.Parent
		local humanoid = character.Humanoid
		local player = game.Players:GetPlayerFromCharacter(character)
		if player and humanoid.RigType == Enum.HumanoidRigType.R15 then -- R15
			sleepAnim = humanoid:LoadAnimation(sleepingR15)
			sleepAnim:Play()
		elseif player then -- R6
			sleepAnim = humanoid:LoadAnimation(sleepingR6)
			sleepAnim:Play()
		end
	elseif sleepAnim then 
		sleepAnim:Stop() 
	end
end)