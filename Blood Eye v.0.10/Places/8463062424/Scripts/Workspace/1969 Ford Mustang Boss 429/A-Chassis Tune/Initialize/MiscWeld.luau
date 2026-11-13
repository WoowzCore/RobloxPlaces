local MiscWeld = {}

function MakeWeld(x,y,type,s) 
	if type==nil then type="Weld" end
	local W=Instance.new(type)
	W.Part0=x W.Part1=y 
	W.C0=x.CFrame:inverse()*x.CFrame 
	W.C1=y.CFrame:inverse()*x.CFrame 
	W.Parent=x 
	if type=="Motor" and s~=nil then 
		W.MaxVelocity=s 
	end 
	return W	
end
function ModelWeld(a,b) 
	if a:IsA("BasePart") then 
		MakeWeld(b,a,"Weld") 
	elseif a:IsA("Model") then 
		for i,v in pairs(a:GetChildren()) do 
			ModelWeld(v,b) 
		end 
	end 
end

car = script.Parent.Parent.Parent
misc = car:WaitForChild("Misc")

---------------------------
--[[
	--Main anchor point is the DriveSeat <car.DriveSeat>	
	
	Usage:
		MakeWeld(Part1,Part2,WeldType*,MotorVelocity**) *default is "Weld"  **Applies to Motor welds only
		ModelWeld(Model,MainPart)
	Example:
		MakeWeld(car.DriveSeat,misc.PassengerSeat)
		MakeWeld(car.DriveSeat,misc.SteeringWheel,"Motor",.2)
		ModelWeld(car.DriveSeat,misc.Door)
]]
--Weld stuff here
MakeWeld(car.DriveSeat,misc:WaitForChild('Downforce'))

misc:WaitForChild("Spoiler")
MakeWeld(car.DriveSeat,misc.Spoiler:WaitForChild("A1")).Name="W"
MakeWeld(misc.Spoiler.A1,misc.Spoiler:WaitForChild("A2"),"Motor",.01).Name="W"
MakeWeld(misc.Spoiler.A2,misc.Spoiler:WaitForChild("A3"),"Motor",.02).Name="W"
MakeWeld(misc.Spoiler.A3,misc.Spoiler:WaitForChild("A"),"Motor",.01).Name="W"
MakeWeld(misc.Spoiler.A3,misc.Spoiler:WaitForChild("A4"),"Motor",.01).Name="P"
MakeWeld(misc.Spoiler.A4,misc.Spoiler:WaitForChild("Sp"),"Motor",.01).Name="W"
MakeWeld(misc.Spoiler.Sp,misc.Spoiler:WaitForChild("B1"))
MakeWeld(misc.Spoiler.B1,misc.Spoiler:WaitForChild("B"),"Motor",.01).Name="W"

car.DriveSeat.ChildAdded:connect(function(child)
	if child.Name=="SeatWeld" and child:IsA("Weld") and game.Players:GetPlayerFromCharacter(child.Part1.Parent)~=nil then
		child.C0=CFrame.new(0,-.5,0)*CFrame.fromEulerAnglesXYZ(-(math.pi/2),0,0)*CFrame.Angles(math.rad(13),0,0)
	end
end)

---------------------------
return MiscWeld