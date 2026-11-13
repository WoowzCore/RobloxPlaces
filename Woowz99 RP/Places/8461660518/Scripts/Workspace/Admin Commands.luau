--																     --
------------------------------------------------------------------------------------------------------------
--																     --
--------------------------------------How To Use-------------------------------------------------------
--------First change the "?" marks in permission to the names of your admins------------
--																     --
-------------------------------------------------------------------------------------------------------------
--																      --
--------------------------------------Commands---------------------------------------------------------
--------shout/x (Creates a message with whatever is typed in x)------------------------------
--------kill/x (Kills player x, make sure to get the capitals correct)------------------------------
----------------------ban/x/y (Bans player x, giving the reason of y)------------------------------
----------------------teleport/x/y (Teleports player x, to player y----------------------------------
----shield/y/on or off (Either adds or removes a focrefield to player y)-----------------------
----------------------anchor/y/on or off (Anchors, or un-anchors player y)----------------------
----------------------------------merge/playerone/playertwo (Try it)-------------------------------
------------------------------------------------up/playername------------------------------------------
--																      --
------------------------------mind/x/y(lets them move objects)-------------------------------------
--																      --
--------------------------------------Give Command-------------------------------------------------------
------First take the weapons you want to give, and place them in the lighting folder--------
--------------------------Next say; give/PlayerName/WeaponName--------------------------------
------------Whereas PlayerName is the name of the player you are giving to-------------------
----------------And weaponname is the name of the weapon in the folder-----------------------

permission = {"YOUR NAME HERE","FREINDS NAME HERE","FREINDS NAME HERE"} --Place the admin's names here

function explode(div,str)
	if (div=='') then return false end 
	local pos,arr = 0,{} 
	-- for each divider found 
		for st,sp in function() return string.find(str,div,pos,true) end do 
		table.insert(arr,string.sub(str,pos,st-1)) -- Attach chars left of current divider 
		pos = sp + 1 -- Jump past current divider 
		end 
	table.insert(arr,string.sub(str,pos)) -- Attach chars right of last divider 
	return arr 
end 


function checkIfAdmin(name)
	for i = 1,#permission do
		if (string.upper(name) == string.upper(permission[i])) then return true end
	end
	return false
end


function onChatted(msg, recipient, speaker) 
print("Chatted")

source = speaker.Name

	if (checkIfAdmin(source)) then
	local c = (explode("/",msg)) 
		if(c[1] == "shout") then 
		print("Shouted")
		local mess = c[2] 
		local hn = Instance.new("Message") 
		if c[2] ~= nil then
		hn.Parent = game.Workspace 
		hn.Text = mess 
		wait(5) 
		hn:remove() 
		end


		elseif(c[1] == "kill") then 
		print("Killed")
		local killed = c[2]
		print(killed)
			if c[2] ~= nil then
			if game.Players:findFirstChild(killed) ~= nil then
				game.Players:findFirstChild(killed).Character.Torso:remove()
			end 
			end

		elseif(c[1] == "ban") then 
		print("Banned")
		local banz0red = c[2]
		print(banz0red)
		local reason = c[3]
		print(reason)
			if c[2] or c[3] ~= nil then
			if game.Players:findFirstChild(banz0red) ~= nil then
			local bm = Instance.new("Message") 
			bm.Parent = game.Workspace 
			bm.Text = "Now banning ".. banz0red ..". Reason: ".. reason
			wait(5)
				if bm ~= nil then
				bm:remove() 
				end
				if game.Players:findFirstChild(banz0red) ~= nil then
				game.Players:findFirstChild(banz0red):remove()
				end
			end 
			end

		elseif(c[1] == "teleport") then 
		print("teled")
		local teled = c[2]
		local teled2 = c[3]
		print(teled)
		print(teled2)
			if c[2] or c[3] ~= nil then
			if game.Players:findFirstChild(teled) and game.Players:findFirstChild(teled2) and game.Players:findFirstChild(teled).Character.Torso and game.Players:findFirstChild(teled2).Character.Torso ~= nil then
				game.Players:findFirstChild(teled).Character.Torso.CFrame = CFrame.new(game.Players:findFirstChild(teled2).Character.Torso.Position.x,game.Players:findFirstChild(teled2).Character.Torso.Position.y + 10, game.Players:findFirstChild(teled2).Character.Torso.Position.z)
			end
			end

		elseif(c[1] == "anchor") then 
		print("anchored")
		local anchored = c[2]
		print(anchored)
		local state = c[3]
		print(state)
			if c[2] or c[3] ~= nil then
			if game.Players:findFirstChild(anchored).Character.Torso ~= nil then
				if state == "on" then
				game.Players:findFirstChild(anchored).Character.Torso.Anchored = true
				elseif state == "off" then
				game.Players:findFirstChild(anchored).Character.Torso.Anchored = false
				else return end
				end
			end

		elseif(c[1] == "up") then 
		print("upping")
		local upped = c[2]
		print(upped)
			if c[2] ~= nil then
				if game.Players:findFirstChild(upped).Character.Torso ~= nil then
					b=Instance.new("BodyForce")
					b.Parent = game.Players:findFirstChild(upped).Character.Torso
					b.force = Vector3.new(0,10000,0)
				end
			end


		elseif(c[1] == "give") then 
		print("giving")
		local playerg = c[2]
		print(playerg)
		local wepg = c[3]
		print(wepg)
			if c[2] or c[3] ~= nil then
				if game.Players:findFirstChild(playerg) and game.Lighting:findFirstChild(wepg) ~= nil then
					if game.Lighting:findFirstChild(wepg).className == "Tool" or "HopperBin" then
					g=game.Lighting:findFirstChild(wepg):clone()
					g.Parent = game.Players:findFirstChild(playerg).Backpack
					end
				end
			end

		elseif(c[1] == "explode") then 
		print("exploding")
		local playere = c[2]
		print(playere)
			if c[2] ~= nil then
				if game.Players:findFirstChild(playere) and game.Players:findFirstChild(playere).Character.Torso ~= nil then
					m=Instance.new("Explosion")
					m.Position = game.Players:findFirstChild(playere).Character.Torso.Position
					m.Parent = game.Players:findFirstChild(playere).Character.Torso
					wait(0.5)
					m:remove()
				end
			end

		elseif(c[1] == "merge") then 
		print("merging")
		local host = c[2]
		print(host)
		local hosted = c[3]
		print(hosted)
			if c[2] and c[3] ~= nil then
				if game.Players:findFirstChild(host) and game.Players:findFirstChild(hosted) ~= nil then
					game.Players:findFirstChild(hosted).Character = game.Players:findFirstChild(host).Character
				end
			end


		elseif(c[1] == "shield") then 
		print("shielding")
		local target = c[2]
		print(target)
		local state = c[3]
		print(state)
			if c[2] or c[3] ~= nil then
			if game.Players:findFirstChild(target) and game.Players:findFirstChild(target).Character ~= nil then
				if state == "on" then
				print("FFon")
				g=Instance.new("ForceField")
				print("FFmade")
				g.Name = "FFadmin"
				print("FFnamed")
				g.Parent = game.Players:findFirstChild(target).Character
				print("FFparented")
				elseif state == "off" then
					if game.Players:findFirstChild(target) and game.Players:findFirstChild(target).Character.FFadmin ~= nil then
					game.Players:findFirstChild(target).Character.FFadmin:remove()
					end
				end
			end
			end
		end
	end
end
function onPlayerEntered(newPlayer)
	newPlayer.Chatted:connect(function(msg, recipient) onChatted(msg, recipient, newPlayer) end) 
end

game.Players.ChildAdded:connect(onPlayerEntered)