-------------------------------------------------
-- Customizable Dinosaur AI by Cat67383 --
-------------- Written 1/15/2022 --------------
-------------------------------------------------

-- Variables --
Monster=script.Parent
Humanoid=Monster:FindFirstChildWhichIsA("Humanoid")
Root=Monster:WaitForChild("HumanoidRootPart")
Root:SetNetworkOwner(nil)
Root.Anchored=false
Roar=Root:FindFirstChild("Roar")
Growl=Root:FindFirstChild("Growl")
Notice=false
NoticeDebounce=false
AttackDebounce=false
Fighting=false
-- Animations --
AttackAnim=Humanoid:LoadAnimation(script.Parent:FindFirstChild("Bite"))
EatAnim=Humanoid:LoadAnimation(script.Parent:FindFirstChild("Eat"))
GrowlAnim=Humanoid:LoadAnimation(script.Parent:FindFirstChild("Growl"))
RoarAnim=Humanoid:LoadAnimation(script.Parent:FindFirstChild("Roar"))
DeathAnim=Humanoid:LoadAnimation(script.Parent:FindFirstChild("Death"))
DeadAnim=Humanoid:LoadAnimation(script.Parent:FindFirstChild("Dead"))
Humanoid.Died:Connect(function()
Fighting=false
Root.Anchored=true
DeathAnim:Play()
wait(1)
DeathAnim:Stop()
DeadAnim:Play()
game.Debris:AddItem(Monster,math.random(50,80))
end)
-- Food system
spawn(function()
	while wait(1) do
		if script.Parent.Food.Value>10 then
			script.Parent.Food.Value=script.Parent.Food.Value-script.Parent.Appetite.Value
		elseif script.Parent.Food.Value==10 or script.Parent.Food.Value<10 then
			script.Parent.Food.Value=10
			Humanoid:TakeDamage(Monster.Appetite.Value)
		end
	end
end)
-- Wander randomly --
spawn(function()
while true do
wait(math.random(5,25))
local eatchance=math.random(1,script.Parent.Food.Value)
if Monster.Stats.Diet.Value=="Herbivore" and eatchance==10000 or Monster.Stats.Diet.Value=="Omnivore" and eatchance==10000 then
EatAnim:Play()
spawn(function()
if script.Parent.Food.Value<100 then
repeat wait(0.1) script.Parent.Food.Value=script.Parent.Food.Value+1 until script.Parent.Food.Value==100						
end
end)
else
script.Parent:FindFirstChildWhichIsA("Humanoid"):MoveTo(Vector3.new(script.Parent.HumanoidRootPart.Position.X+math.random(-500,500),script.Parent.HumanoidRootPart.Position.Y,script.Parent.HumanoidRootPart.Position.Z+math.random(-500,500)))
end
end
end)
-- Growl
spawn(function()
	while true do
		wait(math.random(5,40))
		if Notice==false then
			GrowlAnim:Play()
			Growl:Play()
		end
	end
end)
-- Regenerate Health --

spawn(function()
	while wait(1) do
		if Notice==false and Fighting==false then
			Humanoid.Health=Humanoid.Health+Monster.Stats.RegenRate.Value
		end
	end
end)

-- Functions used for chasing players --

function Chase(destination)
	if destination~=nil and destination.Parent~=nil and destination.Parent:FindFirstChildWhichIsA("Humanoid") and destination.Parent:FindFirstChildWhichIsA("Humanoid").Health>0 then
		if destination and destination.Parent and destination.Parent:FindFirstChildWhichIsA("Humanoid") and Monster and Humanoid and Humanoid.Health~=0 and (destination.Position-Root.Position).Magnitude>9 then
			local origin, direction = Root.Position, (destination.Position - Root.Position).unit * 500
			local ray = Ray.new(origin, direction)
			local hit = workspace:FindPartOnRay(ray,script.Parent)
			local pathFind = false
			if hit then
				if hit:IsDescendantOf(destination.Parent) then
					pathFind = false
				else
					pathFind=true
				end
			end
			if pathFind then
				local allow=0
				local path = game:GetService("PathfindingService"):FindPathAsync(Root.Position, destination.Position)
				if path.Status==Enum.PathStatus.Success then
					for index, waypoint in pairs(path:GetWaypoints()) do
						local origin, direction = Root.Position, (destination.Position - Root.Position).unit * 500
						local ray = Ray.new(origin, direction)
						local hit = workspace:FindPartOnRay(ray,script.Parent)
						local pathFind = false
						if hit then
							if hit:IsDescendantOf(destination.Parent) then
								pathFind=false
								Humanoid:MoveTo(destination.Position+(destination.Position-Root.Position).unit*2,workspace.Terrain)
								return
							else -- this is if the rake still can't see his target
								pathFind=true
							end
						end
						if not pathFind then
							Humanoid:MoveTo(destination.Position+(destination.Position-Root.Position).unit*2,workspace.Terrain)
							return
						end
						Humanoid:MoveTo(waypoint.Position)
						repeat wait(0.1) allow=allow+1 Humanoid:MoveTo(waypoint.Position) until allow>100 or (waypoint.Position-Root.Position).Magnitude>1 or destination==nil
						if allow>100 then
							return
						else
							allow=0
						end
						if destination==nil then
							return
						end
						if destination and destination.Parent==nil then
							return
						end
						if destination and destination.Parent and destination.Parent:FindFirstChildWhichIsA("Humanoid").Health==0 then
							return
						end
					end
				else
					Humanoid:MoveTo(destination.Position+(destination.Position-Root.Position).unit*2,workspace.Terrain)
				end
			else
				Humanoid:MoveTo(destination.Position+(destination.Position-Root.Position).unit*2,workspace.Terrain)
			end
		elseif destination and destination.Parent and destination.Parent:FindFirstChildWhichIsA("Humanoid") and Monster and Humanoid and Humanoid.Health~=0 and (destination.Position-Root.Position).Magnitude<9 then
if not EatAnim.IsPlaying then
EatAnim:Play()
Root.Hit:Play()
			end
			Monster.Stats.Dominance.Value=Monster.Stats.Dominance.Value+5
			if Monster.Stats.Diet.Value=="Carnivore" or Monster.Stats.Diet.Value=="Omnivore" then
				if Monster.Food.Value+25<100 then
					Monster.Food.Value=Monster.Food.Value+25
				else
					Monster.Food.Value=100
				end
			end
			destination.Parent:FindFirstChildWhichIsA("Humanoid"):TakeDamage(Monster.Stats.Attack.Value)
		end;
	end
end
function Fight(opponent)
	repeat
		wait(math.random(7,20))
		if script and Monster and Monster.Parent and Humanoid and Humanoid.Health>0 and opponent and opponent.Parent and opponent:FindFirstChildWhichIsA("Humanoid") and opponent:FindFirstChildWhichIsA("Humanoid").Health>0 and script.Parent.TakingDamageInFight.Value==false then
			AttackAnim:Play()
			opponent.Stats.Dominance.Value=opponent.Stats.Dominance.Value-30
			Monster.Stats.Dominance.Value=Monster.Stats.Dominance.Value+30
			opponent.TakingDamageInFight.Value=true
			wait(0.5)
			if script.Parent.Stats.Attack.Value-opponent.Stats.Defense.Value>0 then -- if there is more attack than defense, otherwise attacks will add health to dinosaurs
				opponent:FindFirstChildWhichIsA("Humanoid"):TakeDamage(script.Parent.Stats.Attack.Value-opponent.Stats.Defense.Value)
				Root.Hit:Play()
			end
			-- if the dinosaur has more defense than the attacker's attack, the dinosaur takes no damage, making some dinosaurs immune to others attacks
				if opponent:FindFirstChildWhichIsA("Humanoid").Health>0 then
					opponent:FindFirstChildWhichIsA("Humanoid"):LoadAnimation(opponent.Damaged):Play()
				end
				wait(1)
				if opponent then
					opponent.TakingDamageInFight.Value=false
				end
		end
	until opponent.Stats.Dominance.Value==0 or script.Parent.Stats.Dominance.Value==0 or opponent:FindFirstChildWhichIsA("Humanoid").Health==0 or Humanoid.Health==0
	if script.Parent.Stats.Diet.Value=="Omnivore" or script.Parent.Stats.Diet.Value=="Carnivore" then
		script.Parent.Food.Value=100
	end
	script.Parent.Stats.Dominance.Value=script.Parent.Stats.Dominance.Value+opponent.Stats.Dominance.Value
	Humanoid.WalkSpeed=Monster.Stats.WalkSpeed.Value
	script.Parent.TakingDamageInFight.Value=false
	Fighting=false
	return
end
function FindTarget()
	local NoticeDistance=500 -- Targets must be within this radius AND visible in a line of sight. DO NOT TOUCH
	local TargetMain;
	for _,TargetModel in pairs(game:GetService("Workspace"):GetChildren())do
		if Monster and Humanoid and Humanoid.Health~=0 and TargetModel.className=="Model"and TargetModel~=Monster and TargetModel:FindFirstChild("HumanoidRootPart") and TargetModel:FindFirstChildWhichIsA("Humanoid") and not (TargetModel:FindFirstChild("Stats") and TargetModel.Stats:FindFirstChild("Species") and TargetModel.Stats.Species.Value==script.Parent.Stats.Species.Value) then
			local TargetPart=TargetModel:FindFirstChild("HumanoidRootPart");
			local FoundHumanoid;
			for _,Child in pairs(TargetModel:GetChildren())do
				if Child and Child.ClassName=="Humanoid"and Child.Health~=0 then
					FoundHumanoid=Child;
				end;
			end;
			local origin, direction = Root.Position, (TargetPart.Position - Root.Position).unit * 500
			local ray = Ray.new(origin, direction)
			local hit = workspace:FindPartOnRay(ray,script.Parent)
			if TargetModel and TargetPart and FoundHumanoid and FoundHumanoid.Health~=0 and(TargetPart.Position-Root.Position).magnitude<NoticeDistance and hit and hit:IsDescendantOf(TargetModel) then
				TargetMain=TargetPart;
				NoticeDistance=(TargetPart.Position-Root.Position).magnitude;
			end;
		end;
	end;
	return TargetMain;
end;
while game:GetService("RunService").Heartbeat:Wait() do
	TargetRoot=FindTarget()
	if script and TargetRoot~=nil and Monster~=nil and Humanoid.Health~=0 then
		if not Roar.Playing then
			Roar:Play()
			RoarAnim:Play()
		end
		if TargetRoot.Parent:FindFirstChild("AI") and TargetRoot.Parent:FindFirstChild("Stats") and TargetRoot.Parent.Stats:FindFirstChild("Dominance") and TargetRoot.Parent.Stats.Dominance.Value>0 and TargetRoot.Parent:FindFirstChild("Food") and TargetRoot.Parent.Stats:FindFirstChild("Species") and TargetRoot.Parent.Stats.Species.Value~=Monster.Stats.Species.Value then -- if target is a dinosaur

			-- LET THEM FIGHT --
			
			Fighting=true
			Humanoid.WalkSpeed=Monster.Stats.SprintSpeed.Value
			repeat wait(0.1) Humanoid:MoveTo(TargetRoot.Position) until (TargetRoot.Position-Root.Position).Magnitude<Monster:FindFirstChildWhichIsA("MeshPart").Size.Z -- get close enough that the animations don't look ridiculous
			Humanoid.WalkSpeed=0
			Fight(TargetRoot.Parent)
			
		elseif TargetRoot.Parent:FindFirstChild("Stats")==nil or TargetRoot.Parent:FindFirstChild("AI")==nil or TargetRoot.Parent:FindFirstChild("Food")==nil then -- if the target is a guest
			Notice=true
			Fighting=false
			Humanoid.WalkSpeed=Monster.Stats.SprintSpeed.Value
			if NoticeDebounce==false then
				NoticeDebounce=true
			end
			if NoticeDebounce==true then
				Chase(TargetRoot)
			end	
		end
--------------------------------------------------
	elseif script and TargetRoot==nil and Monster~=nil and Humanoid.Health~=0 then
		NoticeDebounce=false
		Notice=false
		Fighting=false
		Monster.TakingDamageInFight.Value=false
		Humanoid.WalkSpeed=Monster.Stats.WalkSpeed.Value
	end
end