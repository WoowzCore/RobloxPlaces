local GUI = script.Parent

function updateScopeDimension()
	GUI.ScopeImg1.Position = UDim2.new(0.5, -10 - (GUI.AbsoluteSize.y / 2), 0, -10)
	GUI.ScopeImg1.Size = UDim2.new(0, 20 + GUI.AbsoluteSize.y, 0, 20 + GUI.AbsoluteSize.y)
	GUI.ScopeImg2.Position = UDim2.new(0.5, -10 - (GUI.AbsoluteSize.y / 2), 0, -10)
	GUI.ScopeImg2.Size = UDim2.new(0, 20 + GUI.AbsoluteSize.y, 0, 20 + GUI.AbsoluteSize.y)
	GUI.F1.Size = UDim2.new(0, 20 + ((GUI.AbsoluteSize.x - GUI.AbsoluteSize.y) / 2), 1, 20)
	GUI.F2.Size = UDim2.new(0, 20 + ((GUI.AbsoluteSize.x - GUI.AbsoluteSize.y) / 2), 1, 20)
	GUI.F2.Position = UDim2.new(1, -10 - ((GUI.AbsoluteSize.x - GUI.AbsoluteSize.y) / 2), 0, -10)
end

wait()

GUI.Changed:connect(updateScopeDimension)

updateScopeDimension()