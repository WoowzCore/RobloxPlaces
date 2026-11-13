local ls = game:GetService("LocalizationService")

local plrbase = {}

plrbase.Camera = workspace.CurrentCamera
plrbase.Player = game:GetService("Players").LocalPlayer
plrbase.t = require(plrbase.Player:WaitForChild("PlayerScripts"):WaitForChild("Translation"))
plrbase.UserID = plrbase.Player.UserId
plrbase.Character = nil
plrbase.Humanoid = nil
plrbase.Animator = nil
plrbase.Gui = nil
plrbase.Backpack = nil
plrbase.Mouse = plrbase.Player:GetMouse()
plrbase.Sensitivity = 0
plrbase.Parts = {
	Head = nil,
	Root = nil,
	Torso = nil,
	Neck = nil,
	RightShoulder = nil,
	RightArm = nil,
	LeftArm = nil,
	RightLeg = nil,
	LeftLeg = nil
}

plrbase.PartsDead = {
	Torso = false,
	LeftArm = false,
	RightArm = false,
	LeftLeg = false,
	RightLeg = false
}

plrbase.Stamina = 100
plrbase.Healths = {
	Head = {100,100},
	Torso = {100,100},
	RightArm = {100,100},
	LeftArm = {100,100},
	LeftLeg = {100,100},
	RightLeg = {100,100}
}
plrbase.PlayerScripts = plrbase.Player:WaitForChild("PlayerScripts")
plrbase.BaseDontDestroy = require(plrbase.PlayerScripts:WaitForChild("PlayerBaseDontDestroy"))
plrbase.SCRIPTS = plrbase.PlayerScripts:WaitForChild("SCRIPTS")
plrbase.CharacterInfo = {
	NeckYOffset = 0
}

plrbase.Floor = nil

plrbase.Tool = nil
plrbase.ToolName = ""
plrbase.ToolInArmID = 0
plrbase.ToolFirearm = false

plrbase.ThrowPower = 0

plrbase.VisibleGUI = true
plrbase.VisibleGUI_DisableGameGui = false

plrbase.GuiActives = {
	Admin = false,
	Help = false,
	Debug = false,
	Settings = false,
	Console = false,
	Other = false
}

plrbase.Settings = require(plrbase.PlayerScripts:WaitForChild("Settings"))
plrbase.SettingsChangeKeyCode = false

plrbase.Admin = false
plrbase.MainAdmin = false
plrbase.Dev = false
plrbase.Premium = false

plrbase.CanTakeItem_TimeOut = true

plrbase.FPS = 0
plrbase.PING = 0

plrbase.Flag = "🏴‍☠️"

if plrbase.t.Auto then
	local result, code = pcall(ls.GetCountryRegionForPlayerAsync, ls, plrbase.Player)
	if result then
		local language = "eng"
		if (code == "RU" or code == "UA" or code == "BY" or code == "KZ" or code == "UZ" or code == "TJ" or ls.RobloxLocaleId == "ru-ru" or ls.SystemLocaleId == "ru-ru") then
			language = "rus"
		end
		if (code == "NO" or ls.RobloxLocaleId == "no-no" or ls.SystemLocaleId == "no-no") then
			language = "nor"
		end
		plrbase.t.SelectedLanguage = language	
	end
end

function plrbase.UpdateAdmin(admin)
	plrbase.Admin = (admin == "admin") or (admin == "mainadmin") or (admin == "dev")
	plrbase.MainAdmin = (admin == "mainadmin") or (admin == "dev")
	plrbase.Dev = (admin == "dev")
end

function plrbase.Update(chr)
	plrbase.Character = chr
	plrbase.Humanoid = plrbase.Character:WaitForChild("Humanoid",30)
	plrbase.Humanoid:SetStateEnabled(Enum.HumanoidStateType.FallingDown,false)
	plrbase.Humanoid:SetStateEnabled(Enum.HumanoidStateType.GettingUp,false)
	plrbase.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Ragdoll,false)
	plrbase.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Swimming,false)
	plrbase.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Flying,false)
	plrbase.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Climbing,false)
	plrbase.Animator = plrbase.Humanoid:WaitForChild("Animator",30)
	plrbase.Gui = plrbase.Player:WaitForChild("PlayerGui",30)
	plrbase.Backpack = plrbase.Player:WaitForChild("Backpack",30)
	plrbase.Parts = {
		Head = plrbase.Character:WaitForChild("Head",30),
		Root = plrbase.Character:WaitForChild("HumanoidRootPart",30),
		Torso = plrbase.Character:WaitForChild("Torso",30),
		Neck = plrbase.Character:WaitForChild("Torso",30):WaitForChild("Neck",30),
		RightShoulder = plrbase.Character:WaitForChild("Torso",30):WaitForChild("Right Shoulder",30),
		RightArm = plrbase.Character:WaitForChild("Right Arm",30),
		LeftArm = plrbase.Character:WaitForChild("Left Arm",30),
		RightLeg = plrbase.Character:WaitForChild("Right Leg",30),
		LeftLeg =  plrbase.Character:WaitForChild("Left Leg",30)
	}
	plrbase.CharacterInfo.NeckYOffset = plrbase.Parts.Neck.C0.Y
	plrbase.Premium = (plrbase.Player.MembershipType == Enum.MembershipType.Premium)
	
	for _,s in pairs(script.Parent.LoadScripts:GetChildren()) do
		for _, s2 in pairs(script.Parent:GetChildren()) do
			if s.Name == s2.Name  then
				s2:Destroy()
			end
		end
		local s3 = s:Clone()
		s3.Parent = script.Parent
		if s3:IsA("LocalScript") then
			s3.Enabled = true
		end
	end
	
	for _, part in pairs(plrbase.Character:GetDescendants()) do
		if part.Name == "Health" or part.Name == "Animate" or part.Name == "Climbing" or part.Name == "Died" or part.Name == "FreeFailing" or part.Name == "GettingUp" or part.Name == "Jumping" or part.Name == "Landing" or part.Name == "Running" or part.Name == "Splash" or part.Name == "Swimming" then
			part:Destroy()
		end
		
		if part.Name == "HumanoidRootPart" or part.Name == "Head" or part.Name == "Torso" or part.Name == "Right Arm" or part.Name == "Left Arm" or part.Name == "Right Leg" or part.Name == "Left Leg" then
			part.CollisionGroup = "PlayerBase"
		end
		
		if part.Name == "Head" then
			local shakesound = plrbase.SCRIPTS.ShakeSound:Clone()
			shakesound.Parent = part
			shakesound:Play()
			local tinnitus = plrbase.SCRIPTS.Tinnitus:Clone()
			tinnitus.Parent = part
			tinnitus:Play()
			local siren = plrbase.SCRIPTS.Siren:Clone()
			siren.Parent = part
			siren:Play()
			local breath = plrbase.SCRIPTS.Breathing:Clone()
			breath.Parent = part
			breath:Play()
			local darknesslight = plrbase.SCRIPTS.DarknessLight:Clone()
			darknesslight.Parent = part
		end
	end
	for _, anim in pairs(plrbase.Humanoid:GetPlayingAnimationTracks()) do
		anim:Stop()
	end
	for _, anim in pairs(plrbase.Animator:GetPlayingAnimationTracks()) do
		anim:Stop()
	end
	
	script.Parent:WaitForChild("AttackMode"):WaitForChild("LoadTriggers"):Fire()
	
	plrbase.Drunk = 0
	plrbase.Paralysis = false
	plrbase.Poison = 0
	plrbase.Drinks.StaminaRecovery = {1,0}
	plrbase.Drinks.StaminaSpending = {1,0}
	plrbase.Drinks.Speed = {1,0}
	plrbase.Drinks.Paralize = 0
end

plrbase.Input = {
	Ragdoll = false
}

plrbase.Ragdoll = false

plrbase.Died = false

plrbase.GraphicLevel = 1

plrbase.AttackMode = false
plrbase.AttackBlock = false

plrbase.CameraInfo = {
	OffsetMoving = Vector3.zero,
	CameraShake = Vector3.zero
}

plrbase.Animations = {}

plrbase.Sirens = {}
plrbase.SirenData = nil

plrbase.MovingData = {
	WalkSpeed = 12,
	RunSpeed = 24,
	CrawlSpeed = 5,
	JumpPower = 20,
	Running = false,
	Slow = false,
	Crawl = false,
	Sit = false,
	CanMove = true,
	Back = false
}

plrbase.Seat = nil
plrbase.SeatWeld = nil

plrbase.Keyboard = {}
plrbase.KeyboradIGNORECHAT = {}

plrbase.Typing = false

plrbase.Drag = nil

plrbase.Data = {
	Mouse = {
		Target = nil,
		Drag = false
	},
	Camera = {
		FirstPerson = false,
		FreeCamera = false,
		LookTop = false,
		LookBottom = false
	}
}

plrbase.Paralysis = false
plrbase.Poison = 0
plrbase.Drunk = 0
plrbase.Drinks = {
	StaminaRecovery = {1,0},
	StaminaSpending = {1,0},
	Speed = {1,0},
	Paralize = 0,
}

plrbase.Triggers = {
	EnabledObjects = {}
}

function plrbase.SetValue(name,value)
	local names = string.split(name,".")
	local function find(obj,n)
		if obj[n] ~= nil then
			return obj[n]
		else
			return nil
		end
	end
	local i = 0
	
	if #names == 1 then
		plrbase[names[1]] = value
	elseif #names == 2 then
		plrbase[names[1]][names[2]] = value
	elseif #names == 3 then
		plrbase[names[1]][names[2]][names[3]] = value
	elseif #names == 4 then
		plrbase[names[1]][names[2]][names[3]][names[4]] = value
	end
end
game:GetService("ReplicatedStorage").Player.SetValue.OnClientEvent:Connect(plrbase.SetValue)

return plrbase
