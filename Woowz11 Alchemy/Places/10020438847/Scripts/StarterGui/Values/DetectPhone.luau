local Values = script.Parent
local Value = Values.Player_in_Phone

local PlayerGui = Values.Parent

local MobileAsk = Values.Parent.ScreenGui.MobileAsk

local MA_yes = MobileAsk.yes
local MA_no = MobileAsk.no

local MA_yes_bool = false
local MA_no_bool = false

local AllScripts = {}

for _, script0 in pairs(PlayerGui:GetChildren()) do
	if script0:IsA("LocalScript") then
		table.insert(AllScripts,script0)
	else
		for _1, script2 in pairs(script0:GetChildren()) do
			if script2:IsA("LocalScript") then
				table.insert(AllScripts,script2)
			else
				for _2, script3 in pairs(script2:GetChildren()) do
					if script3:IsA("LocalScript") then
						table.insert(AllScripts,script3)
					else
						for _3, script4 in pairs(script3:GetChildren()) do
							if script4:IsA("LocalScript") then
								table.insert(AllScripts,script4)
							else
								for _4, script5 in pairs(script4:GetChildren()) do
									if script5:IsA("LocalScript") then
										table.insert(AllScripts,script5)
									else
										for _5, script6 in pairs(script5:GetChildren()) do
											if script6:IsA("LocalScript") then
												table.insert(AllScripts,script6)
											else
												for _6, script7 in pairs(script6:GetChildren()) do
													if script7:IsA("LocalScript") then
														table.insert(AllScripts,script7)
													end
												end
											end
										end
									end
								end
							end
						end
					end
				end
			end
		end
	end
end

for _, script1 in pairs(PlayerGui:WaitForChild("Scripts"):GetChildren()) do
	if script1:IsA("LocalScript") then
		table.insert(AllScripts,script1)
	end
end

function DisableAllScripts(bool)
	for _, scriptt in pairs(AllScripts) do
		if scriptt.Name ~= "VisualElementButton" and scriptt.Name ~= "DetectPhone" then
			scriptt.Disabled = bool
		end
	end
	PlayerGui:WaitForChild("AddElements").Disabled = bool
	PlayerGui:WaitForChild("DisableScreenGui").Disabled = bool
end

function MobileGuiRemove()
	local mobileGui = PlayerGui:FindFirstChild("TouchGui")
	if mobileGui ~= nil then
		mobileGui:Remove()
	end
end

function AskResult(result)
	MobileAsk.Visible = false
	if result == 1 then
		Values.Player_in_Phone.Value = false
	else
		Values.Player_in_Phone.Value = true
		MobileGuiRemove()
	end
	DisableAllScripts(false)
	MobileAsk.Parent.Parent.MainScreenGui.Enabled = true
end

function SetMobileUI()
	
end

function ButtonClick(button, result)	
	if button == "yes" then
		if MA_yes_bool == true then
			AskResult(result)
		end
		MA_yes_bool = true
		MA_yes.BackgroundColor3 = Color3.fromRGB(200,150,150)
	else
		if MA_no_bool == true then
			AskResult(result)
		end
		MA_no_bool = true
		MA_no.BackgroundColor3 = Color3.fromRGB(200,150,150)
	end
end

MA_yes.MouseButton1Click:Connect(function()
	ButtonClick("yes",0)
end)
MA_no.MouseButton1Click:Connect(function()
	ButtonClick("no",1)
end)

MobileAsk.Parent.Parent:WaitForChild("MainScreenGui").Enabled = false
MobileAsk.Parent.Enabled = true
MobileAsk.Parent.Parent:WaitForChild("NotScreenGui").Enabled = false
MobileAsk.Visible = true
--MobileGuiRemove()	