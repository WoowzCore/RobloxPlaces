-- MADE BY BACKUPSILLY10 --

Motor = script.Parent.Parent.MotorUnit.Motor
Speed = 0
function Active()
	if Speed == 0 then
		script.Parent.Speed1.Transparency = 1
		script.Parent.Speed2.Transparency = 1
		script.Parent.Speed3.Transparency = 1
		script.Parent.Off.Transparency = 0
		repeat
			Motor.BottomParamB = Motor.BottomParamB + 0.01
			wait()
		until Motor.BottomParamB >= 0
		Motor.BottomParamB = 0
		Speed = 1 
	elseif Speed == 1 then
		script.Parent.Speed1.Transparency = 0
		script.Parent.Speed2.Transparency = 1
		script.Parent.Speed3.Transparency = 1
		script.Parent.Off.Transparency = 1
		repeat
			Motor.BottomParamB = Motor.BottomParamB - 0.01
			wait()
		until Motor.BottomParamB <= -.5
		Motor.BottomParamB = -.5
		Speed = 2 
	elseif Speed == 2 then
		script.Parent.Speed1.Transparency = 1
		script.Parent.Speed2.Transparency = 0
		script.Parent.Speed3.Transparency = 1
		script.Parent.Off.Transparency = 1
		repeat
			Motor.BottomParamB = Motor.BottomParamB - 0.01
			wait()
		until Motor.BottomParamB <= -1
		Motor.BottomParamB = -1
		Speed = 3
	elseif Speed == 3 then
		script.Parent.Speed1.Transparency = 1
		script.Parent.Speed2.Transparency = 1
		script.Parent.Speed3.Transparency = 0
		script.Parent.Off.Transparency = 1
		repeat
			Motor.BottomParamB = Motor.BottomParamB - 0.01
			wait()
		until Motor.BottomParamB <= -1.5
		Motor.BottomParamB = -1.5
		Speed = 0 
	end
end
script.Parent.Clicker.ClickDetector.MouseClick:connect(Active)