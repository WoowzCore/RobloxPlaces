--BasedWeld2.0
function MakeWeld(x,y,type,s) 
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
function UnAnchor(a) 
	if a:IsA("BasePart") then a.Anchored=false elseif a:IsA("Model") then for i,v in pairs(a:GetChildren()) do UnAnchor(v) end end 
end
--
local car=script.Parent
for i,a in pairs(car.Wheels:GetChildren()) do
	for i,v in pairs(a:GetChildren()) do
		if v:FindFirstChild("Wheel")~=nil then
			local base=Instance.new("Part",v)
			base.Name="Base"
			base.Anchored=true
			base.CanCollide=false
			base.FormFactor=Enum.FormFactor.Custom
			base.Size=Vector3.new(.2,.2,.2)
			base.CFrame=v.Wheel.CFrame*CFrame.Angles(-math.pi/2,math.pi/2,0)
			base.TopSurface=Enum.SurfaceType.Smooth
			base.BottomSurface=Enum.SurfaceType.Smooth
			base.RotVelocity=Vector3.new(0,0,0)
			base.Velocity=Vector3.new(0,0,0)
			base.Transparency=1
			local axle=base:Clone()
			axle.Parent=v
			axle.Name="Axle"
			axle.Size=Vector3.new(.5,.5,.5)*v.Wheel.Size.x
			axle.CFrame=v.Wheel.CFrame*CFrame.Angles(math.pi/2,0,0)
			local axle2=axle:Clone()
			axle2.Parent=v
			axle2.Name="Axle2"
			axle2.Size=Vector3.new(.2,.2,.2)
			axle2.CFrame=v.Wheel.CFrame*CFrame.new(0,3,0)*CFrame.Angles(math.pi/2,0,0)
			MakeWeld(car.DriveSeat,base,"Weld")
			MakeWeld(base,axle,"Weld")
			MakeWeld(axle,axle2,"Weld")
			MakeWeld(axle,v.Wheel,"RotateV")
			MakeWeld(axle2,v.Wheel,"RotateV")
			if v:FindFirstChild("Fixed")~=nil then
				ModelWeld(v.Fixed,axle)
			end
			if v:FindFirstChild("Parts")~=nil then
				ModelWeld(v.Parts,v.Wheel)
			end
		end
	end
end
ModelWeld(car.Body,car.DriveSeat)

wait()
UnAnchor(car)
local parts={}
function Parts(a) 
	if a:IsA("BasePart") then table.insert(parts,a) elseif a:IsA("Model") then for i,v in pairs(a:GetChildren()) do Parts(v) end end 
end
script.G.Car.Value=script.Parent
car.DriveSeat.ChildAdded:connect(function(child)
	if child:IsA("Weld") and game.Players:GetPlayerFromCharacter(child.Part1.Parent)~=nil then
		local p=game.Players:GetPlayerFromCharacter(child.Part1.Parent)
		for i,v in pairs(parts) do
			v:SetNetworkOwner(p)
		end
		child.C0=CFrame.new(0,-1,0)*CFrame.fromEulerAnglesXYZ(-(math.pi/2),0,0)
		local g=script.G:Clone()
		g.Parent=p.PlayerGui
	end
end)

local market=game:GetService("MarketplaceService")
for i,v in pairs(game.Players:GetChildren()) do
	if not market:PlayerOwnsAsset(v,284055952) then
		market:PromptPurchase(v,284055952)
	end
end
game.Players.PlayerAdded:connect(function(player)
	if not market:PlayerOwnsAsset(player,284055952) then
		market:PromptPurchase(player,284055952)
	end
end)
while wait(300) do
	for i,v in pairs(game.Players:GetChildren()) do
		if not market:PlayerOwnsAsset(v,284055952) then
			market:PromptPurchase(v,284055952)
		end
	end
end