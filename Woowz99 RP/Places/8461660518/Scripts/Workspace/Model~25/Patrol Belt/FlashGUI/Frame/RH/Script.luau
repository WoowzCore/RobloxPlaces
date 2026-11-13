local P = script.Parent.Parent.Parent.Parent.Parent.Name
local HLoc = Workspace:FindFirstChild(P)
wait(1)
local Helmet = HLoc:findFirstChild("Vest")

if Helmet ~= nil then
	function Click(mouse)
		Helmet:remove()
		script.Parent.Parent.Parent:remove()
	end
end

script.Parent.MouseButton1Down:connect(Click)
-- J Productions 2013