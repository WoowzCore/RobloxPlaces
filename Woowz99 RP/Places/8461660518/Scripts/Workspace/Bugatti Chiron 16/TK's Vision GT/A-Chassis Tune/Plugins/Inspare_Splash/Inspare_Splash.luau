--SecondLogic @ INSPARE
wait(.2)
local out=false
coroutine.resume(coroutine.create(function() 
	local fr = 0
	local trs=1
	while wait(.05) do
		fr = fr+1
		if fr>=10 then fr=0 end
		if not out then
			trs=math.max(0,trs-.05)
		else
			trs=math.min(1,trs+.05)
		end
		for i,v in pairs(script.Parent.Frame:GetChildren()) do
			v.Frame.ImageLabel.ImageTransparency = trs
			v.Frame.ImageLabel.Position=UDim2.new(-(fr%3),0,-math.floor(fr/3),0)
			if out then
				v.BackgroundTransparency=.5+(.5*trs)
				v.Frame.ImageLabel.BackgroundTransparency=trs
			end
		end
		if out then
			script.Parent.IN.TextTransparency=trs
			script.Parent.SPARE.TextTransparency=trs
		end
		if out and trs==1 then
			break
		end
	end
	script.Parent:Destroy()
end))

game:GetService("RunService").RenderStepped:connect(function()
	for i,v in pairs(script.Parent.Frame:GetChildren()) do
		v.Frame.Position = UDim2.new(0,-250-v.Position.X.Offset-script.Parent.Frame.Position.X.Offset,0,-136-v.Position.Y.Offset)
	end
end)

script.Parent.Frame:TweenPosition(UDim2.new(0,-100,0,0),Enum.EasingDirection.InOut,Enum.EasingStyle.Linear,10)
script.Parent.IN:TweenPosition(UDim2.new(0.5,-74,0.5,100),Enum.EasingDirection.InOut,Enum.EasingStyle.Linear,10)
script.Parent.SPARE:TweenPosition(UDim2.new(0.5,6,0.5,100),Enum.EasingDirection.InOut,Enum.EasingStyle.Linear,10)

script.Parent.Frame.B:TweenPosition(UDim2.new(0.5, -44,0.5, -134),Enum.EasingDirection.InOut,Enum.EasingStyle.Quad,.3)
script.Parent.Frame.C:TweenPosition(UDim2.new(0.5, -44,0.5, -134),Enum.EasingDirection.InOut,Enum.EasingStyle.Quad,.3)
script.Parent.Frame.D:TweenPosition(UDim2.new(0.5, -44,0.5, -134),Enum.EasingDirection.InOut,Enum.EasingStyle.Quad,.3)
script.Parent.Frame.E:TweenPosition(UDim2.new(0.5, -44,0.5, -134),Enum.EasingDirection.InOut,Enum.EasingStyle.Quad,.3)
wait(.35)
script.Parent.Frame.C:TweenPosition(UDim2.new(0.5, -44,0.5, -44),Enum.EasingDirection.InOut,Enum.EasingStyle.Quad,.3)
script.Parent.Frame.D:TweenPosition(UDim2.new(0.5, -44,0.5, 46),Enum.EasingDirection.InOut,Enum.EasingStyle.Quad,.3)
script.Parent.Frame.E:TweenPosition(UDim2.new(0.5, -44,0.5, 46),Enum.EasingDirection.InOut,Enum.EasingStyle.Quad,.3)
wait(.35)
script.Parent.Frame.E:TweenPosition(UDim2.new(0.5, -134,0.5, 46),Enum.EasingDirection.InOut,Enum.EasingStyle.Quad,.3)
wait(1)
for i=1,30 do
	for _,v in pairs(script.Parent.Frame:GetChildren()) do
		v.BackgroundTransparency=1-(i/60)
	end
	script.Parent.IN.TextTransparency=1-(i/30)
	script.Parent.SPARE.TextTransparency=1-(i/30)
	wait(.01)
end
wait(1.5)
out=true