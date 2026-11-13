while true do
	wait()
	if script.Parent.Parent.Parent.Welded.Value == true then
		script.Parent.Bill.Text.Text = "Setup Completed"
		script.Parent.Del.Disabled = false
	end
end
