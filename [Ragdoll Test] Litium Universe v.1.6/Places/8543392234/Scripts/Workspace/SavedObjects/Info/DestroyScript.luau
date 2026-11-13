local obj = script.Parent
local text = obj.Gui.Text
local destroyWait = obj.DestroyWait.Value
local times = obj.TransparencyWait.Value
local flyspeed = obj.FlySpeed.Value

obj.Gui.MaxDistance = obj.TextDistance.Value
text.TextColor3 = obj.TextColor.Value
text.Text = obj.Text.Value

local destroying = false
wait(destroyWait)
destroying = true

while destroying do
	wait()
	obj.Position = Vector3.new(obj.Position.x,obj.Position.y+flyspeed,obj.Position.z)
	text.TextTransparency = text.TextTransparency + times
	text.TextStrokeTransparency = text.TextStrokeTransparency + times
	if text.TextTransparency >= 1 then
		obj:Destroy()
	end

end