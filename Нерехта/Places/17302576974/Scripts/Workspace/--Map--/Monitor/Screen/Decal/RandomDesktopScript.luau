wait(1)
local Screen = script.Parent
local RandomScreens = {
	"702364196",
	"16589526716",
	"11135433298",
	"913710611",
	"267898491",
	--"16029628812", ФУРРИ!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
	"15429960578",
	"9555369424",
	"3958582661",
	"4531558047",
	"14959202853",
	"58624824",
	"2425175390",
	"4648020311"
}

if math.random(1, 2) == 2 then
	Screen.Parent.Material = Enum.Material.Neon
	Screen.Transparency = 0
	Screen.Texture = "http://www.roblox.com/asset/?id=" .. RandomScreens[math.random(1, #RandomScreens)]
end