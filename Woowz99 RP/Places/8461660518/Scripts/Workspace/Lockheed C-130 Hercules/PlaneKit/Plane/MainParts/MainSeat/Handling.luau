while (not script.Parent.Parent.Parent.Cloned.Value) do wait() end
local tool = script.Parent.Plane:clone()
script.Parent.Plane:remove()	-- If not removed, the player will have 2 of the tools, one being like a "Ghost." This glitch seen on RO-Port Tycoon, and this line fixes it

script.Parent.ChildAdded:connect(function(obj)
	if (script.Parent.Parent.Parent.Dead.Value) then return end
	if ((not obj:IsA("Weld")) or (obj.Name ~= "SeatWeld")) then return end
	local p = game.Players:GetPlayerFromCharacter(obj.Part1.Parent)
	if (not p) then return end
	if (not p:findFirstChild("Backpack")) then Instance.new("Backpack",p) end
	if (p.Backpack:findFirstChild(tool.Name)) then return end
	local t = tool:clone()
	t.Plane.Value = script.Parent.Parent.Parent
	t.Parent = p.Backpack
	script.Parent.Parent.Parent.Origin.Value = script.Parent.Parent.Parent.Parent
	script.Parent.Parent.Parent.Parent = p.Character
end)

script.Parent.DescendantRemoving:connect(function(obj)	-- Want to catch BEFORE removed to avoid possible problems
	if ((not obj:IsA("Weld")) or (obj.Name ~= "SeatWeld")) then return end
	local p = game.Players:GetPlayerFromCharacter(obj.Part1.Parent)
	if (not p) then return end
	if (not p:findFirstChild("Backpack")) then return end
	for _,v in pairs(p.Backpack:GetChildren()) do	-- In the case the player has more than 1 plane tool, maybe from a glitch or something, this will remove them all
		if ((v.Name == tool.Name) or (v.Name == "RESELECT")) then
			if ((v:findFirstChild("Deselect0")) and (v:findFirstChild("Deselect1")) and (v:findFirstChild("CurrentSelect"))) then
				v.Deselect0.Value = true	-- Tell tool that it needs to be removed
				while ((not v.Deselect1.Value) and (v.CurrentSelect.Value)) do wait(0.1) end	-- Wait for the tool to respond back that it is OK to be removed
				v:remove()
			end
		end
	end
	script.Parent.Parent.Parent.Parent = script.Parent.Parent.Parent.Origin.Value
end)