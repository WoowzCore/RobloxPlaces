local Cell = script.Parent
local Values = Cell.Parent.Parent.Values

Cell.MouseButton1Down:Connect(function()
	if Cell.Object.Value ~= nil then
		Values.Player_take_cell.Value = Cell
	end
end)

Cell.MouseEnter:Connect(function()
	Values.Cursor_on_cell.Value = Cell
end)
Cell.MouseLeave:Connect(function()
	Values.Cursor_on_cell.Value = nil
end)