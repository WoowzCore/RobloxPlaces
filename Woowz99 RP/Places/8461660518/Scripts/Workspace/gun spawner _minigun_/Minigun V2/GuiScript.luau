local Tool = script.Parent
local Ammo = Tool.Ammo
local MaxAmmo = Ammo.Value

local vPlayer
local Gui
local Text

function onChanged(value)
	if value == "Value" or value == Ammo.Value then
		if Gui ~= nil and Text ~= nil then
			if Ammo.Value >= 1 then
				Text.Text = ""..script.Parent.Ammo.Value.."|"..script.Parent.StoredAmmo.Value..""
			elseif math.floor(Ammo.Value) == 0 then
				Text.Text = ""..script.Parent.Ammo.Value.."|"..script.Parent.StoredAmmo.Value..""
			elseif Ammo.Value < 0 then
				for i = 0, 1, 0.03 / 2 do
					local Num = math.floor(i * MaxAmmo + 0.5)

					Text.Text = ""..script.Parent.Ammo.Value.."|"..script.Parent.StoredAmmo.Value..""
					wait()
				end
			end
		end
	end
end

function on2Changed()
	if Gui ~= nil and Text ~= nil then

		Text.Text = ""..script.Parent.Ammo.Value.."|"..script.Parent.StoredAmmo.Value..""
		wait()
	end
end

function setUpGui()
	if vPlayer == nil or vPlayer:findFirstChild("PlayerGui") == nil then
		return
	end

	Gui = Instance.new("ScreenGui")
	Text = Instance.new("TextLabel")

	Gui.Name = "DEDisplay"
	Gui.Parent = vPlayer.PlayerGui

	Text.BackgroundColor3 = BrickColor.Black().Color
   Text.BackgroundTransparency = 1
	Text.BorderColor3 = BrickColor.White().Color
   Text.BorderSizePixel = 0
	Text.Name = "Ammo"
	Text.Parent = Gui
	Text.Position = UDim2.new(0.15, 0, 0.825, 0)
	Text.Size = UDim2.new(0, -60, 0, 64)
   Text.FontSize = "Size18"
	Text.Text = ""..script.Parent.Ammo.Value.."|"..script.Parent.StoredAmmo.Value..""
	Text.TextColor3 = BrickColor.White().Color
end

function onEquippedLocal(mouse)
	vPlayer = game.Players.LocalPlayer

	setUpGui()
end

function onUnequippedLocal(mouse)
	if Gui then
		Gui:remove()
	end

	Gui = nil
	Text = nil
	vPlayer = nil
end

Tool.Equipped:connect(onEquippedLocal)
Tool.Unequipped:connect(onUnequippedLocal)

Ammo.Changed:connect(onChanged)
Tool.StoredAmmo.Changed:connect(on2Changed)