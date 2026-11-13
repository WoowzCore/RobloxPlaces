local RS = game.ReplicatedStorage.Global
local Player = script.Parent
local Character = Player:WaitForChild("Character")

if Character:WaitForChild("HumanoidRootPart") then
local PParts = {
	Base = Character:WaitForChild("HumanoidRootPart");
	Head = Character:WaitForChild("Head");
	Torso = {
		Upper = Character:WaitForChild("UpperTorso");
		Lower = Character:WaitForChild("LowerTorso");
	};
	Arms = {
		Left = {
			Hand = Character:WaitForChild("LeftHand");
			Upper = Character:WaitForChild("LeftUpperArm");
			Lower = Character:WaitForChild("LeftLowerArm");
		};
		Right = {
			Hand = Character:WaitForChild("RightHand");
			Upper = Character:WaitForChild("RightUpperArm");
			Lower = Character:WaitForChild("RightLowerArm");
		};
	};
	Legs = {
		Left = {
			Foot = Character:WaitForChild("LeftFoot");
			Upper = Character:WaitForChild("LeftUpperLeg");
			Lower = Character:WaitForChild("LeftLowerLeg");
		};
		Right = {
			Foot = Character:WaitForChild("RightFoot");
			Upper = Character:WaitForChild("RightUpperLeg");
			Lower = Character:WaitForChild("RightLowerLeg");
		};
	};

}

while true do
	wait()
	RS.PlayerValues:FireServer(PParts)
	end
	end