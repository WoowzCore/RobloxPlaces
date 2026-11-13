script.Parent.Visible = script.Parent.Parent.Values.PBrake.Value
script.Parent.Parent.Values.PBrake.Changed:connect(function()
  script.Parent.Visible = script.Parent.Parent.Values.PBrake.Value
end)
