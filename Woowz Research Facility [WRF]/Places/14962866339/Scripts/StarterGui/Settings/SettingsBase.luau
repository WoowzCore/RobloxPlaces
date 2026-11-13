local plrser = game:GetService("Players")
local plr = plrser.LocalPlayer
local chr = plr.Character or plr.CharacterAdded:Wait()
local base = require(chr:WaitForChild("PlayerBase"))
local panel = script.Parent.background

local function deepCopy(original)
	local copy = {}
	for k, v in pairs(original) do
		if type(v) == "table" then
			v = deepCopy(v)
		end
		copy[k] = v
	end
	return copy
end

repeat wait() until base.Settings.Loaded
local settings_ = require(plr:WaitForChild("PlayerScripts").Settings)
local settings_old = deepCopy(settings_)
base.BaseDontDestroy.OldSettings = settings_old
local rs = game:GetService("ReplicatedStorage")

local Changed = false

panel.closesettings.MouseButton1Click:Connect(function()
	if Changed then return end
	base.GuiActives.Settings = false
end)

local category = ""

local categoryinfo = {
	["other"] = base.t.g("settings.other"),
	["debug"] = base.t.g("settings.debug"),
	["private"] = base.t.g("settings.private"),
	["gameplay"] = base.t.g("settings.game"),
	["optimization"] = base.t.g("settings.optimization"),
	["graphic"] = base.t.g("settings.graphic"),
	["keys"] = base.t.g("settings.keys")
}

local function SetCategory(c)
	if c == category then return end
	if Changed then return end
	category = c
	local info = categoryinfo[c]
	panel.category.Text = info

	for _, setting in pairs(panel.background_background.ScrollingFrame.Settings:GetChildren()) do
		if setting:IsA("Frame") then
			setting.Visible = (setting.category.Value == c)
		end
	end
end

for _, p in pairs(panel:GetChildren()) do
	if p.Name == "category_button" then
		p.MouseButton1Click:Connect(function()
			SetCategory(p.Value.Value)
		end)
	end
end

local function updatechanged()
	if Changed then
		panel.save.BackgroundColor3 = Color3.fromRGB(98, 255, 0)
		panel.save.TextColor3 = Color3.fromRGB(1, 65, 0)
		panel.save.Text = base.t.g("settings.save")
	else
		panel.save.BackgroundColor3 = Color3.fromRGB(106, 106, 106)
		panel.save.TextColor3 = Color3.fromRGB(70, 70, 70)
		panel.save.Text = base.t.g("settings.cantsave")
	end
end
panel.save.Text = base.t.g("settings.cantsave")

local function checkchanged()
	local changed = false
	for _, p in pairs(panel.background_background.ScrollingFrame.Settings:GetChildren()) do
		if p:IsA("Frame") then
			for _,psmol in pairs(p:GetChildren()) do
				if psmol:IsA("Frame") and psmol.Name ~= "setting_name" then
					if psmol.Value.Value ~= psmol.FirstValue.Value then
						changed = true
					end
				end
			end
		end
	end
	script.Parent.ChangedValue.Value = changed
	Changed = changed
	updatechanged()
end

local function Save()
	if not Changed then return end
	
	for _, p in pairs(panel.background_background.ScrollingFrame.Settings:GetDescendants()) do
		if p.Name == "ChangedValue" then
			if p.Value == true then
				p.Parent.FirstValue.Value = p.Parent.Value.Value
				local dataposition = string.split(p.Parent.valueid.Value,".")
				local i = 0
				local result = settings_
				while i < (#dataposition-1) do
					i+=1
					result = result[dataposition[i]]
				end
				local val = p.Parent.Value.Value
				if string.find(tostring(val),"%(KEYCODE%)") then
					val = Enum.KeyCode[string.gsub(val,"%(KEYCODE%)","")]
				end
				result[dataposition[#dataposition]] = val
			end
		end
	end
	checkchanged()
	updatechanged()
end

local function Reset(obj,apply,fulldefalut)
	if apply == nil then apply = false end
	if fulldefalut == nil then fulldefalut = true end
	for _, p in pairs(obj:GetDescendants()) do
		if p.Name == "DefaultValue" then
			local result = p.Value
			if not fulldefalut then
				result = p.Parent.FirstValue.Value
			end
			p.Parent.Value.Value = p.Value
			if apply then
				p.Parent.FirstValue.Value = result
			end
			if p.Parent:FindFirstChild("Reset") then
				p.Parent:FindFirstChild("Reset"):Fire()
			end
		end
	end
	checkchanged()
	updatechanged()
end

chr:WaitForChild("Humanoid"):GetPropertyChangedSignal("Health"):Connect(function()
	if chr:WaitForChild("Humanoid").Health <= 0 then
		for _, p in pairs(panel.background_background.ScrollingFrame.Settings:GetChildren()) do
			Reset(p,true,false)
		end
	end
end)

panel.save.MouseButton1Click:Connect(function()
	Save()
end)

local function GetValue(s,def)
	local result = def
	local str = string.split(s,".")
	local mainsetting,setting = str[1],str[2]

	result = settings_[mainsetting][setting]
	
	if typeof(result) == "EnumItem" then
		result = "(KEYCODE)"..string.split(tostring(result),".")[#string.split(tostring(result),".")]
	end
	
	return result
end

local function CreateSetting(id,info)	
	local setting = script.Parent.Values.setting:Clone()
	setting.Parent = panel.background_background.ScrollingFrame.Settings
	setting.Name = base.t.g(info[1])
	setting.category.Value = info[2]
	setting.id.Value = id
	setting.setting_name.setting_name.Text = base.t.g(info[1])
	setting.setting_name.reset.MouseButton1Click:Connect(function()
		Reset(setting)
	end)

	local function CreateSmolSetting(ss)
		local ss_type = ss[2]
		local ss_object = script.Parent.Values:FindFirstChild(ss_type):Clone()
		setting.Size = UDim2.new(setting.Size.X.Scale,setting.Size.X.Offset,0,setting.Size.Y.Offset+ss_object.Size.Y.Offset+panel.background_background.ScrollingFrame.Settings.UIListLayout.Padding.Offset)
		ss_object.Parent = setting
		ss_object.Name = base.t.g(ss[3])
		ss_object.value_name.Text = base.t.g(ss[3])
		if typeof(ss[4]) == "EnumItem" then
			ss[4] = "(KEYCODE)"..string.split(tostring(ss[4]),".")[#string.split(tostring(ss[4]),".")]
		end
		ss_object.DefaultValue.Value = ss[4]

		ss_object.FirstValue.Value = GetValue(ss[1],ss[4])
		ss_object.Value.Value = GetValue(ss[1],ss[4])

		ss_object.valueid.Value = ss[1]

		if ss_type == "slider" then
			ss_object.ValueLeft.Value = ss[5][1]
			ss_object.ValueRight.Value = ss[5][2]
			ss_object.ValueDel.Value = ss[5][3]
		end

		ss_object.LocalScript.Enabled = true
		ss_object.Visible = true
		ss_object.reset.MouseButton1Click:Connect(function()
			Reset(ss_object)
		end)

		local function v()
			if ss_object.Value.Value ~= ss_object.FirstValue.Value then
				ss_object.ChangedValue.Value = true
				ss_object.BackgroundColor3 = Color3.fromRGB(147, 70, 70)
				script.Parent.ChangedValue.Value = true
				Changed = true
				updatechanged()
			else
				ss_object.ChangedValue.Value = false
				ss_object.BackgroundColor3 = Color3.fromRGB(147, 147, 147)
				checkchanged()
			end
			
			if settings_.Debug.ImmediatelySave and Changed then
				Save()
			end
		end
		ss_object.Value:GetPropertyChangedSignal("Value"):Connect(v)
		ss_object.FirstValue:GetPropertyChangedSignal("Value"):Connect(v)
	end

	for _, ss in pairs(info["settings"]) do
		CreateSmolSetting(ss)
	end
end

local settings_info = {
	["mirrorwork"] = {"settings.mirror","optimization",["settings"] = {{"Optimization.WorkedMirrors","checkbox","settings.mirror.enabled",false},{"Optimization.MirrorsUpdate","slider","settings.mirror.update",10,{0,100,1}}}},
	["globalshadow"] = {"settings.globalshadow","optimization",["settings"] = {{"Optimization.GlobalShadows","checkbox","settings.globalshadow.on",true}}},
	["shadows"] = {"settings.shadows","optimization",["settings"] = {{"Optimization.SirensShadows","checkbox","settings.sirenshadows",true},{"Optimization.SmolThingsShadows","checkbox","settings.smolthingsshadows",true},{"Optimization.LightingShadows","checkbox","settings.lightshadows",true}}},

	["showflag"] = {"settings.flag","private",["settings"] = {{"Privacity.ShowFlag","checkbox","settings.flag.enabled",true}}},
	["shownicknamedata"] = {"settings.nickdata","private",["settings"] = {{"Privacity.ShowFps","checkbox","settings.nickdata.fps",true},{"Privacity.ShowPing","checkbox","settings.nickdata.ping",true},{"Privacity.ShowGraphics","checkbox","settings.nickdata.graphic",true}}},
	
	["immediately_save"] = {"settings.autosave","debug",["settings"] = {{"Debug.ImmediatelySave","checkbox","settings.autosave.enabled",false}}},
	
	["colorcorrection"] = {"settings.cc","other",["settings"] = {{"Other.ColorCorrectionContrast","slider","settings.cc.contrast",0,{-10,10,1}},{"Other.ColorCorrectionSaturation","slider","settings.cc.saturation",0,{-10,10,1}},{"Other.ColorCorrectionBlackWhite","checkbox","settings.cc.whiteblack",false},{"Other.ColorCorrectionInverse","checkbox","settings.cc.inverse",false},{"Other.ColorCorrectionBlur","slider","settings.cc.blur",0,{0,10,0}}}},
	
	["sounds"] = {"settings.sounds","gameplay",["settings"] = {{"Gameplay.TinnitusEnabled","checkbox","settings.sounds.tinnitus",true}}},
	["camera"] = {"settings.camera","gameplay",["settings"] = {{"Gameplay.CustomCamera","checkbox","settings.camera.smooth",true},{"Gameplay.ShakeMultiplier","slider","settings.camera.shaker",1,{0,1,0}}}},
	
	["enable_dof"] = {"settings.dof","graphic",["settings"] = {{"Graphic.DOF","checkbox","settings.dof.enabled",true}}},
	["enable_bloom"] = {"settings.bloom","graphic",["settings"] = {{"Graphic.Bloom","checkbox","settings.bloom.enabled",true}}},
	["enable_specular"] = {"settings.specular","graphic",["settings"] = {{"Graphic.SpecularScale","slider","settings.specular.power",4,{0,10,1}}}},
	["brightness"] = {"settings.brigh","graphic",["settings"] = {{"Graphic.Brightness","slider","settings.brigh.power",0,{-1,1,0}}}},
	
	["key_item"] = {"settings.keys.item","keys",["settings"] = {{"Keys.DropItem","keycode","keys.dropitem",Enum.KeyCode.G}}},
	["key_hotbar"] = {"settings.keys.hotbar","keys",["settings"] = {{"Keys.Item1","keycode","keys.item1",Enum.KeyCode.One},{"Keys.Item2","keycode","keys.item2",Enum.KeyCode.Two},{"Keys.Item3","keycode","keys.item3",Enum.KeyCode.Three},{"Keys.Item4","keycode","keys.item4",Enum.KeyCode.Four},{"Keys.Item5","keycode","keys.item5",Enum.KeyCode.Five},{"Keys.Item6","keycode","keys.item6",Enum.KeyCode.Six},{"Keys.Item7","keycode","keys.item7",Enum.KeyCode.Seven},{"Keys.Item8","keycode","keys.item8",Enum.KeyCode.Eight},{"Keys.Item9","keycode","keys.item9",Enum.KeyCode.Nine},{"Keys.Item10","keycode","keys.item0",Enum.KeyCode.Zero}}},
	["key_movement"] = {"settings.keys.movement","keys",["settings"] = {{"Keys.MoveFront","keycode","keys.move.front",Enum.KeyCode.W},{"Keys.MoveBack","keycode","keys.move.back",Enum.KeyCode.S},{"Keys.MoveRight","keycode","keys.move.right",Enum.KeyCode.D},{"Keys.MoveLeft","keycode","keys.move.left",Enum.KeyCode.A},{"Keys.Jump","keycode","keys.jump",Enum.KeyCode.Space},{"Keys.WalkFast","keycode","keys.run",Enum.KeyCode.LeftShift},{"Keys.WalkSlow","keycode","keys.slowwalk",Enum.KeyCode.LeftControl},{"Keys.Crawl","keycode","keys.crawl",Enum.KeyCode.C},{"Keys.Ragdoll","keycode","keys.ragdoll",Enum.KeyCode.X}}},
	["key_gui"] = {"settings.keys.gui","keys",["settings"] = {{"Keys.VisibleGui","keycode","keys.hideui",Enum.KeyCode.F2},{"Keys.SettingsKey","keycode","keys.settings",Enum.KeyCode.F1},{"Keys.Admin","keycode","keys.admin",Enum.KeyCode.F5},{"Keys.Log","keycode","keys.logs",Enum.KeyCode.F8},{"Keys.Help","keycode","keys.help",Enum.KeyCode.F4},{"Keys.Debug","keycode","keys.debug",Enum.KeyCode.F6}}},
	["key_other"] = {"settings.keys.other","keys",["settings"] = {{"Keys.AttackMode","keycode","keys.attack",Enum.KeyCode.Q},{"Keys.Scream","keycode","keys.scream",Enum.KeyCode.E},{"Keys.Zoom","keycode","keys.zoom",Enum.KeyCode.F},{"Keys.Die","keycode","keys.die",Enum.KeyCode.N}}}
}

for id, info in pairs(settings_info) do
	CreateSetting(id,info)
end

SetCategory("gameplay")