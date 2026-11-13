function OnClicked()
	if script.Parent.HL.Enabled == false
	then script.Parent.HL.Enabled = true
else  script.Parent.HL.Enabled = false
	end	
end
script.Parent.Click.MouseClick:connect(OnClicked)
