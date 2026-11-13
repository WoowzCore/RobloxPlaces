-- YouTube: Lentilkač 58 ( http://youtube.com/channel/UCGW_ltdykdCjQE6kHRn7sPw/ )
-- Skype: Lentilkac58
-- By: Lentilkac58 ( https://www.roblox.com/users/171327977/profile )
-- Date: 30.8.2017
local Teleport = "Lentilkac58-Easy-Teleport-1" --Put the name of the Part between the ""s.
function Touch(hit) --Indicates that the Part has been Touched.
	if script.Parent.Locked == false and script.Parent.Parent:findFirstChild(Teleport).Locked == false then script.Parent.Locked = true script.Parent.Parent:findFirstChild(Teleport).Locked = true --Checks Debounce.
	local Pos = script.Parent.Parent:findFirstChild(Teleport) --Gets the Part to teleport to.
		hit.Parent:moveTo(Pos.Position) wait(1) script.Parent.Locked = false script.Parent.Parent:findFirstChild(Teleport).Locked = false end end --Takes you there and Ends the Function.
script.Parent.Touched:connect(Touch) --Listens out for Touchers.