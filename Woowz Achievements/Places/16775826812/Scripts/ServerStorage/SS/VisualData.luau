local vd = {}

vd.AchLevelsType = {
	Wood = 0,
	Rust = 1,
	Bronze = 2,
	Silver = 3,
	Gold = 4,
	Crystal = 5,
	Angel = 6,
}

vd.Achievements = {
	["join"] = {
		["Icon"] = "",
		["Name"] = "Welcome!",
		["Desc"] = "Come into this place for the first time",
		["Level"] = vd.AchLevelsType.Wood,
	},
	["traveled10"] = {
		["Icon"] = "",
		["Name"] = "Walk 10 meters",
		["Desc"] = "Walk a distance of 10 meters",
		["Level"] = vd.AchLevelsType.Wood,
	},
	["traveled100"] = {
		["Icon"] = "",
		["Name"] = "Walk 100 meters",
		["Desc"] = "Walk a distance of 100 meters",
		["Level"] = vd.AchLevelsType.Wood,
	},
	["traveled500"] = {
		["Icon"] = "",
		["Name"] = "Walk 500 meters",
		["Desc"] = "Walk a distance of 500 meters",
		["Level"] = vd.AchLevelsType.Rust,
	},
	["traveled1000"] = {
		["Icon"] = "",
		["Name"] = "Walk 1000 meters",
		["Desc"] = "Walk a distance of 1000 meters",
		["Level"] = vd.AchLevelsType.Rust,
	},
	["traveled3000"] = {
		["Icon"] = "",
		["Name"] = "Walk 3000 meters",
		["Desc"] = "Walk a distance of 3000 meters",
		["Level"] = vd.AchLevelsType.Bronze,
	},
	["traveled10000"] = {
		["Icon"] = "",
		["Name"] = "Walk 10000 meters",
		["Desc"] = "Walk a distance of 10000 meters",
		["Level"] = vd.AchLevelsType.Silver,
	},
	["traveled20000"] = {
		["Icon"] = "",
		["Name"] = "Walk 20000 meters",
		["Desc"] = "Walk a distance of 20000 meters",
		["Level"] = vd.AchLevelsType.Silver,
	},
	["traveled50000"] = {
		["Icon"] = "",
		["Name"] = "Walk 50000 meters",
		["Desc"] = "Walk a distance of 50000 meters",
		["Level"] = vd.AchLevelsType.Gold,
	},
}

return vd
