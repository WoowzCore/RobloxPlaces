local Tool = script.Parent
local gui = Tool.RadarGui
local guiEnabled = true
local guiOnPlayer = nil
local range = 300
local torso = script.Parent.Parent
local zIndex = 4
local radarCenter = Vector2.new(140,155)

enabled = true


-- when activated, either bring gui up or down, depending on current state


function removeGUIPlayers()

	local guiPlayers = gui.Frame.Players:GetChildren()
	for i = 1, #guiPlayers do
		guiPlayers[i]:remove()
	end

end

function incrementZIndex()

	zIndex = zIndex + 1
	if zIndex > 10000 then
		zIndex = 2
	end

end

function createPlayerGUINode(pos, playerText)

	local playerIcon = Instance.new("ImageLabel")
	playerIcon.Image = "http://www.roblox.com/asset/?id=0"
	playerIcon.BackgroundTransparency = 1
	playerIcon.BorderSizePixel = 0
	playerIcon.Size = UDim2.new(0,22.5,0,40.5)
	playerIcon.Position = UDim2.new(0,pos.x,0,pos.y)
	playerIcon.Parent = gui.Frame.Players
	playerIcon.ZIndex = zIndex
	incrementZIndex()
	
	local playerName = Instance.new("TextLabel")
	playerName.BackgroundTransparency = 1
	playerName.BorderSizePixel = 1

	playerName.Text = tostring(playerText)
	playerName.Size = UDim2.new(0,150,0,25)
	playerName.Parent = playerIcon
	playerName.Position = UDim2.new(0,-65,0,0)
	playerName.TextColor3 =  Color3.new(0,0,0)
	playerName.ZIndex = zIndex
	incrementZIndex()
end


function updateGUI()

	removeGUIPlayers()
	

	local players = game.Players:GetChildren()

	for i = 1, #players do

		local playerTorso = players[i].Character:FindFirstChild("Torso")

		if playerTorso ~= nil then

			local posDiff = Vector3.new(torso.Position.x - playerTorso.Position.x,0,torso.Position.z - playerTorso.Position.z)

			if posDiff.magnitude < range and playerTorso.Parent.Name ~= torso.Parent.Name then

				-- translate coordinates to radar coordinates
				posDiff = Vector2.new((posDiff.x + range) * 0.5,(posDiff.z + range) * 0.5)

				local rotationVector = Tool.Angle.Value
				local denom = math.abs(rotationVector.x) + math.abs(rotationVector.z)

				local xDirect = (rotationVector.x/denom)
				local zDirect =  (rotationVector.z/denom)
				
				local angle = math.atan2(1,0) - math.atan2(zDirect,xDirect)

				local point = Vector2.new(((posDiff.x - radarCenter.x) * math.cos(angle)) - ((posDiff.y - radarCenter.y) * math.sin(angle))  + radarCenter.x,
				((posDiff.x - radarCenter.x) * math.sin(angle)) + ((posDiff.y - radarCenter.y) * math.cos(angle)) + radarCenter.y)

				createPlayerGUINode(point, playerTorso.Parent)

			elseif playerTorso.Parent.Name == torso.Parent.Name then

				createPlayerGUINode(radarCenter,playerTorso.Parent)

			end
		end

	end

end


while true do
	
	if guiEnabled then
		updateGUI()
	end
	wait()

end



