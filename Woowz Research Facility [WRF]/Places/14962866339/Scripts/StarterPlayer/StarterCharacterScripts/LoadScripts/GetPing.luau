local base = require(script.Parent:WaitForChild("PlayerBase"))
local rs = game:GetService("ReplicatedStorage")
wait(5)
while wait(1) do
	local start = time()
	rs.Other.Ping:InvokeServer()
	local ping = ((time() - start)*1000)
	base.PING = math.floor(ping)
end