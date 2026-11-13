local basa = require(script.Parent:WaitForChild("PlayerBasa"))

local function ShakeCamera(p)
	if p == 0 then
		basa.CameraShake = Vector3.zero
	else
		local power = p
		local x,y,z = math.random(-power,power)/500, math.random(-power,power)/500, math.random(-power,power)/500
		basa.CameraShake = Vector3.new(x,y,z)
	end
end

local function ShakeCameraFull()
	local scdata = game.ReplicatedStorage.GetServerData:InvokeServer()["CameraShakeData"]
	local power = 0
	local result = 0
	for _, data in pairs(scdata) do
		power = data["p"] or 0
		local p = data["d"]/math.max((basa.Camera.CFrame.Position-data["pos"]).magnitude,1)*power
		result += p
	end
	ShakeCamera(result)
end

while wait() do
	if basa.Loaded then
		ShakeCameraFull()
	end
end
