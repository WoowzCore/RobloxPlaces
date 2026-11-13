local rs = game:GetService("ReplicatedStorage")
local plr = game:GetService("Players").LocalPlayer
local chr = plr.Character or plr.CharacterAdded:Wait()
local base = require(chr:WaitForChild("PlayerBase"))
while wait(1) do	
	function Format(Int)
		return string.format("%02i", Int)
	end

	function convertToHMS(Seconds)
		local Minutes = (Seconds - Seconds%60)/60
		Seconds = Seconds - Minutes*60
		local Hours = (Minutes - Minutes%60)/60
		Minutes = Minutes - Hours*60
		local Days = (Hours - Hours%24)/24
		Hours = Hours - Days*24
		return Format(Seconds)..":"..Format(Minutes)..":"..Format(Hours)..":"..Format(Days)
	end
	
	script.Parent.Text = base.t.g("debug.serverage")..convertToHMS(rs.GetServerInfoData:InvokeServer("Age"))
end