--local ObjectsThere = game.ReplicatedStorage:WaitForChild("SavedObjects");
--local ObjectTest = game.Workspace.TestObject

--local Objects={
--	Crate = ObjectsThere:WaitForChild("Crate");
--}

local function GetValue(name)
	return script.Parent.Value_Folder:WaitForChild(name).Value
end
local function SetValue(name,value)
	script.Parent.Value_Folder:WaitForChild(name).Value = value
end

local Player = script.Parent.Parent
local Mouse = Player:GetMouse()
local MousePosition = Vector3.zero
local MaxMousePositionDistance = 30
local CanCreateProp = false

local ray = Ray.new(Mouse.Origin.p,Mouse.UnitRay.Direction*50)

local function Round(num)
	return (math.floor((num/4)+(math.random(4,6)/10))*4)
end

local function BlockPosition(pos)
	return  Vector3.new(Round(pos.x),Round(pos.y),Round(pos.z))
end


game:GetService("UserInputService").InputBegan:Connect(function(input,gameProcessedEvent)--Кнопка нажата
	if input.UserInputType == Enum.UserInputType.Keyboard and CanCreateProp then
		
		if input.KeyCode == Enum.KeyCode.T then
			game.ReplicatedStorage:WaitForChild("CreateObject"):FireServer("Crate",MousePosition,false)
			
		end
		if input.KeyCode == Enum.KeyCode.Y then
			game.ReplicatedStorage:WaitForChild("CreateObject"):FireServer("Bricks",BlockPosition(MousePosition),true)

		end
		if input.KeyCode == Enum.KeyCode.U then
			game.ReplicatedStorage:WaitForChild("CreateObject"):FireServer("Car",MousePosition,false)

		end
		if input.KeyCode == Enum.KeyCode.Delete then
			
		--	local hit = game.Workspace:FindPartOnRay(ray,Player)
		--	if hit then
		--	print(tostring(hit.Name))
		--	game.ReplicatedStorage:WaitForChild("DestroyObject"):FireServer(hit)
		--	end

		end
		
		
	end end)

while true do
	wait()
	if game.Workspace:FindPartOnRay(ray,Player) then
		print(game.Workspace:FindPartOnRay(ray,Player))
	end
	MousePosition = Mouse.Hit.Position
	CanCreateProp =  ((MousePosition.Magnitude-Player.Character.HumanoidRootPart.Position.Magnitude)<MaxMousePositionDistance and (MousePosition.Magnitude-Player.Character.HumanoidRootPart.Position.Magnitude) > -MaxMousePositionDistance)
end