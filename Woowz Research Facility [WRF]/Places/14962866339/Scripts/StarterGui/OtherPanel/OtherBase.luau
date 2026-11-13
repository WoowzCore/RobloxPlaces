local panel = script.Parent
local gui = panel.Parent
local plr = game:GetService("Players").LocalPlayer
local chr = plr.Character or plr.CharacterAdded:Wait()
local base = require(chr:WaitForChild("PlayerBase"))

local opencredits = false
panel.background.list["6Back"].MouseButton1Click:Connect(function()
	base.GuiActives.Other = false
end)

panel.background.list["5Debug"].MouseButton1Click:Connect(function()
	base.GuiActives.Debug = not base.GuiActives.Debug
	base.GuiActives.Other = false
end)

panel.background.list["4Logs"].MouseButton1Click:Connect(function()
	base.GuiActives.Console = not base.GuiActives.Console
	base.GuiActives.Other = false
end)

panel.background.list["3Credits"].MouseButton1Click:Connect(function()
	opencredits = true
end)

panel.credits.Close.MouseButton1Click:Connect(function()
	opencredits = false
end)

panel.background.list["2Settings"].MouseButton1Click:Connect(function()
	if base.Settings.Loaded then
		base.GuiActives.Settings = true
		base.GuiActives.Other = false
	end
end)

panel.background.list["1AdminPanel"].MouseButton1Click:Connect(function()
	if base.Admin then
		base.GuiActives.Admin = not base.GuiActives.Admin
	end
	base.GuiActives.Other = false
end)

local Credits = {
	["credit.maindev"] = {1,"credit.maindev.desc",{"Woowz11"}},
	["credit.helper"] = {3,"credit.helper.desc",{"Wilson - P"}},
	["credit.idea"] = {4,"",{"Dexon"}},
	["credit.maintesters"] = {5,"credit.maintesters.desc",{"Wldoui","Cyberpaul red.","Nazar1k1337"}},
	["credit.testers"] = {6,"credit.testers.desc",{"PavkaLakar","Ne1roX","RussiaSupporter"}},
	["credit.jrtesters"] = {7,"credit.jrtesters.desc",{"nekitplay155","SetnaM","Sleeping Man","TheUnfinishedStory75","Beryx","thewindowskerpka","morphandriy"}},
	["credit.noobsdevs"] = {8,"credit.noobsdevs.desc",{"NightTheChosen","Cappucino"}},
	["credit.translates"] = {9,"credit.translates.desc",{"Woowz11 ("..base.t.g("other.language.rus")..")","Woowz11, Wilson ("..base.t.g("other.language.eng")..")",base.t.g("other.online-translator")..", NightTheChosen ("..base.t.g("other.language.nor")..")"}}
}

local function generatecredits()
	local titlenow = nil
	local titleobj = nil
	for title, content in pairs(Credits) do
		if titlenow ~= title then
			titlenow = title
			titleobj = script.Parent.Objs.ObjGroup:Clone()
			titleobj.Name = tostring(content[1]).."_"..titleobj.Name
			titleobj.Parent = script.Parent.credits.background.ScrollingFrame
			titleobj.Title.Text = base.t.g(title)
			if content[2] == "" then
				titleobj.TitleSmall:Destroy()
				titleobj.Line.Position = UDim2.new(0.05,0,0,100)
				titleobj.List.Position = UDim2.new(0.05,0,0,102)
			else
				titleobj.TitleSmall.Text = base.t.g(content[2])
			end
			titleobj.Visible = true
		end
		for _, human in pairs(content[3]) do
			local human_ = script.Parent.Objs.People:Clone()
			human_.Parent = titleobj.List
			human_.Name = human
			human_.Text = human
			human_.Visible = true
		end
	end
end
generatecredits()

while wait() do
	if panel.Enabled then
		panel.background.list["1AdminPanel"].Visible = base.Admin
		panel.background.list["5Debug"].Visible = base.Admin
		panel.background.list["4Logs"].Visible = base.Admin
		
		panel.background.Visible = not opencredits
		panel.credits.Visible = opencredits
	else
		opencredits = false
	end
end