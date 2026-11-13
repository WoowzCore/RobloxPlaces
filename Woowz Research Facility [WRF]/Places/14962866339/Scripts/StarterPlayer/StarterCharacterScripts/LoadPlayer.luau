local pb = require(script.Parent.PlayerBase)
local ps = require(script.Parent.PlayerScript)
local rs = game:GetService("ReplicatedStorage")

local function LoadGui(gui)
	gui.Parent = pb.Gui
end

local function UpdateCharacter(chr)
	local sgui = game:GetService("StarterGui")
	sgui:SetCoreGuiEnabled(Enum.CoreGuiType.Backpack,false)
	sgui:SetCoreGuiEnabled(Enum.CoreGuiType.Health,false)
	sgui:SetCoreGuiEnabled(Enum.CoreGuiType.EmotesMenu,false)
	sgui:SetCoreGuiEnabled(Enum.CoreGuiType.Captures,false)
	local result, code = pcall(game:GetService("LocalizationService").GetCountryRegionForPlayerAsync, game:GetService("LocalizationService"), game:GetService("Players").LocalPlayer)
	if result then
		local flag = ps.getFlagEmoji(code)
		if flag == nil then flag = "" end
		pb.Flag = flag
	end
	
	pb.Update(chr)
	ps.LoadAnimations()
	pb.Gui = pb.Player:WaitForChild("PlayerGui")
	
	local freecam = pb.Gui:FindFirstChild("Freecam")
	if freecam then
		freecam:Destroy()
	end	
	
	ps.ChangePlayerTransparency(false)
	wait(1)
	ps.ChangePlayerTransparency(false)
	wait(1)
	ps.ChangePlayerTransparency(false)
	wait(1)
	ps.ChangePlayerTransparency(false)
	wait(1)
	ps.ChangePlayerTransparency(false)
	wait(1)
	ps.ChangePlayerTransparency(false)
	wait(1)
	ps.ChangePlayerTransparency(false)
	wait(1)
	ps.ChangePlayerTransparency(false)
	wait(1)
	ps.ChangePlayerTransparency(false)
	wait(1)
	ps.ChangePlayerTransparency(false)
	wait(1)
	ps.ChangePlayerTransparency(false)
end

rs.UpdateCharacter.OnClientEvent:Connect(UpdateCharacter)
rs.UpdateAdmin.OnClientEvent:Connect(pb.UpdateAdmin)
rs.SetPlayerDataValue.OnClientInvoke = pb.SetValue
rs.GetHumanoidHealths.OnClientEvent:Connect(function(h,t,la,ra,ll,rl,hmax,tmax,lamax,ramax,llmax,rlmax)
	pb.Healths.Head[1] = h or 0
	pb.Healths.Torso[1] = t or 0
	pb.Healths.LeftArm[1] = la or 0
	pb.Healths.RightArm[1] = ra or 0
	pb.Healths.LeftLeg[1] = ll or 0
	pb.Healths.RightLeg[1] = rl or 0
	pb.Healths.Head[2] = hmax or 0
	pb.Healths.Torso[2] = tmax or 0
	pb.Healths.LeftArm[2] = lamax or 0
	pb.Healths.RightArm[2] = ramax or 0
	pb.Healths.LeftLeg[2] = llmax or 0
	pb.Healths.RightLeg[2] = rlmax or 0
end)