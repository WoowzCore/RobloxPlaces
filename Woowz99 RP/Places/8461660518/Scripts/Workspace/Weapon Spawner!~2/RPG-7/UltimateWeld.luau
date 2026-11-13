--DO NOT USE BOTH WELDING SCRIPTS PROVIDED BY THIS MODEL
--The regular script is recommended



--[[
Prevents welds from breaking/transforming when player uses the tool
This recreates the EXACT weld every time
This also prevents lag build up by clearing old welds, the tradition weld script just keeps making new 
ones, which can lead to weapons have crazy amounts of welds that dont work (I saw 6000 in a weapon once)
]]

--[[Usage
1. Remove Old welding script (optional, only if updating a weapon and that weapon does not rely on that script)
2. Anchor all parts of tool and put inside of a tool object
3. Place this script in that tool (make sure you do this AFTER step 2, otherwise it may fail)
4. Treat like normal tool, nothing special has to be done with it
]]

--[[The local script included in this model can only be used if
1. The weapon is being placed in the players backpack first (i.e. the weapon is in starterpack and moves to player backpack)
OR
2. The weapon is previously welded (weapon can be placed in workspace and picked up then)
]] 
repeat wait() until script.Parent:FindFirstChild("Handle")
local welds={}
function ClearOldWelds(tbl)
	for _,v in pairs(tbl) do
		if v:IsA('Weld') then
			v:Destroy()
		end
	end
end

function Equipped()
	local handle=script.Parent:FindFirstChild('Handle')
	if not handle then return end
	local tble=handle:GetChildren()
	for _,v in pairs(script.Parent:GetChildren()) do
		if v:IsA('BasePart') and v~=handle then
			local c1
			for _1,v1 in pairs(welds) do
				if _1==v then
					c1=v1
					break
				end
			end
			if not c1 then
				welds[v]=v.CFrame:inverse()*handle.CFrame
				v.Anchored=false
				c1=welds[v]
			end
			local weld=Instance.new('Weld')
					weld.Part0=handle
					weld.Part1=v
					weld.C0=CFrame.new()
					weld.C1=c1
					weld.Parent=handle
		end
	end
	ClearOldWelds(tble)
	handle.Anchored=false
end
Equipped()
script.Parent.Equipped:connect(Equipped)

--Made by DonnyTheDemented
