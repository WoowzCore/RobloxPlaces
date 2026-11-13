local sbasa = {}

sbasa.CameraShakeData = {}

function sbasa.AddShakeData(name : string,pos : Vector3,p : number,d : number)
	sbasa.CameraShakeData[name] = {["pos"] = pos, ["p"] = p , ["d"] = d}
end

function sbasa.RemoveShakeData(name : string)
	if sbasa.CameraShakeData[name] ~= nil then
		sbasa.CameraShakeData[name] = nil
	else
		warn(name.." shake data not exsist")
	end
end

game.ReplicatedStorage.GetServerData.OnServerInvoke = function()
	return sbasa
end

return sbasa
