local mouse = game.Players.LocalPlayer:GetMouse()

mouse.KeyDown:connect(function(key)
	
	if key=="z" and script.Left_Ind.Value ~= true then
		script.Left_Ind.Value = true
		script.Right_Ind.Value = false
		script.Hazard_Ind.Value = false
	elseif key=="z" and script.Left_Ind.Value == true then
		script.Left_Ind.Value = false
	end
	
	if key=="c" and script.Right_Ind.Value ~= true then
		script.Right_Ind.Value = true
		script.Left_Ind.Value = false
		script.Hazard_Ind.Value = false
	elseif key=="c" and script.Right_Ind.Value == true then
		script.Right_Ind.Value = false
	end
	
	if key=="x" and script.Hazard_Ind.Value ~= true then
		script.Hazard_Ind.Value = true
		script.Left_Ind.Value = false
		script.Right_Ind.Value = false
	elseif key=="x" and script.Hazard_Ind.Value == true then
		script.Hazard_Ind.Value = false
	end
	
end)

