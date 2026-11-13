local players = game:GetService("Players")
local rs = game:GetService("ReplicatedStorage")
local player = players.LocalPlayer
local base = require(script.Parent:WaitForChild("PlayerBase"))

local function Upd(ui,ad,data)
	if ui.Enabled == true then 
		local icon1,icon2,icon3 = ui.Top.Icon1,ui.Top.Icon2,ui.Top.Icon3
		icon1.Visible = false
		icon2.Visible = false
		icon3.Visible = false

		local whoi = ui.Parent.Admin.Value
		if whoi == "admin" or whoi == "mainadmin" or whoi == "dev" or whoi == "premium" then
			icon1.Visible = true
			local icons = {
				["admin"] = "rbxassetid://15148824516",
				["mainadmin"] = "rbxassetid://15148823152",
				["dev"] = "rbxassetid://15148822170",
				["premium"] = "rbxassetid://15313749370"
			}
			icon1.Image = icons[whoi]
		end

		if ui.Parent.Friend.Value then
			icon3.Visible = true
		end

		if ui.Parent.FirstPerson.Value then
			local ico = icon1
			if icon1.Visible then
				ico = icon2
			end
			ico.Image = "rbxassetid://15148844862"
			ico.Visible = true
		end


		local size1,size2,pos1 = 0,0,0
		if icon1.Visible == true then size1 = 0.18 end
		if icon2.Visible == true then size2 = 0.18 end
		if icon3.Visible == true then pos1 = 0.18 end

		ui.Top.Nickname.Size = UDim2.new(1-size1-size2-pos1-0.12,0,1,0)
		ui.Top.Nickname.Position = UDim2.new(pos1+0.13,0,0,0)

		if ad then
			local ping = "🚫"
			if data.Settings.Privacity.ShowPing ~= false then
				ping = ui.Parent.PING.Value
			end
			local fps = "🚫"
			if data.Settings.Privacity.ShowFps ~= false then
				fps = " "..ui.Parent.FPS.Value
			end
			ui.FPS.Text = fps
			ui.PING.Text = ping
			local graphics = ui.Parent.Graphics.Value
			if graphics == 0 then graphics = "Auto" end
			local g = "🚫"
			if data.Settings.Privacity.ShowGraphics ~= false then
				g = graphics
			end
			ui.Graphics.Text = g
		end
	end
end

local function UPDATE(gui,data)
	Upd(gui.Advanced,true,data)
	Upd(gui.Short,false,data)
end

local chr2 = player.Character or player.CharacterAdded:Wait()
local head2 = chr2:WaitForChild("Head")
local nickdata2 = head2:WaitForChild("Nickname_Data")
nickdata2.CFrame = CFrame.new(head2.Position + Vector3.new(0,1,0))

while wait(0.01) do
	for _, plr in pairs(players:GetPlayers()) do
		local chr = plr.Character or plr.CharacterAdded:Wait()
		local head = chr:WaitForChild("Head",math.huge)
		local nickdata = head:WaitForChild("Nickname_Data")
		local gui = nickdata:FindFirstChild("Nicname_Data_Guis")
		local weld_ = nickdata:FindFirstChildOfClass("Weld")
		
		local mainplr = (plr.UserId == player.UserId)
		local advancedenabled, shortenabled = false,true
			
		if gui == nil then
			gui = player:WaitForChild("PlayerScripts").SCRIPTS.Nicname_Data_Guis:Clone()
			gui.Parent = nickdata
			gui.Advanced.Adornee = nickdata
			gui.Short.Adornee = nickdata
			weld_ = Instance.new("Weld",nickdata)
			weld_.Part1 = nickdata
			weld_.Part0 = head
			weld_.C0 = CFrame.new(0,1,0)
		end
		
		local advanced = false

		local hit = base.Data.Mouse.Target
		local hum = nil
		if hit ~= nil then
			
			if hit.Parent ~= nil then
				
				if hit.Parent:FindFirstChildOfClass("Humanoid") ~= nil then
					hum = hit.Parent:FindFirstChildOfClass("Humanoid")				
				else
					
					if hit.Parent.Parent ~= nil then
						if hit.Parent.Parent:FindFirstChildOfClass("Humanoid") ~= nil then
							hum = hit.Parent.Parent:FindFirstChildOfClass("Humanoid")			
						else
							if hit.Parent.Parent.Parent ~= nil then
								if hit.Parent.Parent.Parent:FindFirstChildOfClass("Humanoid") ~= nil then
									hum = hit.Parent.Parent.Parent:FindFirstChildOfClass("Humanoid")				
								else
									if hit.Parent.Parent.Parent.Parent ~= nil then
										if hit.Parent.Parent.Parent.Parent:FindFirstChildOfClass("Humanoid") ~= nil then
											hum = hit.Parent.Parent.Parent.Parent:FindFirstChildOfClass("Humanoid")				
										end
									end
								end
							end
						end
					end
				end
				
			end
		end
		
		if hum then
			local name = hum.Parent.Name
			if plr.Name == name and not mainplr then
				advanced = true
			end
		end
			
		advancedenabled = advanced
		shortenabled = not advanced
		
		local weldresult = nil
		if mainplr then
			shortenabled = false
			advancedenabled = base.Data.Camera.FreeCamera
			if base.Data.Camera.FirstPerson then
				weldresult = CFrame.new(0,30,0)
			end
		end
		
		local data = rs.GetPlayerDataClient:InvokeServer(plr.UserId)
		if data ~= nil then
			if data.Ragdoll == true or data.Died == true or data.MovingData.Crawl == true or base.VisibleGUI == false then
				shortenabled = false
				advancedenabled = false
			end
			
			gui.FPS.Value = data["FPS"]
			gui.FirstPerson.Value = data["Data"]["Camera"]["FirstPerson"]
			local admin = data["ServerInformation"]["Admin"]
			local dev = data["ServerInformation"]["Dev"]
			local admin_result = "nope"
			if data.Premium then admin_result = "premium" end
			if admin == "admin" or admin == "mainadmin" then
				admin_result = admin
			end
			if dev then
				admin_result = "dev"
			end
			gui.Admin.Value = admin_result
			gui.Graphics.Value = data["GraphicLevel"]
			gui.Friend.Value = player:IsFriendsWith(plr.UserId)
			gui.Advanced.Id.Text = tostring(plr.UserId)
			local flag = data.Flag
			if data.Settings.Privacity.ShowFlag == false then
				flag = ""
			end
			gui.Short.Top.Flag.Text = flag
			gui.Advanced.Top.Flag.Text = flag
			if flag ~= "" then
				gui.Short.Top.Icon3.Position = UDim2.new(0.12,0,0.1,0)
				gui.Advanced.Top.Icon3.Position = UDim2.new(0.12,0,0.1,0)
			else
				gui.Short.Top.Icon3.Position = UDim2.new(0.025,0,0.1,0)
				gui.Advanced.Top.Icon3.Position = UDim2.new(0.025,0,0.1,0)
			end
			gui.Advanced.Top.Nickname.Text = plr.DisplayName
			gui.Short.Top.Nickname.Text = plr.DisplayName
			gui.Advanced.NameText.Text = plr.Name
			gui.PING.Value = data.PING
			
			if weldresult == nil then
				if advancedenabled or shortenabled then
					weldresult = CFrame.new(0,2.5,0)
				else
					weldresult = CFrame.new(0,1,0)
				end
			end
			weld_.C0 = weldresult
			gui.Advanced.Enabled = advancedenabled
			gui.Short.Enabled = shortenabled
				
			UPDATE(gui,data)
		end
		end
end