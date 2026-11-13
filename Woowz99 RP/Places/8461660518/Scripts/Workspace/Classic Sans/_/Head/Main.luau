--[[Hello and welcome to Nikolander's morpher! Below you can edit stuff if you want to.
You also can edit attachments by naming the ObjectValue to the part you want to and assigning the value to the morph part. (you could convert it to an R15 morpher by that)
Custom Animations can be enabled too.
]]


BodyTransparency = 1 --1 = invisible
RemoveAccessories = true --Removes accessories if true
RemoveFace = true --Makes the face invisible
CanCollide = false --recommended to be no
CustomAnimations = false --If you want to have custom animations for your morph, set this to true
WalkSpeed = 40--Speed of the morph
JumpPower = 30--Jump power of the morph
HipHeight = 0--Hip height of the morph
Gamepass = 0--If gamepass is required, put the ID here (otherwise leave it 0)
VIPs = {}--List of people who can use it (leave empty if none)



function Custom() --Insert your own custom code here (if you want to do common modifications like transparency)
	
end




















script.Parent.Touched:connect(function(hit)
	local function VIPCHECK(plr)
		for i=1,#VIPs do
			if game.Players:GetUserIdFromNameAsync(plr.Name) == plr.UserId then
				return true
			end
		end
		return false
	end
	if hit.Parent:FindFirstChildOfClass("Humanoid") then
		if hit.Parent:FindFirstChild("_morphed") == nil then
			
				if #VIPs > 0 then
				local plr = game.Players:GetPlayerFromCharacter(hit.Parent)
				if plr then
				if VIPCHECK(plr) then
								print(plr.Name.." uses "..script.Parent.Parent.Name)
							
			local check = Instance.new("ObjectValue",hit.Parent)
			check.Name = "_morphed"
			local pc = hit.Parent:GetChildren()
			for i=1,#pc do
				if pc[i]:IsA("BasePart") then
					pc[i].Transparency = BodyTransparency
				end
			end
			if RemoveFace then 
				if hit.Parent:FindFirstChild("Head") then
					 hit.Parent:FindFirstChild("Head").face.Transparency = 1
					
				end
			end
			if RemoveAccessories then
				for i=1,#pc do
					if pc[i]:IsA("Accessory") then
						pc[i]:remove()
					end
				end
			end
			if CustomAnimations then
				if hit.Parent:FindFirstChild("Animate") then
					local walkanim = hit.Parent.Animate:FindFirstChild("walk")
					if walkanim then
						walkanim.WalkAnim.AnimationId = "rbxassetid://"..script.Parent.CustomAnimations.Walk.Value
					end
					local runanim = hit.Parent.Animate:FindFirstChild("run")
					if runanim then
						runanim.RunAnim.AnimationId = "rbxassetid://"..script.Parent.CustomAnimations.Run.Value
					end
					local idleanim = hit.Parent.Animate:FindFirstChild("idle")
					if idleanim then
						idleanim.Animation1.AnimationId = "rbxassetid://"..script.Parent.CustomAnimations.Idle1.Value
						idleanim.Animation2.AnimationId = "rbxassetid://"..script.Parent.CustomAnimations.Idle2.Value

					end
					local sitanim = hit.Parent.Animate:FindFirstChild("sit")
					if sitanim then
						sitanim.SitAnim.AnimationId = "rbxassetid://"..script.Parent.CustomAnimations.Sit.Value
					end
						local climbanim = hit.Parent.Animate:FindFirstChild("climb")
					if climbanim then
						climbanim.ClimbAnim.AnimationId = "rbxassetid://"..script.Parent.CustomAnimations.Climb.Value
					end
						local jumpanim = hit.Parent.Animate:FindFirstChild("jump")
					if jumpanim then
						jumpanim.JumpAnim.AnimationId = "rbxassetid://"..script.Parent.CustomAnimations.Jump.Value
					end
						local fallanim = hit.Parent.Animate:FindFirstChild("fall")
					if fallanim then
						fallanim.FallAnim.AnimationId = "rbxassetid://"..script.Parent.CustomAnimations.Fall.Value
					end
						local toolnone = hit.Parent.Animate:FindFirstChild("toolnone")
					if toolnone then
						toolnone.ToolNoneAnim.AnimationId = "rbxassetid://"..script.Parent.CustomAnimations.ToolNone.Value
					end
				end
			end
			local ach = script.Parent.Attachments:GetChildren()
			for i=1,#ach do
				local bp = ach[i].Value:Clone()
				bp.Parent = hit.Parent

				local c = bp:GetChildren()
				for i=1,#c do
					c[i].CanCollide = CanCollide
					if bp:FindFirstChild("Middle") then
						local cj = CFrame.new(bp["Middle"].Position)
	
					local weld = Instance.new("Weld", bp["Middle"])
					weld.Part0 = bp["Middle"]
					weld.C0 = bp["Middle"].CFrame:inverse() * cj
					weld.Part1 = c[i]
					weld.C1 = c[i].CFrame:inverse() * cj
					else
						wait("Joint wasn't found")
					end
										c[i].Anchored = false
				end
								if bp:FindFirstChild("Middle") then
					local weld = Instance.new("Weld",bp["Middle"])
					if hit.Parent:FindFirstChild(ach[i].Name) then
						weld.Part0 = hit.Parent:FindFirstChild(ach[i].Name)
						weld.Part1 = bp["Middle"]
						weld.Name = "Joint"
					else
						warn("Insufficent part")
						bp:remove()
						if check then
							check:remove()
							
						end
					end
						
				else
					warn("Joint part wasn't found")
								end
								local g = script.Parent.GUI:GetChildren()
								local plr = game.Players:GetPlayerFromCharacter(hit.Parent)	
								if plr then							
								for i=1,#g do
								g[i]:Clone().Parent = plr.PlayerGui
								end
								else
									warn("The character was a NPC")
								end
								hit.Parent:FindFirstChildOfClass("Humanoid").JumpPower = JumpPower
								hit.Parent:FindFirstChildOfClass("Humanoid").WalkSpeed = WalkSpeed
								hit.Parent:FindFirstChildOfClass("Humanoid").HipHeight = HipHeight
								Custom()
				end
				end
				
				end
				
				elseif Gamepass > 0 then
									local plr = game.Players:GetPlayerFromCharacter(hit.Parent)
									if plr then
										
										if game:GetService("GamePassService"):PlayerHasPass(plr,Gamepass) then
					
			local check = Instance.new("ObjectValue",hit.Parent)
			check.Name = "_morphed"
			local pc = hit.Parent:GetChildren()
			for i=1,#pc do
				if pc[i]:IsA("BasePart") then
					pc[i].Transparency = BodyTransparency
				end
			end
			if RemoveFace then 
				if hit.Parent:FindFirstChild("Head") then
					 hit.Parent:FindFirstChild("Head").face.Transparency = 1
					
				end
			end
			if RemoveAccessories then
				for i=1,#pc do
					if pc[i]:IsA("Accessory") then
						pc[i]:remove()
					end
				end
			end
			if CustomAnimations then
				if hit.Parent:FindFirstChild("Animate") then
					local walkanim = hit.Parent.Animate:FindFirstChild("walk")
					if walkanim then
						walkanim.WalkAnim.AnimationId = "rbxassetid://"..script.Parent.CustomAnimations.Walk.Value
					end
					local runanim = hit.Parent.Animate:FindFirstChild("run")
					if runanim then
						runanim.RunAnim.AnimationId = "rbxassetid://"..script.Parent.CustomAnimations.Run.Value
					end
					local idleanim = hit.Parent.Animate:FindFirstChild("idle")
					if idleanim then
						idleanim.Animation1.AnimationId = "rbxassetid://"..script.Parent.CustomAnimations.Idle1.Value
						idleanim.Animation2.AnimationId = "rbxassetid://"..script.Parent.CustomAnimations.Idle2.Value

					end
					local sitanim = hit.Parent.Animate:FindFirstChild("sit")
					if sitanim then
						sitanim.SitAnim.AnimationId = "rbxassetid://"..script.Parent.CustomAnimations.Sit.Value
					end
						local climbanim = hit.Parent.Animate:FindFirstChild("climb")
					if climbanim then
						climbanim.ClimbAnim.AnimationId = "rbxassetid://"..script.Parent.CustomAnimations.Climb.Value
					end
						local jumpanim = hit.Parent.Animate:FindFirstChild("jump")
					if jumpanim then
						jumpanim.JumpAnim.AnimationId = "rbxassetid://"..script.Parent.CustomAnimations.Jump.Value
					end
						local fallanim = hit.Parent.Animate:FindFirstChild("fall")
					if fallanim then
						fallanim.FallAnim.AnimationId = "rbxassetid://"..script.Parent.CustomAnimations.Fall.Value
					end
						local toolnone = hit.Parent.Animate:FindFirstChild("toolnone")
					if toolnone then
						toolnone.ToolNoneAnim.AnimationId = "rbxassetid://"..script.Parent.CustomAnimations.ToolNone.Value
					end
				end
			end
			local ach = script.Parent.Attachments:GetChildren()
			for i=1,#ach do
				local bp = ach[i].Value:Clone()
				bp.Parent = hit.Parent

				local c = bp:GetChildren()
				for i=1,#c do
					c[i].CanCollide = CanCollide
					if bp:FindFirstChild("Middle") then
						local cj = CFrame.new(bp["Middle"].Position)
	
					local weld = Instance.new("Weld", bp["Middle"])
					weld.Part0 = bp["Middle"]
					weld.C0 = bp["Middle"].CFrame:inverse() * cj
					weld.Part1 = c[i]
					weld.C1 = c[i].CFrame:inverse() * cj
					else
						wait("Joint wasn't found")
					end
										c[i].Anchored = false
				end
								if bp:FindFirstChild("Middle") then
					local weld = Instance.new("Weld",bp["Middle"])
					if hit.Parent:FindFirstChild(ach[i].Name) then
						weld.Part0 = hit.Parent:FindFirstChild(ach[i].Name)
						weld.Part1 = bp["Middle"]
						weld.Name = "Joint"
					else
						warn("Insufficent part")
						bp:remove()
						if check then
							check:remove()
							
						end
					end
				else
					warn("Joint part wasn't found")
								end
								local g = script.Parent.GUI:GetChildren()
								local plr = game.Players:GetPlayerFromCharacter(hit.Parent)	
								if plr then							
								for i=1,#g do
								g[i]:Clone().Parent = plr.PlayerGui
								end
								else
									warn("The character was a NPC")
								end
								hit.Parent:FindFirstChildOfClass("Humanoid").JumpPower = JumpPower
								hit.Parent:FindFirstChildOfClass("Humanoid").WalkSpeed = WalkSpeed
								hit.Parent:FindFirstChildOfClass("Humanoid").HipHeight = HipHeight
								Custom()
								end
										end
										end
			else
				
							
			local check = Instance.new("ObjectValue",hit.Parent)
			check.Name = "_morphed"
			local pc = hit.Parent:GetChildren()
			for i=1,#pc do
				if pc[i]:IsA("BasePart") then
					pc[i].Transparency = BodyTransparency
				end
			end
			if RemoveFace then 
				if hit.Parent:FindFirstChild("Head") then
					 hit.Parent:FindFirstChild("Head").face.Transparency = 1
					
				end
			end
			if RemoveAccessories then
				for i=1,#pc do
					if pc[i]:IsA("Accessory") then
						pc[i]:remove()
					end
				end
			end
			if CustomAnimations then
				if hit.Parent:FindFirstChild("Animate") then
					local walkanim = hit.Parent.Animate:FindFirstChild("walk")
					if walkanim then
						walkanim.WalkAnim.AnimationId = "rbxassetid://"..script.Parent.CustomAnimations.Walk.Value
					end
					local runanim = hit.Parent.Animate:FindFirstChild("run")
					if runanim then
						runanim.RunAnim.AnimationId = "rbxassetid://"..script.Parent.CustomAnimations.Run.Value
					end
					local idleanim = hit.Parent.Animate:FindFirstChild("idle")
					if idleanim then
						idleanim.Animation1.AnimationId = "rbxassetid://"..script.Parent.CustomAnimations.Idle1.Value
						idleanim.Animation2.AnimationId = "rbxassetid://"..script.Parent.CustomAnimations.Idle2.Value

					end
					local sitanim = hit.Parent.Animate:FindFirstChild("sit")
					if sitanim then
						sitanim.SitAnim.AnimationId = "rbxassetid://"..script.Parent.CustomAnimations.Sit.Value
					end
						local climbanim = hit.Parent.Animate:FindFirstChild("climb")
					if climbanim then
						climbanim.ClimbAnim.AnimationId = "rbxassetid://"..script.Parent.CustomAnimations.Climb.Value
					end
						local jumpanim = hit.Parent.Animate:FindFirstChild("jump")
					if jumpanim then
						jumpanim.JumpAnim.AnimationId = "rbxassetid://"..script.Parent.CustomAnimations.Jump.Value
					end
						local fallanim = hit.Parent.Animate:FindFirstChild("fall")
					if fallanim then
						fallanim.FallAnim.AnimationId = "rbxassetid://"..script.Parent.CustomAnimations.Fall.Value
					end
						local toolnone = hit.Parent.Animate:FindFirstChild("toolnone")
					if toolnone then
						toolnone.ToolNoneAnim.AnimationId = "rbxassetid://"..script.Parent.CustomAnimations.ToolNone.Value
					end
				end
			end
			local ach = script.Parent.Attachments:GetChildren()
			for i=1,#ach do
				local bp = ach[i].Value:Clone()
				bp.Parent = hit.Parent

				local c = bp:GetChildren()
				for i=1,#c do
					c[i].CanCollide = CanCollide
					if bp:FindFirstChild("Middle") then
						local cj = CFrame.new(bp["Middle"].Position)
	
					local weld = Instance.new("Weld", bp["Middle"])
					weld.Part0 = bp["Middle"]
					weld.C0 = bp["Middle"].CFrame:inverse() * cj
					weld.Part1 = c[i]
					weld.C1 = c[i].CFrame:inverse() * cj
					else
						wait("Joint wasn't found")
					end
										c[i].Anchored = false

				end
								if bp:FindFirstChild("Middle") then
					local weld = Instance.new("Weld",bp["Middle"])
					if hit.Parent:FindFirstChild(ach[i].Name) then
						weld.Part0 = hit.Parent:FindFirstChild(ach[i].Name)
						weld.Part1 = bp["Middle"]
						weld.Name = "Joint"
					else
						warn("Insufficent part")
						bp:remove()
						if check then
							check:remove()
							
						end
					end
				else
					warn("Joint part wasn't found")
								end
								local g = script.Parent.GUI:GetChildren()
								local plr = game.Players:GetPlayerFromCharacter(hit.Parent)	
								if plr then							
								for i=1,#g do
								g[i]:Clone().Parent = plr.PlayerGui
								end
								else
									warn("The character was a NPC")
								end
								hit.Parent:FindFirstChildOfClass("Humanoid").JumpPower = JumpPower
								hit.Parent:FindFirstChildOfClass("Humanoid").WalkSpeed = WalkSpeed
								hit.Parent:FindFirstChildOfClass("Humanoid").HipHeight = HipHeight
								Custom()
			end
			end
			end
		end
		
end)