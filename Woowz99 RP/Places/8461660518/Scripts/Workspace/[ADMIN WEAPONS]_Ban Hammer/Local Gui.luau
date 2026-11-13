print(script)
local Tool = script.Parent;
print(Tool)

local h = Tool.Parent:FindFirstChild("Humanoid")

local keepLooping = true

function onEquippedLocal(mouse)

	keepLooping = true

	if mouse == nil then
		print("Mouse not found")
		return 
	end

	while keepLooping do
		while Tool.Enabled do
			if not keepLooping then return end
			wait(.01)
		end
		
		print("Setting Mouse To Wait")

		while not Tool.Enabled do
			if not keepLooping then return end
			wait(.01)
		end

		print("Setting Mouse To Go")
	end

	keepLooping = true
end

function onUnequippedLocal()
	keepLooping = false
end


function onActivated()
	if not Tool.Enabled then return end
	local vChar = Tool.Parent
	if vChar == nil then return end
	
	local hum = vChar:FindFirstChild("Humanoid")
	if hum == nil then return end

	--wait(1)
	
	print(Tool.BANNED)
	BruceBANner = hum:LoadAnimation(Tool.BANNED)
	BruceBANner:Play()
end

Tool.Activated:connect(onActivated)
Tool.Equipped:connect(onEquippedLocal)
Tool.Unequipped:connect(onUnequippedLocal)
