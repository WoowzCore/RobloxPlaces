local group = script.Parent.Parent.Parent.Misc

for i,v in pairs(script.Parent:getChildren()) do
	if v:IsA('BoolValue') then
		v.Changed:connect(function()
			if v.Value == true then
				if v.Name == 'FL' then
					local win = group:findFirstChild(v.Name):WaitForChild('Window')
					win:WaitForChild('SS'):WaitForChild('Motor').DesiredAngle = -0.2
				elseif v.Name == 'FR' then
					local win = group:findFirstChild(v.Name):WaitForChild('Window')
					win:WaitForChild('SS'):WaitForChild('Motor').DesiredAngle = 0.2
				elseif v.Name == 'RL' then
					local win = group:findFirstChild(v.Name):WaitForChild('Window')
					win:WaitForChild('SS'):WaitForChild('Motor').DesiredAngle = -0.2
				elseif v.Name == 'RR' then
					local win = group:findFirstChild(v.Name):WaitForChild('Window')
					win:WaitForChild('SS'):WaitForChild('Motor').DesiredAngle = 0.2
				end
			else
				if v.Name == 'FL' then
					local win = group:findFirstChild(v.Name):WaitForChild('Window')
					win:WaitForChild('SS'):WaitForChild('Motor').DesiredAngle = 0
				elseif v.Name == 'FR' then
					local win = group:findFirstChild(v.Name):WaitForChild('Window')
					win:WaitForChild('SS'):WaitForChild('Motor').DesiredAngle = 0
				elseif v.Name == 'RL' then
					local win = group:findFirstChild(v.Name):WaitForChild('Window')
					win:WaitForChild('SS'):WaitForChild('Motor').DesiredAngle = 0
				elseif v.Name == 'RR' then
					local win = group:findFirstChild(v.Name):WaitForChild('Window')
					win:WaitForChild('SS'):WaitForChild('Motor').DesiredAngle = 0
				end
			end
		end)
	end
end