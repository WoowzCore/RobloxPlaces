local Settings = {}

Settings.Optimization = {
	WorkedMirrors = false,
	MirrorsUpdate = 10,
	GlobalShadows = true,
	SirensShadows = true,
	SmolThingsShadows = true,
	LightingShadows = true
}

Settings.Privacity = {
	ShowFlag = true,
	ShowPing = true,
	ShowFps = true,
	ShowGraphics = true
}

Settings.Keys = {
	DropItem = Enum.KeyCode.G,
	Crawl = Enum.KeyCode.C,
	Ragdoll = Enum.KeyCode.X,
	SettingsKey = Enum.KeyCode.F1,
	VisibleGui = Enum.KeyCode.F2,
	Help = Enum.KeyCode.F4,
	Admin = Enum.KeyCode.F5,
	Debug = Enum.KeyCode.F6,
	Log = Enum.KeyCode.F8,
	Die = Enum.KeyCode.N,
	MoveFront = Enum.KeyCode.W,
	MoveRight = Enum.KeyCode.D,
	MoveLeft = Enum.KeyCode.A,
	MoveBack = Enum.KeyCode.S,
	Jump = Enum.KeyCode.Space,
	Zoom = Enum.KeyCode.F,
	WalkFast = Enum.KeyCode.LeftShift,
	WalkSlow = Enum.KeyCode.LeftControl,
	AttackMode = Enum.KeyCode.Q,
	Item1 = Enum.KeyCode.One,
	Item2 = Enum.KeyCode.Two,
	Item3 = Enum.KeyCode.Three,
	Item4 = Enum.KeyCode.Four,
	Item5 = Enum.KeyCode.Five,
	Item6 = Enum.KeyCode.Six,
	Item7 = Enum.KeyCode.Seven,
	Item8 = Enum.KeyCode.Eight,
	Item9 = Enum.KeyCode.Nine,
	Item10 = Enum.KeyCode.Zero,
	Scream = Enum.KeyCode.E
}

Settings.Debug = {
	ImmediatelySave = false
}

Settings.Other = {
	ColorCorrectionContrast = 0,
	ColorCorrectionSaturation = 0,
	ColorCorrectionBlackWhite = false,
	ColorCorrectionInverse = false,
	ColorCorrectionBlur = 0
}

Settings.Gameplay = {
	ShakeMultiplier = 1,
	TinnitusEnabled = true
}

Settings.Graphic = {
	DOF = true,
	Bloom = true,
	SpecularScale = 4,
	Brightness = 0
}

Settings.Loaded = false

function Settings.Update(new)
	local function upd(tab)
		local newtab = {}
		for i,p in pairs(Settings[tab] or {}) do
			newtab[i] = p
		end
		
		for i,p in pairs(new[tab] or {}) do
			newtab[i] = p
		end
		
		Settings[tab] = newtab
	end
	
	upd("Optimization")
	upd("Privacity")
	upd("Keys")
	upd("Debug")
	upd("Other")
	upd("Gameplay")
	upd("Graphic")
end

return Settings
