local module = {}

--vvv Made by Anaminus vvv---
local function NumNormal(n)
	return n == 0 and 0 or n/math.abs(n)
end

function module.surface(part,point)
	local p = part.CFrame:toObjectSpace(CFrame.new(point)).p
	local s = part.Size
	local ax,ay,az = math.abs(p.x/s.x),math.abs(p.y/s.y),math.abs(p.z/s.z)
	return Vector3.new(NumNormal(p.x),NumNormal(p.y),NumNormal(p.z)) * Vector3.new(
		(ax>ay and ax>az) and 1 or 0,
		(ay>ax and ay>az) and 1 or 0,
		(az>ax and az>ay) and 1 or 0
	)
end
--^^^ Made by Anaminus ^^^---

function module.getSide(p,s)
	local cf = p.CFrame
	if s.x > 0 then
		return (cf*CFrame.fromAxisAngle(Vector3.new(0,-1,0),math.pi/2)).lookVector
	elseif s.x < 0 then
		return (cf*CFrame.fromAxisAngle(Vector3.new(0,1,0),math.pi/2)).lookVector
	end
	
	if s.y < 0 then
		return (cf*CFrame.fromAxisAngle(Vector3.new(-1,0,0),math.pi/2)).lookVector
	elseif s.y > 0 then
		return (cf*CFrame.fromAxisAngle(Vector3.new(1,0,0),math.pi/2)).lookVector
	end
	
	if s.z < 0 then
		return cf.lookVector
	elseif s.z > 0 then
		return -cf.lookVector
	end
end

function module.debounce(func)
	local debounce = false
	return function(...)
		if not debounce then
			debounce = true
			func(...)
			debounce = false
		end
	end
end

function module.part(p)
	local parts = {}
	local function getParts(m)
		for _,v in pairs(m:GetChildren()) do
			if v:IsA("Part") and v ~= p then
				table.insert(parts,#parts+1,v)
			elseif v:IsA("Model") then
				getParts(v)
			end
		end
	end
	getParts(game.Workspace)
	local winner = {}
	for _,q in pairs(parts) do
		local mag = (q.Position-p.Position).magnitude
		if mag < winner[1] then
			winner[1] = mag
			winner[2] = q
		end
	end
	return winner[2]
end

function module.weld(p1,p2)
	local w = Instance.new("Weld")
	w.Part0 = p1
	w.Part1 = p2
	w.C0 = p1.CFrame:inverse() * p2.CFrame
	w.Parent = p1
	return w
end
return module