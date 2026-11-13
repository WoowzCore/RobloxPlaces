local light = game:GetService("Lighting")
light.LoadingScreen.Enabled = true
local plr = script.Parent.Parent.Parent
local sgui = game:GetService("StarterGui")
local gui = script.Parent
gui.t2.Visible = false
gui.t3.Visible = false
gui.t4.Visible = false
gui.t5.Visible = false
gui.t6.Visible = false
gui.t7.Visible = false
gui.t8.Visible = false
gui.t9.Visible = false
gui.Enabled = true

sgui:SetCoreGuiEnabled(Enum.CoreGuiType.All,false)
local loaded_player = false
local loading_assets = false
local j = 0
local totalj = 0
local loading_symbol_i = 0

local loading_symbols = {
	[0] = "|",
	[1] = "/",
	[2] = "-",
	[3] = "\\"
}
local upd = game:GetService("RunService").RenderStepped:Connect(function(dt)
	j+=1
	if not loading_assets then
		totalj += 1
	end
	if j >= 10 then
		j = 0
		loading_symbol_i += 1
		if loading_symbol_i >= 4 then
			loading_symbol_i = 0
		end
	end
	
	if loaded_player then
		gui.t5.Text = "Dанниtе на поtреjиtеля са кас'ени! ["..plr.Name.."]"
		
		if loading_assets then
			gui.t7.Text = "Симулак'ияtа е кас'ена! ["..tostring(math.round(totalj)).." tps]"
		else
			gui.t7.Text = "Зареs/dане на симулак'ия: "..loading_symbols[loading_symbol_i]
		end
	else
		gui.t5.Text = "Зареs/dане на поtреjиtелски dанни: "..loading_symbols[loading_symbol_i]
	end
end)
gui.Sound:Play()
gui.t2.Visible = true
gui.t3.Visible = true
gui.t4.Visible = true
gui.t5.Visible = true
gui.t9.Visible = true

repeat wait() until plr.Character ~= nil
loaded_player = true
local chr = plr.Character or plr.CharacterAdded:Wait()
local base = require(chr:WaitForChild("PlayerBase"))

local function stoploading()
	if base.BaseDontDestroy.LoadingScreen == false then return end
	light.LoadingScreen.Enabled = false
	gui.Enabled = false
	sgui:SetCoreGuiEnabled(Enum.CoreGuiType.All,true)
	sgui:SetCoreGuiEnabled(Enum.CoreGuiType.Backpack,false)
	sgui:SetCoreGuiEnabled(Enum.CoreGuiType.Health,false)
	sgui:SetCoreGuiEnabled(Enum.CoreGuiType.EmotesMenu,false)
	upd:Disconnect()
	gui.Sound:Stop()
	gui.SoundEnd:Play()
	base.BaseDontDestroy.LoadingScreen = false
end

game:GetService("UserInputService").InputBegan:Connect(function(key)
	if key.KeyCode == Enum.KeyCode.Space then
		stoploading()
	end
end)

gui.t6.Visible = true
gui.t7.Visible = true
gui.t8.Visible = true

local cp = game:GetService("ContentProvider")
local assets = workspace:GetDescendants()
for i = 1, #assets do
	if base.BaseDontDestroy.LoadingScreen == false then return end
	gui.SoundBeep:Play()
	gui.t8.Text = "Зареs/dане на симулак'ионни оjекtи: "..tostring(math.round(i)).." / "..tostring(math.round(#assets))
	local asset = assets[i]
	cp:PreloadAsync({asset})
	
	if i == #assets then
		loading_assets = true
		gui.t8.Text = "Изпvлнение на симулак'ияtа!"
		task.wait(2)
	end
end

stoploading()