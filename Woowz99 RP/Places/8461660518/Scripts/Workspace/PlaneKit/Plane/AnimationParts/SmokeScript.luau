local One = script.One.Value
local Two = script.Two.Value
local Three = script.Three.Value

function SmokeOne()
	if One.Velocity.Magnitude > 140 then
		One.Smoke:Emit(100)
	end
end

function SmokeTwo()
	if Two.Velocity.Magnitude > 140 then
		Two.Smoke:Emit(100)
	end
end

function SmokeThree()
	if Three.Velocity.Magnitude > 140 then
		Three.Smoke:Emit(100)
	end
end

One.Touched:Connect(SmokeOne)
Two.Touched:Connect(SmokeTwo)
Three.Touched:Connect(SmokeThree)