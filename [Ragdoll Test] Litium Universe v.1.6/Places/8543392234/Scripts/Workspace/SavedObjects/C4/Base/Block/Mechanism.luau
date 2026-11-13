local c4 = script.Parent.Parent
local tablet = script.Parent
local clickdet = tablet.ClickDet

local function Explosive()
	
	game.ServerScriptService.Explosive:Fire(c4.Position,30)
	
	c4.Parent:Destroy()
end

clickdet.RightMouseClick:Connect(function(player)
	Explosive()
end)