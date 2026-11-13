local screen = script.Parent
local s = screen.screen
local data = game:GetService("ServerScriptService").ServerInfo.Data

local active = false
local activated = false
local function Active(bool)
	s.Loading.Visible = not bool
	s.data.Text = tostring(data.Day.Value).."."..tostring(data.Month.Value).."."..tostring(data.Year.Value)
	s.data.Visible = bool
end

local i = 1
while wait(0.5) do
	if active == false then
		i+=1
		local t = {"",".","..","..."}
		if i> #t then
			i = 1
		end
		screen.screen.Loading.Text = "Соеденение с сервером"..t[i]
		if math.random(0,100)>=98 then
			active = true
		end
	else
		if active ~= activated then
			activated = active
			Active(active)
		end
	end
end