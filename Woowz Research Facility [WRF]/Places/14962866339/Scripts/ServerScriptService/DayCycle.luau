local base = require(script.Parent.Base)
local data = script.Parent.ServerInfo.Data
local light = game:GetService("Lighting")

local date = os.date("!*t",os.time()+60*60*3)
local day_ = date.day

local mounth_ = date.month

--Christmas Halloween Easter Cosmonautics WRFDay

-- 20-31 10 Halloween
-- 20-31 12 & 1-8 1 Christmas
-- 21-31 3 & 1-25 4 Easter
-- 12 4 Cosmonautics
-- 4 10 WRFDay

local function SetHoliday()
	local holiday = ""

	if day_ >= 20 and mounth_ == 10 then
		holiday = "Halloween"
	end

	if (day_ >= 20 and mounth_ == 12) or (day_ <= 8 and mounth_ == 1) then
		holiday = "Christmas"
	end 

	if (day_ >= 21 and mounth_ == 3) or (day_ <= 25 and mounth_ == 4) then
		holiday = "Easter"
	end

	if day_ == 12 and mounth_ == 4 then
		holiday = "Cosmonautics"
	end

	if day_ == 4 and mounth_ == 10 then
		holiday = "WRFDay"
	end

	data.Holiday.Value = holiday
end
script.Parent.SetHoliday.Event:Connect(SetHoliday)

while wait() do
	date = os.date("!*t",os.time()+60*60*3)
	
	local day = date.day
	local mounth = date.month
	local year = date.year
	local s = date.sec
	local m = date.min
	local h = date.hour
	
	data.Hour.Value = h
	data.Minute.Value = m
	data.Second.Value = s
	light.TimeOfDay = h..":"..m..":"..s
	if string.len(day)==1 then
		day = "0"..day
	end
	if string.len(mounth)==1 then
		mounth = "0"..mounth
	end
	base.SetData(day,mounth,year+5)
end