local Item = script.Parent.Parent

local Light = Item.Light
local LightLight2 = Item.Light.Light2
local LightLight = Light.Light

local SavedColor = Light.Color
local SavedMaterial = Light.Material

local Activate = true

local function SetOff()
	LightLight.Enabled = false
	LightLight2.Enabled = false
	Light.Material = Enum.Material.Glass
	Light.Color = Color3.fromRGB(45,45,45)
end
local function SetOn()
	LightLight.Enabled = true
	LightLight2.Enabled = true
	Light.Material = SavedMaterial
	Light.Color = SavedColor
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