ball = script.Parent
damage = math.random(30,50)
local hitt = false

HitSound = Instance.new("Sound")
HitSound.Name = "HitSound"
HitSound.SoundId = "http://www.roblox.com/asset/?id=11945266"
HitSound.Pitch = .8
HitSound.Volume = 1
HitSound.Parent = ball

function onTouched(hit)
	if hit.Parent:findFirstChild("ForceField") ~= nil then return end
	if hit.CanCollide == false and hit.Parent:findFirstChild("Humanoid") == nil then return end
	if hit.Parent.className == "Hat" and hitt == false then
		hitt = true
		hit:BreakJoints()
		hit.Velocity = ball.Velocity
		hit.Parent.Parent = game.Workspace
	end

	if hit:findFirstChild("Metal") ~= nil and hitt == false then
		hitt = true
		for i = 1,math.random(1,3) do
			local j = Instance.new("Part")
			j.formFactor = "Plate"
			j.Size = Vector3.new(1,.4,1)
			j.BrickColor = BrickColor.new("Bright yellow")
			j.CanCollide = false
			j.Velocity = Vector3.new(math.random(-10,10),math.random(-10,10),math.random(-10,10))
			j.CFrame = script.Parent.CFrame
			j.Parent = game.Workspace
		end
	end

	local humanoid = hit.Parent:findFirstChild("Humanoid")

	if humanoid ~= nil and hitt == false then
		hitt = true
		tagHumanoid(humanoid)
		if hit.Name == "Head" then
			humanoid.Health = humanoid.Health - damage * 2
		elseif hit.Name == "Torso" then
			humanoid.Health = humanoid.Health - damage * 1.5
		else
			humanoid.Health = humanoid.Health - damage
		end
		wait(.2)
		untagHumanoid(humanoid)
	end
	if hitt == true then
		HitSound:play()
		ball.Parent = nil
	end
end

function tagHumanoid(humanoid)
	-- todo: make tag expire
	local tag = ball:findFirstChild("creator")
	if tag ~= nil then
		local new_tag = tag:clone()
		new_tag.Parent = humanoid
	end
end


function untagHumanoid(humanoid)
	if humanoid ~= nil then
		local tag = humanoid:findFirstChild("creator")
		if tag ~= nil then
			tag.Parent = nil
		end
	end
end

connection = ball.Touched:connect(onTouched)

while true do
wait(.01)
if damage < 0 then
break
else
damage = damage - .5
end
end

ball.Parent = nil