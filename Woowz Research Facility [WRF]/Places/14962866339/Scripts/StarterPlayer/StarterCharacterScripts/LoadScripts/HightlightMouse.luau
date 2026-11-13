local plrbase = require(script.Parent:WaitForChild("PlayerBase"))
local mouse = plrbase.Player:GetMouse()
local rs = game:GetService("ReplicatedStorage")

local function UpdateDrag(drag)
	local c2
	c2 = drag.DragStart:Connect(function()
		plrbase.Drag = drag
		c2:Disconnect()
	end)
	rs.UpdateDragDetector:FireServer(drag,true)
end

local function DropDrag()
	if plrbase.Drag then
		rs.UpdateDragDetector:FireServer(plrbase.Drag,false)
		plrbase.Drag = nil
	end
end

game:GetService("UserInputService").InputEnded:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		DropDrag()
	end
end)

local hightlight = Instance.new("Highlight",script)
hightlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
hightlight.Enabled = true
hightlight.FillColor = Color3.new(1,1,1)
hightlight.FillTransparency = 0.75
hightlight.Name = "MouseOverHightlight"
hightlight.OutlineColor = Color3.new(1,1,1)
hightlight.OutlineTransparency = 0.1

local function DestroyHL()
	if hightlight ~= nil and script ~= nil then
		if hightlight.Parent ~= script then
			hightlight.Parent = script
		end
	end
end

plrbase.Humanoid:GetPropertyChangedSignal("Health"):Connect(function()
	if plrbase.Humanoid.Health <= 0 then
		if hightlight then
			hightlight:Destroy()
			script:Destroy()
		end
	end
end)

local function lerp(x,y,z)
	return x * (1-z) + y * z
end

local power = 1
local function CreateHL(objs)
	local glowpoer = math.sin(power)
	local function createglow(obj)
		if obj:FindFirstChild("MouseOverHightlight")==nil then
			hightlight.FillTransparency = lerp(0.75,0.9,glowpoer)
			hightlight.OutlineTransparency = lerp(0.1,0.8,glowpoer)
			hightlight.Parent = obj
		else
			obj:FindFirstChild("MouseOverHightlight").FillTransparency = lerp(0.75,0.9,glowpoer)
			obj:FindFirstChild("MouseOverHightlight").OutlineTransparency = lerp(0.1,0.8,glowpoer)
		end
	end
	
	createglow(objs)
end

game:GetService("UserInputService").InputBegan:Connect(function(key)
	if key.UserInputType == Enum.UserInputType.MouseButton1 then
		local hit = plrbase.Data.Mouse.Target
		if plrbase.Tool ~= nil and hit ~= nil then
			if hit:FindFirstChildOfClass("ClickDetector") then
				if hit:FindFirstChildOfClass("ClickDetector"):FindFirstChild("ClickDetectorScript") and hit:FindFirstChildOfClass("ClickDetector"):FindFirstChild("DontIgnoreItem") then
					if ((plrbase.Parts.Head.Position - plrbase.Data.Mouse.Target.Position).Magnitude) <= hit:FindFirstChildOfClass("ClickDetector").MaxActivationDistance then
						rs.ActivateClickDetector:FireServer(hit:FindFirstChildOfClass("ClickDetector"))
					end
				end
			end
		end
	end
end)

while wait() do
	if plrbase.AttackMode or plrbase.Died or plrbase.Ragdoll then
		DropDrag()
	end
	
	power += 0.2
	plrbase.Data.Mouse.Target = mouse.Target
	local hit = plrbase.Data.Mouse.Target
	
	local thatend = false
	if plrbase.Tool ~= nil then
		if hit then
			if hit:FindFirstChildOfClass("ClickDetector") then
				if hit:FindFirstChildOfClass("ClickDetector"):FindFirstChild("DontIgnoreItem") == nil then
					thatend = true
				end
				if hit.Parent:IsA("Tool") then
					if hit.Parent.ToolScript.CantTake.Value then
						thatend = true
					end
				end
			else
				thatend = true
			end
		end
	end
	
	if thatend then
		DestroyHL() plrbase.Data.Mouse.Drag = false
	else
	
	if plrbase.Died or hit == nil or plrbase.VisibleGUI == false or not plrbase.MovingData.CanMove or plrbase.AttackMode then DestroyHL() plrbase.Data.Mouse.Drag = false else
		if hit:FindFirstChildOfClass("ClickDetector") and hit:FindFirstChild("MouseOver")  then
			if ((plrbase.Parts.Head.Position - plrbase.Data.Mouse.Target.Position).Magnitude) <= hit:FindFirstChildOfClass("ClickDetector").MaxActivationDistance then
				local obj = nil

				if hit:FindFirstChild("MouseOver"):IsA("BoolValue") then
					obj = hit.Parent
				else
					obj = hit:FindFirstChild("MouseOver").Value
				end

				if hit.Parent:IsA("Tool") then
					if plrbase.Ragdoll or (plrbase.PartsDead.RightArm and plrbase.PartsDead.LeftArm) or plrbase.AttackMode or plrbase.Paralysis then
						obj = nil
					else
						if hit.Parent.Parent ~= nil then
							if hit.Parent.Parent:FindFirstChildOfClass("Humanoid")==nil then
								obj = hit.Parent
							else
								obj = nil
							end
						else
							obj = nil
						end
					end
				end
				
				if hit:FindFirstChildOfClass("ClickDetector"):FindFirstChild("Seat") then
					local seat = hit:FindFirstChildOfClass("ClickDetector"):FindFirstChild("Seat").Value
					local x,y,z = seat.CFrame:ToOrientation()
					if x>0.4 or x<-0.4 or z>0.4 or z<-0.4 then
						obj = nil
					end
				end

				if obj==nil then
					DestroyHL()
				else
					CreateHL(obj)
				end
			else
				DestroyHL()
			end
		else
			DestroyHL()
		end
	
		if hit:FindFirstChildOfClass("DragDetector") then
			if ((plrbase.Parts.Head.Position - mouse.Hit.Position).Magnitude) <= hit:FindFirstChildOfClass("DragDetector").MaxActivationDistance and not plrbase.Died and not plrbase.AttackMode and not (plrbase.PartsDead.RightArm and plrbase.PartsDead.LeftArm) then
				plrbase.Data.Mouse.Drag = true
				UpdateDrag(hit:FindFirstChildOfClass("DragDetector"))
			else
				plrbase.Data.Mouse.Drag = false
			end
			hit:FindFirstChildOfClass("DragDetector").Enabled = plrbase.Data.Mouse.Drag
			
		else
			plrbase.Data.Mouse.Drag = false
		end
	end
	
	end
end