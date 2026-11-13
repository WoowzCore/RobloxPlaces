local EBL = require(game:GetService("ServerScriptService"):WaitForChild("EBLibbary"))

local timer = 0
local timerrand = 0

function PlaySound()
	if math.random(0,100) > 85 then
		local sound = EBL.CreppySound[math.random(1,#EBL.CreppySound)]
		for _, plr in pairs(game.Players:GetPlayers()) do
			EBL.PlaySound(plr,sound,1,nil,{8,0})	
		end
	else
		local plrs = game.Players:GetPlayers()
		if plrs == nil or #plrs <= 0 or EBL.CreppySound == nil then return end
		EBL.PlaySound(plrs[math.random(1,#plrs)],EBL.CreppySound[math.random(1,#EBL.CreppySound)],1,nil,{8,0})	
		
	end
	timerrand = math.random(100,5000)
	timer = 0
end

while wait() do
	if not EBL.GetSettingValue("PlayingScarySounds",true) then return end
	timer += 1
	if timer >= timerrand then
		PlaySound()
	end
end