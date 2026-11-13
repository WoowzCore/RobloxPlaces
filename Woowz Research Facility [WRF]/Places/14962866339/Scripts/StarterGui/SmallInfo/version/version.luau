local rs = game:GetService("ReplicatedStorage")
local holiday = rs.GetServerInfoData:InvokeServer("Holiday")
local emojes = {
	[""] = {""},
	["Christmas"] = {"🎄","❄️","🎆","🎇","🧊","☃️","⛄","🎁","🎅","⭐","✨"},
	["Halloween"] = {"🎃","💀","👻","🌕","🕸","🕷","⚰️","🔮"},
	["Easter"] = {"🐇","🥚","🍫","🔔","🐰"},
	["Cosmonautics"] = {"👨‍🚀","🚀","🌐","🌌","☀️","🪐"},
	["WRFDay"] = {"⚗️","🔬","🦠","👾","☢"}
}
local emoji = emojes[holiday][math.random(1,#emojes[holiday])]
local space = " "
if emoji == "" then
	space = ""
end
script.Parent.Text = game:GetService("ReplicatedStorage").GetServerInfoData:InvokeServer("PlaceVersion")..space..emoji