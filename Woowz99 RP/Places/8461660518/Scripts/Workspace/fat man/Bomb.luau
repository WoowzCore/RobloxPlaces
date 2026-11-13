local updateInterval = .4

local currentColor = 1
local colors = {26, 21} 

local ticksound = Instance.new("Sound")
ticksound.SoundId = "rbxasset://sounds\\clickfast.wav"
ticksound.Parent = script.Parent

function update()
	updateInterval = updateInterval * .9
	script.Parent.BrickColor = BrickColor.new(colors[currentColor])
	currentColor = currentColor + 1
	if (currentColor > 2) then currentColor = 1 end
end


function blowUp()
	local sound = Instance.new("Sound")		
	    sound.SoundId = "rbxasset://sounds\\Rocket shot.wav"
		sound.Parent = script.Parent
		sound.Volume = 10
		sound:play()
	 --find instigator tag
	local creator = script.Parent:findFirstChild("creator")
	if creator ~= nil then
	end
end

function onPlayerBlownUp(part, distance, creator)
	if part.Name == "Head" then
		local humanoid = part.Parent.Humanoid
		tagHumanoid(humanoid, creator)
	end
end

function tagHumanoid(humanoid, creator)
	-- tag does not need to expire iff all explosions lethal	
	if creator ~= nil then
		local new_tag = creator:clone()
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

while updateInterval > .05 do
	wait(updateInterval)
	update()	
	ticksound:play()	
end

blowUp()
script.Parent.Transparency = 1
