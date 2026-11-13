-- Waits for the child of the specified parent
local function WaitForChild(parent, childName)
	while not parent:FindFirstChild(childName) do parent.ChildAdded:wait() end
	return parent[childName]
end

local Tool = script.Parent

local Animations = {}
local MyHumanoid
local MyCharacter


local function PlayAnimation(animationName)
	if Animations[animationName] then
		Animations[animationName]:Play()
	end
end

local function StopAnimation(animationName)
	if Animations[animationName] then
		Animations[animationName]:Stop()
	end
end


function OnEquipped(mouse)
	MyCharacter = Tool.Parent
	MyHumanoid = WaitForChild(MyCharacter, 'Humanoid')
	if MyHumanoid then
		Animations['EquipAnim'] = MyHumanoid:LoadAnimation(WaitForChild(Tool, 'EquipAnim5'))
		Animations['IdleAnim'] = MyHumanoid:LoadAnimation(WaitForChild(Tool, 'IdleAnim3'))
		Animations['OverheadAnim'] = MyHumanoid:LoadAnimation(WaitForChild(Tool, 'OverheadAnim2'))
		Animations['SlashAnim'] = MyHumanoid:LoadAnimation(WaitForChild(Tool, 'SlashAnim2'))
		Animations['ThrustAnim'] = MyHumanoid:LoadAnimation(WaitForChild(Tool, 'ThrustAnim2'))
		Animations['UnequipAnim'] = MyHumanoid:LoadAnimation(WaitForChild(Tool, 'UnequipAnim2'))
	end
	PlayAnimation('EquipAnim')
	PlayAnimation('IdleAnim')
end

function OnUnequipped()
	for animName, _ in pairs(Animations) do
		StopAnimation(animName)
	end
end

Tool.Equipped:connect(OnEquipped)
Tool.Unequipped:connect(OnUnequipped)

WaitForChild(Tool, 'PlaySlash').Changed:connect(
	function (value)
		--if value then
			PlayAnimation('SlashAnim')
		--else
		--	StopAnimation('SlashAnim')
		--end
	end)

WaitForChild(Tool, 'PlayThrust').Changed:connect(
	function (value)
		--if value then
			PlayAnimation('ThrustAnim')
		--else
		--	StopAnimation('ThrustAnim')
		--end
	end)

WaitForChild(Tool, 'PlayOverhead').Changed:connect(
	function (value)
		--if value then
			PlayAnimation('OverheadAnim')
		--else
		--	StopAnimation('OverheadAnim')
		--end
	end)
