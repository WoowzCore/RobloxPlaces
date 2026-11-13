local base = require(script.Parent.Base)
local players = game:GetService("Players")
local sound = {
	"234813665","9111868149","8232978517","8232976983","8734471313","9084543492","9120454922",
	"9113744767","9119452434","4843088994","1296864907","9113840530","9116432084","966888080",
	"1313018532","8234125536","9113201934","8110725602","5083035644","7924080681","1416343052",
	"7924941851","9119397579","3179847853","5133603058","9117009473","9118052156","9118053865",
	
	"6302642278","542336227","5677129907","2390698929","8399963468","8399972150","8399987978",
	"8399968474","966888146","8312994232","9113948545","9114574159","9119410377","9126176334",
}

wait(10)
while true do
	wait(math.random(1,40))
	local playerstable = players:GetPlayers()
	if playerstable ~= nil and #playerstable ~= 0 then
		local plr = playerstable[math.random(1,#playerstable)]
		if plr == nil then return end
		local chr = plr.Character or plr.CharacterAdded:Wait()
		local root = chr:FindFirstChild("HumanoidRootPart")
		if root then
			local soundphysic = base.PlaySound(sound[math.random(1,#sound)],root.Position,math.random(1,10)/10,math.random(5,500),math.random(80,120)/100)
		end	
	end
end

--[[

Норм музыка!!!!!!!!

1837841399, 1836406623, 1840753146, 1836252301

]]