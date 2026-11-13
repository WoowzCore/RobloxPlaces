local timer = script.Parent

local hour = 0
local minut = 0
local second = 0

local function UpdateText()
	local zero_h = "0"
	local zero_m = "0"
	local zero_s = "0"
	
	if hour >= 10 then
		zero_h = ""
	end
	if minut >= 10 then
		zero_m = ""
	end
	if second >= 10 then
		zero_s = ""
	end
	
	timer.Text = zero_h..tostring(hour)..":"..zero_m..tostring(minut)..":"..zero_s..tostring(second)
end

local oldactive = false
while wait(1) do
	if oldactive ~= script.Parent.Parent.Enabled then
		oldactive = script.Parent.Parent.Enabled
		second = 0
		minut = 0
		hour = 0
		UpdateText()
	end
	
	if oldactive then
		second += 1
		if second > 59 then
			second = 0
			minut += 1
		end
		if minut > 59 then
			minut = 0
			hour += 1
		end
		if hour > 99 then
			second = 0
			minut = 0
			hour = 0
		end
		UpdateText()
	end
end