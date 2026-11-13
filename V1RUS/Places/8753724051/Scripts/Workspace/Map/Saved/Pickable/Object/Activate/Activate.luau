local Item = script.Parent.Parent

local FirePartical = Item.Fireplace.Fire
local FireLight = Item.Fireplace.FireLight

local Activate = true

local function SetOff()
	FirePartical.Enabled = false
	FireLight.Enabled = false
end
local function SetOn()
	FirePartical.Enabled = true
	FireLight.Enabled = true
end

local function SetActive(bool)
	Activate = bool
	if bool then
		SetOn()
	else
		SetOff()
	end
end

local function Active()
	SetActive(not Activate)
end
Active()

script.Parent.ActivateEvent.Event:Connect(Active)
script.Parent.SetActivateEvent.Event:Connect(SetActive)