local player = game.Players.LocalPlayer


local function GetValue(name)
	local v = player.PlayerStarter.Values
	return v:WaitForChild(name).Value
end

local function GetGlobalValue(name)
	local v = game.Workspace.Files.GlobalValue
	return v:WaitForChild(name).Value
end


local HereTexts = player:WaitForChild("PlayerGui"):WaitForChild("GUI")

local Texts = {
	GameInfo = HereTexts.GameStartInfo.GameInfo;
		GameType = HereTexts.GameStartInfo.GameType;
	GameVariant = HereTexts.GameStartInfo.GameVariant;
	RunType = HereTexts.RunType;
	BonusInfo = HereTexts.BonusInfo;
}

while true do
	wait()
	
	if HereTexts then
		if not GetValue("ShowGameInfo") then
			Texts.GameVariant.Visible = false
			Texts.GameType.Visible = false
			Texts.GameInfo.Visible = false
		else
			Texts.GameVariant.Visible = true
			Texts.GameType.Visible = true
			Texts.GameInfo.Visible = true
		end
		
		
		Texts.RunType.Text = "Run Type : "..GetValue("RunType").." , "..GetValue("RunExtras")
		Texts.GameType.Text = "Type : "..GetGlobalValue("GameType")
		Texts.GameVariant.Text = "Variant : "..GetGlobalValue("GameVariant")
		if GetValue("RunType") == "Run" or GetValue("RunType") == "Fly" or GetValue("RunType") == "FlyMore" then
			Texts.BonusInfo.Text = "BonusInfo : "..GetValue("Stamina")
			end
	else if GetValue("RunType") == "NoMaterial" then
			Texts.BonusInfo.Text = "BonusInfo : "..GetValue("CantRunThisMaterial").." , "..GetValue("EventPlayerStepMaterial")
		end
	end
end